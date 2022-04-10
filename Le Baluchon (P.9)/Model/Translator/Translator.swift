//
//  TranslatorAPI.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

struct TranslationResponse: Codable {
    struct Data: Codable {
        struct Translations: Codable {
            let translatedText: String
        }
        let translations: [Translations]
    }
    let data : Data
}

// MARK: - JSON RESPONSE

//
//{
//    "data": {
//        "translations": [
//            {
//                "translatedText": "Est-ce que vous connaissez Mickey?"
//            }
//        ]
//    }
//}
