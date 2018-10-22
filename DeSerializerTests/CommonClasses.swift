//
//  CommonClasses.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 2/6/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import DeSerializer

@objc
class SimpleObject: Ancestor {
    @objc var name: String!
    @objc var price: NSDecimalNumber!
    
    public override static func create() -> SimpleObject {
        return SimpleObject()
    }
    
    override static func getRequiredFields() -> [Any]! {
        return ["name"]
    }
}

class Thumbnail: Ancestor {
    @objc var url: String!
    @objc var height: String!
    @objc var width: String!
    
    public override static func create() -> Thumbnail {
        return Thumbnail()
    }
}

@objc
class NestedObject: Ancestor {
    @objc var title: String!
    @objc var summary: String!
    @objc var url: String!
    @objc var clickUrl: String!
    @objc var refererUrl: String!
    @objc var fileSize: Int = 0
    @objc var fileFormat: String!
    @objc var height: String!
    @objc var width: String!
    @objc var thumbnail: Thumbnail?
    
    public override static func create() -> NestedObject {
        return NestedObject()
    }
}

@objc
class Address: Ancestor {
    @objc var streetAddress: String!
    @objc var city: String!
    @objc var state: String!
    @objc var postalCode: String!
    
    public override static func create() -> Address {
        return Address()
    }
}

@objc
class Phone: Ancestor {
    @objc var type: String!
    @objc var number: String!
    
    public override static func create() -> Phone {
        return Phone()
    }
}

@objc
class NestedObjectWithArray: Ancestor {
    @objc var firstName: String!
    @objc var lastName: String!
    @objc var age: Int = 0
    @objc var address: Address!
    @objc var phoneNumber: [Phone] = []
    
    public override static func create() -> NestedObjectWithArray {
        return NestedObjectWithArray()
    }
}

@objc
class Recording: Ancestor {
    @objc var RecType: String!
    @objc var DupMethod: String!
    @objc var DupInType: String!
    @objc var Profile: String!
    @objc var Priority: String!
    @objc var EndTs: String!
    @objc var RecGroup: String!
    @objc var StorageGroup: String!
    @objc var StartTs: String!
    @objc var RecordId: String!
    @objc var EncoderId: String!
    @objc var PlayGroup: String!
    @objc var Status: String!
    
    public override static func create() -> Recording {
        return Recording()
    }
}

@objc
class ArtworkInfo: Ancestor {
    @objc var StorageGroup: String!
    @objc var URL: String!
    @objc var `Type`: String!
    @objc var FileName: String!
    
    public override static func create() -> ArtworkInfo {
        return ArtworkInfo()
    }
}

@objc
class Artwork: Ancestor {
    @objc var ArtworkInfos: [ArtworkInfo] = []
    
    public override static func create() -> Artwork {
        return Artwork()
    }
}

@objc
class Channel: Ancestor {
    @objc var ServiceId: String!
    @objc var ChanNum: String!
    @objc var TransportId: String!
    @objc var SourceId: String!
    @objc var FrequencyId: String!
    @objc var CommFree: String!
    @objc var UseEIT: String!
    @objc var DefaultAuth: String!
    @objc var ChannelName: String!
    @objc var SIStandard: String!
    @objc var ATSCMinorChan: String!
    @objc var Visible: String!
    @objc var Format: String!
    @objc var Programs: [String] = []
    @objc var ATSCMajorChan: String!
    @objc var FrequencyTable: String!
    @objc var ChanId: String!
    @objc var Frequency: String!
    @objc var InputId: String!
    @objc var CallSign: String!
    @objc var IconURL: String!
    @objc var MplexId: String!
    @objc var NetworkId: String!
    @objc var Modulation: String!
    @objc var FineTune: String!
    @objc var ChanFilters: String!
    @objc var XMLTVID: String!
    
    public override static func create() -> Channel {
        return Channel()
    }
}

@objc
class Program: Ancestor {
    @objc var Stars: String!
    @objc var Title: String!
    @objc var HostName: String!
    @objc var Artwork: Artwork!
    @objc var Repeat: String!
    @objc var Inetref: String!
    @objc var LastModified: String!
    @objc var SubTitle: String!
    @objc var AudioProps: String!
    @objc var FileSize: String!
    @objc var VideoProps: String!
    @objc var SeriesId: String!
    @objc var Season: String!
    @objc var ProgramFlags: String!
    @objc var Episode: String!
    @objc var Airdate: String!
    @objc var StartTime: String!
    @objc var Recording: Recording!
    @objc var Description: String!
    @objc var Channel: Channel!
    @objc var Category: String!
    @objc var EndTime: String!
    @objc var FileName: String!
    @objc var SubProps: String!
    @objc var ProgramId: String!
    @objc var CatType: String!
    
    public override static func create() -> Program {
        return Program()
    }
}

@objc
class ProgramList: Ancestor {
    @objc var Version: String!
    @objc var StartIndex: String!
    @objc var ProtoVer: String!
    @objc var TotalAvailable: String!
    @objc var AsOf: String!
    @objc var Programs: [Program] = []
    @objc var Count: String!
    
    public override static func create() -> ProgramList {
        return ProgramList()
    }
}

@objc
class Large: Ancestor {
    @objc var ProgramList: ProgramList!
    
    public override static func create() -> Large {
        return Large()
    }
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
