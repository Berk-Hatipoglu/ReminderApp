//
//  LottieSliderView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI

struct OnboardingSliderView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        OnboardingPageView(page: page)
                        Spacer()
                        
                        VStack {
                            Spacer()
                            if page == pages.last {
                                NavigationLink(destination: SignUpView().environmentObject(userManager) .navigationBarBackButtonHidden(true)) {
                                    Text("Sign Up")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 130)
                                        .frame(height: 20)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                            } else {
                                Button(action: incrementPage) {
                                    Text("Next")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 130)
                                        .frame(height: 20)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                            }
                            Spacer()
                        }
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
            }
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
}
