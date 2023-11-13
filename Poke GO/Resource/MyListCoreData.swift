//
//  MyListCoreData.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 13/11/23.
//

import Foundation
import CoreData

extension FavoriteCard {
  static func instance(from card: FavoriteModel, with context: NSManagedObjectContext) -> FavoriteCard {
    let newFavorite = FavoriteCard(context: context)
    newFavorite.id = card.id
    newFavorite.name = card.name
    newFavorite.imageURL = card.images.smallURLString

    return newFavorite
  }
}
