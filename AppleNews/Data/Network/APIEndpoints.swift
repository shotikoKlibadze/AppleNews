//
//  APIEndpoints.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 07.09.22.
//

import Foundation

struct APIEndpoints {
    
    static func getNewsEndpoint() -> Endpoint<NewsArticleResponse> {
        return Endpoint(path: "https://newsapi.org/v2/everything?q=apple&from=2022-10-12&to=2022-10-12&sortBy=popularity&apiKey=c076c89e95874516a719fc2afff072b4", method: .get)
    }
    
    static func getMoviePosterEndpoint(URLString: String) -> Endpoint<Data> {
        return Endpoint(path: URLString, method: .get, responseDecoder: RawDataResponseDecoder())
    }
    
}
