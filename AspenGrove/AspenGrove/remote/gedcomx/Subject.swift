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

class Subject : Conclusion {
	var extracted:Bool?
	var identifiers = [Identifier]()
	var media = [SourceReference]()
	var evidence = [EvidenceReference]()
	
    func addIdentifiersFromJson(_ pson:JSON) {
		if pson["identifiers"] != JSON.null {
			for (type, ids) in pson["identifiers"] {
				let typeIds = Identifier.convertJsonToIdentifier(type, json: ids)
				for id in typeIds {
					self.identifiers.append(id)
				}
			}
		}
	}
}
