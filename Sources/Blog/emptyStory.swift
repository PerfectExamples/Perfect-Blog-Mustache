//
//  emptyStory.swift
//  Perfect-Blog-Mustache
//
//  Created by Jonathan Guthrie on 2016-09-28.
//
//

import Foundation
import PerfectMustache
import PerfectHTTP

// handles and empty story url.
// simply an alternative way of dealing with invoking the assembly.

func emptyStory(_ webRoot: String, request: HTTPRequest, response: HTTPResponse) {
	mustacheRequest(
		request: request, response: response,
		handler: emptyStoryHandler(),
		templatePath: webRoot + "/emptyStory.mustache"
	)

}

struct emptyStoryHandler: MustachePageHandler { // all template handlers must inherit from PageHandler

	// This is the function which all handlers must impliment.
	// It is called by the system to allow the handler to return the set of values which will be used when populating the template.
	// - parameter context: The MustacheWebEvaluationContext which provides access to the HTTPRequest containing all the information pertaining to the request
	// - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.

	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
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
