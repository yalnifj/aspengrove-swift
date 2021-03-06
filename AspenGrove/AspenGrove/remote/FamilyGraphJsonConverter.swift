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

class FamilyGraphJsonConverter {
    var gedcomParser = GedcomParser()
    
    func createJsonPerson(_ json:JSON) -> Person {
        let person = Person()
        
        person.id = json["id"].string
        
        let gen = json["gender"].string
        
        var gender = GenderType.unknown
        if gen != nil {
            if "M" == gen {
                gender = GenderType.male
            } else if "F" == gen {
                gender = GenderType.female
            }
        }
        person.gender = gender
        
        let isAlive = json["is_alive"].bool
        person.living = isAlive
        
        let link = Link()
        link.href = json["link"].string
        link.rel = "link"
        
        let name = Name()
        let form = NameForm()
        let ft = json["name"].string
        if ft != nil {
            form.fulltext = StringUtils.replaceAll(text: ft!, regex: " \\([\\w\\s]*\\)", replace: "")
        } else {
            form.fulltext = ft
        }
        
        if json["first_name"] != JSON.null {
            let part = NamePart()
            part.type = "http://gedcomx.org/Given"
            part.value = json["first_name"].string
            form.parts.append(part)
        }
        if json["last_name"] != JSON.null {
            let part = NamePart()
            part.type = "http://gedcomx.org/Surname"
            part.value = json["last_name"].string
            form.parts.append(part)
        }
        if json["name_prefix"] != JSON.null {
            let part = NamePart()
            part.type = "http://gedcomx.org/Prefix"
            part.value = json["name_prefix"].string
            form.parts.append(part)
        }
        if json["name_suffix"] != JSON.null {
            let part = NamePart()
            part.type = "http://gedcomx.org/Suffix"
            part.value = json["name_suffix"].string
            form.parts.append(part)
        }
        
        name.nameForms.append(form)
        person.names.append(name)
        
        if json["nickname"] != JSON.null {
            let nickname = Name()
            let nickform = NameForm()
            let part = NamePart()
            part.type = "http://gedcomx.org/Given"
            part.value = json["nickname"].string
            form.parts.append(part)
            nickname.nameForms.append(nickform)
            person.names.append(nickname)
        }
        
        if json["personal_photo"] != JSON.null {
            let photo = json["personal_photo"]
            let photo_id = photo["id"].string
            let sr = SourceReference()
            let link = Link()
            link.rel = "image"
            link.href = photo_id
            sr.links.append(link)
            person.media.append(sr)
        }
        
        return person
    }
    
    func processEvents(_ json:JSON, person:Person) {
        let facts = json["data"].array
        if facts != nil {
            for factjson in facts! {
                let factj = factjson
                let eventType = factj["event_type"].string
                
                let fact = Fact()
                if eventType == nil || gedcomParser.factMap[eventType!] == nil {
                    fact.type = "http://gedcomx.org/Other"
                } else {
                    fact.type = gedcomParser.factMap[eventType!]
                }
                
                if factj["header"] != JSON.null {
                    fact.value = factj["header"].string
                }

                if factj["date"] != JSON.null {
                    let datej = factj["date"]
                    let date = GedcomDate()
                    date.formal = "+\(datej["date"])"
                    date.original = datej["gedcom"].string
                    date.parseDate()
                    fact.date = date
                }
                
                if factj["place"] != JSON.null {
                    let place = PlaceReference()
                    place.original = factj["place"].string
                    fact.place = place
                }
                
                person.facts.append(fact)
            }
        }
    }
    
    func convertMedia(_ media:JSON) -> SourceDescription {
        let sd = SourceDescription()
        sd.id = media["id"].string
        if media["is_personal_photo"] != JSON.null {
            sd.sortKey = "1"
        }
        
        let link = Link()
        if media["type"] != JSON.null && media["type"].string == "photo" {
            link.rel = "image"
        } else {
            link.rel = media["type"].string
        }
        link.href = media["url"].string
        sd.links.append(link)
        
        return sd
    }
    
    func convertFamily(_ json:JSON) -> FamilyHolder {
        let family = FamilyHolder()
        family.id = json["id"].string
        if json["husband"] != nil {
            let link = Link()
            let husband = json["husband"]
            link.rel = "HUSB"
            link.href = husband["id"].string
            family.parents.append(link)
        }
        if json["wife"] != nil {
            let link = Link()
            let wife = json["wife"]
            link.rel = "WIFE"
            link.href = wife["id"].string
            family.parents.append(link)
        }
        if json["children"] != nil {
            let jchildren = json["children"].array
            for childj in jchildren! {
                let child = childj
                let link = Link()
                link.rel = "CHIL"
                link.href = child["id"].string
                family.children.append(link)
            }
        }
        return family
    }
}
