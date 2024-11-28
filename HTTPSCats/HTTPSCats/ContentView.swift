//
//  ContentView.swift
//  HTTPSCats
//
//  Created by Otávio Albuquerque on 01/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var code: String = ""
    @State var image: Data? = nil
    var body: some View {
        VStack {
            Text("Meet your cats!")
            if let image = image {
                Image(uiImage: (UIImage(data: image) ?? UIImage(named: "confused"))!)
                    .resizable()
                    .scaledToFit()
            }

            TextField("Código", text: $code)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button(action: {
                Task {
                    image = await ApiServices.singleton.getCat(code: code)
                }
            }, label: {
                Text("Async Send")
                    .foregroundStyle(.white)
            })
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            Button(action: {
                ApiServices.singleton.getCatCodeClosure(code: code, completion: { data in
                    image = data
                })
            }, label: {
                Text("Closure send")
                    .foregroundStyle(.white)
            })
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
