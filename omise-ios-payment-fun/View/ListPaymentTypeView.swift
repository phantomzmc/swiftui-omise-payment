//
//  ListPaymentTypeView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI
import UIKit

struct ListPaymentTypeView: View {
    let paymentList: [PaymentType]
    var body: some View {
        VStack {
            List(paymentList) { paymentType in
                NavigationLink(destination: PaymentDetailView(paymentType: paymentType)) {
                    CellPaymentTypeView(paymentType: paymentType)
                }
            }
            
        }
    }
}

#Preview {
    ListPaymentTypeView(paymentList:  [
        PaymentType(key: "credit-card", name: "Credit card", thumnail: UIImage(named: "ic_credit_card")!),
        PaymentType(key: "promtpay", name: "QR Payment", thumnail: UIImage(named: "ic_qr_promptpay")!)
    ])
}
