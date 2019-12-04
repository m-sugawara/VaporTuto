//
//  SearchTodoRequest.swift
//  App
//
//  Created by M_Sugawara on 2019/12/04.
//

import FluentSQLite
import Vapor

struct SearchTodoRequest: SQLiteModel {
    var id: Int?
    var query: String
    var limit: Int?
}

extension SearchTodoRequest: Content { }

extension SearchTodoRequest: Migration { }

extension SearchTodoRequest: Parameter { }
