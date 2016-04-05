# Final Project - *Events*

Time spent: **4** weeks spent in total
## Overall

   Event social network where every body can create, interest, join events base on some entertainment categories (activities, sport, going out, gaming, workshop ...). Users can organizate event by themself (add photos, short description, address, time range...), invite your friend, share public. Allow users to create event's chat group to discuss, to prepare or to make it special. If events is interested, users can add to calendar or check "interested" to reminder. The application will connect people via events!

## User Stories

The following is **basically** functions:

###1. Login
   - As user, you can register by email, password.
   - As user, you must verify email by click on "verify url".
   - As user, you can login native, Facebook, Google Plus.
   - As user, you can navigate into "Forgot password" if you forgot your password. You must fill in your email to get the new one.

###2. Getting start
   - As user, you navigate into "My Profile" immediately after successful register/login. You can upload your profile image. You can edit your Name, Email, Gender, Radius, pick your Location.
   - As user, you navigate into "Your interest" to choose events categories what you want to participate.

###3. Structure
   - As user, you have 5 tabs: Home, My Event, Create Event button, Notification Center, Message at bottom .
   - As user, you have "My profile" and "Settings" icon on navigation bar, to navigate to your profile and settings respectively.

###4. Home (Tab 1)
   - As user, you can view a list of event of your friend, public event, invitation event. Each item will show event image, name, category, address, time. You can also like, comment, or "favorite" to save this event. 
   - As user, you can view 4 types of item: your event (create by yourself), public/friend's event, public/friend's status, and current event.
   - As user, you want to show the current event in case it is from 15 minnutes before event start to 60 minutes after event end, if not current event will disappear. (base on event time).
   - As user, you can navigate to event detail by click on item, navigate to profile detail by click on profile image, navigate to image full screen mode by click on it.
   - As user, you can see the Stream Update of current event if you are part of event, else Stream Update will disappear.
   - As user, you can see all of people who join event at Stream Update. You can push photos into Stream Update.

###5. My Event (Tab 2)
   - As user, you have 3 tabs inside My Event: Mine, Private, Public
   - Mine:
      + As user, you have 2 sections: All events what you organize, All events what you have Accepted/MayBe.
      + As user, in organization event, you can Edit, Cancel, Add to calendar, share via FB or Google+. You can also see all of people who participate.
      + As user, in Accepted/Maybe, you can share via FB or Google+. You can reponse (Going, Not Going, MayBe). You can add to calendar.
   - Private: is all events what are invited by your friends
      + As user, you can share via FB or Google+, You can response (Going, Not Going, MayBe, or Interested to view later).
   - Public: is all events what are public state, and inside your settings radius.
      + As user, you can share via FB or Google+, You can response (Going, Not Going, MayBe, or Interested to view later).

###6. Create Event (Tab 3)
   - As user, you can upload event poster.
   - As user, you can select state (Public, Friend, Private).
   - As user, you can name event, select category, pick date/time, pick location, set limitation of attendees, give some description.
   - As user, you save event, then navigate into invite friend. You can pick friends here. You can search friend by name too.
   
###7. Notification center (Tab 4)
   - As user, you have 2 tabs inside Notification: Friends Request, Events Reminder.
   - As user, in Friends Request, you will see a list of notification about friends request.
   - As user, in Events Reminder, you will see a list of notification about event such as (some body response, like, comment your event).

###8. Message (Tab 5)
   - As user, you will see all message thread on the main message screen. Each item will show name, profile image, last message, time ago.
   - As user, you can create new single/group chat by click on the top right icon. Then, it navigate into pick friend screen, pick friends and chat.
   - As user, you will only simple chat with text only. List of chat message will be section by date (today, yesterday, ...), and message align left and right with time ago. Message input and send button locate at the bottom of screen.
   - As user, you can swipe left to delete a thread message.
   
###9. Settings
   - As user, you can see number of friend, can also navigate to friends list.
   - As user, you can find friends from FB and Google+.
   - As user, you can change your interested categories.
   - As user, you can navigate to list interested events.
   - As user, you can logout.

###10. Event Detail
   - As user, you go into this screen by click on event item.
   - As user, you will see event infomations such as event poster, event's host image, name, state, category, number of interest/going/invited, datetime, address, description, event album.
   - As user, you can response here (Going, Not Going, Maybe, or Interested).
   - As user, you can see a list of comments, and also comment.

###11. Profile
   - As user, you will see many infos such as profile image, name, all of categories, list friend, your organization events.
   - As user, if this is another user, you can add friend, create message. Otherwise, you can edit your profile.

## Mobile-oriented features:
   - Application use Map, location, camera, push.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

  1.
  2.


## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/swRO9PL.png' title='Login' width='200' />  <img src='http://i.imgur.com/XfVnHi1.png' title='Getting Start' width='200' />  <img src='http://i.imgur.com/2WbPldJ.png' title='Your interested' width='200' /> <img src='http://i.imgur.com/lsmjSEJ.png' title='Home' width='200' />

<img src='http://i.imgur.com/z3Dq00k.png' title='Events - Mine' width='200' />  <img src='http://i.imgur.com/2wArAv5.png' title='Events - Private' width='200' />  <img src='http://i.imgur.com/GY6dH0D.png' title='Events - Public' width='200' /> <img src='http://i.imgur.com/7Tb5rUh.png' title='Notification - Friend Request' width='200' />

<img src='http://i.imgur.com/qFjIqc2.png' title='Notification - Reminder' width='200' />  <img src='http://i.imgur.com/ps5gW4S.png' title='Message' width='200' />  <img src='http://i.imgur.com/s1MVLjx.png' title='Message - Create New' width='200' /> <img src='http://i.imgur.com/nbVnsfx.png' title='Conversations' width='200' />

<img src='http://i.imgur.com/Rsdh5Cp.png' title='Profile - My Profile' width='200' />  <img src='http://i.imgur.com/aPzcW80.png' title='Profile - User profile' width='200' />  <img src='http://i.imgur.com/KfY10Oc.png' title='Event - Create New' width='200' /> <img src='http://i.imgur.com/B0ME1GC.png' title='Event Detail - Photos' width='200' />

<img src='http://i.imgur.com/CSYQA9E.png' title='Event Detail - Comments' width='200' />  <img src='http://i.imgur.com/2sEyG3W.png' title='Settings' width='200' />  

Wireframe created with [NinjaMock](https://www.ninjamock.com).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2016] [coderschool - group3 - HoangNguyen - PhuongLe - TriNgo]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
