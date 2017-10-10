//
//  main.swift
//  Perfect Blog Mustache Example
//
//  Created by Jonathan Guthrie on 2016-09-28.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

// Create HTTP server.
let server = HTTPServer()

// Set the webroot directory so static files such as the logo, can be served
server.documentRoot = "./webroot"

// Create the container variable for routes to be added to.
var routes = Routes()

// setting up the database at runtime
var dbHandler = DB()
dbHandler.create()
dbHandler.populate()

// Adding a route to handle the root list
routes.add(method: .get, uri: "/", handler: {
	request, response in

	// Setting the response content type explicitly to text/html
	response.setHeader(.contentType, value: "text/html")
	// Setting the body response to the generated list via Mustache
	mustacheRequest(
		request: request,
		response: response,
		handler: ListHandler(),
		templatePath: request.documentRoot + "/index.mustache"
	)
	// Signalling that the request is completed
	response.completed()
	}
)

// Serve a story
routes.add(method: .get, uris: ["/story","/story/{titleSanitized}"], handler: {
	request, response in

	let titleSanitized = request.urlVariables["titlesanitized"] ?? ""

	// Setting the response content type explicitly to text/html
	response.setHeader(.contentType, value: "text/html")

	if titleSanitized.characters.count > 0 {
		// Setting the body response to the generated list via Mustache
		mustacheRequest(
			request: request,
			response: response,
			handler: StoryHandler(),
			templatePath: request.documentRoot + "/story.mustache"
		)
	} else {
		// Setting the body response to the generated list via Mustache
		emptyStory(request.documentRoot, request: request, response: response)
	}

	// Signalling that the request is completed
	response.completed()
	}
)


// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
