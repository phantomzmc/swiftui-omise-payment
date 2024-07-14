//
//  PaymentDetailView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct PaymentDetailView: View {
    let paymentType: PaymentType
    
    var body: some View {
        VStack {
            switch paymentType.key {
            case "credit-card":
                CreditCardView()
            case "promtpay":
                PromptPayView()
            default:
                CreditCardView()
            }
            
        }
        .padding(.top, 5)
        .navigationTitle("Payment by " + paymentType.name)
        
    }
}

#Preview {
    PaymentDetailView(paymentType: PaymentType(key: "credit-card", name: "Credit Card", thumnail:  UIImage(named: "ic_qr_promptpay")!))
}
