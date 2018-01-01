require_relative("unitType")
require_relative("appointments")

def team_availability(appointments)
  lunch = ["12:00", "1:00"]
  appointments.push(lunch)
#express appointments as intervals over time line
  appointments = encodeAppointments(appointments)
  startOfDay, endOfDay = encode("8:30"), encode("5:00")
#express availability as intervals over time segment
  availability = encodeAvailability(appointments, startOfDay, endOfDay)
#chop availablity into 30 minute openings
  openings = encodeOpenings(availability)
#Decode openings to string time
  decodeOpenings(openings)
  return openings
end

appointments = [['9:00', '9:30'], ['9:00', '11:30'], ['10:00', '11:00'], ['2:30', '3:00'], ['2:30', '3:30']]
print(team_availability(appointments))

