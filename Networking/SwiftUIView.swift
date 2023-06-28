//
//  SwiftUIView.swift
//  Networking
//
//  Created by Artur on 30.04.2023.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ViewUIKit()
            .frame(height: 60)
            .padding(.horizontal, 16)
            .background(.gray)
    }
}

struct ViewUIKit: UIViewRepresentable {
    func makeUIView(context: Context) -> UITextField {
        let cell = UITextField(frame: .zero)
        cell.isSecureTextEntry = true
        cell.placeholder = "Your Text"
        
        return cell
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
