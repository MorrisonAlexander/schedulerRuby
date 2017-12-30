def encode(time)
    #example does not provide am pm.
    #am pm implicit possible due to no overlap of pm am work day hours
    hours, minutes = time.split(":")
    halfHours, minutes = 2 * hours.to_f, minutes.to_f
    halfHours += (minutes / 30).to_i
    minutes -= (minutes / 30).to_i * 30
    #convert to military time
    if hours.to_i < 8 #if pm as inferred by context
        halfHours += 2 * 12
    end
    #reduce dimensions of unit
    #possible because time forms a line with minutes and smaller frames of time expressed in decimal range
    halfHours += 100**-1 * minutes
    return halfHours
end

def decode(time)
    #timeInTermsOfAppointments -> stringTime
    minutes = (((time % 2).to_i * 30 + 100 * (time % time.to_i)).to_i).to_s
    hours = ((time / 2).to_i - 12 * (time / 24).to_i).to_s
    if hours == "0"
        hours = "12"
    end

    while minutes.length < 2
        minutes += "0"
    end
    return hours + ":" + minutes
end

