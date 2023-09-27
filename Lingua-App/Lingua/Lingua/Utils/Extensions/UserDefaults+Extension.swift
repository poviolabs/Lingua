//
//  UserDefaults+Extension.swift
//  Lingua
//
//  Created by Egzon Arifi on 22/08/2023.
//

import Foundation

extension UserDefaults {
  func setEncodable<T: Codable>(_ value: T, forKey key: String, encoder: JSONEncoder = .init()) {
    if let encoded = try? encoder.encode(value) {
      self.set(encoded, forKey: key)
    }
  }
  
  func getDecodable<T: Codable>(_ type: T.Type, forKey key: String, decoder: JSONDecoder = .init()) -> T? {
    guard let data = self.data(forKey: key) else { return nil }
    return try? decoder.decode(T.self, from: data)
  }
}

extension UserDefaults {
  static func getProjects() -> [Project] {
    standard.getDecodable([Project].self, forKey: "projects") ?? []
  }
  
  static func setProjects(_ projects: [Project]) {
    standard.setEncodable(projects, forKey: "projects")
  }
}
