//
//  Page.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 30.07.2024.
//

import Foundation

enum Page: String, CaseIterable {
    
    case page1 = "arrow.clockwise.circle.fill"
    case page2 = "lock.rectangle.stack.fill"
    case page3 = "hare.fill"
    case page4 = "bubble.left.and.exclamationmark.bubble.right.fill"
    
    var title: String {
        switch self {
        case .page1: "Her zaman güncel"
        case .page2: "Hızlı ve Guvenilir Veritabanı"
        case .page3: "Hiç Olmadığı Kadar Hızlı"
        case .page4: "Olağanüstü Destek"

        }
    }
    var subTitle: String {
        switch self {
        case .page1: "Projelerimize vermiş olduğumuz versiyon numaraları ile her zaman yenilikçi ve güncel sistemler"
        case .page2: "Hızlı, güvenli ve düzennli yedekleme ile maksimum hizmet veren veritabanı sistemleri"
        case .page3: "Kullanılan yüksek teknoloji sunucular ile hiç olmadığı kadar hızlı sistemler"
        case .page4: "Uzman ve profesyonel teknik ekibimiz ile olağan üstü destek hizmeti"

        }
    }
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3

        }
    }
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < 4 {
            return Page.allCases[index]
        }
        return self
    }
    var previousPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }

}
