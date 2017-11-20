// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require jquery_ujs

// With using Turbolinks we need to listen to Turbolinks loads not just page loads
$( document ).on('turbolinks:load', function() {

    // Creates visible function
    // Is just like .show() but sets visibility not display
    // This is done by by changing the element's css of visibility
    jQuery.fn.visible = function() {
        return this.css('visibility', 'visible');
    };

    // Creates invisible function
    // Is just like .hide() but sets visibility not display
    jQuery.fn.invisible = function() {
        return this.css('visibility', 'hidden');
    };

    //Checks if the p tag in the alerts div is empty or not
    // True: No content in p, set alerts div to invisible to allow it to take space on page
    // False: Does contain content in p, set alerts div to visible in order to display content
    if ($('#alerts p').is(':empty')) {
        $('#alerts').invisible();
    }else{
        $('#alerts').visible();
    }

    // Allows the alerts and notice pop up to be closed when user click the X
    $("#alerts .close").click(function(){
        $('#alerts').invisible();
    });

});