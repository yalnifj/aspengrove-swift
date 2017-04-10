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

class Field {
	var label:String?
	var type:String?
	var values = [FieldValue]()
	
	static func convertJsonToField(_ json:JSON) -> Field {
		let field = Field()
		field.label = json["label"].description
		field.type = json["type"].description
		if json["values"] != JSON.null {
			for val in json["values"].array! {
				field.values.append(FieldValue.convertJsonToFieldValue(val))
			}
		}
		return field
	}
}
