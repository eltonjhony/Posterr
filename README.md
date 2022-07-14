### Elton Jhony Romao de Oliveira
# Posterr

## Setup instructions

Considering that iOS 15.4 has been used to develop the app, make sure to use Xcode 13+ to run the project.

## Usage instructions

I developed a hidden screen to switch between users while using the app. **Shake** :handshake: the device :iphone: to access it.

## Critique

Considering that this mobile app has been built without any API integration, it's owning more responsibility than it should. 
I would move the validations to the API in order to have a common source of truth for this kind of business logic. Also, other clients
can benefit from it. 
I would give more attention to colours and fonts as well as UI components if we had a Design system in place. It's something that tends to become a source of truth for UI related decisions.
It's valid to mention that if I had more time, improving test coverage would be a priority to make sure the app keeps evolving in a good shape.

- _Assuming you've got multiple crash reports and reviews saying the app is not working properly and is slow for specific models, what would be your strategy to tackle the problem? (assuming the app is supposed to work well for these models)_

**In this case, the idea would be to perform test cases for this scenario in order to identify the problem (maybe approaching some users to better understand it). If the application is not integrated with a fault analysis tool or backed by a remote logging tool, this should be prioritized to provide engineers with more information to identify the problem. Once the problem is identified and fixed, automated tests must be written to ensure long-term quality.**

- _Assuming your app has now thousands of users thus a lot of posts to show in the feed. What do you believe should be improved in this initial version and what strategies/proposals you could formulate for such a challenge?_

**The very first improvement would be to have a paginated feed.** 
**This strategy would drastically increase the query response time.**
**I would also provide filter options to give users the choice to filter only newest posts.**
**Move daily post limit validation to the backend in order to simplify the client.**
**Local caching strategies to hit the API only when necessary is also something important. As well as having a fallback solution to continue to show up content if there is a server outage.**