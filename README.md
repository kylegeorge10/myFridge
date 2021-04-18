


Original App Design Project - README Template
===

# myFridge

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
4. [Gifs](#Gifs)

## Overview
### Description
myFridge takes the idea of "easy to cook" to a reality. With the idea in mind that most people aren't experienced in cooking, we made an app to make it easy for you. Our app uses Pinterest's way of displaying new foods/recipes that you may be interested in. Once you click on those foods/recipes there will be a page that will display the difficulty, cooking time, and number of ingredients.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Cooking**
- **Mobile: iOS only**
- **Story: None**
- **Market: Everyone**
- **Habit: Cooking**
- **Scope: Everyone**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can login
- [x] User can logout
- [x] User stays logged in across restarts
- [x] User can post new posts
- [x] Stylized main feed
- [x] Detail page of specific post
- [] Profile screen with user's personal content
- [] Discover page with app's filtering features

**Optional Nice-to-have Stories**

- [] Page that shows what people you're following are up to (like instagram's old feature)
- [] User can repost posts that they like

### 2. Screen Archetypes

* Login screen
   * User needs to log in/sign up
* Home screen
   * This page will show what the people that you follow have posted
   * It will have a tableview setup
   * User can repost certain posts and they will show up on their page (like twitter retweet)
* Post screen
   * User can post their own food/recipes
* Suggested screen
   * This page will show the same style of suggested posts like on instagram/pinterest 
* Profile screen
   * standard profile screen (similar layout to instagram)

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Used to move between the main screens (home, suggested etc)

**Flow Navigation** (Screen to Screen)

* Suggested screen
   * When you click on a post
* Home screen
   * Each post will have a small description of the post and then when they click for more details it will bring up a fully detailed screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img width="600" alt="Screen Shot 2021-03-21 at 11 37 18 PM" src="https://user-images.githubusercontent.com/69189423/111915914-85d92b00-8a9e-11eb-8ae4-f442d8c9f0f5.png">

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |
   | reviews       | String   | review by user posted to another user's post | 
   | reviewsCount | Number   | number of reviews that has been posted to an image |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
### Networking
- [Add list of network requests by screen ]
- Home Feed
  - ```swift
           let query = PFQuery(className:"Post")
           query.whereKey("author", equalTo: PFUser.current())
           query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
              if let error = error { 
                 print(error.localizedDescription)
              } else if let posts = posts {
                 print("Successfully retrieved \(posts.count) posts.")
             // TODO: Do something with posts...
              }
           }
           ```
  - (Create/POST) Create a new review on the post
  - (Delete) Delete previous review
  - (Create/POST) Create a new post
    - Submit new post Screen
      - Screen where user can post a new post
- Suggested Feed
  - Same style as Home Feed, but of people that you aren't following (currently will only show people that you are following, but in a different style)
- Profile Screen
  - Shows profile picture
  - Posts that the user has made
- [OPTIONAL: List endpoints if using existing API such as Yelp]
  - Might use Yelp/Pinterest for certain

## Gifs
- User can login/logout and stays logged in across restarts
<img src='http://g.recordit.co/3MsoonJooy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
- User can see an appIcon and Launch Screen
- User can also see an animation while waiting for the app to complete retrive the data from the database.
<img src='http://g.recordit.co/JwfaQmny8V.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
