ruleset echo {
  meta {
    name "Echo"
    description <<
A ruleset for Reactive Programming:Single Pico Part 1
>>
    author "Jeffrey Bacon"
    logging on
    sharing on
    provides hello
 
  }
  global {
 
  }
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  rule message {
  	select when echo message
  	pre {
		input = event:attr("input").klog("our passed in Input: ");
	}
	{
		send_directive("say") with
      		something = "#{input}";
	}
  }
 
}