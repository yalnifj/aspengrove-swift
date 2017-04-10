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

class Identifier {
	var hasUniqueKey:Bool = false
	var value:String?
	var type:String?
	
	static func convertJsonToIdentifier(_ type:String, json:JSON) -> [Identifier] {
		var ids = [Identifier]()
        if json[type] != JSON.null {
            for val in json[type].array! {
                let id = Identifier()
                id.type = type
                id.value = val.description
                ids.append(id)
            }
        }
		return ids
	}
}
