//
//  PhotoEditorView.swift
//  AezakmiTestTask
//
//  Created by Aleksey Konchyts on 25.09.24.
//

import SwiftUI
import PhotosUI

struct PhotoEditorView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showActionSheet = false
    
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                self.scale = value
                            }
                    )
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                self.rotation = angle
                            }
                    )
            } else {
                Text("Выберите изображение")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(Color.gray.opacity(0.2))
            }

            Spacer()

            Button("Выбрать изображение") {
                showActionSheet = true
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Выбрать изображение"), buttons: [
                    .default(Text("Из библиотеки")) {
                        showImagePicker = true
                    },
                    .default(Text("Сделать фото")) {
                        showCamera = true
                    },
                    .cancel()
                ])
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
        }
    }
}

#Preview {
    PhotoEditorView()
}
