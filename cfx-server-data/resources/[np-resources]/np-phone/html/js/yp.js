$('#advert').click(function(){
    $('.sari-add').css('display', 'flex');
})

$('.sari-add').on('click', '#close-input', function(){
    $('.sari-add').css('display', 'none');
})

$('.sari-add').on('click', '#submit-input', function(){ 
    let ypost = escapeHtml($("#saridetailinput").val())
    if (Number(ypost.length) <= Number(5)){ 
        $('.warn-text2').text("Character must be more than 5")
        $('.warning-yp').css('display', 'flex')
        setTimeout(() => {
            $('.warning-yp').css('display', 'none')
        }, 2000);
        return false
     }else{
        $('.sari-add').css('display', 'none');
        complateInputJustGreen();
        $.post('http://np-phone/newPostSubmit', JSON.stringify({
            advert: ypost
        }));
        $("#saridetailinput").val("")
        $("#sari-name").val("")
    }
})