//
//  HeaderPropertyView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 6/04/25.
//

import SwiftUI

struct HeaderPropertyView: View {
    let property: PropertyModel
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack(spacing: 5) {
            CarouselPropertyImagesView(property: property, width: width, height: height)
            PropertyInformationView(property: property)
        }
    }
}

#Preview {
    HeaderPropertyView(property: Constants.PreviewsForViewSample.propertyDetail, width: 400, height: 350)
}
