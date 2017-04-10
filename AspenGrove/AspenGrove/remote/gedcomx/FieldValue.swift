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

class FieldValue {
	var type:String?
	var text:String?
	var datatype:String?
	var resource:String?
	var labelId:String?
	
	static func convertJsonToFieldValue(_ json:JSON) -> FieldValue {
		let value = FieldValue()
		value.type = json["type"].description
		value.text = json["text"].description
		value.datatype = json["datatype"].description
		value.resource = json["resource"].description
		value.labelId = json["labelId"].description
		return value
	}
}
