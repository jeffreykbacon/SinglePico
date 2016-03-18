ruleset track_trips {
  meta {
    name "Track Trips"
    description <<
A ruleset for Reactive Programming:Single Pico Part 1
>>
    author "Jeffrey Bacon"
    logging on
    sharing on
 
  }
  global {
 
  }
  rule process_trip {
  	select when echo message
  	pre {
		mileage = event:attr("mileage").klog("our passed in Mileage: ");
	}
	{
		send_directive("trip") with
      		trip_length = "#{mileage}";
	}
  }
 
}