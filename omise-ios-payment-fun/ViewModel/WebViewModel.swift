//
//  WebViewModel.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 15/7/2567 BE.
//

import Foundation

enum CurrentPaymentStatus {
    case pending
    case successful
    case fail
}


class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    @Published var paymentCurrentPaymentStatus: CurrentPaymentStatus = .pending

    var url: String

    init(url: String) {
        self.url = url
    }
}
