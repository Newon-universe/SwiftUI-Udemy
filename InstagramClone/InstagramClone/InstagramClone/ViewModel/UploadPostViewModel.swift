//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by Kim Yewon on 2022/10/20.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost(caption: String, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(imgae: image, type: .post) { imageUrl in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerUid": user.id ?? "",
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.userName
            ] as [String: Any]
            
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
