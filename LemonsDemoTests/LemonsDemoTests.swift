//
//  LemonsDemoTests.swift
//  LemonsDemoTests
//
//  Created by Condy on 2023/4/3.
//

import XCTest
@testable import LemonsDemo
import Lemons

final class LemonsDemoTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func delay(_ time: Double, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) { block() }
    }
    
    func testSaveData2DiskExample() {
        let disk = Lemons.Disk()
        
        let key = CryptoType.md5.encryptedString(with: "disk_1234")
        let data = "Condy_Disk".data(using: String.Encoding.utf8)!
        
        disk.store(key: key, value: data)
    }
    
    func testReadFromDiskExample() {
        let disk = Lemons.Disk()
        
        let key = CryptoType.md5.encryptedString(with: "disk_1234")
        let data_ = disk.read(key: key)
        XCTAssertNotNil(data_)
        
        let string = String(data: data_!, encoding: String.Encoding.utf8)
        XCTAssertNotNil(string)
        XCTAssert(string! == "Condy_Disk", "Disk data reading failed.")
    }
    
    func testRemoveDiskExample() {
        let exp = expectation(description: #function)

        let disk = Lemons.Disk()
        let key = CryptoType.md5.encryptedString(with: "disk_1234")
        let isSuccess = disk.removeCache(key: key)
        XCTAssert(isSuccess == true, "Successful disk data cleaning!")
        exp.fulfill()

        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testStorageExample() {
        let queue = DispatchQueue(label: "com.test.condy.lemons.cached.queue")
        let storage = Storage<CacheModel>.init(queue: queue)
        
        let key = CryptoType.md5.encryptedString(with: "key1234")
        let data = "Condy".data(using: String.Encoding.utf8)!
        
        let model = CacheModel(data: data, statusCode: 200)
        storage.storeCached(model, forKey: key, options: .disk)
        
        let model2 = storage.fetchCached(forKey: key, options: .disk)!
        
        XCTAssertEqual(model.data, model2.data)
        XCTAssertEqual(model.statusCode, model2.statusCode)
    }
}
