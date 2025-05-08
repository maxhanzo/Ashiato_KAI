//
//  ImmigrantSearchDTO.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Foundation

public struct ImmigrantSearchDTO: Codable {
    let immigrantId: Int?
    let nameRomaji: String?
    let surnameRomaji: String?
    let groupId: Int?
    let year: Int?
    let arrivalDate: String?
    let departureDate: String?
    let shipName: String?
    let prefectureName: String?
}

extension ImmigrantSearchDTO {
    var asQueryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let immigrantId = immigrantId {
            params["immigrantId"] = "eq\(immigrantId)"
        }
        if let nameRomaji = nameRomaji {
            params["nameRomaji"] = "ilike.%25\(nameRomaji)%25"
        }
        if let surnameRomaji = surnameRomaji {
            params["surnameRomaji"] = "ilike.%25\(surnameRomaji)%25"
        }
        if let groupId = groupId {
            params["groupId"] = "eq.\(groupId)"
        }
        if let year = year {
            params["year"] = "eq.\(year)"
        }
        if let arrivalDate = arrivalDate {
            params["arrivalDate"] = "eq.\(arrivalDate)"
        }
        if let departureDate = departureDate {
            params["departureDate"] = "eq.\(departureDate)"
        }
        if let shipName = shipName {
            params["shipName"] = "ilike.%25\(shipName)%25"
        }
        if let prefectureName = prefectureName {
            params["prefectureName"] = "ilike.%25\(prefectureName)%25"
        }
        return params
    }
}


