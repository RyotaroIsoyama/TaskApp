//
//  ProfilePhotoSelectView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/20.
//

import SwiftUI

struct ProfilePhotoSelectView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Put below icon to select your profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 40)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 40)
                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                Button {
                    authViewModel.uploadProfileImage(selectedImage)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                            .frame(width: 340, height: 50)
                        Text("Register photo")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
            }
            
            Spacer()
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ProfilePhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectView()
    }
}
