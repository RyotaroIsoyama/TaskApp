//
//  extention.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import Foundation

extension Encodable {
    //Dictionary型の型アノテーション
    func asDictionary() -> [String: Any] {
        
        //JSONEncoderにより、self（Encodableオブジェクト自体）をJSONデータにエンコード        
        guard let data = try?
                JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
