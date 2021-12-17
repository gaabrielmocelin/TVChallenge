//
//  TVChallengeTests.swift
//  TVChallengeTests
//
//  Created by Gabriel Mocelin on 14/12/21.
//

import XCTest
@testable import TVChallenge

class ShowDetailViewModelTests: XCTestCase {

    var sut: ShowDetailViewModel!

    override func setUp() {
        super.setUp()
        let show = Show(id: 1, name: "Test", image: nil, genres: ["Drama", "Science-Fiction", "Thriller"], summary: "<p>Test Summary<p>", schedule: Show.Schedule(time: "22:00", days: ["Sunday"]))

        sut = ShowDetailViewModel(showService: ShowServiceMock(), show: show)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testGenresFormatted() {
        XCTAssertEqual(sut.genres, "Genres: Drama; Science-Fiction; Thriller")
    }

    func testScheduleFormatted() {
        XCTAssertEqual(sut.schedule, "Schedule: 22:00 - Sunday")
    }

    func testSummaryWithoutHTMLTags() {
        XCTAssertEqual(sut.summary, "Test Summary")
    }
}

private final class ShowServiceMock: ShowServiceProtocol {
    func fetchShows(page: Int, completion: @escaping (Result<[Show], APIError>) -> Void) {
        completion(.success([]))
    }

    func searchShows(for query: String, completion: @escaping (Result<[Show], APIError>) -> Void) {
        completion(.success([]))
    }

    func fetchEpisodes(of show: Show, completion: @escaping (Result<[Episode], APIError>) -> Void) {
        completion(.success([]))
    }
}
