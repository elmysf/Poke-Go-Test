//
//  FavoriteModel.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 13/11/23.
//

import Foundation

struct FavoriteModel: Codable, Equatable, Identifiable {
  var id: String
  var name: String
  var images: Images

  init(
    id: String,
    name: String,
    imageURLString: String
  ) {
    self.id = id
    self.name = name
    self.images = Images(smallURLString: imageURLString)
  }
}

struct Images: Codable, Equatable {
  var smallURLString: String
  var smallURL: URL? {
    URL(string: smallURLString)
  }

  enum CodingKeys: String, CodingKey {
    case smallURLString = "small"
  }
}

// MARK: Inits

extension FavoriteModel {
  init(with favorite: FavoriteCard) {
    self.id = favorite.id ?? ""
    self.name = favorite.name ?? ""
    self.images = Images(smallURLString: favorite.imageURL ?? "")
  }
}

// MARK: - Cards

struct FavoriteModels: Codable, Equatable, Identifiable {
  var id = UUID()
  var cards: [FavoriteModel]

  enum CodingKeys: String, CodingKey {
    case cards = "data"
  }
}

