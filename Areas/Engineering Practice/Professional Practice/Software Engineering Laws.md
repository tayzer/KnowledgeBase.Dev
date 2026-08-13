# S of tw ar e E ng in ee ri ng L aw s
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #engineering-practice #professional-practice

## TL;DR / Quick Reference

**Definition:** Reference guidance for S of tw ar e E ng in ee ri ng L aw s.

**When to use:**
- Use this note when making a decision about S of tw ar e E ng in ee ri ng L aw s.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.

> MURPHY’S LAW  
> “Anything that can go wrong will go wrong.”

  
Probably one of the most famous of all laws, mostly because it is not only applicable to software development.

![fundamental_laws_02](https://codium.one/images/blog/2022_06/fundamental_laws_02.jpeg)

**First derivation:** If it works, you probably didn’t write it.  
**Second derivation:** Cursing is the only language all programmers speak fluently.  
**Conclusion:** A computer will do what you write, not what you want.

Defensive programming, version control, doom scenario’s (for those damned zombie-server-attacks), TDD, MDD, etc. are all are good practices for defending against this law.

> Brooks’ law  
> “Adding manpower to a late project makes it later.”

  
The Mythical Man Month, written by Fred Brooks in 1975, is the source of Brooks’ law. It operates on the premise that the team members and the number of months required are interchangeable. This is not true, especially when developing software (or any product development, for that matter). Why? due to the time required to inform and update individuals on the project.

![fundamental_laws_03](https://codium.one/images/blog/2022_06/fundamental_laws_03.png)

> Conway’s law  
> “Any piece of software reflects the organizational communication structure that produced it.”

  
This rule of software development was stated by Melvin Conway in 1967. Product design is related to Conway’s law. The influence of communication architecture on software production is an observed phenomena.

Thus, a close-knit team that works in unison develops software that has intertwined features and code.

Meanwhile, a looser, decentralized team produces more modular software.

> Murphy’s law  
> “If something can go wrong, it will.”

  
This is the most well-known and universally applicable law on this list. Murphy’s law is visible in all realms of project management, software development and life in general.

Murphy’s rule emphasizes a crucial idea in software development: computers act according to instructions rather than user preferences.

> Hofstadter’s law  
> “It always takes longer than you expect. (Even when you factor in Hofstadter’s law.)”

  
One of the most feared questions in software development is “How long will it take?” The explanation is given by Hofstadter’s law.

This is connected to another rule, known as Parkinson’s law, which states that work expands to take up all of the time necessary to complete it. It is very difficult to predict the completion time due to Parkinson’s law and Hofstadter’s law.

![fundamental_laws_04](https://codium.one/images/blog/2022_06/fundamental_laws_04.png)

>   
> Linus’ law  
> “Given enough eyeballs, all bugs are shallow.”

  
This law was described using the famous The Cathedral and the Bazaar essay, explaining the contrast between two different free software development models:

The Cathedral model, in which source code is available with each software release, but code developed between releases is restricted to an exclusive group of software developers.  
The Bazaar model, in which the code is developed over the Internet in view of the public.  
The conclusion?

The more widely available the source code is for public testing, scrutiny, and experimentation, the more rapidly all forms of bugs will be discovered.

> Goodhart’s law  
> “When a measure becomes a target, it ceases to be a good measure.”

  
An example of Goodhart’s law in software development is lines of code. Lines of code provide a way to measure the size of a software product. But, when used as a target, code quality drops. Lines that should need refining or cutting from the software are instead built on, creating a messy plate of spaghetti code.

> Gall’s law  
> “A complex system that works has evolved from a simple system that worked. A complex system built from scratch won’t work.”

  
Gall’s law, if it holds true (which it seems to do), is a good reason to start software product development with a minimum viable product (MVP).

> Zawinski’s Law  
> “Every program attempts to expand until it can read mail. Those programs which cannot expand are replaced by ones that can.”

  
Speaking of complexity, Zawinski’s law suggests that, once built, products continue to expand. They add more areas of functionality until they cannot expand any more. Instances of feature creep illustrate Zawinski’s law in software development. Bloated programs soon get dropped for more streamlined options.

> Eagleson’s law  
> “Any code of your own that you haven’t looked at for six or more months might as well have been written by someone else.”

  
Many think Eagleson an optimist — suggesting that six months is a generous timeframe. Either way, Eagleson’s law highlights the need for clear, effective commenting and clear coding standards. After all, not even the original programmer could decipher messy code later down the line.

> Lubarsky’s law  
> “There’s always one more bug.”

Finally, for all your programming best practices, updates, and maintenance, there is always one more bug to fix. Or one more thing to tweak, or add, or learn. A programmer’s work is never done, after all. So, remember, when it comes to software development, done is better than perfect!

>   
> Ninety-Ninety Rule:  
> “The first 90% of the code takes 10% of the time.  
> The remaining 10% takes the other 90% of the time!”
> 
>   
> Knut’s optimization principle:  
> “Premature optimization is the root of all evil!”

  
If you try to optimize with future states in mind trying to account for future edge cases, you will inherently keep increasing the complexity of the solution of the system itself while not even properly knowing what the future problem state would exactly be.

## Related Concepts
- [[Areas/_Index|Software Engineering Knowledge Base]]

## Review Schedule
- [ ] Review in 3 months.
