//
//  CellPaymentTypeView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct CellPaymentTypeView: View {
    let paymentType : PaymentType
    var body: some View {
        
        HStack {
            Image(uiImage: paymentType.thumnail).resizable().aspectRatio(contentMode: .fill).frame(width: 20, height: 20)
            
            Text(paymentType.name)
                .lineLimit(1).padding(.leading)
            Spacer()
        }
        .padding(.all, 8)
    }
}

#Preview {
    CellPaymentTypeView(paymentType:
                            PaymentType(key: "credit-card", name: "Credit card", thumnail: UIImage(named: "ic_credit_card")!))
    
}
