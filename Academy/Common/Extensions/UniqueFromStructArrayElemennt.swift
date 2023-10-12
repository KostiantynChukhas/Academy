//
//  UniqueFromStructArrayElemennt.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.12.2021.
//

import Foundation
extension Array
{
   func filterDuplicate<T:Hashable>(_ keyValue:(Element)->T) -> [Element]
   {
      var uniqueKeys = Set<T>()
      return filter{uniqueKeys.insert(keyValue($0)).inserted}
   }

   func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
   {
      return filterDuplicate{"\(keyValue($0))"}
   }
}
