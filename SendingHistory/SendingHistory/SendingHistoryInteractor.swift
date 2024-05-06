//
//  File.swift
//  DemoExample
//
//  Created by admin on 08.04.2024.
//

import Foundation


struct HistoryDate: Codable {
    var date: String
}

class SendingHistoryInteractor: SendingHistoryInteractorProtocol {
    var service: SomeServiceProtocol
    init(service: SomeServiceProtocol = SomeService()) {
        self.service = service
    }
    var dates: [HistoryDate] = []
    func getDates() async -> [HistoryDate] {
        do {
            dates = try await service.getDates()
        } catch {
            dates = []
        }
        return dates
    }
}

protocol SomeServiceProtocol {
    func getDates() async throws -> [HistoryDate]
}

class SomeService: SomeServiceProtocol {
    func getDates() async throws -> [HistoryDate] {
        
        try await NetworkService.request(type: .getMovies, responseType: GetMoviesResponse.self)
            .results
            .map { HistoryDate(date: $0.name) }
    }
}
