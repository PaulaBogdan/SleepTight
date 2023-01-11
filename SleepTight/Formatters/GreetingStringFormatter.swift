//
//  GreetingStringFormatter.swift
//  SleepTight
//
//  Created by Paula on 16/11/2022.
//

import Foundation

class Greeting {
  
  let newDay = 0
  let noon = 12
  let sunset = 18
  let midnight = 24
  var greetingText = "Hello"
  
  
    func greetingLogic() -> String {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
      
        if currentHour >= newDay && currentHour <= noon {
            greetingText = "Good Morning"
        }
        else if currentHour > noon && currentHour <= sunset {
            greetingText = "Good Afternoon"
        }
        else if currentHour > sunset && currentHour <= midnight {
            greetingText = "Good Evening"
        }
        
        return greetingText
    }
}
