//
//  ImmigrantDTO.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//
import Foundation

public struct ImmigrantDTO: Codable {
    let immigrantID: Int
    let groupID: Int
    let destination: String
    let year: Int
    let farm: String
    let arrivalDate: String // yyyy-MM-dd
    let departureDate: String // yyyy-MM-dd
    let shipName: String
    let prefectureName: String
    let nameRomaji: String
    let surnameRomaji: String
    let surnameKanji: String
    let nameKanji: String
    let companions: String
    let station: String
}

extension ImmigrantDTO {
    func toOM() -> ImmigrantOM {
        ImmigrantOM(
            id: immigrantID, // or another UUID you generate
            immigrantID: immigrantID,
            groupID: groupID,
            destination: destination,
            year: year,
            farm: farm,
            arrivalDate: arrivalDate.toDate(),
            departureDate: departureDate.toDate(),
            shipName: shipName,
            prefectureName: prefectureName,
            nameRomaji: nameRomaji,
            surnameRomaji: surnameRomaji,
            surnameKanji: surnameKanji,
            nameKanji: nameKanji,
            companions: companions,
            station: station
        )
    }
}
