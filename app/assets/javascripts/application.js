// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require selectize
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .

$(document).ready(function(){
    // $(":radio").click(function(){
    $(":radio").on("click", function (event) {
            var rate = "";
            var movie_id = "";
            var selected  = $("input[type='radio'][name='rate']:checked");
            var selected2 = $("input[type='hidden'][name='movie_id']");
            if (selected.length > 0) {
                rate = selected.val();
                movie_id = selected2.val();
                alert(rate + movie_id);

                $.ajax({
                  url: '/ratings/',
                  type: 'POST',
                  data: { rate: rate, movie_id: movie_id }
                });
            }
        });
});

$(document).ready(function(){
  $('#search_genre_id').selectize();
  $('#search_language_id').selectize();
  $('#search_country_id').selectize();
  $('#search_rated_id').selectize();
});

