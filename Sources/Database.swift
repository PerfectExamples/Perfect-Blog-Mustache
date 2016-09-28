//
//  Database.swift
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

// bandles database interactions
class DB {
	// The path to the SQLite database file
	let dbPath = "./blog-database"

	// Create the database, and table.
	func create() {
		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			try sqlite.execute(statement: "CREATE TABLE IF NOT EXISTS blog (id INTEGER PRIMARY KEY NOT NULL, title TEXT NOT NULL, titlesanitized TEXT NOT NULL, synopsis TEXT NOT NULL, body TEXT NOT NULL)")

		} catch {
			//Handle Errors
			print(error)
		}
	}

	// Seed the demo database with dummy data
	func populate() {
		let data = [
			["The Big List of Fun Things to Do By Yourself","This is a list of fun things you can do by yourself (or with friends in some cases).","<h3>The Beauty of Being Alone</h3><p>This is a list of fun things you can do by yourself (or with friends in some cases).  I’ve included TONS of links to some GREAT sites that can help get you moving and keep you entertained, so please feel free to share this post with your friends!</p><p>So, what are some things to do by yourself?  Well, there are a lot of things that you can do, but the direction you’ll want to take might depend on your situation.  By the way, there is a big difference between being alone and being lonely.  If you aren’t clear on that, watch this amazing video I came across.  The message can change the way you look at your life!</p><h3>Enjoy Your Day!</h3><p>Are you looking for a break from a busy daily routine?  If so, you might have to actually schedule your alone time.  Maybe you’re at a time in your life when you just don’t have very much to do, or people to do things with.  Don’t fret.  Make the most of your alone time.  Maybe learning to meditate or developing a new skill would be more productive than dropping on to the couch and watching TV.  What follows are some ideas to get you going."],
			["LED icicle lights","The Basics LED Christmas lights, sometimes referred to as LED icicle lights, have grown rapidly in popularity in recent years. There are actually two distinct types of lights that are popularly known by this name","<p>LED Christmas lights, sometimes referred to as LED icicle lights, have grown rapidly in popularity in recent years. There are actually two distinct types of lights that are popularly known by this name.  First are the tiny lights dangling from wires, which when suspended create a net-like effect. Also widely known as LED icicle lights are LED lights that are actually made to resemble icicles. In order to avoid confusion, some people refer to the former type of light as ‘net’ LED lights.</p><p>LED is an acronym for ‘light emitting diode’, which produces light on a different basic principle than do incandescent or fluorescent lights. Light emitting diode work by the movement of electrons through semiconductor material. They have no filaments as in an incandescent light, nor do they contain gases, as in a fluorescent or neon type light.</p>"],
			["Find Home Decor Guidance in Interior Design Books","Interior Design Books can help the novice designer as well as the experienced professional in creating unique interior designs to fit any décor.","<p>Interior Design Books can help the novice designer as well as the experienced professional in creating unique interior designs to fit any décor. Whether one wants a traditional or modern interior design, the right books can provide the guidance one needs in creating the perfect living room, bedroom, dining room or any other room in the home. Even business establishments can benefit from interior design ideas in order to make their offices more inviting and productive to employees as well as customers.</p><h3>What Room is Getting the Makeover?</h3><p>When looking for the right books on interior design, it is important to consider what room or rooms need a makeover. For instance, if one wants to give the living room a new twist, a book with furniture ideas such as couches, sofas, coffee tables and other common items found in this area should be first on the list. A book that has ideas for wall art or flooring styles most compatible with a preferred style should also be considered.</p><h3What’s Your Style?<h3><p>It is also possible to look for books based on particular decorating styles. For example, Oriental designs are popular in many households, so finding a book with Oriental design concepts and Asian furniture decorating ideas can be useful. These books can help designers find benches and stools, wooden screens and dividers or cabinets and armoires with distinct Asian designs. One may also find out what Asian inspired art such as ceramic pots, tapestries, carved statues, folding screens, jade pieces and many other decorative accents go best with the chosen decorative motif or theme.</p><h3Interior Design is for Business Too!<h3><p>Businesses also benefit from paying attention to their interior designs. An office’s atmosphere can affect the way business is conducted. Having a comfortable and cozy homelike feel to an office may put potential clients or customers at ease.  The interior design can also say volumes about the business itself from sophisticated and elegant to casual and relaxed. Choosing books that show business owners how to choose and create décor can be a great business asset, especially since first impressions are critical to businesses.</p>"],
			["How to Make Patio Lanterns","If you are looking to give your patio and backyard some type of mood inducing illumination, your first step is to put up patio lights.  However, these forms of lighting can be a stress on your budget, especially if you are trying to get something that fits your sense of style as well as functionality.","<p>If you are looking to give your patio and backyard some type of mood inducing illumination, your first step is to put up patio lights.  However, these forms of lighting can be a stress on your budget, especially if you are trying to get something that fits your sense of style as well as functionality.  If you are having trouble obtaining inexpensive and attractive lighting options, here are some tips on how to make patio lanterns on your own.hanging patio lanterns</p><p><b>Hanging Jar Lanterns:</b> Fill cleaned glass jars with a variety of candles; the shapes and sizes of both of these can be varied by taste or just by what you happen to have on hand.  Jars with a lip will work best, as you can then bend metal around the opening and hook it over to create a handle, much like an ornament.  These can then be hung from wires or tree branches, and you can replace the candles whenever they run low.</p><p><b>Touch Light Lamps:</b> Touch lights are inexpensive lighting options that you can purchase at an office supply store and are easy to turn on and off.  Create shades out of decorative paper squares, rolling them and fastening them around the touch lights.  You can even cut attractive shapes out of the paper to cast fun shadows onto your patio.  This can be a fun project to that will get the kids involved.</p><p>Concentrated Christmas Lights: Purchase strings of white (or colored, if you desire) lights during the Christmas season, when they are inexpensive.  Wrap bunches of 10-15 little bulbs together and make a paper shade similar to the one mentioned above — just make sure the paper won’t touch the bulbs.  Connect several strings together for more lights.</p>"]
		]
		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}
			// CLEAR OUT DATABASE
			try sqlite.execute(statement: "DELETE FROM blog")
			// REPOPULATE
			for i in 0..<data.count {
				try sqlite.execute(statement: "INSERT INTO blog (id,title,titlesanitized,synopsis,body) VALUES(:1,:2,:3,:4,:5)", doBindings: {
					(statement: SQLiteStmt) -> () in
					try statement.bind(position: 1, (i + 1))
					try statement.bind(position: 2, data[i][0])
					try statement.bind(position: 3, data[i][0].slugify())
					try statement.bind(position: 4, data[i][1])
					try statement.bind(position: 5, data[i][2])
				})
			}

		} catch {
			//Handle Errors
			print(error)
		}
	}

	// The function that retrieves the list of blog posts
	func getList() -> [[String: String]] {
		var data = [[String: String]]()

		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			let demoStatement = "SELECT title,synopsis FROM blog"

			try sqlite.forEachRow(statement: demoStatement, handleRow: {(statement: SQLiteStmt, i:Int) -> () in
				var contentDict = [String: String]()
				contentDict["title"] = String(statement.columnText(position: 0))
				contentDict["synopsis"] = String(statement.columnText(position: 1))
				data.append(contentDict)
			})

		} catch {
			//Handle Errors
			print(error)
		}
		return data

	}

	// Getting the story
	func getStory(_ storyid: String) -> [String: String] {
		var data = [String: String]()

		do {
			let sqlite = try SQLite(dbPath)
			defer {
				sqlite.close() // This makes sure we close our connection.
			}

			let demoStatement = "SELECT title,body FROM blog WHERE titlesanitized = :1"

			try sqlite.forEachRow(statement: demoStatement, doBindings: {

				(statement: SQLiteStmt) -> () in

				try statement.bind(position: 1, storyid)

				}, handleRow: {(statement: SQLiteStmt, i:Int) -> () in
				data["title"] = String(statement.columnText(position: 0))
				data["body"] = String(statement.columnText(position: 1))
			})

		} catch {
			//Handle Errors
			print(error)
		}
		return data
	}
}

