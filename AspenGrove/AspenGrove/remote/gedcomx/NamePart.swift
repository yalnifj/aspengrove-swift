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

class NamePart {
	var type:String?
	var value:String?
	var qualifiers = [Qualifier]()
	var fields = [Field]()
	
	static func convertJsonToNamePart(_ json:JSON) -> NamePart {
		let part = NamePart()
		part.type = json["type"].description
		part.value = json["value"].description
		if json["qualifiers"] != JSON.null {
			for q in json["qualifiers"].array! {
				part.qualifiers.append(Qualifier.convertJsonToQualifier(q))
			}
		}
		if json["fields"] != JSON.null {
			for field in json["fields"].array! {
				part.fields.append(Field.convertJsonToField(field))
			}
		}
		return part
	}
}
