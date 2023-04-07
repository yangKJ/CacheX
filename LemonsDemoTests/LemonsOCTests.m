//
//  LemonsOCTests.m
//  LemonsDemoTests
//
//  Created by Condy on 2023/4/7.
//

#import <XCTest/XCTest.h>
#import "Lemons-Swift.h"

@interface LemonsOCTests : XCTestCase

@property (nonatomic, strong) OCStorage *storage;

@end

@implementation LemonsOCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (OCStorage *)storage {
    if (_storage == nil) {
        _storage = [[OCStorage alloc] init];
    }
    return _storage;
}

- (void)testStoreDiskExample {
    NSString *key = @"kay_12345";
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
    [self.storage storeWithKey:key value:data options:OCCachedOptionsDisk];
}

- (void)testReadDiskExample {
    NSString *key = @"kay_12345";
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data_ = [self.storage readWithKey:key options:OCCachedOptionsDisk];
    
    XCTAssertEqualObjects(data, data_);
    XCTAssertEqual(data.length, data_.length);
}

- (void)testRemovedDiskExample {
    [self.storage removeAllCache];
}

@end
