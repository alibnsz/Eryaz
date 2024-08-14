//
//  HomeViewModel.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 6.08.2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var details: [ModelElement] = []
    private var apiService: APIService = APIServiceImpl()
    
    init() {
        fetchDetails()
    }
    
    func fetchDetails() {
        apiService.fetchData { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.details = model
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
}
