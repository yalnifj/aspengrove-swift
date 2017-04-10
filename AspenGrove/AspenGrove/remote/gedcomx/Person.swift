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

class Person : Subject {
  var living:Bool!
  var principal:Bool?
  var gender:GenderType?
  var names = [Name]()
  var facts = [Fact]()
  var display:DisplayProperties?
  var lastChange:Foundation.Date?
  var relationships = [Relationship]()
  
  func getFullName() -> String? {
    if (display != nil && display!.name != nil) {
      return display!.name!
    }
    if (names.count > 0 && names[0].nameForms.count > 0) {
      return names[0].nameForms[0].fulltext!;
    }
    return nil;
  }
    
    func getFactsByType(type:String) -> [Fact] {
        var facts = [Fact]()
        for f in self.facts {
            if f.type == type {
                facts.append(f)
            }
        }
        return facts
    }
  
  static func convertJsonToPersons(_ json:JSON) -> [Person] {
		var persons = [Person]()
    
    if json["persons"].array == nil {
        return persons
    }
		
		for pson in json["persons"].array! {
			let person = Person()
			person.id = pson["id"].description
			person.addLinksFromJson(pson)
			person.addAttributionFromJson(pson)
			person.addIdentifiersFromJson(pson)
			
			person.living = pson["living"].bool
			
			if pson["gender"] != JSON.null {
				if pson["gender"]["type"] == "http://gedcomx.org/Male" {
					person.gender = GenderType.male
				}
				else if pson["gender"]["type"] == "http://gedcomx.org/Female" {
					person.gender = GenderType.female
				}
				else if pson["gender"]["type"] == "http://gedcomx.org/Other" {
					person.gender = GenderType.other
				}
				else {
					person.gender = GenderType.unknown
				}
			}
			
			if pson["names"] != JSON.null {
				for name in pson["names"].array! {
					person.names.append(Name.convertJsonToName(name))
				}
			}
			
			if pson["facts"] != JSON.null {
				for fact in pson["facts"].array! {
					person.facts.append(Fact.convertJsonToFact(fact))
				}
			}
			
			if pson["display"] != JSON.null {
				person.display = DisplayProperties.convertJsonToDisplayProperties(pson["display"])
			}
            
            person.relationships = Relationship.convertJsonToRelationships(pson["relationships"])
			
			persons.append(person)
		}
		
		return persons
	}
}
