//
//  CommonClasses.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 2/6/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import DeSerializer
import KlappaDeSerializer

class Ancestor: NSObject, KLPDeserializable {
    public static func getNamingStrategy() -> KLPNamingStrategy? {
        return nil
    }

    required override init() {
        super.init()
    }
    
    class func getRequiredFields() -> [Any]! {
        return []
    }
    
    static func getCustomFieldsMapping() -> [AnyHashable : Any]! {
        return [:]
    }
    
    static func getFieldsToClassMap() -> [AnyHashable : Any]! {
        return [:]
    }
}

class SimpleObject: Ancestor {
    var name: String!
    var price: NSDecimalNumber!
    
    override static func getRequiredFields() -> [Any]! {
        return ["name"]
    }
}

class Thumbnail: Ancestor {
    var url: String!
    var height: String!
    var width: String!
}

class NestedObject: Ancestor {
    var title: String!
    var summary: String!
    var url: String!
    var clickUrl: String!
    var refererUrl: String!
    var fileSize: Int = 0
    var fileFormat: String!
    var height: String!
    var width: String!
    var thumbnail: Thumbnail!
}

class Address: Ancestor {
    var streetAddress: String!
    var city: String!
    var state: String!
    var postalCode: String!
}

class Phone: Ancestor {
    var type: String!
    var number: String!
}

class NestedObjectWithArray: Ancestor {
    var firstName: String!
    var lastName: String!
    var age: Int = 0
    var address: Address!
    var phoneNumber: [Phone] = []
}

class Recording: Ancestor {
    var RecType: String!
    var DupMethod: String!
    var DupInType: String!
    var Profile: String!
    var Priority: String!
    var EndTs: String!
    var RecGroup: String!
    var StorageGroup: String!
    var StartTs: String!
    var RecordId: String!
    var EncoderId: String!
    var PlayGroup: String!
    var Status: String!
}

class ArtworkInfo: Ancestor {
    var StorageGroup: String!
    var URL: String!
    var `Type`: String!
    var FileName: String!
}

class Artwork: Ancestor {
    var ArtworkInfos: [ArtworkInfo] = []
}

class Channel: Ancestor {
    var ServiceId: String!
    var ChanNum: String!
    var TransportId: String!
    var SourceId: String!
    var FrequencyId: String!
    var CommFree: String!
    var UseEIT: String!
    var DefaultAuth: String!
    var ChannelName: String!
    var SIStandard: String!
    var ATSCMinorChan: String!
    var Visible: String!
    var Format: String!
    var Programs: [String] = []
    var ATSCMajorChan: String!
    var FrequencyTable: String!
    var ChanId: String!
    var Frequency: String!
    var InputId: String!
    var CallSign: String!
    var IconURL: String!
    var MplexId: String!
    var NetworkId: String!
    var Modulation: String!
    var FineTune: String!
    var ChanFilters: String!
    var XMLTVID: String!
}

class Program: Ancestor {
    var Stars: String!
    var Title: String!
    var HostName: String!
    var Artwork: Artwork!
    var Repeat: String!
    var Inetref: String!
    var LastModified: String!
    var SubTitle: String!
    var AudioProps: String!
    var FileSize: String!
    var VideoProps: String!
    var SeriesId: String!
    var Season: String!
    var ProgramFlags: String!
    var Episode: String!
    var Airdate: String!
    var StartTime: String!
    var Recording: Recording!
    var Description: String!
    var Channel: Channel!
    var Category: String!
    var EndTime: String!
    var FileName: String!
    var SubProps: String!
    var ProgramId: String!
    var CatType: String!
}

class ProgramList: Ancestor {
    var Version: String!
    var StartIndex: String!
    var ProtoVer: String!
    var TotalAvailable: String!
    var AsOf: String!
    var Programs: [Program] = []
    var Count: String!
}

class Large: Ancestor {
    var ProgramList: ProgramList!
}


func getJsonString(name: String) -> String {
    let filepath = Bundle.init(for: NestedObject.self as AnyClass).path(forResource: name, ofType: "json")
    let content = try? String.init(contentsOfFile: filepath!)
    return content!
}

func getJsonFile(name: String) -> [String: Any]  {
    let content = getJsonString(name: name)
    let data = content.data(using: .utf8)
    let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    return dict as! [String: Any]
}

func getJsonFile(name: String) -> [[String: Any]]  {
    let content = getJsonString(name: name)
    let data = content.data(using: .utf8)
    let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    return dict as! [[String: Any]]
}
