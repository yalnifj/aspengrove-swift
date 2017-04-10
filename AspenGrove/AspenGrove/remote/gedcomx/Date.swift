//
//  Copyright © 2017 Yellow Fork Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

class GedcomDate {
    var original:String?
    var formal:String?
    var normalized = [TextValue]()
    var fields = [Field]()
    var parsedDate:Date?
    var hasDateParts = ["d":false, "M":false, "y":false]
  
    static func convertJsonToDate(_ json:JSON) -> GedcomDate {
        let date = GedcomDate()
        date.original = json["original"].description
        date.formal = json["formal"].description
        if json["normalized"] != nil {
            for tv in json["normalized"].array! {
                date.normalized.append(TextValue.convertJsonToTextValue(tv))
            }
        }
        if json["fields"] != nil {
            for field in json["fields"].array! {
                date.fields.append(Field.convertJsonToField(field))
            }
        }
        date.parseDate()
        return date
    }
    
    func parseDate() -> Date? {
        if self.formal != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "+yyyy-MM-dd"
            let date = dateFormatter.date(from: self.original!)
            if date != nil {
                hasDateParts = ["d":true, "M":true, "y":true]
                return date
            }
        }
        if self.original != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            self.parsedDate = dateFormatter.date(from: self.original!)
            if self.parsedDate != nil {
                hasDateParts = ["d":true, "M":true, "y":true]
                return self.parsedDate
            }
            
            dateFormatter.dateFormat = "MMM yyyy"
            self.parsedDate = dateFormatter.date(from: self.original!)
            if self.parsedDate != nil {
                hasDateParts = ["d":false, "M":true, "y":true]
                return self.parsedDate
            }
            
            let range = self.original!.range(of: "\\d\\d\\d\\d", options: .regularExpression)
            if range != nil {
                let year = self.original!.substring(with: range!)
                dateFormatter.dateFormat = "yyyy"
                self.parsedDate = dateFormatter.date(from: year)
                if self.parsedDate != nil {
                    hasDateParts = ["d":false, "M":false, "y":true]
                    return self.parsedDate
                }
            }
        }
        self.parsedDate = nil
        return nil
    }
}
