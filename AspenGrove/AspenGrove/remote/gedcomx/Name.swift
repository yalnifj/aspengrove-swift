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

class Name : Conclusion {
  var type:String?
  var date:Date?
  var nameForms = [NameForm]()
  var preferred:Bool?
  
  static func convertJsonToName(_ json:JSON) -> Name {
	let name = Name()
	name.id = json["id"].description
	name.addLinksFromJson(json)
	name.addAttributionFromJson(json)
	name.type = json["type"].description
	if json["nameForms"] != JSON.null {
		for nson in json["nameForms"].array! {
			let nameForm = NameForm.convertJsonToNameForm(nson)
			name.nameForms.append(nameForm)
		}
	}
	name.preferred = json["preferred"].bool
	return name
  }
}
