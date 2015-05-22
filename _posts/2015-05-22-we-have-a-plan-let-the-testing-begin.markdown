---
title: "We have a plan, let the testing begin!"
date: "2015-05-22 02:35"
---
# We have a plan, let the testing begin!

The planning phase of this gem has taken longer than expected. We wanted to make sure that the gem loaded theme assets into the asset pipeline correctly, rather than hacking rails. At long last we've found a way to accomplish our goal, and it's time to start writing our tests. Allow me to explain how Bootstrapify will work it's magic.

## What to do with CSS and JavaScript

The rails asset pipeline has three places you can put CSS and JavaScript files. They are `app/assets/`, `vender/assets/`, or `lib/assets`. The folder we want to use is `vender/assets` because it is the correct place to add third party assets. And since our gem will be importing a theme, we want it to load it there. Rails has two manifest files that tells the asset pipeline where to look for CSS and JavaScript files. These files basically contain a list of assets. The thing is, normally when a developer puts a theme in their application, they have to add each file of the theme to these manifest files. This can be very time consuming and annoying. Thankfully, Rails also allows you to create your own manifest files. So what Bootstrapify will do is index each CSS and JavaScript file in the theme and programmatically create manifest files with the resulting lists (one for CSS, one for JavaScript). Now all the developer has to do is add our generated manifest files to their master manifest files and their done! The assets will work like a charm, and the developer will never need to change their manifest file again.

## Fonts and Images

Now that we have CSS and JavaScript assets working great, we need to deal with fonts and images. This has been a difficult problem with themes and Rails, especially on production servers that precompile all of your assets when your app is deployed. In the end, the solution is simple. We will scan through the theme and index each image and font that we find, then we will copy those files into either `public/assets/fonts/` or `public/assets/images/` depending on what they are. We will then scan through our CSS and JavaScript files and edit an references of those fonts and images to point to their new location. And just like that, fonts and images are accessible in development and production!

## Now let's get testing!

Now that we know what we want our gem to do, it's time to write our Acceptance and Unit tests. This is where things will get really exciting! We need to write Acceptance tests to verify that styling is working correctly, and Unit test to make sure each method responsible for moving and editing files work correctly. Let the coding begin!
