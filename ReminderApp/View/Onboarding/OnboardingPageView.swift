//
//  LottiePageView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 20) {
            OnboardingView(animationName: page.animationName)
                .frame(height: 250)
                .padding(.horizontal, 20)
            
            VStack(spacing: 10) {
                Text(page.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Text(page.description)
                    .font(.headline)
                    .frame(minHeight: 100) 
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, alignment: .center) 
    }
}

