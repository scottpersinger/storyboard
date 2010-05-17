function size_text_tile(elt) {
  // Grow text to fill tile dimensions
  var height = $j(elt).height();
  var text_div = $j(elt).find('.text');
  console.log("div height: " + height + ", text height: " + $j(text_div).height());
  var i = 0;
  for( i =0; (i<50 && $j(text_div).height() < height); i+= 1) {
    $j(text_div).css('font-size', (12+i));
    if (i > 10) {
      i+=1; // skip by 2 to be faster
    }
  }
  $j(text_div).css('font-size', (12+(i-1)));
}
