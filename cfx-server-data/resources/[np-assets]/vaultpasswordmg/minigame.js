let timer_start, timer_game, timer_finish, timer_time, answer, wrong, right, numbers, timerStart, positions;
let game_started = false;
let cookie = document.cookie;
const regex_time = /best-time_vaultcodes=([\d.]+)/g;
cookie = document.cookie;
kullanilacakrakam = 5;

const sleep = (ms, fn) => {return setTimeout(fn, ms)};

const rangeNumbers = (length = 1) => {
    return Array.from({length}, _ => Math.floor(Math.random() * 10))
}

// Options


document.querySelector('.minigame .numbers').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'c'){
        alert('Low tier cheater WeirdChamp');
        e.preventDefault();
        return false;
    }
});
document.querySelector('#answer').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'v'){
        alert('Low tier cheater WeirdChamp');
        e.preventDefault();
        return false;
    }
    if (e.key === 'Enter' && document.querySelector('.solution').offsetHeight === 0) {
        clearTimeout(timer_finish);
        check();
    }
});
document.querySelector('#answer').addEventListener('drop', function(e) {
    alert('Low tier cheater WeirdChamp');
    e.preventDefault();
    return false;
});

function check(){
    stopTimer();

    let response = document.querySelector('#answer').value.toLowerCase().trim();

    if(game_started && response === answer.join('')){
        document.querySelector('#answer').value = '';
        document.querySelector('.solution').innerHTML = '';
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.minigame .numbers').classList.add('hidden');
        document.querySelector('.minigame .input').classList.add('hidden');
        document.querySelector('.splash').innerHTML = `<div class="fa hacker">&#xf21b;</div class="texttttt">Password Input Completed`;
        $.post('http://vaultpasswordmg/callback', JSON.stringify({'success': true}));
        setTimeout( function(){
            $(".minigame").fadeOut()
        }, 3000)
    }else{
        document.querySelector('#answer').value = '';
        document.querySelector('.solution').innerHTML = '';
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.minigame .numbers').classList.add('hidden');
        document.querySelector('.minigame .input').classList.add('hidden');
        document.querySelector('.splash').innerHTML = `<div class="fa hacker">&#xf21b;</div class="texttttt">Password Input Failed`;
        $.post('http://vaultpasswordmg/callback', JSON.stringify({'success': false}));
        setTimeout( function(){
            $(".minigame").fadeOut()
        }, 3000)
    }
}

function reset(){
    game_started = false;

    resetTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);

    document.querySelector('.splash').classList.remove('hidden');
    document.querySelector('.minigame .numbers').classList.add('hidden');
    document.querySelector('.minigame .input').classList.add('hidden');

    document.querySelector('#answer').value = '';
    document.querySelector('.solution').innerHTML = '';

    start();
}

function start(data){

    document.querySelector('.splash').innerHTML = `<div class="fa hacker">&#xf21b;</div class="texttttt">Input password as shown`;
    answer = rangeNumbers(data.rakamsayisi);
    document.querySelector('.minigame .numbers').innerHTML = answer.join('');

    timer_start = sleep(2000, function(){
        document.querySelector('.splash').classList.add('hidden');
        document.querySelector('.minigame .numbers').classList.remove('hidden');

        timer_game = sleep(3000, function(){
            document.querySelector('.minigame .numbers').classList.add('hidden');
            document.querySelector('.minigame .input').classList.remove('hidden');

            game_started = true;
            startTimer();

            document.querySelector('#answer').focus({preventScroll: true});

            timer_finish = sleep((10000), function(){
                game_started = false;
                check();
            });
        });
    });
}

function startTimer(){
    timerStart = new Date();
    timer_time = setInterval(timer,1);
}
function timer(){
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}
function stopTimer(){
    clearInterval(timer_time);
}
function resetTimer(){
    clearInterval(timer_time);
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        $(".minigame").fadeIn()
        start(event.data);
    }
});