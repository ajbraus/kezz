// Strategy 0
// textarea
// each time you keyup take the whole thing
// hack apart lines with "\n"
// wrap each line in divs
// count sylables
// color the divs
// put the whole thing to the right side

// TODO check if any words are true or slant rhymes with any others
// TODO tab = add four spaces --> save this and display it

$(function() {
  $('#poem').focus();

  $('#title').on('keyup', function(e) {
    var poemTitle = $('#title').val();
    $('#poemTitle').text(poemTitle);
  });

  $('#poem').on('keyup', function(e) {
    var poemText = $('#poem').val().replace( /\n/g, '<br \\>' ); // get poem
    var lineArray = poemText.split("<br \\>"); // break into array of lines
    //console.log(lineArray)
    var formattedArray = []
    lineArray.forEach(function(line, index) { 
      var totalSyllables = lineSyllablesCount(line); // count syllables
      //line = jQuery.parseHTML("<div>" + line + "</div>")
      //console.log(line)
      if (totalSyllables == 5) { //style lines with 5 or 7 syllables
        line = "<span style='color:blue;'>" + line + "</span><br>"
      } else if (totalSyllables == 7) {
        line = "<span style='color:green;'>" + line + "</span><br>"
      } else if (totalSyllables == 10) {
        line = "<span style='color:gold;'>" + line + "</span><br>"
      } else {
        line = "<span style='color:grey;'>" + line + "</span><br>"
      }
      //line = index + 1 + " " + line // add line numbers
      formattedArray.push(line);
    }); 
    var poemFormatted = formattedArray.join(" ");
    // console.log(lineArray.join(" "))
    $('#poemText').html(poemFormatted); //output formatted poem
  });
});


// STRATEGY 1
// wrap <div></div> around first line
// poem is array of lines, first el is title (don't color it, add another <br> after it)
// add | character between <div>'s
// strip out html
// split lines on |
// each line count syllables
// if line syllables == 5, 7, or 10 assign a color to the line's html element
// pros can copy paste, work with poem as block
// easier to save and display for editing
// cons - 
// enter management
// grouping and coloring elements


// $(function() {
//   $('#poem').focus();
//   $('#poem').on('keydown', function(e) {
//     if ($('#poem').children().length == 1) { 
//       if (e.keyCode == 13) { // ENTER
//         $('#poem').wrapInner("<div></div>") //CHROME wrap first line of contentedtible in <div>
//         setTimeout(function(){$('#poem').children().first().append("<br>")}, 1); //add <br> after title
//       }
//     } 
//     var poem_html = $('#poem').html()
//     console.log( $('#poem').html())
//     // TODO add line number on left of new line
//     // TODO stripe white space from end of current line
//     var new_poem_html = poem_html.replace(/<\/div>/gi, "</div>|");
//     var new_poem_html = new_poem_html.replace(/<(?:.|\n)*?>/gm, '');

//     //console.log(poem_html);
//     //console.log(new_poem_html);
//     var linesArray = new_poem_html.split("|")
//     linesArray.shift();
//     console.log(linesArray);
//     linesArray.forEach(function(line, index) { // break up lines by
//       countLineIndexSyllables(line, index + 1);
//     });
//   });



// ALTERNATIVE STRATEGY
// each line is a new contenteditable div
// when you key down count syllables and stuff in that line
// if key is enter, append and focus on a new editable div and re apply the syllable counting function
// pros - wraps each line already
// cons - can't copy/paste the poem
// hard to save in a structured way and then display for editing
// backspace management


// $(function() {
//   $('#poem').on('keypress', function(e) {
//     if (e.keyCode==13) { //enter && shift
//      e.preventDefault();
//      var newLineNum = $(this).children().length + 1
//      var newLine = "<div contenteditable='true' class='editable-line' id='line" + newLineNum + "' style='white-space: normal;' >"
//      $(this).append(newLine)
//      $("#line" + newLineNum).focus(); // focus on new editable line
//     }
//     if (e.keyCode == 8) { //backspace
//       var currentLine = $(document.activeElement)
//       if (currentLine.text().length == 0) {
//         var currentLineNum = parseInt(currentLine.attr('id').replace(/\D/g,''));
//         previousLine = $('#line' + currentLineNum - 1)
//       }
//     }
    
//     linesArray = []
//     $('.editable-line').each(function(){    
//       linesArray.push($(this).text());
//     });
//     console.log(linesArray)
//     linesArray.forEach(function(line) { // break up lines by word
//       totalSyllables = countLineSyllables(line)
//       if (totalSyllables == 5) { //style lines with 5 or 7 syllables
//         console.log("5 syllables")
//       } else if (totalSyllables == 7) {
//         console.log("7 syllables")
//       } else {
//         console.log("not right")
//       }
//     });
//   });

// });


function countWordSyllables(word) {
  word = word.toLowerCase();
  if(word.length <= 3) { return 1; }
  word = word.replace(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '');
  word = word.replace(/^y/, '');
  if (word.match(/[aeiouy]{1,2}/g).length) {
    return word.match(/[aeiouy]{1,2}/g).length;  
  }
}

function lineSyllablesCount(line) {
  var line = line.split(/\s+/);
  var totalSyllables = 0
  line.forEach(function(word) { //count sylables per word
    if (word.length > 0) {
      totalSyllables += countWordSyllables(word) // add up syllables to count per line  
    }
  });
  return totalSyllables
}

function countLineIndexSyllables(line, index) {
  var line = line.split(/\s+/);
  var totalSyllables = 0
  line.forEach(function(word) { //count sylables per word
    if (word.length > 0) {
      totalSyllables += countWordSyllables(word) // add up syllables to count per line  
    }
  });
  if (totalSyllables == 5) { //style lines with 5 or 7 syllables
    console.log(index)
    $('#poem div:nth-child(' + index + ')').css('color', 'blue');
  } else if (totalSyllables == 7) {
    $('#poem div:nth-child(' + index + ')').css('color', 'green');
  } else if (totalSyllables == 10) {
    $('#poem div:nth-child(' + index + ')').css('color', 'gold');
  } 
}
