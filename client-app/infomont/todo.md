- Watch out for pairing style (driver driving on it's own, vs being navigated)
- Discuss if we want to focus on result or learning.

NEXT
- Show default English text description
- Refactoring and cleaning up
- Add language parameter to the app for the descriptions, display user language or fall back to english if necessary

LATER
- Create correct data for the portions
- Find a way to create hike options description
- Integrate Map Visualization
- Create the screen for the hike option details
- Show the hike option details on the map
- Regenerate hike options for all the connecting points


NEW FEATURES - Backend
- Create a backed (web mainly because of ease of use to insert data). It needs to contain the following features:
	- Add / edit country
	- Add / edit mountain area
	- Add / edit point
	- Add / edit portion

- Create a hike options generator that takes all the portions from the mountain area and uses a graph search algorithm (for example A*) to connect all the options between all the portions, and insert a hike for all the found options. This hike will have all the needed aggregated data (total duration, marks, marks quality, etc). This feature should be accesible only to admins, from the backend.


NEW FEATURES - Mobile
- Add a map to the existing screen showing the hike options
- Create a new screen where to show the detailed hike options (containing all the portions)
- Add a map to the existing screen showing the hike options details (containing all the portions)
- Record a hike with the gps of the phone and upload the GPS track (GPS points and waypoints)
- Analyze the kike points uploaded and add them to an the existing portions
