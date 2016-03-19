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
    always{
        raise explicit event 'trip_processed'
          attributes event:attrs()        
           
    }
  }

  rule find_long_trips {
    select when explicit trip_processed
    pre {
        mileage = event:attr("mileage").klog("Mileage from trip_processed: ");
        long_trip = 50
    }
    if(mileage > long_trip) then {
        send_directive("trip") with
            trip_length = "#{mileage}";
    }
    fired {
        log "Raising found_long_trip";
        raise explicit event 'found_long_trip'
          with found = "true"    
    }
    else {
        log "Not raising found_long_trip";
    }
  }
 
}