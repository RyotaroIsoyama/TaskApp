//
//  FirebaseProtocol.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/07.
//

import Foundation
import Firebase

protocol AuthServiceProtocol {
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
}

class FirebaseFirestoreService: FirestoreProtocol {
    func collection(_ collectionPath: String) -> CollectionReferenceProtocol {
        let firestore = Firestore.firestore()
        let collectionReference = firestore.collection(collectionPath)
        return MyCollectionReference(collectionReference: collectionReference)
    }
}

protocol FirestoreProtocol {
    func collection(_ collectionPath: String) -> CollectionReferenceProtocol
}

protocol CollectionReferenceProtocol {
    func document(_ documentPath: String) -> DocumentReferenceProtocol
}

protocol DocumentReferenceProtocol {
    func collection(_ collectionPath: String) -> CollectionReferenceProtocol
    func setData(_ documentData: [String: Any], completion: ((Error?) -> Void)?)
}

class MyCollectionReference: CollectionReferenceProtocol {
    private let collectionReference: CollectionReference
    
    init(collectionReference: CollectionReference) {
        self.collectionReference = collectionReference
    }
    
    func document(_ documentPath: String) -> DocumentReferenceProtocol {
        let documentReference = collectionReference.document(documentPath)
        return MyDocumentReference(documentReference: documentReference)
    }
}

class MyDocumentReference: DocumentReferenceProtocol {
    func collection(_ collectionPath: String) -> CollectionReferenceProtocol {
        fatalError("")
    }
    
    private let documentReference: DocumentReference
    
    init(documentReference: DocumentReference) {
        self.documentReference = documentReference
    }
    
    func setData(_ documentData: [String: Any], completion: ((Error?) -> Void)?) {
        
    }
}
