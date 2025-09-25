var inInput = false
var inAnswer = false
var inputData = []
$(document).keydown(function(e) {
    var pressenter=13;
    var close = 27;
    var close2 = 8;
    switch (e.keyCode) {
        case pressenter:
            if (inInput) {
                send_values()
            } else if (inAnswer) {
                cancelInput()
            }
        break;
        case close:
            if (inInput) {
                close_input()
            } else if (inAnswer) {
                cancelInput()
            }
        break;

    }
});

$(function() {
    function display2(bool) {
        if (bool) {
            $("#container").fadeIn(100);
        } else {
            $("#container").fadeOut(50);
        }
    }
    function display_input(bool) {
        if (bool) {
            $("#containerInput").show();
        } else {
            $("#containerInput").hide();
        }
    }
    function display_answer(bool) {
        if (bool) {
            $("#containerInput2").show();
        } else {
            $("#containerInput2").hide();
        }
    }
    $("#containerMultiple").hide();
    display2(false)
    display_input(false)
    display_answer(false)
    $("#drawEye").hide();

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "hitEye") {
            if (item.status == true) {
                $("#drawEye").css("background-image", "url('images/hoverEye.png')").css("transition", "background-image 0.15s");
            } else {
                $("#drawEye").css("background-image", "url('images/eye.png')").css("transition", "background-image 0.15s");
            }
        }
        if (item.type === "drawEye") {
            if (item.status == true) {
                $("#drawEye").show();
            } else {
                $("#drawEye").hide();
            }
        }
        if (item.type === "open_multipleinputs") {
            inputData = item.data
            loadMultipleInputs()
        }
        if (item.type === "copyPoly") {
            var text = ""
            for (var i in item.points) {
                text += "vector3("+item.points[i].x+","+item.points[i].y+","+item.points[i].z+"),\n";
            }
            var node = document.createElement('textarea');
            var selection = document.getSelection();
      
            node.textContent = text;
            document.body.appendChild(node);
      
            selection.removeAllRanges();
            node.select();
            document.execCommand('copy');
      
            selection.removeAllRanges();
            document.body.removeChild(node);
        }
        if (item.type === "notify") {
            if (item.status == true) {
                setTimeout(function(){ 
                    document.getElementById("title_text").innerHTML = item.title;
                    document.getElementById("text_system").innerHTML = item.text;
                    document.getElementById("iconimage").style.backgroundImage = "url('nui://"+item.folder+""+item.id+".png')";
                    display2(true)
                }, 50);
            } else {
                display2(false)
            }
        }
        if (event.data.type == "open_inputs"){
            if (event.data.status == true) {
                inInput = true
                display_input(true)
                $("#text_input").focus();
                set_input_info(event.data.title, event.data.subtext)
            } else {
                display_input(false)  
                inInput = false
            }
        }
        if (event.data.type == "open_answer"){
            if (event.data.status == true) {
                inAnswer = true
                display_answer(true)
                $("#text_input").focus();
                set_input_answer(event.data.title, event.data.first, event.data.second)
            } else {
                display_answer(false)  
                inAnswer = false
            }
        }

    })

})
function loadMultipleInputs() {
    const tableBody = document.getElementById('containerMultiple');
    let dataHtml = '';   
    dataHtml += '<br>';   
    for (var a in inputData) {
        if (inputData[a].isButton) {
            dataHtml += '<center>- ' + inputData[a].label + ' -<br><div id="inputButton' + a + '1" class="inputButton" onclick="swapIt(' + a + ', 1)" style="display: inline-block;">' + inputData[a].button1 + '</div><div id="inputButton' + a + '2" class="inputButton" onclick="swapIt(' + a + ', 2)" style="display: inline-block;">' + inputData[a].button2 + '</div></center><br><br>';
        } else {
            dataHtml += '<center>- ' + inputData[a].label + ' -<br><input type="text" id="input' + a + '" class="inputNumber" value="'+inputData[a].value+'" onchange="swapItInput(\'' + a + '\', this.value)"></center><br><br>';
        }
    }
    dataHtml += '<center><div id="inputButton" class="inputButton" onclick="finishMultipleInputs()" style="display: inline-block;">Finish</div><div id="inputButton" class="inputButton" onclick="cancelMultipleInputs()" style="display: inline-block;">Cancel</div></center><br><br>';
    tableBody.innerHTML = dataHtml;
    $("#containerMultiple").show();
}
function swapIt(key, value) {
    inputData[key].value = value

    if (value == 1) {
        document.getElementById("inputButton" + key + value).style.backgroundImage = "url('images/buttonInputActive.png')";
        document.getElementById("inputButton" + key + 2).style.backgroundImage = "url('images/buttonInput.png')";        
    } else {
        document.getElementById("inputButton" + key + value).style.backgroundImage = "url('images/buttonInputActive.png')";
        document.getElementById("inputButton" + key + 1).style.backgroundImage = "url('images/buttonInput.png')";        
    }
}

function cancelMultipleInputs() {
    $("#containerMultiple").hide();
    $.post('http://gumApi/multipleinputs', JSON.stringify({ inputData: null }));
}
function finishMultipleInputs() {
    var isComplete = true
    for (var a in inputData) {
        if (inputData[a].isButton) {
            if (inputData[a].value === 0) {
                isComplete = false
            }
        }
    }
    if (isComplete) {
        $("#containerMultiple").hide();
        $.post('http://gumApi/multipleinputs', JSON.stringify({ inputData: inputData }));
    }
}
function swapItInput(key, value) {
    inputData[key].value = value
}

function set_input_info(title, subtext) {
    document.getElementById("header").innerHTML = title;
    document.getElementById("button_2").innerHTML = subtext;
}
function set_input_answer(title, first, second) {
    document.getElementById("header2").innerHTML = title;

    document.getElementById("button_2_ans").innerHTML = first;
    document.getElementById("button_1_ans").innerHTML = second;
}

function send_values() {
    if (document.getElementById("text_input").value === "") {
        document.getElementById("form_id").reset();
        $.post('http://gumApi/button_1', JSON.stringify({ text: "close" }));
    } else {
        $.post('http://gumApi/button_2', JSON.stringify({ text: document.getElementById("text_input").value }));
        document.getElementById("text_input").value = "";
        document.getElementById("form_id").reset();
    }
    inInput = false;
}

function close_input() {
    document.getElementById("form_id").reset();
    inInput = false
    $("#containerInput").hide();
    $.post('http://gumApi/button_1', JSON.stringify({ text: "close" }));
}

function yes_func() {
    document.getElementById("form_id").reset();
    $("#containerInput2").hide();
    inAnswer = false
    $.post('http://gumApi/yes', JSON.stringify({ text: "yes" }));
}

function no_func() {
    document.getElementById("form_id").reset();
    $("#containerInput2").hide();
    inAnswer = false
    $.post('http://gumApi/no', JSON.stringify({ text: "no" }));
}

function cancelInput() {
    document.getElementById("form_id").reset();
    $("#containerInput2").hide();
    inAnswer = false
    $.post('http://gumApi/cancelAnswer', JSON.stringify({ text: "cancel" }));
}