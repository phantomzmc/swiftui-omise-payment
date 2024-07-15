//
//  CreditCardViewModel.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation
import SwiftyJSON

extension CreditCardView {
    class ViewModel: ObservableObject {
        @Published var cardHolderName : String = ""
        @Published var cardNumber : String = ""
        @Published var cvv : String = ""
        @Published var monthExpired: String = ""
        @Published var yearExpired : String = ""
        @Published var zipCode : String = ""
        @Published var city: String = ""
        @Published var isError = false
        @Published var msgError: String = ""
        @Published var popUpInformation: Bool = false
        @Published var isSuccess: Bool = false
        @Published var authUri: String = ""
        @Published var isOpenWebView: Bool = false
        
        private let baseApiService = BaseAPIService()
        private let amount: Int = 100000
        
        func confirmPaymentCreditCard() -> Void {
            let creditCardPayload: CreditCardPayload = CreditCardPayload(cardName: cardHolderName, cardNumber: cardNumber, cvv: cvv, monthExpired: Int(monthExpired) ?? 0 , yearExpired: Int(yearExpired) ?? 0, city: city, zipCode: zipCode)
            createTokenCreditCard(creditCardPayload: creditCardPayload) {
                result in
                switch result {
                case .success(let token):
                    print("Created token: \(token)")
                    let data = RequestCreateChargeByToken(tokenId: token.id, currency: "thb", amount: self.amount)
                    self.baseApiService.postData(url: API.baseURL.appendingPathComponent("/charge-by-token"), payload: data, completed: self.isSuccess) { result in
                        switch result {
                        case .success(let response):
                            print(response)
                            let jsonData = JSON(response)
                            
                            self.authUri = jsonData["data"]["authorize_uri"].stringValue
                            self.isOpenWebView = true
//                            self.chargeId = jsonData["data"]["id"].stringValue
//                            if let source = jsonData["data"]["source"].dictionary {
//                                print(source)
//                                self.showQRPayment = true
//                                self.imageUrl = URL(string: source["dowloadUrl"]?.stringValue ?? "")
//                            } else {
//                                print("Error")
//                            }
                            
                        case .failure(let error):
                            print("Failed to create todo: \(error)")
                        }
                    }
                case .failure(let error):
                    print("Failed to create source: \(error)")
                    self.isError = true
                    self.msgError = error.localizedDescription
                }
            }
        }
    }
}
