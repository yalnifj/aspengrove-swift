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

class SourceReference : HypermediaEnabledData {
	var descriptionRef:String?
	var attribution:Attribution?
	var qualifiers = [Qualifier]()
	
	func addAttributionFromJson(_ json:JSON) {
		if json["attribution"] != JSON.null {
			self.attribution = Attribution.convertJsonToAttribution(json["attribution"])
		}
	}
	
	static func convertJsonToSourceReference(_ json:JSON) -> SourceReference {
		let source = SourceReference()
		source.id = json["id"].description
		source.addLinksFromJson(json)
		source.addAttributionFromJson(json)
		if json["qualifiers"] != JSON.null {
			for q in json["qualifiers"].array! {
				source.qualifiers.append(Qualifier.convertJsonToQualifier(q))
			}
		}
		return source
	}
}
