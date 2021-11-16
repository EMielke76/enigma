## Self-evaluation for Enigma project

###Functionality
**Meets expectations**
- #Encrypt and #Decrypt methods are both successfully implemented
- Encrypt/Decrypt Runners/CLI successfully implemented
- Didnt have the brain power/time for #cracking

###Object Oriented Programing
**Above Expectations**
- 4 modules were used for this project
- Each module encapsulates one portion of functionality within the program, and only one portion.
- Modules seemed like the logical choice over classes due to there being no need for any classes to hold state/attributes. A collection of methods that could be tested, then shared to the various parts of the program that needed them seemed like the logical way to ensure SRP were adhered to, as well as adding a layer of abstraction to the program.
- As I only had one class, Enigma, there was no need to implement/use inheritance. No classes needed to inherit anything from Enigma, instead I chose to create mixins and use them liberally.

###Ruby Conventions and Mechanics
**Meets Expectations**
- I've got two methods that are 11 and 12 lines long, so by the letter of the law, I'm outside the parameters for Above Expectations. Outside of that, I'd say this is the cleanest, least "smelly" project I've ever touched.

###TDD
**Meets Expectations**
- Every method has been tested at both the unit and integration level, all actions have been verified. Edge cases have been addressed (as far as I am aware...), and test coverage is 100%
- No mocks or stubs were used, I simply used dummy data to ensure all my methods/code was producing effectively.

##Version Control
- 0 commits straight to main, all PR's come from branches. Sitting on 40+ commits at the time of writting, expect that to increase by one with I send the README to main.
