function size_text_tile(elt) {
  var tile = $j(elt);

  if (tile.data('resized')) {
    return;
  }

  tile.data('resized', true);

  // make offscreen visible div to use for sizing
  var offdiv = $j('#offdiv')[0] ||
    $j(document.body).append('<div id="offwrap" style="position:absolute;top:0;left:-2000px;background:red"><div id="offdiv" class="text"></div></div>');

  offdiv = $j('#offdiv');
  var offwrap = $j('#offwrap');

  // Grow text to fill tile dimensions
  var tile_height = tile.outerHeight();
  var text_div = tile.find('.text');
  
  offwrap.css('width', tile.outerWidth() + 'px');
  offdiv.html(text_div.html());

  console.log("tile height: " + tile_height + ", text height: " + $j(offdiv).outerHeight());
  var i = 0;
  for( i =0; (i<50 && $j(offdiv).outerHeight() < tile_height); i+= 1) {
    $j(offdiv).css('font-size', (12+i));
    console.log("offdiv height: ", $j(offdiv).outerHeight());
    if (i > 10) {
      i+=1; // skip by 2 to be faster
    }
  }
  $j(text_div).css('font-size', (12+(i-1)));
}

function layout_row(divs_in_row, height) {
  var width = 100.0 / divs_in_row.length;
  
  $j.each(divs_in_row, function() {
    console.log("Laying out div (width: " + width + ", height: " + height + "): ", $j(this).html().substring(0,50));
    $j(this).css({width: width + '%', height: height + '%', 'float': 'left'});
    if (this == divs_in_row[divs_in_row.length-1]) {
      $j(this).addClass('clearfix');
    }
  });
}

function layout_tiles(page) {
  page = $j(page);
  $j(document.body).height($j(window).height());

  var rowcount = $j(page).find('.tile').filter('.last').length;
  if (!$j(page).find('.tile:last').hasClass('last')) {
    rowcount++;
  }

  var rowset = [];
  var divs_in_row = [];
  var last_tile = page.find('.tile:last')[0];

  page.find('.tile').each(function() {
    divs_in_row.push(this);
    if ($j(this).hasClass('last') || this == last_tile) {
      rowset.push(divs_in_row);
      divs_in_row = [];
    }
  });

  var rowheights = {};
  var footnote_count = 0;

  $j.each(rowset, function(index) {
    if ($j(this).filter('.footnote').length == this.length) {
      rowheights[index] = 15;
      footnote_count++;
    }
  });

  var remainder = (100 - (15 * footnote_count)) / (rowset.length - footnote_count);

  $j.each(rowset, function(index) {
    var h = rowheights[index] || remainder;
    layout_row(this, h);
  });
}


var $current_page = null;

function show_page(pagenum) {
  $j('.page-wrapper').hide();
  var page = $j('#page_' + pagenum);
  page.show();
  //page.css('visibility:hidden');

  layout_tiles(page);
  page.find('.tile-text').each(function() {size_text_tile(this)});


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