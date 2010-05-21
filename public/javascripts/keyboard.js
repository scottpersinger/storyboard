$j(function() {
  $j(document.body).keydown(function(e) {
    if (e.which == 37) {
      // left arrow
      show_prev_page();
    } else if (e.which == 39) {
      // right arrow
      show_next_page();
    }
  });
});
