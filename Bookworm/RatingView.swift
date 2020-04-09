//
//  RatingView.swift
//  Bookworm
//
//  Created by Yuki Shinohara on 2020/04/09.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

//https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    //    このratingがaddbookviewに反映される
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        //        評価3だったら1,2はonImage, 4,5はoffImage
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    //Text(label)のデザインを条件に応じて変更している部分
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    //                    評価より高い番目の星はoffColorで低い番目はonColor
                    .onTapGesture {
                        //                        タップした星がratingに代入されている
                        self.rating = number
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating:  .constant(4))
    }
}
