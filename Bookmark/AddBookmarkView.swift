//
//  AddBookmarkView.swift
//  Bookmark
//
//  Created by Manarbek Bibit on 18.04.2023.
//

import SwiftUI

struct AddBookmarkView: View {
    @State var showBottonSheet = false
    var body: some View {
        VStack{
            Text("Save your first \nbookmark")
                .frame(width: 358, height: 92, alignment: .center)
                .font(.custom("SFProDisplay-Bold", size: 36))
                .multilineTextAlignment(.center)
                .lineSpacing(1.07)
            
                ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black)
                    Text("Add bookmark")
                        .foregroundColor(.white)
                        .font(.custom("SFProText-Medium", size: 16))
                        .frame(width: 310, height: 22)
                }
                .frame(height: 58)
                .onTapGesture {
                    showBottonSheet = true
                }
        }
        .padding([.leading, .trailing], 16)
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView()
    }
}
