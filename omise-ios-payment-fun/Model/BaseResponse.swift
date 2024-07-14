//
//  BaseResponse.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation

struct BaseAPIResponse: Decodable {
    let status: String
    let message: String
    let data: Any
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.message = try container.decode(String.self, forKey: .message)
        if let dictionaryData = try? container.decode(AnyDecodable.self, forKey: .data) {
            self.data = dictionaryData
        } else if let arrayData = try? container.decode([AnyDecodable].self, forKey: .data) {
            self.data = arrayData
        } else {
            self.data = try container.decode(AnyDecodable.self, forKey: .data)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}

struct AnyDecodable: Decodable {
    let value: Any
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            value = intValue
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            value = stringValue
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            value = boolValue
        } else if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            value = doubleValue
        } else if let dictionaryValue = try? decoder.singleValueContainer().decode([String: AnyDecodable].self) {
            value = dictionaryValue
        } else if let arrayValue = try? decoder.singleValueContainer().decode([AnyDecodable].self) {
            value = arrayValue
        } else {
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "The container contains nothing decodable.")
        }
    }
}
