//
//  MovieDBCodingChallengeUITestsLaunchTests.swift
//  MovieDBCodingChallengeUITests
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import XCTest

final class MovieDBCodingChallengeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
