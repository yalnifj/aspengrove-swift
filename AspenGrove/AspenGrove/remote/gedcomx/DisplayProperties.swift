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

class DisplayProperties {
  var name:String?
  var gender:String?
  var lifespan:String?
  var birthDate:String?
  var birthPlace:String?
  var deathDate:String?
  var deathPlace:String?
  var ascendancyNumber:String?
  var descendancyNumber:String?
  
  static func convertJsonToDisplayProperties(_ json:JSON) -> DisplayProperties {
	let dp = DisplayProperties()
	if json["name"] != JSON.null {
		dp.name = json["name"].description
	}
	if json["lifespan"] != JSON.null {
		dp.lifespan = json["lifespan"].description
	}
	if json["birthDate"] != JSON.null {
		dp.birthDate = json["birthDate"].description
	}
	if json["birthPlace"] != JSON.null {
		dp.birthPlace = json["birthPlace"].description
	}
	if json["deathDate"] != JSON.null {
		dp.deathDate = json["deathDate"].description
	}
	if json["deathPlace"] != JSON.null {
		dp.deathPlace = json["deathPlace"].description
	}
	if json["ascendancyNumber"] != JSON.null {
		dp.ascendancyNumber = json["ascendancyNumber"].description
	}
	if json["descendancyNumber"] != JSON.null {
		dp.descendancyNumber = json["descendancyNumber"].description
	}
	return dp
  }
}
