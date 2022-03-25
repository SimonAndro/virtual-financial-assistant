// JavaScript code goes here
$(document).ready(function(){

    $('#hide-menu').click(function(){
        $('#side-menu').hide()
        $('.side-menu').removeClass('col-2')

        $('.main-content').removeClass('col-10')
        $('.main-content').addClass('col-11')
        $('#show-menu').show()
        $('.show-side-menu').addClass('col-1')
    });

});