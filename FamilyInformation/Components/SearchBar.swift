//
//  SearchBar.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/8/26.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("BrandBlue"))
                .font(.system(size: 18))

            TextField("Search family member...", text: $searchText)
                .disableAutocorrection(true)
                .autocapitalization(.none)

            if !searchText.isEmpty {

                Button(action: {
                    withAnimation(.easeOut){
                    searchText = ""
                     }
                }) {

                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 15)
        .frame(height: 52)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
