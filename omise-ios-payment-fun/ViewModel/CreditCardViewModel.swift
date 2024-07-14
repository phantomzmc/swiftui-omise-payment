//
//  CreditCardViewModel.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation

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
        
        func confirmPaymentCreditCard() -> Void {
            let creditCardPayload: CreditCardPayload = CreditCardPayload(cardName: cardHolderName, cardNumber: cardNumber, cvv: cvv, monthExpired: Int(monthExpired) ?? 0 , yearExpired: Int(yearExpired) ?? 0, city: city, zipCode: zipCode)
            createTokenCreditCard(creditCardPayload: creditCardPayload) {
                result in
                switch result {
                case .success(let token):
                    print("Created token: \(token)")
                case .failure(let error):
                    print("Failed to create source: \(error)")
                    self.isError = true
                    self.msgError = error.localizedDescription
                }
            }
        }
    }
}
