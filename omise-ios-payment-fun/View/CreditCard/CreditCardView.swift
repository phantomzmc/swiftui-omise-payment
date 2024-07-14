//
//  CreditCardView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct CreditCardView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("Card holder name", text: $viewModel.cardHolderName).addColorBorderStyle()
            TextField("Card Number", text: $viewModel.cardNumber).keyboardType(.numberPad).addColorBorderStyle()
            HStack {
                HStack {
                    TextField("12", text: $viewModel.monthExpired)
                    Text(" / ")
                    TextField("2024", text: $viewModel.yearExpired)
                }.addColorBorderStyle()
                TextField("CVV", text: $viewModel.cvv).keyboardType(.numberPad).addColorBorderStyle()
            }
            HStack {
                TextField("City", text: $viewModel.city).keyboardType(.numberPad).addColorBorderStyle()
                TextField("Zip Code", text: $viewModel.zipCode).keyboardType(.numberPad).addColorBorderStyle()
            }
            Spacer()
            Button("Confirm Payment", action: {
                viewModel.popUpInformation = true
            }).addColorButtonStyle().padding(.bottom, 30)
        }.padding(.horizontal)
            .alert("Confirm Information Card", isPresented: $viewModel.popUpInformation) {
                Button("Ok", action: {
                    viewModel.confirmPaymentCreditCard()
                })
            } message: {
                VStack {
                    Text("Card Name: \(viewModel.cardHolderName)")
                    Text("Card Number: \(viewModel.cardNumber)")
                    Text("Expired: \(viewModel.monthExpired) / \(viewModel.yearExpired)")
                    Text("CVV: \(viewModel.cvv)")
                    Text("City: \(viewModel.city) \(viewModel.zipCode)")
                }
            }
    }
}

#Preview {
    CreditCardView()
}
