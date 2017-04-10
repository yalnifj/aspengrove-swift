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

class PlaceReference {
	var original:String?
	var descriptionRef:String?
	var fields = [Field]()
	var normalized = [TextValue]()
	
	static func convertJsonToPlaceReference(_ json:JSON) -> PlaceReference {
		let place = PlaceReference()
		place.original = json["original"].description
		place.descriptionRef = json["descriptionRef"].description
		if json["fields"] != JSON.null {
			for field in json["fields"].array! {
				place.fields.append(Field.convertJsonToField(field))
			}
		}
		if json["normalized"] != JSON.null {
			for tv in json["normalized"].array! {
				place.normalized.append(TextValue.convertJsonToTextValue(tv))
			}
		}
		return place
	}
}
