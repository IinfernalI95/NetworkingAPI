//
//  ContentView.swift
//  CourseDetails
//
//  Created by Alexey Efimov on 06.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI

struct CourseDetailsViewController: View {
        
    @ObservedObject
    var viewModel: CourseDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.courseName)
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    CourseImage(imageData: $viewModel.imageData)
                        
                        .cornerRadius(30)
                        .frame(width: 230, height: 180)
                        .shadow(radius: 10)
                    Button {
                        viewModel.favoriteButtonPressed()
                    } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .position(x: 120, y: 100)
                    .frame(width: 35, height: 35)
                    .foregroundColor(viewModel.isFavorite ? .red : .gray)
                    
                }
                HStack {
                    Text(viewModel.numberOfLessons)
                }
                .font(.headline)
                
                HStack {
                    Text(viewModel.numberOfTests)
                }
                .font(.headline)
                
            }.padding(.top)
            
            Spacer()
        }
            .padding(.top)
            .onAppear {
                Task {
                    await viewModel.getImageData()
                }
            }
    }
}

struct CourseImage: View {
    
    @Binding var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData = imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "xmark.shield")
                    .resizable()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: NetworkManager.shared.getCourse()))
//    }
//}
