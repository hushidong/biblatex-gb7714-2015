#!/usr/bin/env python

"""
BibLaTeX check on missing fields and consistent name conventions,
especially developed for requirements in Computer Science.
"""

__author__ = "Pez Cuckow"
__version__ = "0.1.4"
__credits__ = ["Pez Cuckow", "BibTex Check 0.2.0 by Fabian Beck"]
__license__ = "MIT"
__email__ = "email<at>pezcuckow.com"

####################################################################
# Properties (please change according to your needs)
####################################################################

# links
citeulikeUsername = ""  # if no username is profided, no CiteULike links appear
citeulikeHref = "http://www.citeulike.org/user/" + \
    citeulikeUsername + "/article/"

libraries = [("Scholar", "http://scholar.google.de/scholar?hl=en&q="),
             ("Google", "https://www.google.com/search?q="),
             ("DBLP", "http://dblp.org/search/index.php#query="),
             ("IEEE", "http://ieeexplore.ieee.org/search/searchresult.jsp?queryText="),
             ("ACM", "http://dl.acm.org/results.cfm?query="),
             ]


# fields that are required for a specific type of entry
requiredFields = {"article": ["author", "title", "journaltitle/journal", "year/date"],
                  "book": ["author", "title", "year/date"],
                  "mvbook": "book",
                  "inbook": ["author", "title", "booktitle", "year/date"],
                  "bookinbook": "inbook",
                  "suppbook": "inbook",
                  "booklet": ["author/editor", "title", "year/date"],
                  "collection": ["editor", "title", "year/date"],
                  "mvcollection": "collection",
                  "incollection": ["author", "title", "booktitle", "year/date"],
                  "suppcollection": "incollection",
                  "manual": ["author/editor", "title", "year/date"],
                  "misc": ["author/editor", "title", "year/date"],
                  "online": ["author/editor", "title", "year/date", "url"],
                  "patent": ["author", "title", "number", "year/date"],
                  "periodical": ["editor", "title", "year/date"],
                  "suppperiodical": "article",
                  "proceedings": ["title", "year/date"],
                  "mvproceedings": "proceedings",
                  "inproceedings": ["author", "title", "booktitle", "year/date"],
                  "reference": "collection",
                  "mvreference": "collection",
                  "inreference": "incollection",
                  "report": ["author", "title", "type", "institution", "year/date"],
                  "thesis": ["author", "title", "type", "institution", "year/date"],
                  "unpublished": ["author", "title", "year/date"],

                  # semi aliases (differing fields)
                  "mastersthesis": ["author", "title", "institution", "year/date"],
                  "techreport": ["author", "title", "institution", "year/date"],

                  # other aliases
                  "conference": "inproceedings",
                  "electronic": "online",
                  "phdthesis": "mastersthesis",
                  "www": "online",
                  "school": "mastersthesis"
                  }

####################################################################

import string
import re
import sys
from optparse import OptionParser

# Parse options
usage = sys.argv[
    0] + " [-b|--bib=<input.bib>] [-a|--aux=<input.aux>] [-o|--output=<output.html>] [-v|--view] [-h|--help]"

parser = OptionParser(usage)

parser.add_option("-b", "--bib", dest="bibFile",
                  help="Bib File", metavar="input.bib", default="input.bib")

parser.add_option("-a", "--aux", dest="auxFile",
                  help="Aux File", metavar="input.aux", default="references.aux")

parser.add_option("-o", "--output", dest="htmlOutput",
                  help="HTML Output File", metavar="output.html")

parser.add_option("-v", "--view", dest="view", action="store_true",
                  help="Open in Browser")

parser.add_option("-N", "--no-console", dest="no_console", action="store_true",
                  help="Do not print problems to console")

(options, args) = parser.parse_args()

# Backporting Python 3 open(encoding="utf-8") to Python 2
# based on http://stackoverflow.com/questions/10971033/backporting-python-3-openencoding-utf-8-to-python-2

if sys.version_info[0] > 2:
    # py3k
    pass
else:
    # py2
    import codecs
    import warnings
    reload(sys)
    sys.setdefaultencoding('utf8')
    def open(file, mode='r', buffering=-1, encoding=None,
             errors=None, newline=None, closefd=True, opener=None):
        if newline is not None:
            warnings.warn('newline is not supported in py2')
        if not closefd:
            warnings.warn('closefd is not supported in py2')
        if opener is not None:
            warnings.warn('opener is not supported in py2')
        return codecs.open(filename=file, mode=mode, encoding=encoding,
                    errors=errors, buffering=buffering)

