# MoviesDB
Tabbed app following the presented design to look and search your favorite movies.

- A home tab with the trending and popular movies now and from any time.
- Searching tab to look for specific movies based on their names.
- A watchlist tab, to not forget the movies you added, even when you have no internet connection.


https://github.com/user-attachments/assets/a4c8433c-62e6-493b-a759-d3d29403fb75

https://github.com/user-attachments/assets/7229236a-959b-4cf2-9bab-477e31c80baa

## Challenge questions

###  What does the single responsibility principle consist of? What's its purpose?
SRP is the first of the SOLID principles, and its main purpose is to keep the code scalable and maintainable over time. The idea is that every module or class should have one and only one motive to exist and to change. So, if there is a class that has many responsibilities and does a lot of processing tasks, it's a candidate for being modularized into several classes with only one purpose. 

### What characteristics does, in your opinion, a “good” code or clean code have?
A clean code should have many aspects to be considered clean/good. For instance, it has to be legible and modularized in a way that could be easily expanded or scaled when the software becomes more complex. It's crucial to choose a proper architecture for the software to implement, so many future problems can be attacked from the ground on. The SOLID principles are good examples of good practices and helpers to achieve this. Also, in Swift is very common to follow a Protocol-Oriented development, which facilitates the evolution of the participating classes regarding the business logic, as well as the testing one.


## Future work and possible improvements

- Improve animations within every screen in the app.
- Improve the caching strategy to lose fewer photos when there is no connection.
- Improve the quality and quantity of the Unit tests.
- Improve the searching feature to search by more fields than only the name.
- Improve the loading states in the UI, for instance, adding skeletons on each screen.
