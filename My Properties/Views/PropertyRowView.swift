//
//  PropertyRowView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI

struct PropertyRowView: View {
    
    let property: PropertyModel
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        VStack {
            HeaderPropertyView(property: property, width: width, height: height)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    PropertyRowView(property: Constants.PreviewsForViewSample.propertyDetail, width: 400, height: 350)
}
