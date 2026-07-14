////
////  SearchBar.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/8/26.
////
//
//import SwiftUI
//
//struct SearchBar: View {
//    
//    @Binding var searchText: String
//    
//    var body: some View {
//
//        HStack(spacing: 12) {
//
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(Color("BrandBlue"))
//                .font(.system(size: 18))
//
//            TextField("Search family member...", text: $searchText)
//                .disableAutocorrection(true)
//                .autocapitalization(.none)
//
//            if !searchText.isEmpty {
//
//                Button(action: {
//                    withAnimation(.easeOut){
//                    searchText = ""
//                     }
//                }) {
//
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//        .padding(.horizontal, 15)
//        .frame(height: 52)
//        .background(Color.white)
//        .cornerRadius(15)
//        .shadow(
//            color: Color.black.opacity(0.08),
//            radius: 8,
//            x: 0,
//            y: 4
//        )
//        .padding(.horizontal)
//    }
//}
//
//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar(searchText: .constant(""))
//    }
//}
//


import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(appState.isDarkMode ? .white.opacity(0.2) : .gray.opacity(0.6))
                .font(.system(size: 16))
            
            TextField("Search family member...", text: $searchText)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.none)
                .font(.system(size: 15))
                // Fix: Custom typography contrast matching
                .foregroundColor(appState.isDarkMode ? .white : .primary)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(appState.isDarkMode ? .white.opacity(0.6) : .gray.opacity(0.6))
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 46)
        // Fix: Matches the header and cards elevated context layer
        .background(appState.isDarkMode ? Color(red: 0.1, green: 0.12, blue: 0.18) : Color.white)
        .cornerRadius(14)
        // Fix: Premium deep slate blur styling
        .shadow(color: Color.white.opacity(appState.isDarkMode ? 0.15 : 0.03), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
        .environmentObject(AppState.shared)
}
