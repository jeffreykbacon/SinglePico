ruleset trip_store {
  meta {
    name "Trip Store"
    description <<
A ruleset for Reactive Programming:Single Pico Part 3
>>
    author "Jeffrey Bacon"
    logging on
    sharing on
    provides trips
    provides long_trips
    provides short_trips
 
  }
  global {
    trips = function() {
      trips_arr = ent:trips;
      trips_arr
    }
    long_trips = function() {
      long_trips_arr = ent:long_trips;
      long_trips_arr
    }
    short_trips = function() {
      short_trips_arr = ent:trips.filter(function(x){ent:long_trips.index(x) == -1})
      short_trips_arr
    }
  }
  rule collect_trips {
  	select when explicit trip_processed
  	pre {
  		mileage = event:attr("mileage").klog("our passed in Mileage: ");
      trip = timestamp + mileage;
  	}
  	{
  		send_directive("collect_trip") with
        	trip_length = "#{mileage}";
  	}
    always {
      set ent:trips ent:trips.append(trip)
    }
  }
  rule collect_long_trips {
    select when explicit found_long_trip
    pre {
      mileage = event:attr("mileage").klog("our passed in Mileage: ");
      trip = timestamp + mileage;
    }
    {
      send_directive("collect_long_trip") with
        trip_length = "#{mileage}";
    }
    always {
      set ent:long_trips ent:long_trips.append(trip)
    }
  }
  rule clear_trips {
    select when car trip_reset
    pre {
      empty_trips = [];
      empty_long_trips = [];
    }
    {
      send_directive("clear_trip") with
        message = "Clear";
    }
    always {
      set ent:trips empty_trips;
      set ent:long_trips empty_long_trips;
    }
  }
 
}