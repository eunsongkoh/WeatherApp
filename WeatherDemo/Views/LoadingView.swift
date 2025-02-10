//
//  LoadingView.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
