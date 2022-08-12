//
//  UNPhotoStatisticsTests.swift
//  
//
//  Created by Pablo Camiletti on 12/08/2022.
//

@testable import UnsplashFramework
import XCTest

final class UNPhotoStatisticsTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = DemoData.dataFromJSONFile(named: "PhotoStatistics")
        let decoder = JSONDecoder.unsplashDecoder
        let photoStats = try decoder.decode(UNPhotoStatistics.self, from: jsonData)

        XCTAssertEqual(photoStats.downloads.total, 33809)
        XCTAssertEqual(photoStats.downloads.history.amountOfChanges, 511)
        XCTAssertEqual(photoStats.downloads.history.interval, .days)
        XCTAssertEqual(photoStats.downloads.history.changes.count, 30)

        XCTAssertEqual(photoStats.views.total, 3226410)
        XCTAssertEqual(photoStats.views.history.amountOfChanges, 45266)
        XCTAssertEqual(photoStats.views.history.interval, .days)
        XCTAssertEqual(photoStats.views.history.changes.count, 30)

        XCTAssertEqual(photoStats.likes.total, 0)
        XCTAssertEqual(photoStats.likes.history.amountOfChanges, 0)
        XCTAssertEqual(photoStats.likes.history.interval, .days)
        XCTAssertEqual(photoStats.likes.history.changes.count, 30)
    }

}
