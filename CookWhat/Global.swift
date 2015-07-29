//
//  Global.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import Foundation

class RecipeToSuggest{
    
    var time: Int = 0;
    var title: String = "";
    var photo: String = ""
}

class AvailableIngredients{
    
    var name: String = ""
    var quantity: String = ""
    var unit: String = ""
}



extension String
{
    var length: Int {
        get {
            return count(self)
        }
    }
    func indexOf(target: String) -> Int
    {
        var range = self.rangeOfString(target)
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    func subString(startIndex: Int, length: Int) -> String
    {
        var start = advance(self.startIndex, startIndex)
        var end = advance(self.startIndex, startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
}