//
//  CountdownView.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 14/7/2567 BE.
//

import SwiftUI

struct CountdownView: View {
  @State private var remainingTime: TimeInterval = 90 // 1 minute and 30 seconds in seconds

  var body: some View {
    VStack {
//        Text("\(remainingTime.formatted(.format("mm:ss")))") // Format as m:ss
//        .font(.largeTitle)
//        .fontWeight(.bold)
//      Button("Start Countdown") {
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//          if self.remainingTime > 0 {
//            self.remainingTime -= 1
//          } else {
//            timer.invalidate() // Stop timer when it reaches 0
//          }
//        }
//      }
    }
  }
}

#Preview {
    CountdownView()
}
