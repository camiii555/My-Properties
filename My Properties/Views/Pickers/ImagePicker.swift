//
//  ImagePickerViewController.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 7/04/25.
//

import Foundation
import SwiftUI
import PhotosUI


struct ImagePicker: UIViewControllerRepresentable {
    
    var maxSelection: Int
    var onImagesPicked: ([UIImage]) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagesPicked: onImagesPicked)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = maxSelection
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var onImagesPicked: ([UIImage]) -> Void
        
        init(onImagesPicked: @escaping ([UIImage]) -> Void) {
            self.onImagesPicked = onImagesPicked
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            var uiImages: [UIImage] = []
            let group = DispatchGroup()
            
            for result in results {
                group.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    guard let uiImage = object as? UIImage else { return }
                    uiImages.append(uiImage)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.onImagesPicked(uiImages)
            }
        }
    }
    
}
