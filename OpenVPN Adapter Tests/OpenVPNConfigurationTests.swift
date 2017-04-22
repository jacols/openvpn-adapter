//
//  OpenVPNConfigurationTests.swift
//  OpenVPN Adapter
//
//  Created by Sergey Abramchuk on 21.04.17.
//
//

import XCTest
@testable import OpenVPNAdapter

class OpenVPNConfigurationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSetProfile() {
        let originalProfile = ProfileLoader.getVPNProfile(type: .localKeyAuthentication)
        
        let configuration = OpenVPNConfiguration()
        
        guard configuration.fileContent == nil else {
            XCTFail("Empty file content should return nil")
            return
        }
        
        configuration.fileContent = originalProfile
        
        guard let returnedProfile = configuration.fileContent else {
            XCTFail("Returned file content should not be nil")
            return
        }
        
        XCTAssert(originalProfile.elementsEqual(returnedProfile))
        
        configuration.fileContent = nil
        XCTAssert(configuration.fileContent == nil, "Empty file content should return nil")
        
        configuration.fileContent = Data()
        XCTAssert(configuration.fileContent == nil, "Empty file content should return nil")
    }
    
    func testGetSetSettings() {
        let originalSettings = [
            "client": "",
            "dev": "tun",
            "remote-cert-tls" : "server"
        ]
        
        let configuration = OpenVPNConfiguration()
        
        guard configuration.settings == nil else {
            XCTFail("Empty settings should return nil")
            return
        }
        
        configuration.settings = originalSettings
        
        guard let returnedSettings = configuration.settings else {
            XCTFail("Returned settings should not be nil")
            return
        }
        
        let equals = originalSettings.elementsEqual(returnedSettings) { (first, second) -> Bool in
            first.key == second.key && first.value == second.value
        }
        XCTAssert(equals)
        
        configuration.settings = [:]
        XCTAssert(configuration.settings == nil, "Empty settings should return nil")
    }
    
    func testCreateConfiguration() {
        let configuration = OpenVPNConfiguration()
        
        let some = configuration.fileContent
        
        let test = "Some String".data(using: .utf8)
        configuration.fileContent = test
    }
    
}