////
////  FlagButton.swift
////  Guess the Flag
////
////  Created by Alisher Baigazin on 22.06.2022.
////
//
//import SwiftUI
//
//struct FlagButton: View {
//    var image: String
//    @State var rotate = 0
//    var number: Int
//    var selected: Int
//    var score: (Int) -> ()
////    var action: () -> ()
//    var body: some View {
//        Button {
//            score(number)
//            rotate += 360
//
//        } label: {
//            Image(image)
//                .renderingMode(.original)
//                .cornerRadius(15)
//                .shadow(radius: 5)
//        }
//        .rotation3DEffect(.degrees(number == selected ? Double(rotate) : 0), axis: (x: 0, y: 1, z: 0))
//        .opacity(number != selected ? 0.25 : 1)
////        .animation(.easeInOut, value: rotate)
//    }
//}
//
//struct FlagButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FlagButton(image: "Estonia", number: 1, selected: 2, score: {_ in })
//    }
//}
