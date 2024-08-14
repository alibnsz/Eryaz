//
//  UrlModel.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 2.08.2024.
//

import Foundation

struct UrlModel {
    let title: String
    let url: String
    let imageName: String
    
    static let sampleData: [UrlModel] = [
        UrlModel(title: "Hakkımızda", url: "https://www.eryaz.com.tr/tr/Pages/hakkimizda", imageName: "b2b"),
        UrlModel(title: "Projeler", url: "https://www.eryaz.com.tr/tr/projeler", imageName: "b4b"),
        UrlModel(title: "SSS", url: "https://www.eryaz.com.tr/tr/SSS", imageName: "zeus"),
        UrlModel(title: "Basında biz", url: "https://www.eryaz.com.tr/tr/", imageName: "ticket")
    ]
}
