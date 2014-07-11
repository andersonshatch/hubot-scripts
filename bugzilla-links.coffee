# Description:
#   Link references to "bug <n>"
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_BUGZILLA_LINKS_URL_ROOT - URL root for bugzilla e.g. http://bugzilla.example.com
#
# Commands:
#   None
#
# Author:
#   andersonshatch

module.exports = (robot) ->
	urlRoot = process.env.HUBOT_BUGZILLA_LINKS_URL_ROOT
	unless urlRoot?
		robot.logger.warning("Will not linkify bug references, HUBOT_BUGZILLA_LINKS_URL_ROOT not defined")
		return

	urlRoot += "/" if urlRoot[urlRoot.length - 1] != "/"

	bugPrefixRegex = new RegExp("bug ", "i")

	robot.hear /bug (\d+)/ig, (msg) ->
		responseText = ""

		for match in msg.match
			responseText += "\n" if responseText.length > 0
			responseText += urlRoot + "show_bug.cgi?id=" + match.replace(bugPrefixRegex, "")

		msg.send responseText
