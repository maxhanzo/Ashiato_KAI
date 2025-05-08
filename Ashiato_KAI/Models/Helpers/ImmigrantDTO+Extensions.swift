//
//  ImmigrantDTO+Extensions.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 08/05/25.
//
import Foundation

extension ImmigrantDTO: ModelMappable {
    public init(from model: ImmigrantOM) {
        self.init(
            immigrantId: model.immigrantId,
            groupId: model.groupId,
            destination: model.destination,
            year: model.year,
            farm: model.farm,
            arrivalDate: model.arrivalDate.toString(),
            departureDate: model.departureDate.toString(),     
            shipName: model.shipName,
            prefectureName: model.prefectureName,
            nameRomaji: model.nameRomaji,
            surnameRomaji: model.surnameRomaji,
            surnameKanji: model.surnameKanji,
            nameKanji: model.nameKanji,
            companions: model.companions,
            station: model.station
        )
    }
    
    public func toModel() -> ImmigrantOM {
        ImmigrantOM(from: self)
    }
}

extension ImmigrantOM {
    convenience init(from dto: ImmigrantDTO) {
        self.init(
            immigrantId: dto.immigrantId,
            groupId: dto.groupId,
            destination: dto.destination,
            year: dto.year,
            farm: dto.farm,
            arrivalDate: dto.arrivalDate.toDate(),
            departureDate: dto.departureDate.toDate(),
            shipName: dto.shipName,
            prefectureName: dto.prefectureName,
            nameRomaji: dto.nameRomaji,
            surnameRomaji: dto.surnameRomaji,
            surnameKanji: dto.surnameKanji,
            nameKanji: dto.nameKanji,
            companions: dto.companions,
            station: dto.station
        )
    }
}
