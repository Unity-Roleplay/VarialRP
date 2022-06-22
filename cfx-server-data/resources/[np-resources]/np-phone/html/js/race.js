

$('.racetrack-wrapper').on('click', '.create-race-button', function(){
   trackID = $(this).attr("trackerID")
   trackName = $(this).attr("trackerName")
   console.log("CLICK TO CREATE RACE",overid,trackName)
   $('#track-id').val(trackID)
   $('#track_name').val(trackName)
   $('.creating-race').show()
})


$('.close-crace').click(function(){
    console.log("CLICK TO CREATE RACE")
    $('.creating-race').hide()
})

$('.submit-crace').click(function(){
   let id = $('#track-id').val()
   let name = $('#track_name').val()
   let event_name = $('#event_name').val()
   let alias = $('#alias').val()
   let laps = $('#laps').val()
   let bet = $('#bet').val()
   let countdown = $('#countdown').val()
   let bubble = $("#bubble").is(":checked");
    console.log("SUBMIT CREATE RACE", id, name, event_name, alias, laps, bet, countdown, bubble)
    $('.creating-race').hide()
})

function addRaceTracker(raceTrack){
    var random = Math.floor(Math.random() * 10000) + 1;
    
    for (let track of raceTrack) {
        let tracks = `<div hoverid="${track.id}" class="component-paper" style="width: 100%;">
        <div class="main-container clicked-function-container">
           <div class="details ">
             <div class="title ">
               <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                 style="word-break: break-word;">${track.name}</p>
             </div>
             <div class="description ">
               <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                 style="word-break: break-word;">Laps</p>
             </div>
           </div>
           <div class="details-aux " style="padding-top: 10px;">
             <div class="text">
               <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                 style="word-break: break-word;">${track.dist}mi</p>
             </div>
           </div>
           <div hoverid="${track.id}" class="actions actions-show">
              <div aria-label="Leaderboard" class="">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                    class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                       d="M572.1 82.38C569.5 71.59 559.8 64 548.7 64h-100.8c.2422-12.45 .1078-23.7-.1559-33.02C447.3 13.63 433.2 0 415.8 0H160.2C142.8 0 128.7 13.63 128.2 30.98C127.1 40.3 127.8 51.55 128.1 64H27.26C16.16 64 6.537 71.59 3.912 82.38C3.1 85.78-15.71 167.2 37.07 245.9c37.44 55.82 100.6 95.03 187.5 117.4c18.7 4.805 31.41 22.06 31.41 41.37C256 428.5 236.5 448 212.6 448H208c-26.51 0-47.99 21.49-47.99 48c0 8.836 7.163 16 15.1 16h223.1c8.836 0 15.1-7.164 15.1-16c0-26.51-21.48-48-47.99-48h-4.644c-23.86 0-43.36-19.5-43.36-43.35c0-19.31 12.71-36.57 31.41-41.37c86.96-22.34 150.1-61.55 187.5-117.4C591.7 167.2 572.9 85.78 572.1 82.38zM77.41 219.8C49.47 178.6 47.01 135.7 48.38 112h80.39c5.359 59.62 20.35 131.1 57.67 189.1C137.4 281.6 100.9 254.4 77.41 219.8zM498.6 219.8c-23.44 34.6-59.94 61.75-109 81.22C426.9 243.1 441.9 171.6 447.2 112h80.39C528.1 135.7 526.5 178.7 498.6 219.8z">
                    </path>
                 </svg>
              </div>
              <div aria-label="Preview" class="">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                    class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                       d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z">
                    </path>
                 </svg>
              </div>
              <div aria-label="Set GPS" class="">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                    class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                       d="M384 192C384 279.4 267 435 215.7 499.2C203.4 514.5 180.6 514.5 168.3 499.2C116.1 435 0 279.4 0 192C0 85.96 85.96 0 192 0C298 0 384 85.96 384 192H384z">
                    </path>
                 </svg>
              </div>
              <div aria-label="Create Race" trackerID="${track.id}" trackerName="${track.name}" class="create-race-button">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                    class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                       d="M509.5 .0234c-6.145 0-12.53 1.344-18.64 4.227c-44.11 20.86-76.81 27.94-104.1 27.94c-57.89 0-91.53-31.86-158.2-31.87C195 .3203 153.3 8.324 96 32.38V32c0-17.75-14.25-32-32-32S32 14.25 32 32L31.96 496c0 8.75 7.25 16 16 16H80C88.75 512 96 504.8 96 496V384c51.74-23.86 92.71-31.82 128.3-31.82c71.09 0 120.6 31.78 191.7 31.78c30.81 0 65.67-5.969 108.1-23.09C536.3 355.9 544 344.4 544 332.1V30.74C544 12.01 527.8 .0234 509.5 .0234zM480 141.8c-31.99 14.04-57.81 20.59-80 22.49v80.21c25.44-1.477 51.59-6.953 80-17.34V308.9c-22.83 7.441-43.93 11.08-64.03 11.08c-5.447 0-10.71-.4258-15.97-.8906V244.5c-4.436 .2578-8.893 .6523-13.29 .6523c-25.82 0-47.35-4.547-66.71-10.08v66.91c-23.81-6.055-50.17-11.41-80-12.98V213.1C236.2 213.7 232.5 213.3 228.5 213.3C208.8 213.3 185.1 217.7 160 225.1v69.1C139.2 299.4 117.9 305.8 96 314.4V250.7l24.77-10.39C134.8 234.5 147.6 229.9 160 225.1V143.4C140.9 148.5 120.1 155.2 96 165.3V101.8l24.77-10.39C134.8 85.52 147.6 80.97 160 77.02v66.41c26.39-6.953 49.09-10.17 68.48-10.16c4.072 0 7.676 .4453 11.52 .668V65.03C258.6 66.6 274.4 71.55 293.2 77.83C301.7 80.63 310.7 83.45 320 86.12v66.07c20.79 6.84 41.45 12.96 66.71 12.96c4.207 0 8.781-.4766 13.29-.8594V95.54c25.44-1.477 51.59-6.953 80-17.34V141.8zM240 133.9v80.04c18.61 1.57 34.37 6.523 53.23 12.8C301.7 229.6 310.7 232.4 320 235.1V152.2C296.1 144.3 271.6 135.8 240 133.9z">
                    </path>
                 </svg>
              </div>
           </div>
        </div>
     </div>`
        console.log(JSON.stringify(track))
        console.log(track.name)
        
        $('.racetrack-wrapper').append(tracks)
    }
    console.log("raceTrack",raceTrack)
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("hoverid")
        $(".actions[hoverid=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none");
    });
}