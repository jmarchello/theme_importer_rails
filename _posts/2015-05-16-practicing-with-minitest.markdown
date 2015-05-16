---
title: "Practicing with minitest"
date: "2015-05-16 00:40"
---
# Practicing with minitest

We are still in the middle of planning how we are going to implement bootstrapify to work it's magic. We have tried doing some UML diagrams and such, but our plans are still a bit too nebulous. The implementation is going to be more complicated than I anticipated and I need to make sure that we play well with Rails, which is very opinionated. In the meantime, I'll share some things I've learned about minitest, which we will be using to implement our TDD.

## How does a test work?

Automated tests focus on assertions. An assertion is a declaration of something that should be true. For example, if I assert that a + b = 5, than a + b should equal 5. If they don't, I know something is wrong. Minitest, like most testing frameworks, has a set of custom assertions that can be used to make sure everything is working correctly. So when I write a test, I create an assertion of what I expect the outcome of the method tested to be.

## So lets get testing.

Here is a simple test class I created.

{% highlight ruby %}
require 'minitest/autorun'
require_relative 'cool.rb'

class TestCool < Minitest::Test
  def setup
    @cool = Cool.new
  end

  def test_cool_addition
    assert_equal 9, @cool.addition(3, 6)
  end

  def test_cool_logic
    assert_equal "true", @cool.logic(10)
  end

  def test_cool_string_concatination
    assert_equal "Hello World", @cool.string_concatination("Hello", "World")
  end
end
{% endhighlight %}

You'll notice that i've included mintest, as well as `cool.rb` wich is the class I will be testing. Right now cool is just a stub that looks like this:

{% highlight ruby %}

class Cool

end

{% endhighlight %}

That's because with TDD, we write the test first. Then the test will tell us what we need to implement. You'll also notice I have class that inherits from `Minitest::Test`. Next I've implemented a method called `setup`. This method is a special method for minitest. It will get called before each of the other methods below. And each of those methods test a different method of `Cool`. The `assert_equal` method will make sure that the method output is the same as what I expect it to be.

Looking at my test above, I need 3 methods: `addition`, `logic`, and `string_concatination`. But first I'll run my test and make sure it fails.

{% highlight text %}
$ ruby -Ilib:test test.rb
Run options: --seed 33195

# Running:

EEE

Finished in 0.002071s, 1448.5756 runs/s, 0.0000 assertions/s.

  1) Error:
TestCool#test_cool_logic:
NoMethodError: undefined method `logic' for #<Cool:0x000001010bfb10>
    test.rb:14:in `test_cool_logic'


  2) Error:
TestCool#test_cool_addition:
NoMethodError: undefined method `addition' for #<Cool:0x000001010bf638>
    test.rb:10:in `test_cool_addition'


  3) Error:
TestCool#test_cool_string_concatination:
NoMethodError: undefined method `string_concatination' for #<Cool:0x000001010bf110>
    test.rb:18:in `test_cool_string_concatination'

3 runs, 0 assertions, 0 failures, 3 errors, 0 skips
{% endhighlight %}

So now we see `EEE` and some error messages as the results of our tests, along with a summary at the bottom. We ran 3 tests, and got 3 errors. Right now this is a good thing because we haven't written any code yet. You'll notice that each error tells us that we are missing a method in my `Cool` class. So lets implement one of those methods.

Here I've implemented `addition`.

{% highlight ruby %}
class Cool
  def addition(a, b)
    a + b
  end
end
{% endhighlight %}

Now when I run my test, at least one test should pass. Lets see.

{% highlight text %}
$ ruby -Ilib:test test.rb
Run options: --seed 39964

# Running:

E.E

Finished in 0.001586s, 1891.5511 runs/s, 630.5170 assertions/s.

  1) Error:
TestCool#test_cool_logic:
NoMethodError: undefined method `logic' for #<Cool:0x000001010b9ff8>
    test.rb:14:in `test_cool_logic'


  2) Error:
TestCool#test_cool_string_concatination:
NoMethodError: undefined method `string_concatination' for #<Cool:0x000001010b9648>
    test.rb:18:in `test_cool_string_concatination'

3 runs, 1 assertions, 0 failures, 2 errors, 0 skips
{% endhighlight %}

Now the output shows `E.E` and only 2 errors instead of 3. The `.` represents a successful assertion, and each `E` represents an error. So according to TDD, I am done with `addtion`. It is complete and is functioning properly.

Now I'll implement the rest of the methods:

{% highlight ruby %}
class Cool
  def addition(a, b)
    a + b
  end

  def logic(num)
    if num % 2 == 0
      return "true"
    else
      return "false"
    end
  end

  def string_concatination(string1, string2)
    string1 + " " + string2
  end
end
{% endhighlight %}

Now when I run my tests, I get the following.

{% highlight text %}
$ ruby -Ilib:test test.rb
Run options: --seed 43691

# Running:

...

Finished in 0.001922s, 1560.8741 runs/s, 1560.8741 assertions/s.

3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
{% endhighlight %}

No errors and no failures! Looks like my tests passed! So now I know that my `Cool` class is complete and working properly. We've just carried out TDD with minitest. Pretty simple don't you think?
