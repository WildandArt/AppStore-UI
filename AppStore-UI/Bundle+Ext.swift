//
//  Bundle+Ext.swift
//  AppStore-UI
//
//  Created by Artemy Ozerski on 13/07/2022.
//

import UIKit

extension Bundle{
    func decode<T: Decodable>(type : T.Type, from file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Url error of file \(file)")
        }
        guard let data =  try? Data(contentsOf: url) else {
            fatalError("failed to load from bundle")
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        }
        catch DecodingError.typeMismatch(let type, let context){
            fatalError("type: \(type) type mismatch : \(context.debugDescription)")
        }
        catch DecodingError.valueNotFound(let type, let context){
            fatalError("value of type \(type), from file \(context.debugDescription) not found")
        }
        catch DecodingError.keyNotFound(let codingKey, let context){
            fatalError("missing key: \(codingKey.stringValue) ,\(context.debugDescription)")
        }
        catch DecodingError.dataCorrupted(let context) {
            fatalError("data is corrupted \(context.debugDescription)")
        }
        catch{
            fatalError("\(error.localizedDescription)")
        }


    }
}
