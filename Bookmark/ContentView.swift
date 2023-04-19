//
//  ContentView.swift
//  Bookmark
//
//  Created by Manarbek Bibit on 18.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack(content: {
                    Image("BG_ImageWS1")
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 24, content: {
                        HStack{
                            Text("Save all interesting links in one app")
                                .font(.system(size: 36, weight: .bold))
                                .frame(width: 358 ,height: 92, alignment: .leading)
                                .foregroundColor(.white)
                        }
                        NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: 358 ,height: 58)
                                    Text("Let’s start collecting")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                        .frame(width: 310, height: 22)
                                }

                        }
                    }) .padding([.leading, .trailing], 16)
                    
                })
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