### End Backport ###

print("INFO: Reading references from '" + options.bibFile + "'")
try:
    fIn = open(options.bibFile, 'r', encoding="utf8")
except IOError as e:
    print("ERROR: Input bib file '" + options.bibFile +
          "' doesn't exist or is not readable")
    sys.exit(-1)

if options.no_console:
    print("INFO: Will surpress problems on console")

if options.htmlOutput:
    print("INFO: Will output HTML to '" + options.htmlOutput + "'"
        + (" and auto open in the default web browser" if options.view else ""))

# Filter by reference ID's that are used
usedIds = set()
if options.auxFile:
    print("INFO: Filtering by references found in '" + options.auxFile + "'")
    try:
        fInAux = open(options.auxFile, 'r', encoding="utf8")
        for line in fInAux:
            if line.startswith("\\citation"):
                ids = line.split("{")[1].rstrip("} \n").split(", ")
                for id in ids:
                    if (id != ""):
                        usedIds.add(id)
        fInAux.close()
    except IOError as e:
        print ("WARNING: Aux file '" + options.auxFile +
               "' doesn't exist -> not restricting entries")

# Go through and check all references
completeEntry = ""
currentId = ""
ids = []
currentType = ""
currentArticleId = ""
currentTitle = ""
fields = []
problems = []
subproblems = []

counterMissingFields = 0
counterFlawedNames = 0
counterWrongTypes = 0
counterNonUniqueId = 0
counterWrongFieldNames = 0

removePunctuationMap = dict((ord(char), None) for char in string.punctuation)

for line in fIn:
    line = line.strip("\n")
    if line.startswith("@"):
        if currentId in usedIds or not usedIds:
            for fieldName, requiredFieldsType in requiredFields.items():
                if fieldName == currentType.lower():
                    # alises use a string to point at another set of fields
                    currentRequiredFields = requiredFieldsType
                    while isinstance(currentRequiredFields, str):
                        currentRequiredFields = requiredFields[currentRequiredFields] # resolve alias

                    for requiredFieldsString in currentRequiredFields:
                        # support for author/editor syntax
                        typeFields = requiredFieldsString.split('/')

                        # at least one the required fields is not found
                        if set(typeFields).isdisjoint(fields):
                            subproblems.append(
                                "missing field '" + requiredFieldsString + "'")
                            counterMissingFields += 1
        else:
            subproblems = []

        if currentId in usedIds or (currentId and not usedIds):
            cleanedTitle = currentTitle.translate(removePunctuationMap)
            problem = "<div id='" + currentId + \
                "' class='problem severe" + str(len(subproblems)) + "'>"
            problem += "<h2>" + currentId + " (" + currentType + ")</h2> "
            problem += "<div class='links'>"
            if citeulikeUsername:
                problem += "<a href='" + citeulikeHref + \
                    currentArticleId + "' target='_blank'>CiteULike</a> |"

            list = []
            for name, site in libraries:
                list.append(
                    " <a href='" + site + cleanedTitle + "' target='_blank'>" + name + "</a>")
            problem += " | ".join(list)

            problem += "</div>"
            problem += "<div class='reference'>" + currentTitle
            problem += "</div>"
            problem += "<ul>"
            for subproblem in subproblems:
                problem += "<li>" + subproblem + "</li>"
                if not options.no_console:
                    print("PROBLEM: " + currentId + " - " + subproblem)
            problem += "</ul>"
            problem += "<form class='problem_control'><label>checked</label><input type='checkbox' class='checked'/></form>"
            problem += "<div class='bibtex_toggle'>Current BibLaTex Entry</div>"
            problem += "<div class='bibtex'>" + completeEntry + "</div>"
            problem += "</div>"
            problems.append(problem)
        fields = []
        subproblems = []
        currentId = line.split("{")[1].rstrip(",\n")
        if currentId in ids:
            subproblems.append("non-unique id: '" + currentId + "'")
            counterNonUniqueId += 1
        else:
            ids.append(currentId)
        currentType = line.split("{")[0].strip("@ ")
        completeEntry = line + "<br />"
    else:
        if line != "":
            completeEntry += line + "<br />"
        if currentId in usedIds or not usedIds:
            if "=" in line:
                # biblatex is not case sensitive
                field = line.split("=")[0].strip().lower()
                fields.append(field)
                value = line.split("=")[1].strip("{} ,\n")
                if field == "author":
                    currentAuthor = filter(
                        lambda x: not (x in "\\\"{}"), value.split(" and ")[0])
                if field == "citeulike-article-id":
                    currentArticleId = value
                if field == "title":
                    currentTitle = re.sub(r'\}|\{', r'', value)

                ###############################################################
                # Checks (please (de)activate/extend to your needs)
                ###############################################################

                # check if type 'proceedings' might be 'inproceedings'
                if currentType == "proceedings" and field == "pages":
                    subproblems.append(
                        "wrong type: maybe should be 'inproceedings' because entry has page numbers")
                    counterWrongTypes += 1

                # check if abbreviations are used in journal titles
                if currentType == "article" and (field == "journal" or field == "journaltitle"):

                    if "." in line:
                        subproblems.append(
                            "flawed name: abbreviated journal title '" + value + "'")
                        counterFlawedNames += 1

                # check booktitle format; expected format "ICBAB '13: Proceeding of the 13th International Conference on Bla and Blubb"
                # if currentType == "inproceedings" and field == "booktitle":
                    # if ":" not in line or ("Proceedings" not in line and "Companion" not in line) or "." in line or " '" not in line or "workshop" in line or "conference" in line or "symposium" in line:
                        #subproblems.append("flawed name: inconsistent formatting of booktitle '"+value+"'")
                        #counterFlawedNames += 1

                 # check if title is capitalized (heuristic)
                 # if field == "title":
                    # for word in currentTitle.split(" "):
                        #word = word.strip(":")
                        # if len(word) > 7 and word[0].islower() and not  "-" in word and not "_"  in word and not "[" in word:
                        #subproblems.append("flawed name: non-capitalized title '"+currentTitle+"'")
                        #counterFlawedNames += 1
                        # break

                ###############################################################

