$(function() {
    let height = 25.5;
    window.addEventListener("message", function(event) {
        if (event.data.type == "updateStatusHud") {
            let voice = event.data.varSetVoice;
            if (voice == 1) {
                Progress(event.data.varSetVoice * 25, '.progress-voice')
            }
            if (voice == 2) {
                Progress(event.data.varSetVoice * 30, '.progress-voice')
            }
            if (voice == 3) {
                Progress(101, '.progress-voice')
            }
        } else if (event.data.type == "talkingStatus") {
            if (event.data.is_talking) {
                document.getElementById("progress-voicer").style.stroke = "#D5CD31";
                document.getElementById("back-voicer").style.fill = "#B9B44E";
            } else {
                document.getElementById("progress-voicer").style.stroke = "";
                document.getElementById("back-voicer").style.fill = "";
            }
        } else if (event.data.type == "transmittingStatus") {
            var element = document.getElementById("progress-voicer");
            var backelement = document.getElementById("back-voicer");
            if (event.data.is_transmitting) {
                element.classList.add("transmitting");
                backelement.classList.add("transmitting2");
            } else {
                element.classList.remove("transmitting");
                backelement.classList.remove("transmitting2");
            }
        }
    });

    function widthHeightSplit(value, ele) {
        let eleHeight = (value / 100) * height;
        let leftOverHeight = height - eleHeight;

        ele.attr(
            "style",
            "height: " + eleHeight + "px; top: " + leftOverHeight + "px;"
        );
    }

    function changeColor(ele, value, flip) {
        let add = false;
        if (flip) {
            if (value > 85) {
                add = true;
            }
        } else {
            if (value < 25) {
                add = true;
            }
        }

        if (add) {
            // ele.find(".barIcon").addClass("danger")
            ele.find(".progressBar").addClass("dangerGrad");
        } else {
            // ele.find(".barIcon").removeClass("danger")
            ele.find(".progressBar").removeClass("dangerGrad");
        }
    }
});


function Progress(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find("span");

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 99) / 100 / 100) * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
}