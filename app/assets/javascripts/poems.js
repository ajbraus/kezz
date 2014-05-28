// STRATEGY 1
function countWordSyllables(word) {
  word = word.toLowerCase();
  if(word.length <= 3) { return 1; }
  word = word.replace(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '');
  word = word.replace(/^y/, '');
  return word.match(/[aeiouy]{1,2}/g).length;
}

function countLineSyllables(line, index) {
  var line = line.split(/\s+/);
  var totalSyllables = 0
  line.forEach(function(word) { //count sylables per word
    if (word.length > 0) {
      totalSyllables += countWordSyllables(word) // add up syllables to count per line  
    }
  });
  if (totalSyllables == 5) { //style lines with 5 or 7 syllables
    $('#poem div:nth-child(' + index + ')').css('color', 'blue');
  } else if (totalSyllables == 7) {
    $('#poem div:nth-child(' + index + ')').css('color', 'green');
  } else if (totalSyllables == 10) {
    $('#poem div:nth-child(' + index + ')').css('color', 'gold');
  } else {
    $('#poem div:nth-child(' + index + ')').css('color', 'grey');
  }
}

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


$(function() {
  $('#poem').on('keydown', function(e) {
    if ($('#poem').children().length == 0) { 
      if (e.keyCode == 13) { // ENTER
        //CHROME wrap first line of contentedtible in <div>
        $('#poem').wrapInner("<div></div>")
        //TODO add <br> after title
      }
    } 
    var poem_html = $('#poem').html()
    console.log( $('#poem').html())
    // TODO add line number on left of new line
    // TODO stripe white space from end of current line
    var new_poem_html = poem_html.replace(/<\/div>/gi, "</div>|");
    var new_poem_html = new_poem_html.replace(/<(?:.|\n)*?>/gm, '');

    //console.log(poem_html);
    //console.log(new_poem_html)
    var linesArray = new_poem_html.split("|");
    console.log(linesArray)
    linesArray.forEach(function(line, index) { // break up lines by word
      countLineSyllables(line, index + 1);
    });
  });

  // TODO optional title
  // TODO ignore punctuation in syllable count
  // TODO check if any words are true or slant rhymes with any others
  // TODO tab = add four spaces --> save this and display it
  // TOOD hack off title, save title and body separately


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

});

function countWordSyllables(word) {
  word = word.toLowerCase();
  if(word.length <= 3) { return 1; }
  word = word.replace(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '');
  word = word.replace(/^y/, '');
  return word.match(/[aeiouy]{1,2}/g).length;
}

function countLineSyllables(line, index) {
  var line = line.split(/\s+/);
  var totalSyllables = 0
  line.forEach(function(word) { //count sylables per word
    if (word.length > 0) {
      totalSyllables += countWordSyllables(word) // add up syllables to count per line  
    }
  });
  if (totalSyllables == 5) { //style lines with 5 or 7 syllables
    $('#poem div:nth-child(' + index + ')').css('color', 'blue');
  } else if (totalSyllables == 7) {
    $('#poem div:nth-child(' + index + ')').css('color', 'green');
  } else if (totalSyllables == 10) {
    $('#poem div:nth-child(' + index + ')').css('color', 'gold');
  } else {
    $('#poem div:nth-child(' + index + ')').css('color', 'grey');
  }
}
