//
//  ContentView.swift
//  CourseDetails
//
//  Created by Alexey Efimov on 06.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI

struct CourseDetailsViewController: View {
    @State private var isButtonTapped = false
    var viewModel: CourseDetailsViewModelProtocol!
    var body: some View {
        VStack {
            Text(viewModel.courseName)
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    CourseImage(viewModel: viewModel)
                    Button {
                        viewModel.favoriteButtonPressed()
                        isButtonTapped = viewModel.isFavorite
                    } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .position(x: 120, y: 100)
                    .frame(width: 35, height: 35)
                    .foregroundColor(isButtonTapped ? .red : .gray)
                }
                HStack {
                    Text("\(viewModel.numberOfLessons)")
                }
                .font(.headline)
                
                HStack {
                    Text("\(viewModel.numberOfTests)")
                }
                .font(.headline)
                
            }.padding(.top)
            
            Spacer()
        }.padding(.top)
    }
    
    private func setStatusForFavoriteButton() {
        isButtonTapped = viewModel.isFavorite
    }
}

struct CourseImage: View {
    
    let viewModel: CourseDetailsViewModelProtocol
    
    var body: some View {
        ZStack {
            getImage(from: viewModel.imageData)
                .resizable()
                .cornerRadius(30)
                .frame(width: 230, height: 180)
            .shadow(radius: 10)
            
        }
    }
    
    private func getImage(from imageData: Data?) -> Image {
            guard let imageData = try? imageData else { return Image(systemName: "xmark.shield") }
            guard let image = UIImage(data: imageData) else { return Image(systemName: "xmark.shield") }
            return Image(uiImage: image)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailsViewController(viewModel: CourseDetailsViewModel(course: NetworkManager.shared.getCourseV3()))
    }
}
