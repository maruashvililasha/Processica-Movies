//
//  Processica_MoviesTests.swift
//  Processica MoviesTests
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import XCTest
import Core
@testable import Processica_Movies

class Processica_MoviesTests: XCTestCase {
    
    var remoteDataSource : MoviesRemoteDataSource!
    var localDataSource: MoviesLocalDataSource!
    var dataRepo: MoviesDataRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        remoteDataSource = MoviesRemoteDataSource()
        localDataSource = MoviesLocalDataSource()
        dataRepo = MoviesDataRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
    }

    override func tearDownWithError() throws {
        
    }

    func testFetchingMovies() throws {
        let exp = expectation(description: "TestingRemoteDataSource")
        remoteDataSource.getPopularMovies(page: 1) { result in
            switch result {
            case .success(let page):
                XCTAssertFalse(page.results.isEmpty)
            case .failure(let error):
                // no internet check
                XCTAssertTrue(error.errorCode == -1009)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGettingMovies() throws {
        let exp = expectation(description: "TestingLocalDataSource")
        localDataSource.getPage(page: 1) { result in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTAssert(false)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testDataRepo() throws {
        let exp = expectation(description: "TestingDataRepo")
        dataRepo.getPopularMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
            case .failure(let error):
                // no internet check
                XCTAssertTrue(error.errorCode == -1009)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
