//
//  ProfileImagePickerView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI
import PhotosUI

struct ProfileImagePickerView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImage: UIImage?

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
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 120, height: 120)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("BrandBlue"), lineWidth: 2)
                    )

                    Circle()
                        .fill(Color("BrandBlue"))
                        .frame(width: 38, height: 38)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                        )
                }
            }
            .buttonStyle(PlainButtonStyle())

            Text("Upload Photo")
                .font(.footnote)
                .foregroundColor(.gray)
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
