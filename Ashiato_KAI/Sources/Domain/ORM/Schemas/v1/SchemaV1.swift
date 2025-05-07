//
//  SchemaV1.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 06/05/25.
//

import Foundation
import SwiftData

public enum SchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version = .init(1, 0, 0)
    public static var models: [any PersistentModel.Type] { [
        ImmigrantOM.self
    ] }
}

extension SchemaV1 {

    @Model
    public final class ImmigrantOM {
        @Attribute(.unique)
        public var id: Int

        public var immigrantID: Int
        public var groupID: Int
        public var destination: String
        public var year: Int
        public var farm: String
        public var arrivalDate: Date // yyyy-MM-dd
        public var departureDate: Date // yyyy-MM-dd
        public var shipName: String
        public var prefectureName: String
        public var nameRomaji: String
        public var surnameRomaji: String
        public var surnameKanji: String
        public var nameKanji: String
        public var companions: String
        public var station: String
        
        public init(id: Int, immigrantID: Int, groupID: Int, destination: String, year: Int, farm: String, arrivalDate: String, departureDate: String, shipName: String, prefectureName: String, nameRomaji: String, surnameRomaji: String, surnameKanji: String, nameKanji: String, companions: String, station: String) {
            self.id = id
            self.immigrantID = immigrantID
            self.groupID = groupID
            self.destination = destination
            self.year = year
            self.farm = farm
            self.arrivalDate = arrivalDate.toDate()
            self.departureDate = departureDate.toDate()
            self.shipName = shipName
            self.prefectureName = prefectureName
            self.nameRomaji = nameRomaji
            self.surnameRomaji = surnameRomaji
            self.surnameKanji = surnameKanji
            self.nameKanji = nameKanji
            self.companions = companions
            self.station = station
        }
    }
}
