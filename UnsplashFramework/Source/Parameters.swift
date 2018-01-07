//
//  Parameters.swift
//  UnsplashFramework
//
//  Copyright 2017 Pablo Camiletti
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


import Foundation


// MARK: - Parameters URL Representable Protocol

/// Protocol for getting the URL parameters as URLQueryItem.
internal protocol ParametersURLRepresentable
{
    /// Represents the URL parameters as an array of URLQueryItem.
    func asQueryItems() -> [URLQueryItem]
}


// MARK: - Parameter for listing photos

/// The parameters' names and values that can be passed to Unsplash in a query.
internal struct PhotoListParameters
{
    /// The requested page parameter's name.
    static let pageNumberName = "page"
    
    /// Amount of photos per page parameter's name.
    static let photosPerPageName = "per_page"
    
    /// The sort order parameter's name.
    static let sortOrderName = "order_by"
    
    
    /// The requested page.
    let pageNumber    : Int
    
    /// The desired amount of photos per page.
    let photosPerPage : Int
    
    /// The desired sort order of the query's result.
    let sortOrder     : UNSort
}


extension PhotoListParameters: ParametersURLRepresentable
{
    func asQueryItems() -> [URLQueryItem]
    {
        return [
            URLQueryItem(name: PhotoListParameters.pageNumberName, value: "\(self.pageNumber)"),
            URLQueryItem(name: PhotoListParameters.photosPerPageName,  value: "\(self.photosPerPage)"),
            URLQueryItem(name: PhotoListParameters.sortOrderName,  value: "\(self.sortOrder.rawValue)")
        ]
    }
}


// MARK: - Parameter for searching photos

/// The parameters' names and values that can be passed to Unsplash in a query.
internal struct PhotoSearchParameters
{
    /// The requested query parameter's name.
    static let queryName = "query"
    
    /// The requested page parameter's name.
    static let pageNumberName = "page"
    
    /// Amount of photos per page parameter's name.
    static let photosPerPageName  = "per_page"
    
    /// Collections to narrow search parameter's name.
    static let collectionsName = "collections"
    
    /// Orientation of the desired photo parameter's name.
    static let orientationName = "orientation"
    
    
    /// Words that describe the photos to be searched.
    let query         : String
    
    /// The requested page.
    let pageNumber    : Int
    
    /// The desired amount of photos per page.
    let photosPerPage : Int
    
    /// Collections to narrow search.
    let collections   : [UNCollection]?
    
    /// Orientation of the desired photo.
    let orientation   : UNPhotoOrientation?
}


extension PhotoSearchParameters: ParametersURLRepresentable
{
    func asQueryItems() -> [URLQueryItem]
    {
        var items =
        [
            URLQueryItem(name: PhotoSearchParameters.queryName,      value: "\(self.query)"),
            URLQueryItem(name: PhotoSearchParameters.pageNumberName, value: "\(self.pageNumber)"),
            URLQueryItem(name: PhotoSearchParameters.photosPerPageName,  value: "\(self.photosPerPage)")
        ]
        
        // In case specific collections were specified
        if  let collections = collections,
            collections.isEmpty == false
        {
            var commaSeparatedIDs = collections.reduce("") { text, collection in text + ",\(collection.id)" }
            commaSeparatedIDs.removeFirst() // Removes the first comma
            let collectionsItem = URLQueryItem(name: PhotoSearchParameters.collectionsName,
                                               value: commaSeparatedIDs)
            items.append(collectionsItem)
        }
        
        // In case a particular orientation was specified
        if let orientation = self.orientation
        {
            let orientationItem = URLQueryItem(name: PhotoSearchParameters.orientationName,
                                               value: orientation.rawValue)
            items.append(orientationItem)
        }
        
        return items
    }
}
