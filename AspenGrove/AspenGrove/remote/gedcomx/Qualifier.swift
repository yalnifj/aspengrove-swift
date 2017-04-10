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

class Qualifier {
	var name:String?
	var value:String?
	
	static func convertJsonToQualifier(_ json:JSON) -> Qualifier {
		let qualifier = Qualifier()
		qualifier.name = json["name"].description
		qualifier.value = json["value"].description
		return qualifier
	}
}
