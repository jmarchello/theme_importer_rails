---
title: "Test Driven Development"
date: "2015-05-08 23:10"
---

# Test Driven Development (TDD)

After some careful consideration, We've decided that linear approach in Phase 1 would not be a wise choice. Software development is just too variable to have everything planned out before any code is written. As one works they tend to find new problems and new solutions. Because of this we are taking a more agile approach and focusing on Test Driven Development.

## What is TDD?
If you've never heard of Test Driven Development (TDD), than allow me to explain. TDD is a software engineering philosophy that uses tests to specify behavioral and functional requirements of an application.

The idea is this, before I implement some piece of functionality, I will first write an automated test that verifies it. I run said test, which will obviously fail since I have not yet written any functional code. I will then implement the feature, and run the test again. If the test passes, that feature is complete. If the test fails, I revise my work and try again.

Many believe this methodology is primarily for verifying code quality and facilitating regression testing. But while these are beneficial side-effects (and big selling points for me), the main purpose of TDD is to specify requirements and provide focus when developing. When a test is written, it becomes a criteria that must be met. Your sole goal is to pass the test. This helps you focus on the task at hand, and keeps you from writing unnecessary code. If you write a series of tests, you know have an effective task list with indication when each task is completed (the passing of a test).

## How we will use TDD.
For Bootstrapify, Phase 1 of development will focus on mastering this paradigm. We will use two different kinds of tests to provide guidance and feedback regarding our efforts. The first kind of test will be an Acceptance test. This is a test that addresses high level behavior, rather than low level functionality. In other words, it will make sure a part of the app is accomplishing what its intended to accomplish. We will write out a series of Acceptance tests that will effectively lay out the our requirements for phase 1. As we go about developing we will focus on passing each one of these tests.

During that process, we will use another type of test to verify our work on a lower level, as well as provide regression testing. This kind of test is called a Unit Test and each one will verify the output of individual methods in our code. As we work to complete a higher level acceptance test, we will write a unit test before writing each method. By doing this, we will provide a framework for each method and ensure that it is written with as few bugs as possible.

And so we will proceed throughout Phase 1, addressing each acceptance test by implementing out code one unit test at a time.

## Rspec or Minitest?

Before wrapping up, I'd like to mention which testing framework I've decided to use for Bootstrapify. For Ruby, there seem to be two options that stand out: [rspec](http://rspec.info/) and [minitest](https://github.com/seattlerb/minitest). I had originally assumed that we would use rspec because it seemed to be the most popular ruby testing framework out there. But since I've never done TDD before, I decided to look into a couple of different options. That's when I discovered minitest. From what I found regarding rspec and minitest, they both serve the same purpose and they both do a fairly good job. But one thing stood out to me that made me pick minitest, which can be summarized by the following quote

> rspec is a testing DSL. minitest is ruby.
>-- Adam Hawkins, "Bow Before MiniTest"

A DSL is a "domain specific language", which means that its a language written within a specific scope. In other words, rspec has devised it's own language for testing, why minitest uses common ruby syntax. Why does this matter? For some it may not, but for me, I've learned that the more obvious your code is, the better it is to work with. Being a Rails developer, I'm used to things happening "automagically". But i'd prefer to know what's going un under the hood. That is why I prefer minitest, one can see what exactly it is doing in plain old ruby language.

So that's TDD as I see it, and I can't wait to get my hand dirty trying it out!


**References**

[Introduction to Test Driven Development (TDD)](http://agiledata.org/essays/tdd.html)

[rspec](http://rspec.info/)

[minitest](https://github.com/seattlerb/minitest)
