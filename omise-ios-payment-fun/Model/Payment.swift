//
//  Payment.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation
import UIKit
import OmiseSDK

struct PaymentType: Identifiable {
    let id = UUID()
    let key: String
    let name: String
    let thumnail: UIImage
}


struct CreditCardPayload {
    let cardName: String
    let cardNumber: String
    let cvv: String
    let monthExpired: Int
    let yearExpired: Int
    let city: String
    let zipCode: String
}

struct RequestCreateSourcePayload: Encodable {
    let amount: Int
    let currency: Currency
    let paymentInfo: PaymentInformation
}

struct ResponseChargeBySource {
    let status: String
    let message: String
    let data: DataChargeBySource
}

struct DataChargeBySource: Decodable {
    let status: String
    let amount: Int
    let currency: String
    let source: ChargeSource
}

// MARK: - Source
struct ChargeSource: Decodable {
    let id: String
    let type: String
    let dowloadURL: String
    let fileName: String
}

struct RequestCreateChargeBySource: Encodable {
    let sourceId: String
    let currency: String
    let amount: Int
}

enum PaymentChargeStatus: String, CodingKey {
    case success = "successful"
    case expired = "expired"
    case pending = "pending"
}
