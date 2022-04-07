//
//  Library.swift
//  IMusic
//
//  Created by Mitrio on 07.04.2022.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView{
            VStack{
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button (action: {
                            print("12321")
                        }, label: {
                            Image(systemName: "play.fill").frame(width: geometry.size.width/2 - 10, height: 50).accentColor(Color.init(uiColor: UIColor(rgb: 0xFF2C55))).background(Color.init(UIColor(rgb: 0xEFEFEF))).cornerRadius(10)
                        })
                        Button (action: {
                            print("asdda")
                        }, label: {
                            Image(systemName: "arrow.2.circlepath").frame(width: geometry.size.width/2 - 10, height: 50).accentColor(Color.init(uiColor: UIColor(rgb: 0xFF2C55))).background(Color.init(UIColor(rgb: 0xEFEFEF))).cornerRadius(10)
                        })
                    }
                }.frame(height: 40).padding()
                Divider().padding(.leading).padding(.trailing)
                List {
                    LibraryCell()
                    Text("Second")
                    Text("Third")
                }
            }
            .navigationBarTitle("Library")

        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image("cover").resizable().frame(width: 60, height: 60)
        VStack {
            
            Text("Track Name")

            Text("Artist Name")
        }
            
        }
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
