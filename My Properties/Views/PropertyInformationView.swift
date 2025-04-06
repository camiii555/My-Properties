//
//  SwiftUIView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 6/04/25.
//

import SwiftUI

struct PropertyInformationView: View {
    
    let property: PropertyModel
    
    var body: some View {
        VStack(alignment: .leading , spacing: 5){
            Text(property.propertyTitle)
                .font(.headline)
            Text(property.propertyType)
            Text(property.getUbication)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#Preview {
    PropertyInformationView(property: Constants.PreviewsForViewSample.propertyDetail)
}
