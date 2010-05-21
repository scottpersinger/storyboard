function size_text_tile(elt) {
  var tile = $j(elt);

  if (tile.data('resized')) {
    return;
  }

  tile.data('resized', true);

  // make offscreen visible div to use for sizing
  var offdiv = $j('#offdiv')[0] ||
    $j(document.body).append('<div id="offdiv" style="position:absolute;top:0;left:-2000px"></div>');

  offdiv = $j('#offdiv');

  // Grow text to fill tile dimensions
  var tile_height = tile.height();
  var text_div = tile.find('.text');
  
  offdiv.css('width', tile.width() + 'px');
  offdiv.html(text_div.html());

  console.log("tile height: " + tile_height + ", text height: " + $j(offdiv).height());
  var i = 0;
  for( i =0; (i<50 && $j(offdiv).height() < tile_height); i+= 1) {
    $j(offdiv).css('font-size', (12+i));
    if (i > 10) {
      i+=1; // skip by 2 to be faster
    }
  }
  $j(text_div).css('font-size', (12+(i-1)));
}

function layout_row(divs_in_row, rowcount) {
  var height_rem = 100 / rowcount;
  var width = 100.0 / divs_in_row.length;
  
  $j.each(divs_in_row, function() {
    $j(this).css({width: width + '%', height: height_rem + '%', 'float': 'left'});
    if (this == divs_in_row[divs_in_row.length-1]) {
      $j(this).addClass('clearfix');
    }
  });
}

function layout_tiles(page) {
  page = $j(page);

  var rowcount = $j(page).find('.tile').filter('.last').length;
  if (!$j(page).find('.tile:last').hasClass('last')) {
    rowcount++;
  }

  var divs_in_row = [];
  var last_tile = page.find('.tile:last')[0];

  page.find('.tile').each(function() {
    divs_in_row.push(this);
    if ($j(this).hasClass('last') || this == last_tile) {
      layout_row(divs_in_row, rowcount);
      divs_in_rows = [];
    }
  });
}

var $current_page = null;

function show_page(pagenum) {
  $j('.page-wrapper').hide();
  var page = $j('#page_' + pagenum);

  //page.css('visibility:hidden');
  //page.find('.tile-text').each(function() {size_text_tile(this)});
  layout_tiles(page);

  page.show();

  $current_page = pagenum;
}

function show_next_page() {
  var newpage = $current_page + 1;
  if ($j('#page_' + newpage)) {
    show_page(newpage);
  }
}

function show_prev_page() {
  if ($current_page > 0) {
    show_page($current_page - 1);
  }
}