# CenkerDemirViaflyTestProject

Choices:

* Converted the CSV to JSON and parsed it. JSON is one of the most common output of internet APIs and easy to parse with swift.
* Created a singleton data store file to serialize the JSON file into an array of items. It is a singleton so it can be reached from any VC in the app. We have two for this app (side bar and main view VCs), but it can easily be scaled to more VCs. 
* Created an item class so different properties or even functions can be added or inheritance can be possible for future expansion. Item class gets its properties from the data file.
* Created the categories from the data file via a function. This way, if new categories are added to the data file in the future they will automatically show up on the side bar menu for filtering
* Used a side bar to show different categories and filter the items for the tableview
* Placed the sort-by-price and in-stock buttons on the navigation bar for easy access.
      - In-stock button hides the out-of-stock items upon the first tap, and unhides them with the second tap.
      - There was no out-of-stock item in the data file, so I added an item called out-of-stock item to demonstrate the button
* Created extensions for the UISearchBar protocols as i thought Main View Controllers definition was getting to crowded and did not look good. I also put them into to separate extensions as they are two different protocols, they could be merged into one.
* I downloaded sample images for each category. In a real app, each item can have its own image/images. I wanted to have some images next to the categories so we know what category each item belongs to. It is much better to separate them with images, it is visual.
* For the item price, if there is no decimal value then the price is shown without a decimal value ($50 instead of $50.0). If there is one ($58.95) then it shows 2 decimals.
* I used a 3rd part library for the sidebar (SWRevealController). It was written in Objective-C so there is a bridging header. 

Future Plans / Thoughts / Possibilities:

- Writing a script / function to parse CSV directly to JSON
- The JSON-to-Store conversion is dependent on upon the data file structure. If the data file's structure changes, the store function will need to be updated. You need to know the data structure to do this but I would like to have a more-automated solution.
- I would definitely have a detailed item page showing the details of each item when the item is tapped on the list
- Visually, the design has room to improve. So, Changing the design a little bit would be a good idea. For example, Moving the sort and in-stock buttons to a tab bar or another space. Having some other filtering options on another view, or customizing the tableview cells more (and better) to show other info, such as item ratings
- Adding barcode scanning would be needed for a future version
- When the app actually downloads the data from an api, the api client will need to be very fast to parse the data. (ignoring the data connection quality issues). 