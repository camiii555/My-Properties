//
//  PropertyPhotosSectionView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI

struct PropertyPhotosSectionView: View {
    
    @Binding var selectedImages: [UIImage]
    @Binding var showImagePicker: Bool
    
    var body: some View {
        Section(header: Text("Fotos de la propiedad")) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    let enumeratedImages: [(offset: Int, element: UIImage)] = Array(selectedImages.enumerated())
                    
                    ForEach(enumeratedImages, id: \.element) { item in
                        let index = item.offset
                        let image = item.element
                        
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipped()
                                .cornerRadius(8)
                            
                            HStack {
                                Button {
                                    if index > 0 {
                                        selectedImages.swapAt(index, index - 1)
                                    }
                                } label: {
                                    Image(systemName: "arrow.left")
                                }
                                .disabled(index == 0)
                                
                                Button {
                                    if index < selectedImages.count - 1 {
                                        selectedImages.swapAt(index, index + 1)
                                    }
                                } label: {
                                    Image(systemName: "arrow.right")
                                }
                                .disabled(index == selectedImages.count - 1)
                                
                                Button {
                                    if index >= 0 {
                                        selectedImages.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .padding(.leading, 30)
                                .frame(width: 40, height: 50, alignment: .trailing)
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
                .padding(.vertical, 8)
            }
            
            Button("Seleccionar imágenes") {
                showImagePicker = true
            }
            .disabled(selectedImages.count >= 10)
            
            if selectedImages.count < 5 {
                Text("Selecciona al menos 5 imágenes")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    
    @Previewable @State var selectedImages: [UIImage] = []
    @Previewable @State var showImagePicker: Bool = false
    
    Form {
        PropertyPhotosSectionView(selectedImages: $selectedImages, showImagePicker: $showImagePicker)
    }
    .sheet(isPresented: $showImagePicker) {
        ImagePicker(maxSelection: 10 - selectedImages.count) { images in
            selectedImages.append(contentsOf: images)
        }
    }
}
