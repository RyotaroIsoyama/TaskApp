//
//  HeaderView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let headerColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(headerColor)
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                Text(subtitle)
                    .font(.system(size: 20))
                    .foregroundColor(.white)

            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title",
                   subtitle: "SubTitle",
                   headerColor: Color.pink)
    }
}
