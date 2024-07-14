//
//  OmiseService.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation
import OmiseSDK

let omiseSDK = OmiseSDK.Client.init(publicKey: "pkey_test_5xurq3wypybxwpbp4nq")

func createTokenCreditCard(creditCardPayload: CreditCardPayload, completion: @escaping (Result<Token, Error>) -> Void) {
    let tokenParameters = Token.CreateParameter(
        name: creditCardPayload.cardName,
        number: creditCardPayload.cardNumber,
        expirationMonth: creditCardPayload.monthExpired,
        expirationYear: creditCardPayload.yearExpired,
        securityCode: creditCardPayload.cvv,
        countryCode: "TH",
        city: creditCardPayload.city,
        state: creditCardPayload.city,
        postalCode: creditCardPayload.zipCode
    )
    
    let request = Request<Token>(parameter: tokenParameters)
    omiseSDK.send(request) {(result) in
        switch result {
        case .success(let token):
            print(token)
            completion(.success(token))
        case .failure(let error):
            print(error)
            completion(.failure(error))
        }
    }
}

func createSource(createSource: RequestCreateSourcePayload, completion: @escaping (Result<Source, Error>) -> Void) {
    //    let paymentInformation = PaymentInformation.internetBanking(.bbl) // Bangkok Bank Internet Banking payment method
    let sourceParameter = CreateSourceParameter(
        paymentInformation: createSource.paymentInfo,
        amount: Int64(createSource.amount * 100),
        currency: createSource.currency
    )
    
    let request = Request<Source>(parameter: sourceParameter)
    omiseSDK.send(request) {(result) in
        switch result {
        case .success(let source):
            completion(.success(source))
        case .failure(let error):
            print(error)
            completion(.failure(error))
        }
    }
}
