//
//  MainPage.swift
//  Bookmark
//
//  Created by Manarbek Bibit on 18.04.2023.
//

import SwiftUI


enum ScreenState {
    case firstAdd
    case listView
}
struct Bookmark: Identifiable {
    let id = UUID()
    var title: String
    var link: String
}


struct MainPage: View {
    @State var screenState: ScreenState = .firstAdd
    @State var textInput: String = ""
    @State var linkInput: String = ""
    @State var savedText: [String] = []
    @State var savedLink: [String] = []
    @State var showBottonSheet = false
    @State var dict: [String: String] = [:]
    var body: some View {
        switch screenState {
        case .firstAdd:
            SaveFirstView(showBottonSheet: $showBottonSheet,textInput: $textInput, linkInput: $linkInput, savedText: $savedText, savedLink: $savedLink,  screenState: $screenState, dict: $dict)
        case .listView:
            ListView(savedText: $savedText, savedLink: $savedLink, textInput: $textInput, linkInput: $linkInput,showBottonSheet: $showBottonSheet, screenState: $screenState, dict: $dict)
        }
    }
}

struct SaveFirstView: View {
    
    @Binding var showBottonSheet: Bool
    @Binding var textInput: String
    @Binding var linkInput: String
    @Binding var savedText: [String]
    @Binding var savedLink: [String]
    @Binding var screenState: ScreenState
    @Binding var dict: [String: String]
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Save your first \nbookmark")
                    .frame(width: 358, height: 92, alignment: .center)
                    .font(.system(size: 36, weight: .bold))
                    .multilineTextAlignment(.center)
                    .lineSpacing(1.07)
                Spacer()
                CustomButton(title: "Add bookmark")
                    .frame(height: 58)
                    .onTapGesture {
                        showBottonSheet = true
                    }
                
            }
            .padding([.leading, .trailing], 16)
            BottomSheet(showBottonSheet: $showBottonSheet, textInput: $textInput, linkInput: $linkInput, savedText: $savedText, savedLink: $savedLink, screenState: $screenState, dict: $dict)
        }
    }
}

struct BottomSheet: View {
    @Binding var showBottonSheet: Bool
    @Binding var textInput: String
    @Binding var linkInput: String
    @Binding var savedText: [String]
    @Binding var savedLink: [String]
    @Binding var screenState: ScreenState
    @Binding var dict: [String: String]
    var body: some View {
        if showBottonSheet {
            bottomSheet()
                .background(Color(CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)).edgesIgnoringSafeArea(.all))
        }
    }
    func bottomSheet() -> some View {
        GeometryReader { geo in
            ZStack(content: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                VStack(spacing: 12) {
                    HStack{
                        Spacer()
                        Button("\(Image(systemName: "xmark"))") {
                            showBottonSheet = false
                        }
                        .foregroundColor(.black)
                        .frame(width: 15, height: 15)
                    }
                    HStack{
                        Text("Title")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    TextField("Add bookmark", text: $textInput)
                        .padding(16)
                        .font(.system(size: 17, weight: .regular))
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Color(CGColor(red: 0.949, green: 0.949, blue: 0.933, alpha: 1))
                                 )
                        )
                    HStack{
                        Text("Link")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                    }
                    TextField("Bookmark link (URL)", text: $linkInput)
                        .padding(16)
                        .font(.system(size: 17, weight: .regular))
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Color(CGColor(red: 0.949, green: 0.949, blue: 0.933, alpha: 1))
                                 )
                        )
                    CustomButton(title: "Save")
                        .padding(.top, 12)
                        .onTapGesture {
                            savedText.append(textInput)
                            savedLink.append(linkInput)
                            for (index, element) in savedText.enumerated() {
                                dict[element] = savedLink[index]
                            }
                            textInput = ""
                            linkInput = ""
                            showBottonSheet = false
                            screenState = .listView
                        }
                    
                }
                .padding([.leading, .trailing], 16)
            })
            .frame(height: 362)
            .frame(width: geo.size.width, height: geo.size.height / 2)
            .offset(y: geo.size.height / 1.87)
        }
        .edgesIgnoringSafeArea(.all)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}

struct ListView: View {
    @Binding var savedText: [String]
    @Binding var savedLink: [String]
    @Binding var textInput: String
    @Binding var linkInput: String
    @Binding var showBottonSheet: Bool
    @Binding var screenState: ScreenState
    @Binding var dict: [String: String]
    @State private var editMode = EditMode.inactive
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List {
                        ForEach(dict.sorted(by: <), id:\.key) { (key, value) in
                            HStack {
                                if key.isEmpty {
                                    Text("Google")
                                } else {
                                    Text(key)
                                }
                                Spacer()
                                Link(destination: URL(string: value) ?? URL(string: "https://www.google.com")!) {
                                    Image(systemName: "arrow.up.forward.square")
                                        .font(.system(size: 24))
                                }
                            }
                            .padding(.top, 39)
                        }
                        .onDelete(perform: onDelete)
                        .onMove(perform: onMove)
                    }
                    .listStyle(.inset)
                    CustomButton(title: "Add bookmark")
                        .onTapGesture {
                            showBottonSheet = true
                        }
                }
                .padding([.leading, .trailing], 16)
                BottomSheet(showBottonSheet: $showBottonSheet, textInput: $textInput, linkInput: $linkInput, savedText: $savedText, savedLink: $savedLink, screenState: $screenState, dict: $dict)
            }
            
            
            
            
        }
        .navigationTitle("List")
        .environment(\.editMode, $editMode)
    }
    
    private func onDelete(offsets: IndexSet) {
            savedText.remove(atOffsets: offsets)
        }
    private func onMove(from source: IndexSet, to destination: Int) {
        savedText.move(fromOffsets: source, toOffset: destination)
    }
}

extension Dictionary {
    init(keys: [Key], values: [Value]) {
        self.init()
        
        for (key, value) in zip(keys, values) {
            self[key] = value
        }
    }
}



struct CustomButton: View {
    var title: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black)
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 310, height: 22)
        }
        .frame(height: 58)
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

//ForEach(savedText, id: \.self) {items in
//    Text(items)
//        .font(.system(size: 17, weight: .regular))
//    Spacer()
//    ForEach(savedLink, id: \.self) {url in
//        Link(destination: URL(string: url) ?? URL(string: "https://www.google.com")!) {
//            Image(systemName: "arrow.up.forward.square")
//                .font(.system(size: 24))
//        }
//    }
//}.onDelete(perform: onDelete)
