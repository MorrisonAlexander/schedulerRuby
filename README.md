# schedulerRuby
*A demonstration of using mathematical schema to describe time in terms of a given event*

Entry point in -> appointments.rb -> team_availability(appointments)   
Vocabulary Key: open- no appointment, closed-appointment  

# Problem Description:
* Given appointments over a given time interval -> render a sequence of all 30 minute open blocks that result
  
## Chosen Solution:
* Descibe time interval in terms of unit appointmentTime, where whole numbers are 30 minute blocks and decimals are fractions of 30 minute blocks. Numeric system base 30 in decimal range
* Using military time for one demensional representation of appointmentTime. Example 2:25 pm -> 26.25 and 2:30 pm -> 27.00
* Tabulate open intervals
* Iterate over open intervals for all open 30 minute blocks
 
