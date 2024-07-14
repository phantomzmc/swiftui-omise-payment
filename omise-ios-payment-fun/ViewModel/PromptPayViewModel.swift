//
//  PromptPayViewModel.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation
import SwiftyJSON

extension PromptPayView {
    class ViewModel: ObservableObject {
        @Published var imageUrl: URL?
        @Published var showQRPayment: Bool = false
        @Published var isSuccess: Bool = false
        @Published var msgSuccess: String = ""
        @Published var isError = false
        @Published var msgError: String = ""
        @Published var apiDataResponse: DataChargeBySource?
        @Published var status: PaymentChargeStatus = .pending
        
        @Published var countdownCheckStatus: Int = 5
        @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        private let baseApiService = BaseAPIService()
        private var chargeId: String = ""
        
        func checkPaymentStatus() -> Void {
            print("checkPaymentStatus")
            self.baseApiService.fetchData(url: API.baseURL.appendingPathComponent("/check/\(chargeId)"), completed: self.isSuccess) { result in
                switch result {
                case .success(let response):
                    let jsonData = JSON(response)
                    print(jsonData)
                    if let status = jsonData["data"]["status"].string {
                        switch status {
                        case PaymentChargeStatus.success.rawValue:
                            print("success")
                            self.status = .success
                        case PaymentChargeStatus.pending.rawValue:
                            print("pending")
                            self.status = .pending
                        case PaymentChargeStatus.expired.rawValue:
                            print("expired")
                            self.isError = true
                            self.msgError = "QR Code Expired"
                            self.status = .expired
                        default:
                            print("pending")
                        }
                    } else {
                        print("Error")
                    }
                    
                case .failure(let error):
                    print("Failed to create todo: \(error)")
                }
            }
        }
        
        func confirmPayment(amount: Int) -> Void {
            let createSourcePayload: RequestCreateSourcePayload = RequestCreateSourcePayload(amount: amount, currency: .thb, paymentInfo: .promptpay)
            createSource(createSource: createSourcePayload) { result in
                print(result)
                switch result {
                case .success(let source):
                    // Handle success with the `Source` object
                    print("Created source: \(source)")
                    let data = RequestCreateChargeBySource(sourceId: source.id, currency: "thb", amount: Int(source.amount))
                    self.baseApiService.postData(url: API.baseURL.appendingPathComponent("/charge-by-source"), payload: data, completed: self.isSuccess) { result in
                        switch result {
                        case .success(let response):
                            print(response)
                            let jsonData = JSON(response)
                            self.chargeId = jsonData["data"]["id"].stringValue
                            if let source = jsonData["data"]["source"].dictionary {
                                print(source)
                                self.showQRPayment = true
                                self.imageUrl = URL(string: source["dowloadUrl"]?.stringValue ?? "")
                            } else {
                                print("Error")
                            }
                            
                        case .failure(let error):
                            print("Failed to create todo: \(error)")
                        }
                    }
                    
                case .failure(let error):
                    // Handle failure with the `Error` object
                    print("Failed to create source: \(error)")
                    self.isError = true
                    self.msgError = error.localizedDescription
                }
            }
        }
    }
}
