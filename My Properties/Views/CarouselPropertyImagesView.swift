//
//  CarouselPropertyImagesView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 6/04/25.
//

import SwiftUI

struct CarouselPropertyImagesView: View {
    
    let property: PropertyModel
    let width: CGFloat
    let height: CGFloat
    
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(property.propertyPhotos.indices, id: \.self) { index in
                Image(uiImage: property.propertyPhotos[index])
                    .resizable()
                    .scaledToFill()
                    .frame(width: width)
                    .clipped()
                    .cornerRadius(10)
                    .tag(index)
            }
        }
        .frame(height: height)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))    
    }
}

#Preview {
    CarouselPropertyImagesView(property: Constants.PreviewsForViewSample.propertyDetail, width: 400, height: 350)
}
