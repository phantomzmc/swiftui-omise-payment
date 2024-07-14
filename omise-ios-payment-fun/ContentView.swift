//
//  ContentView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI
import UIKit


struct ContentView: View {
    let paymentList: [PaymentType] = [
        PaymentType(key: "credit-card", name: "Credit card", thumnail: UIImage(named: "ic_credit_card")!),
        PaymentType(key: "promtpay", name: "QR Payment", thumnail: UIImage(named: "ic_qr_promptpay")!)
    ]
    var body: some View {
        NavigationView(content: {
            VStack {
                VStack {
                    ListPaymentTypeView(paymentList: paymentList)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Omise Payment Type")
        })
        
    }
}

#Preview {
    ContentView()
}
