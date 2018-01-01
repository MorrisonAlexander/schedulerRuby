require_relative "unitType"

def encodeAppointments(appointments)
  #express appointments as intervals over time line
  for appointment in appointments
    i = appointments.index(appointment)
    appointments[i] = [encode(appointment[0]), encode(appointment[1])]
  end
  appointments.sort_by! {|x| x[0]}
  appointmentIntervals = []
  alreadyProccessed = []
  for appointment in appointments
    i = appointments.index(appointment)
    startBlock, endBlock = appointment[0], appointment[1]
    if alreadyProccessed.include?([startBlock, endBlock])
      next #prevent duplication
    end
    for otherStart, otherStop in appointments[i + 1, appointments.size - 1]
      if otherStart <= endBlock and otherStart >= startBlock
        # overlap occured
        alreadyProccessed.push([otherStart, otherStop])
        if endBlock < otherStop
          #overlap not equal -> extend block
          endBlock = otherStop
        end
      end
    end
    appointmentIntervals.push([startBlock, endBlock])
  end
  return appointmentIntervals
end

def encodeAvailability(appointments, fromThisTime, tillThisTime)
  #express availability as intervals over time line
  if appointments[0][0].is_a? String
    appointments = encodeAppointments(appointments)
  end
  availability = []
  last = fromThisTime
  for start, close in appointments
    #available from end of last appointment till begining of next appointment
    availability.push([last, start])
    last = close
  end
  availability.push([last, tillThisTime])
  return availability
end

def encodeOpenings(availability)
  #appointment openings are
  appointmentOpenings = []
  for start, stop in availability
    #how many half hours segments are in open interval
    segmentCount = Unit.new(stop) - Unit.new(start)
    for offset in 0..(segmentCount.to_i - 1)
      appointmentOpenings.push([start + offset, start + offset + 1])
    end
  end
  return appointmentOpenings
end

def decodeOpenings(openings)
  for opening in openings
    i = openings.index(opening)
    openings[i] = [decode(opening[0]), decode(opening[1])]
  end
end
