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

class SourceDescription : HypermediaEnabledData {
	var citations = [SourceCitation]()
	var mediaType:String?
	var about:String?
	var mediator:ResourceReference?
	var sources = [SourceReference]()
	var analysis:ResourceReference?
	var componentOf:SourceReference?
	var titles = [TextValue]()
	var notes = [Note]()
	var attribution:Attribution?
	var resourceType:String?
	var sortKey:String?
	var description = [TextValue]()
	var identifiers = [Identifier]()
	var created:Date?
	var modified:Date?
	var coverage = [Coverage]()
	var repository:ResourceReference?
	var descriptorRef:ResourceReference?
	
	static func convertJsonToSourceDescriptions(_ json:JSON) -> [SourceDescription] {
		var sds = [SourceDescription]()
		
        if json["sourceDescriptions"] != JSON.null {
            for sson in json["sourceDescriptions"].array! {
                let sd = SourceDescription()
                sd.id = sson["id"].description
                sd.mediaType = sson["mediaType"].description
                sd.about = sson["about"].description
                sd.resourceType = sson["resourceType"].description
                sd.addLinksFromJson(sson)
                
                // -- TODO add other attributes for non-media sourceDescriptions
                
                sds.append(sd)
            }
        }
		
		return sds
	}
}
