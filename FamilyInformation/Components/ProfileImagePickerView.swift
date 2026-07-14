////
////  ProfileImagePickerView.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/10/26.
////
//
//import SwiftUI
//import PhotosUI
//
//struct ProfileImagePickerView: View {
//    @Binding var selectedItem: PhotosPickerItem?
//    @Binding var selectedImage: UIImage?
//
//    var body: some View {
//        VStack(spacing: 12) {
//            PhotosPicker(selection: $selectedItem, matching: .images) {
//                ZStack(alignment: .bottomTrailing) {
//                    Group {
//                        if let image = selectedImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                        } else {
//                            Image(systemName: "person.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .padding(30)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    .frame(width: 120, height: 120)
//                    .background(Color(.systemGray6))
//                    .clipShape(Circle())
//                    .overlay(
//                        Circle()
//                            .stroke(Color("BrandBlue"), lineWidth: 2)
//                    )
//
//                    Circle()
//                        .fill(Color("BrandBlue"))
//                        .frame(width: 38, height: 38)
//                        .overlay(
//                            Image(systemName: "camera.fill")
//                                .foregroundColor(.white)
//                                .font(.system(size: 16))
//                        )
//                }
//            }
//            .buttonStyle(PlainButtonStyle())
//
//            Text("Upload Photo")
//                .font(.footnote)
//                .foregroundColor(.gray)
//        }
//        .frame(maxWidth: .infinity)
//        .padding(.vertical, 10)
//        // Image extraction task handler inside the subcomponent
//        .onChange(of: selectedItem) { _, newItem in
//            Task {
//                if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                    if let uiImage = UIImage(data: data) {
//                        selectedImage = uiImage
//                    }
//                }
//            }
//        }
//    }
//}


import SwiftUI
import PhotosUI

struct ProfileImagePickerView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImage: UIImage?

    @EnvironmentObject var appState: AppState // Global theme listener injected

    var body: some View {
        VStack(spacing: 12) {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(30)
                                // Fix: Adaptive contrast placeholder tint
                                .foregroundColor(appState.isDarkMode ? .white.opacity(0.4) : .gray.opacity(0.7))
                        }
                    }
                    .frame(width: 120, height: 120)
                    // Fix: Dynamic disk surface panel mapping
                    .background(appState.isDarkMode ? Color(red: 0.22, green: 0.24, blue: 0.28) : Color(.systemGray6))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(appState.isDarkMode ? Color.cyan : Color("BrandBlue"), lineWidth: 2)
                    )

                    Circle()
                        // Fix: Adaptive camera badge color mapping
                        .fill(appState.isDarkMode ? Color.cyan : Color("BrandBlue"))
                        .frame(width: 38, height: 38)
                        .overlay(
                            Circle()
                                .stroke(appState.isDarkMode ? Color(red: 0.12, green: 0.14, blue: 0.17) : Color.white, lineWidth: 2.5)
                        )
                        .overlay(
                            Image(systemName: "camera.fill")
                                .foregroundColor(appState.isDarkMode ? .black : .white)
                                .font(.system(size: 14, weight: .bold))
                        )
                }
            }
            .buttonStyle(PlainButtonStyle())

            Text("Upload Photo")
                .font(.footnote)
                .fontWeight(.medium)
                // Fix: Adaptive hint color logic
                .foregroundColor(appState.isDarkMode ? .white.opacity(0.5) : .gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        // Image extraction task handler inside the subcomponent
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                    }
                }
            }
        }
    }
}
