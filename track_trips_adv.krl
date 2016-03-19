ruleset track_trips_adv {
  meta {
    name "Track Trips Advanced"
    description <<
A ruleset for Reactive Programming:Single Pico Part 2
>>
    author "Jeffrey Bacon"
    logging on
    sharing on
 
  }
  global {

  }
  rule process_trip {
  	select when car new_trip
  	pre {
  		mileage = event:attr("mileage").klog("our passed in Mileage: ");
  	}
  	{
  		send_directive("trip") with
            trip_length = "#{mileage}";
  	}
  }
 
}