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

class Relationship : Subject {
    static var REL_TYPE_COUPLE = "http://gedcomx.org/Couple"
    static var REL_TYPE_PARENTCHILD = "http://gedcomx.org/ParentChild"
    
	var type:String?
	var person1:ResourceReference?
	var person2:ResourceReference?
	var facts = [Fact]()
	var fields = [Field]()
	
	static func convertJsonToRelationships(_ json:JSON) -> [Relationship] {
		var relationships = [Relationship]()
		
        if json["relationships"] != JSON.null {
            for rson:JSON in json["relationships"].array! {
                let rel = Relationship()
                rel.id = rson["id"].description
                rel.addLinksFromJson(rson)
                rel.type = rson["type"].description
                rel.person1 = ResourceReference.convertJsonToResourceReference(rson["person1"])
                rel.person2 = ResourceReference.convertJsonToResourceReference(rson["person2"])
                rel.addIdentifiersFromJson(rson)
                relationships.append(rel)
            }
        }
		
        return relationships;
    }
}
