//
//  Handlers.swift
//  Perfect-Blog-Mustache
//
//  Created by Jonathan Guthrie on 2016-09-28.
//
//

import PerfectLib
import SQLite
import PerfectHTTP
import PerfectMustache
import SwiftString

/*
	These are the main Mustache handlers.
	They are called as the handlers from the routes in main.swift
*/


struct ListHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
	// This is the function which all handlers must impliment.
	// It is called by the system to allow the handler to return the set of values which will be used when populating the template.
	// - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
	// - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.

	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		var values = MustacheEvaluationContext.MapType()
		var ary = [Any]()

		let dbHandler = DB()
		let data = dbHandler.getList()

		for i in 0..<data.count {
			var thisPost = [String:String]()
			thisPost["title"] = data[i]["title"]
			thisPost["synopsis"] = data[i]["synopsis"]
			thisPost["titlesanitized"] = data[i]["title"]!.slugify()
			ary.append(thisPost)
		}
		values["posts"] = ary

		contxt.extendValues(with: values)
		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}




struct StoryHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
	// This is the function which all handlers must impliment.
	// It is called by the system to allow the handler to return the set of values which will be used when populating the template.
	// - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
	// - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.

	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		var values = MustacheEvaluationContext.MapType()
		let request = contxt.webRequest
		let titleSanitized = request.urlVariables["titlesanitized"] ?? ""

		let dbHandler = DB()
		let data = dbHandler.getStory(titleSanitized)

		if data["title"] == nil {
			values["title"] = "Error"
			values["body"] = "<p>No story found</p>"
		} else {
			values["title"] = data["title"]
			values["body"] = data["body"]
		}

		contxt.extendValues(with: values)
		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}



