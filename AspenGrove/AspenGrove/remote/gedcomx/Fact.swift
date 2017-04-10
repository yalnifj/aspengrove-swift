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

class Fact : Conclusion {
	var type:String?
	var date:GedcomDate?
	var place:PlaceReference?
	var value:String?
	var qualifiers = [Qualifier]()
	var fields = [Field]()
	var primary:Bool?
	
	static func convertJsonToFact(_ json:JSON) -> Fact {
		let fact = Fact()
		fact.id = json["id"].description
		fact.addLinksFromJson(json)
		fact.addAttributionFromJson(json)
		fact.type = json["type"].description
		if json["date"] != JSON.null {
			fact.date = GedcomDate.convertJsonToDate(json["date"])
		}
		if json["place"] != JSON.null {
			fact.place = PlaceReference.convertJsonToPlaceReference(json["place"])
		}
		if json["value"] != JSON.null {
			fact.value = json["value"].description
		}
        
		if json["fields"] != JSON.null {
            for field in json["fields"].array! {
				fact.fields.append(Field.convertJsonToField(field))
			}
		}
		if json["primary"] != JSON.null {
			fact.primary = json["primary"].bool
		}
		return fact
	}
}
