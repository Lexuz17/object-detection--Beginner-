//
//  ContentView.swift
//  object-detection-[Beginner]
//
//  Created by Jason Susanto on 06/05/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
//    @State private var selectedItem: PhotosPickerItem?
//    @State var image: UIImage?
    
    // Access camera
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    var body: some View {
        
        /*
        // Mengambil photo menggunakan photopicker.
        VStack {
            // The matching argument is used to determine the desired type of display in PhotosPicker.
            // So, if you use .images, it will display all the images available in the gallery.
            // However, if you only want to display screenshots, you can use .screenshots.
            // And if you want to display all types except screenshots, you can use .images.not(.screenshots).
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Select Multiple Photos")
            }.onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                    print("Failed to load the image")
                }
            }
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
        }
        .padding()
        /*Task dalam swift digunakan untuk menjalankan kode secara aync tanpa mengehentikan eksekusi kode utama atau antarmuka pengguna (UI) */
        */
        
        // mengakses camera
        VStack {
            if let selectedImage{
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            }
            Button("Open Camera"){
                self.showCamera.toggle()
            }
            .fullScreenCover(isPresented: self.$showCamera, content: {
                
            })
        }
    }
}

// UIViewControllerRepresentable ini adalah sebuah protocol yang digunakan untuk menyatukan antara SwfitUI dengan UIKIt
// \presentationMode adalah sebuah property wrapper yang memungkinkan Anda untuk mengakses mode presentasi dari tampilan saat ini dalam SwiftUI. Ini berguna ketika Anda ingin mengontrol presentasi atau dismiss tampilan secara programatik.

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// some digunakan untuk mengembalikan tipe yg spesifik tapi blm ditentuk secara pasti.

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

// Coondinator dalam konteks 'UIViewControllterRepresentable' adalah objek yang membantuk koordinasi antara tampilan UIKit dengan tampilan SwiftUI (Perantara)
// koordinator dalam konteks ini sering digunakan untuk menangani delegasi dari 'UIViewController'.
// NSObejct digunakan sebagai superclass coordinator karena koordinator perlu mematuhi beberapa protokol tertentu yang memerlukan NSObject seperti delegate..

#Preview {
    ContentView()
}
