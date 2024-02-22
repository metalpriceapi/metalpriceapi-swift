import XCTest
@testable import MetalpriceAPI

final class MetalpriceAPITests: XCTestCase {
    #warning("Warning - Please add your API here")
    let apiKey = ""

    func testInitFunction() {
        let service = MetalpriceAPIService(apiKey: apiKey)
        XCTAssertNotNil(service)
    }

    func testFetchSymbols() {
        let expectation = XCTestExpectation.init(description: "fetchSymbols")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.fetchSymbols(completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(!result!.symbols.keys.isEmpty)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testFetchLive() {
        let expectation = XCTestExpectation.init(description: "fetchLive")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.fetchLive(base: "USD", currencies: ["XAU", "XAG", "XPD", "XPT"], completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.rates.keys.count == 4)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testFetchHistorical() {
        let expectation = XCTestExpectation.init(description: "fetchHistorical")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.fetchHistorical(date: "2024-02-05", base: "USD", currencies: ["XAU", "XAG", "XPD", "XPT"], completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.rates.keys.count == 4)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testConvert() {
        let expectation = XCTestExpectation.init(description: "convert")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.convert(fromCurrency: "USD", toCurrency: "EUR", amount: 100.0, date: "2024-02-05", completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.query.from == "USD")
                XCTAssertTrue(result!.query.to == "EUR")
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testTimeframe() {
        let expectation = XCTestExpectation.init(description: "timeframe")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.timeframe(startDate: "2024-02-05", endDate: "2024-02-06", base: "USD", currencies: ["XAU", "XAG", "XPD", "XPT"], completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.rates["2024-02-05"]!.keys.count == 4)
                XCTAssertTrue(result!.rates["2024-02-06"]!.keys.count == 4)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testChange() {
        let expectation = XCTestExpectation.init(description: "change")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.change(startDate: "2024-02-05", endDate: "2024-02-06", base: "USD", currencies: ["XAU", "XAG", "XPD", "XPT"], completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.rates.keys.count == 4)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }

    func testCarat() {
        let expectation = XCTestExpectation.init(description: "carat")
        let service = MetalpriceAPIService(apiKey: apiKey)

        service.carat(base: "USD", date: "2024-02-04", completion: { result in
            if (result!.success) {
                print("Success! \(String(describing: result))")
                XCTAssertNotNil(result)
                XCTAssertTrue(result!.data.keys.count > 0)
                expectation.fulfill()
            } else {
                print("Failure!")
                XCTAssertNil(result)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 30.0)
    }
}
