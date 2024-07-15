//
//  PromptPayView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct PromptPayView: View {
    
    @State private var amount: String = ""
    @State private var showAlert: Bool = false
    @State private var image: Image?
    @State private var isLoading = false
    
    @StateObject private var viewModel = ViewModel()
    
    
    var body: some View {
        VStack {
            if viewModel.showQRPayment && (viewModel.imageUrl != nil) {
                ScrollView {
                    VStack {
                        switch viewModel.status {
                        case .success:
                            PaymentSuccess()
                        case .expired:
                            EmptyView()
                        case .pending:
                            SVGImage(url: viewModel.imageUrl!)
                        }
                    }
                    .onReceive(viewModel.timer) { input in
                        if viewModel.countdownCheckStatus == 0 {
                            viewModel.checkPaymentStatus()
                            viewModel.countdownCheckStatus = 5
                        } else {
                            viewModel.countdownCheckStatus -= 1
                        }
                    }
                }
                
            } else {
                Text("Input Amount").frame(maxWidth: .infinity, alignment: .leading)
                TextField("Ex. 1,000", text: $amount).keyboardType(.numberPad).addColorBorderStyle()
                Spacer()
                Button("Generate QR Code", action: generateQrCode).addColorButtonStyle()
            }
        }
        .padding(.horizontal)
        .alert("Error", isPresented: $viewModel.isError, actions: {
            Button(action: {
                viewModel.isError = false
            }, label: {
                Text("OK")
            })
        }, message : {
            Text(self.viewModel.msgError)
        })
    }
    
    func generateQrCode() -> Void {
        self.viewModel.confirmPayment(amount: Int(amount) ?? 0)
    }
}

#Preview {
    PromptPayView()
}