fIn.close()


problemCount = counterMissingFields + counterFlawedNames + counterWrongFieldNames + counterWrongTypes + counterNonUniqueId

# Write out our HTML file
if options.htmlOutput:
    html = open(options.htmlOutput, 'w', encoding="utf8")
    html.write("""<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>BibLatex Check</title>
<style>
body {
    font-family: Calibri, Arial, Sans;
    padding: 10px;
    width: 1030px;
    margin: 10px auto;
    border-top: 1px solid black;
}

#title {
    width: 720px;
    border-bottom: 1px solid black;
}

#title h1 {
    margin: 10px 0px;
}

#title h1 a {
    color: black;
    text-decoration: none;
}

#control {
    clear: both;
}

#search {
    float: left;
}

#search input {
    width: 300px;
    font-size: 14pt;
}

#mode {
    text-align: right;
}

#mode label:first-child {
    font-weight: bold;
}

#mode input {
    margin-left: 20px;
}

.info {
    margin-top: 10px;
    padding: 10px;
    background: #FAFADD;
    width: 250px;
    float: right;
    box-shadow: 1px 1px 1px 1px #ccc;
    clear: both;
}

.info h2 {
    font-size: 12pt;
    padding: 0px;
    margin: 0px;
}

.problem {
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 10px;
    background: #FFBBAA;
    counter-increment: problem;
    width: 700px;
    border: 1px solid #993333;
    border-left: 5px solid #993333;
    box-shadow: 1px 1px 1px 1px #ccc;
    float: left;
}

.active {
    box-shadow: 5px 5px 3px 3px #ccc;
    position: relative;
    top: -2px;
}

.severe0 {
    background: #FAFAFA;
    border: 1px solid black;
    border-left: 5px solid black;
}

.severe1 {
    background: #FFEEDD;
}

.severe2 {
    background: #FFDDCC;
}

.severe3 {
    background: #FFCCBB;
}

.problem_checked {
    border: 1px solid #339933;
    border-left: 5px solid #339933;
}

.problem h2:before {
    content: counter(problem) ". "; color: gray;
}

.problem h2 {
    font-size: 12pt;
    padding: 0px;
    margin: 0px;
}

.problem .links {
    float: right;
    position:relative;
    top: -22px;
}

.problem .links a {
    color: #3333CC;
}

.problem .links a:visited {
    color: #666666;
}

.problem .reference {
    clear: both;
    font-size: 9pt;
    margin-left: 20px;
    font-style:italic;
    font-weight:bold;
}

.problem ul {
    clear: both;
}

.problem .problem_control {
    float: right;
    margin: 0px;
    padding: 0px;
}

.problem .bibtex_toggle{
    text-decoration: underline;
    font-size: 9pt;
    cursor: pointer;
    padding-top: 5px;
}

.problem .bibtex {
    margin-top: 5px;
    font-family: Monospace;
    font-size: 8pt;
    display: none;
    border: 1px solid black;
    background-color: #FFFFFF;
    padding: 5px;
}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script>

function isInProblemMode() {
    return $('#mode_problems:checked').val() == 'problems'
}

function update() {
    $('.problem').hide();
    $('.problem[id*='+$('#search input').val()+']').show();
    $('.problem .checked').each(function () {
        if ($(this).attr('checked')) {
            $(this).parents('.problem').addClass('problem_checked');
        } else {
            $(this).parents('.problem').removeClass('problem_checked');
        }
    });
    if (isInProblemMode()) {
        $('.severe0').hide();
        $('.problem_checked').hide();
    }
}

$(document).ready(function(){

    $(".bibtex_toggle").click(function(event){
        event.preventDefault();
        $(this).next().slideToggle();
    });

    $('#search input').live('input', function() {
        update();
    });

    $('#mode input').change(function() {
        update();
    });

    $("#uncheck_button").click(function(){
        $('.problem .checked').attr('checked',false);
        localStorage.clear();
        update();
    });

    $('.problem a').mousedown(function(event) {
        $('.problem').removeClass('active');
        $(this).parents('.problem').addClass('active');
    });

    $('.problem .checked').change(function(event) {
        var problem = $(this).parents('.problem');
        problem.toggleClass('problem_checked');
        var checked = problem.hasClass('problem_checked');
        localStorage.setItem(problem.attr('id'),checked);
        if (checked && isInProblemMode()) {
            problem.slideUp();
        }
    });

    $('.problem .checked').each(function () {
        $(this).attr('checked',localStorage.getItem($(this).parents('.problem').attr('id'))=='true');
    });
    update();
});

</script>
</head>
<body>
<div id="title">
<h1><a href='http://github.com/pezmc/BibLatex-Check'>BibLaTeX Check</a></h1>
<div id="control">
<form id="search"><input placeholder="search entry ID ..."/></form>
<form id="mode">
<label>show entries:</label>
<input type = "radio"
                 name = "mode"
                 id = "mode_problems"
                 value = "problems"
                 checked = "checked" />
          <label for = "mode_problems">problems</label>
          <input type = "radio"
                 name = "mode"
                 id = "mode_all"
                 value = "all" />
          <label for = "mode_all">all</label>
<input type="button" value="uncheck all" id="uncheck_button"></button>
</form>
<br style="clear: both; " />
</div>
</div>
""")
    html.write("<div class='info'><h2>Info</h2><ul>")
    html.write("<li>bib file: " + options.bibFile + "</li>")
    html.write("<li>aux file: " + options.auxFile + "</li>")
    html.write("<li># entries: " + str(len(problems)) + "</li>")
    html.write("<li># problems: " + str(problemCount) + "</li><ul>")
    html.write("<li># missing fields: " + str(counterMissingFields) + "</li>")
    html.write("<li># flawed names: " + str(counterFlawedNames) + "</li>")
    html.write("<li># wrong types: " + str(counterWrongTypes) + "</li>")
    html.write("<li># non-unique id: " + str(counterNonUniqueId) + "</li>")
    html.write("<li># wrong field: " + str(counterWrongFieldNames) + "</li>")
    html.write("</ul></ul></div>")

    problems.sort()
    for problem in problems:
        html.write(problem)
    html.write("</body></html>")
    html.close()

    if options.view:
        import webbrowser
        webbrowser.open(html.name)

    print("SUCCESS: Report {} has been generated".format(options.htmlOutput))

if problemCount > 0:
    print("WARNING: Found {} problems.".format(problemCount))
    sys.exit(-1)
