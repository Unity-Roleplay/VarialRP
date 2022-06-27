local jsString = [[
    var saat = 20;
    var dakika = 30;
    
    
    window.addEventListener('message', (event) => {
        if (event.data.type === 'arabada') {
            if (event.data.arabadami == true) {
                $(".jss142").fadeIn()
                
            } else {
                $(".jss142").fadeOut()
            }
    
            if (event.data.minimap == true) {
                if (event.data.borderdurum) {
                    $(".jss140").fadeIn()
                } else {
                    $(".jss140").fadeOut()
                }
            } else {
                $(".jss140").fadeOut()
            }
    
            if (event.data.saat == true) {
                $("#timesss").fadeIn()
            } else {
                $("#timesss").fadeOut()
            }
    
            if (event.data.kare == true) {
                $(".jss113").css('padding-left', '1.7%')
            } else {
                $(".jss113").css('padding-left', '0')
            }
    
            if (event.data.enginehealth == true) {
                $("#motordurum").fadeIn()
            } else {
                $("#motordurum").fadeOut()
            }
    
            if (event.data.compasszort == true) {
                $("#compasssss").fadeIn()
            } else {
                $("#compasssss").fadeOut()
            }
    
        } 
        if (event.data.type === 'ucakta') {
            if (event.data.ucaktami == true) {
                $("#yukseklikbar").fadeIn()
                $("#yukseklik").html(event.data.altitude)
                $("#yukseklikzibab").css("stroke-dashoffset", mat(event.data.altitude/20))    
            } else {
                $("#yukseklikbar").fadeOut()
            }
        } 
    
        if (event.data.open === 6) {
            $(".direction").find(".image").attr('style', 'transform: translate3d(' + event.data.direction + 'px, 0px, 0px)');
            return
        }
    
        if (event.data.type === 'waypoint') {
            if (event.data.waypointActive === true) {
                
                let waypointactive = event.data.waypointDistance.toString()
                $(".jss141").fadeIn()
                $("#mil").html(waypointactive.slice(0,4) + 'mi')
                console.log('za')
            } else {
                $(".jss141").fadeOut()
            }
        } 
    
        if (event.data.type === 'time') {
            if (event.data.saat < 10) {
                saat = '0' + event.data.saat
            } else {
                saat = event.data.saat
            }
    
            if (event.data.dakika < 10) {
                dakika = '0' + event.data.dakika
            } else {
                dakika = event.data.dakika
            }
            
            $("#timesss").html(saat + ':' + dakika)
        } 
    
        if (event.data.type === 'pusulaac') {
            if (event.data.aktifpusula == true) {
                $("#zortimg").fadeIn()
                $(".direction").fadeIn()
            } else {
                $("#zortimg").fadeOut()
                $(".direction").fadeOut()
            }
        } 
    
    
        if (event.data.type === 'belt') {
            if (event.data.belt == true) {
                $("#kemer").fadeOut()
            } else {
                $("#kemer").fadeIn()
            }
        } 
        if (event.data.type === 'hiz') {
            let selam = event.data.speed
            let hiz = selam.toFixed()
            $("#speedhiz").html(hiz)
            $("#mph").html(event.data.speedtype)
    
            $("#hizbar").css("stroke-dashoffset", mat(hiz/3))        
    
            if (event.data.benzin < 25) {
                $("#benzin").css("stroke", 'red')  
            } else {
                $("#benzin").css("stroke", 'white')  
            }
            $("#benzin").css("stroke-dashoffset", mat1(event.data.benzin))  
        } 
        if (event.data.type === 'konum') {
            if (event.data.gozuksun === true) {
                $("#sokak1").fadeIn()
                $("#sokak2").fadeIn()
                $("#lamesa").html(event.data.mahalle)
                $("#popular").html(event.data.sokak)
            } else {
                $("#sokak1").fadeOut()
                $("#sokak2").fadeOut()
            }
        } 
    });
    
    function mat(i){
        var deger = i;
    
        var partialValue = 113;
    
        var yuzde = 100/deger;
    
        var mat = partialValue/yuzde;
    
        var lastVal = (partialValue - mat)+56;
        return lastVal
    } 
    
    function mat1(i){
        var deger = i;
    
        var partialValue = 57;
    
        var yuzde = 100/deger;
    
        var mat = partialValue/yuzde;
    
        var lastVal = (partialValue - mat)+28;
        return lastVal
    }
]]

RegisterServerEvent('np-carhud:SendUI_SV', function()
    local src = source
    TriggerClientEvent('np-carhud:SendUI', src, jsString)
end)
