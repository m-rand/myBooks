//
//  ImageRequest.swift
//  myBooks
//
//  Created by Marcel Baláš on 03.04.2021.
//

import Foundation

func createUrlfromId(coverId: Int) -> URL? {
    let baseCoverUrlString = "https://covers.openlibrary.org"
    let coverIdPath = "/b/id/"
    let coverIdPostfix = "-L.jpg"
    let finalUrlString = baseCoverUrlString + coverIdPath + String(coverId) + coverIdPostfix
    return URL(string: finalUrlString) ?? nil
}
