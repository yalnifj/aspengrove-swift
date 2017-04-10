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

class TextValue {
	var lang:String?
	var value:String?
	
	static func convertJsonToTextValue(_ json:JSON) -> TextValue {
		let textValue = TextValue()
		textValue.lang = json["lang"].description
		textValue.value = json["value"].description
		return textValue
	}
}
