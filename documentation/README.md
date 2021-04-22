# RDOC vs YARD

## RDOC

RDOC was the only way to document a ruby project, It analyzes Ruby source code, generating a structured collection of pages for Ruby objects and methods

GEM documentation → <https://ruby.github.io/rdoc/index.html>

### How to use RDOC?

Once installed, you can create documentation using the rdoc command

`rdoc [options] [names...]`

If a name is a directory, it is traversed. If no names are specified, all Ruby files in the current directory (and subdirectories) are processed.

Options that can be passed when generating the documentation:

#### --all

include protected and private methods in the output (by default only public methods are included)

#### -t, --title=TITLE

Set TITLE as the title for HTML output.

#### -x, --exclude=PATTERN

Do not process files or directories matching PATTERN.

#### -q, --quiet

Don't show progress as we parse.

#### -V, --verbose

Display extra progress as RDoc parses

#### -v, --version

Print the version

#### -h, --help

Display the help

### Example of the command

`rdoc --all --exclude test -t "POKEMON API" -V`

### How to document with RDOC?

Comment blocks can be written fairly naturally.

1. Paragraphs are lines that share the left margin. Text indented past this margin are formatted verbatim.

```ruby
    1. Lists are typed as indented
       paragraphs with:
       * a '*' or '-' (for bullet lists)
       * a digit followed by a period for
         numbered lists
    2. Just for testing
```

2. Labeled lists (sometimes called description lists) are typed using square brackets for the label.

```ruby
[cat] small domestic animal
[+cat+] command to copy standard input
```

3. Headings are entered using equals signs and so on

```ruby
= Level One Heading
== Level Two Heading
```

4. Non-verbatim text can be marked up

```ruby
italic:word or <em>text</em>
bold:word or <b>text</b>
typewriter:word or <tt>text</tt>
```

5. Names of classes, source files, and any method names containing an underscore or preceded by a hash character are automatically hyperlinked from comment text to their description.

6. RDoc stops processing comments if it finds a comment line containing '#--'. This can be used to separate external from internal comments or to stop a comment from being associated with a method, class, or module. Commenting can be turned back on with a line that starts '#++'.


```ruby
# Test interminent comments
#--
# This is a internal comment (Will not be displayed)
#++
# This will displayed
```

## YARD

GEM documentation → <https://rubydoc.info/gems/yard/file/README.md>

### How to use YARD?

Once installed, you can create documentation using the rdoc command

`yard doc [options]source_files [- extra_files]]`

Options that can be passed when generating the documentation:

#### --no-public

Don't show public methods. (default shows public)

#### --one-file

Generates output as a single file on the doc folder with the name index.html

#### --protected

Show protected methods. (default hides protected)

#### --private

Show private methods. (default hides private)

#### --no-private

Hide objects with @private tag

#### --title TITLE

Add a specific title to HTML documents

#### --type-name-tag TAG:TITLE

Tag with optional types and a name field

#### -q, --quiet

Show no warnings.

#### --verbose

Show more information.

Example of the command

`yardoc app/**/\*.rb test/**/_.rb lib/\*\*/_.rb --private --type-name-tag controller_action_param:"Controller Action Parameters"`

### More YARD Commands

The following commands are available in YARD 0.6.x (see yard help for a full list):

Usage: `yard <command> [options]`

Commands:

* **config**   Views or edits current global configuration
* **diff**     Returns the object diff of two gems or .yardoc files
* **doc**      Generates documentation
* **gems**     Builds YARD index for gems
* **graph**    Graphs class diagram using Graphviz
* **help**     Retrieves help for a command
* **ri**       A tool to view documentation in the console like `ri`
* **server**   Runs a local documentation server
* **stats**    Prints documentation statistics on a set of files

### How to document with YARD?

YARD use tags as an easy way to document code

#### @abstract description

Marks a class/module/method as abstract with optional implementor information.

Example:

```ruby
# @abstract Subclass and override {#run} to implement
# a custom Threadable class.
class Runnable
def run; raise NotImplementedError end
end
```

#### @deprecated description

Marks a method/class as deprecated with an optional description. The description should be used to inform users of the recommended migration path, and/or any useful information about why the object was marked as deprecated.

Example:

Deprecate a method with a replacement API

```ruby
# @deprecated Use {#bar} instead.

def foo; end
```

#### @example Optional title

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Code block**

Show an example snippet of code for an object. The first line is an optional title.

Example:

```ruby
# @example Reverse a String
# "mystring".reverse #=> "gnirtsym"

def reverse; end
```

#### @note description

Adds an emphasized note at the top of the docstring for the object

Examples:

```ruby
# @note This method should only be used in outer space.

def eject; end
```

#### @option name [Types] option_key (default_value) description

Describe an options hash in a method. The tag takes the name of the options parameter first, followed by optional types, the option key name, a default value for the key and a description of the option. The default value should be placed within parentheses and is optional (can be omitted).

Note that a @param tag need not be defined for the options hash itself, though it is useful to do so for completeness.

This can be very helpful when we use Trailblazer operations

Examples:

```ruby

# @param [Hash] opts the options to create a message with.

# @option opts [String] :subject The subject

# @option opts [String] :from ('nobody') From address

# @option opts [String] :to Recipient email

# @option opts [String] :body ('') The email's body
```

#### @param name [Types] description

Documents a single method parameter (either regular or keyword) with a given name, type, and optional description.

Examples:

```ruby
# @param url [String] the URL of the page to download
# @param directory [String] the name of the directory to save to
def load_page(url, directory: 'pages') end
```

#### @raise [Types] description

Describes that a method may raise a given exception, with an optional description of what it may mean.

Examples:

```ruby
# @raise [AccountBalanceError] if the account does not have

# sufficient funds to perform the transaction

def withdraw(amount) end
```

#### @return [Types] description

Describes the return value (and type or types) of a method. You can list multiple return tags for a method in the case where a method has distinct return cases. In this case, each case should begin with “if …”.

Examples:

A regular return value

```ruby
# @return [Fixnum] the size of the file

def size; @file.size end
```

A method returns an Array or a single object

```ruby
  # @return [String] if a single object was returned
  #   from the database.
  # @return [Array] if multiple objects were
  #   returned.
  def find(query) end
```

#### @todo description

Marks a TODO note in the object being documented.

Examples:

```ruby
# @todo Add authentication method
class User; end
```

#### Nested Params

There is not a tag for nested params, but according to the author of the gem, the approach will be the following:

```ruby
# @param [Hash<Symbol, Object>] options
#   * :order (String) ["id.asc"] the query's order
#   * :page_size (Integer) [25] the number of results per page
#   * :where (Hash<String, Object> a list of query options
#     * :name (String) get objects with given name
#     * :owner (Integer) get objects with the given owner id
```

For more information on this, visit this [issue](https://github.com/lsegal/yard/issues/622) on the YARD gem

## Helpful Links

* **YARD TAGS:** <https://rubydoc.info/gems/yard/file/docs/Tags.md>
* **YARD Cheatsheet:** <https://gist.github.com/phansch/db18a595d2f5f1ef16646af72fe1fb0e>
* **RDOC Documentation:** <https://docs.ruby-lang.org/en/2.0.0/RDoc/Markup.html>
* **RDOC resumed documentation:** <http://rdoc.sourceforge.net/doc/>
* **Demo Link:** <https://www.loom.com/share/6d0b3a3266de46b08e41b887618b0367>
