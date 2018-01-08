//
//  File.swift
//  theMoviesApp
//
//  Created by Sanjay Mali on 09/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
struct Movies:Decodable {
    var iso_3166_1:String?
    var name:String?
    var description:String?
    var backdrop_path:String?
    var average_rating:Double?
    var poster_path:String?
    var results:[Results]
}
struct Results:Decodable {
    var vote_average:Float?
    var vote_count:Int?
    var id:Int?
    var video:Bool?
    var media_type:String?
    var title:String?
    var poster_path:String?
    var original_title:String?
    var overview:String?
    var release_date:String?

}
