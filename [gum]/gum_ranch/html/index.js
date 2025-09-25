var languageRanch = {}
var allSetup = {}
var maxBuy = []
var maxBreed = []
var allAnimals = []
var shared = []
var overMeCheck = false
var expCounter = []
var ownedTrough = []
var expTable = []
var owner = false
var inMinigame = false
var storageEnable = false
var blockSell = false
var isRentTime = false
var animalsData = []
$(document).keydown(function(e) {
    var close = 27;
    var close2 = 8;
    switch (e.keyCode) {
        case close:
            $.post('http://gum_ranch/close');
            $("#ranchManage").hide();
            $("#ranchAnimals").hide();
            $("#minigame").hide();
            if (inMinigame === true) {
                $.post('http://gum_ranch/finishMinigame');
                inMinigame = false
            }
            break;
        case close2:
            $.post('http://gum_ranch/close');
            $("#ranchManage").hide();
            $("#ranchAnimals").hide();
            $("#minigame").hide();
            if (inMinigame === true) {
                $.post('http://gum_ranch/finishMinigame');
                inMinigame = false
            }
        break;
    }
});

$(function() {
    function ranchMenu(bool) {
        if (bool) {
            $("#ranchManage").show();
        } else {
            $("#ranchManage").hide();
        }
    }
    function Stats(bool) {
        if (bool) {
            $("#animal_stats").show();
        } else {
            $("#animal_stats").hide();
        }
    }

    $("#ranchAnimals").hide();
    $("#minigame").hide();
    ranchMenu(false)
    Stats(false)
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "startMinigame") {
            openMinigame(item.product, item.count, item.pos, item.productItem)
            inMinigame = true
        }
        if (item.type === "show_stats") {
            Stats(true)
            languageRanch = item.language
            document.getElementById("gender").innerHTML = ""+languageRanch[44]+" : "+item.gender+""
            if (item.age == languageRanch[3]) {
                document.getElementById("age").innerHTML = ""+languageRanch[45]+""
            } else {
                document.getElementById("age").innerHTML = ""+languageRanch[46]+" : "+item.age+""+languageRanch[47]+""
            }
            document.getElementById("exp").innerHTML = ""+languageRanch[48]+" : "+item.exp+""
            document.getElementById("satisfaction").innerHTML = ""+languageRanch[49]+" : "+item.satisfaction+"%"
            document.getElementById("health").innerHTML = ""+languageRanch[50]+" : "+item.health+"%"
            document.getElementById("hunger").innerHTML = ""+languageRanch[51]+" : "+item.hunger+"%"
            document.getElementById("thirst").innerHTML = ""+languageRanch[52]+" : "+item.thirst+"%"
            if (item.product !== "none" && item.product !== 0) {
                document.getElementById("product").innerHTML = ""+languageRanch[53]+" : "+item.product+""+languageRanch[54]+""
            } else {
                document.getElementById("product").innerHTML = ""+languageRanch[55]+""
            }
            if (Number(item.breedtime) !== 0) {
                $("#breedtime").show();
                document.getElementById("breedtime").innerHTML = ""+languageRanch[56]+" : "+item.breedtime+""
            } else {
                $("#breedtime").hide();
            }
        }
        if (item.type === "hide_stats") {
            Stats(false)
        }
        if (item.type === "showMenu") {
            $("#ranchInfo").hide();
            $("#ranchInfoAccess").hide();
            enabledAnimals = item.enabledAnimals
            blockSell = item.blockSell
            storageEnable = item.storageEnable
            languageRanch = item.language
            expTable = item.expTable
            owner = item.owner
            allSetup = item.allSetup
            expCounter = item.expCounter
            shared = item.shared
            maxBuy = item.maxBuy
            maxBreed = item.maxBreed
            allAnimals = item.allAnimals
            ownedTrough = item.ownedTrough
            data = item.data
            animalsData = item.animalsData
            trough = item.trough
            isRentTime = item.isRentTime
            canAccessStorage = item.accessToStorage
            openMenuRanch(item.money, item.prepayed, item.prepayedDate)
        }

        if (item.type === "hide_stats_trough") {
            Stats(false)
        }
    })

    $("#close").click(function() {
        $.post('http://gum_ranch/exit', JSON.stringify({}));
        return
    })
})
var globalReward = 0
function openMinigame(animal, count, pos, productItem) {
   const tableBody = document.getElementById('minigame');
    let dataHtml = '';
    globalReward = count
    for(var i = 0; i < count; i++)
    {
        dataHtml += '<div class="gameItem" id="reward_'+i+'" onclick="pickReward(\''+i+'\',\''+animal+'\',\''+pos+'\')"><img src="images/product'+productItem+'.png" width="100" height="100" id="item"></div></div>'
    }
    tableBody.innerHTML = dataHtml
    for(var i = 0; i < count; i++)
    {
        var randomGeneratorX = getRandomInt(80);
        var randomGeneratorY = getRandomInt(80);
        document.getElementById('reward_'+i+'').style.left = ""+randomGeneratorX+"%";
        document.getElementById('reward_'+i+'').style.top = ""+randomGeneratorY+"%";
    }
    $("#minigame").show();
}

function pickReward(i, animal, pos) {
    globalReward = globalReward - 1
    document.getElementById('reward_'+i+'').remove();
    $.post('http://gum_ranch/pickReward', JSON.stringify({animal:animal, pos:pos}));
    if (globalReward == 0) {
        $("#minigame").hide();
        $.post('http://gum_ranch/finishMinigame');
        inMinigame = false
    }
}
function getRandomInt(max) {
    return Math.floor(Math.random() * max);
  }
function openMenuRanch(money, prepayed, prepayedDate) {
    const tableBody = document.getElementById('ranchButtons');
    let dataHtml = '';
    dataHtml += '<div class="buttonManage" id="animalsBuy" onclick="onClickAnimalsStore()">'+languageRanch[58]+'</div>'
    dataHtml += '<div class="buttonManage" id="through" onclick="onClickThrought()">'+languageRanch[59]+'</div>'
    dataHtml += '<div class="buttonManage" id="myAnimals" onclick="onClickMyAnimals()">'+languageRanch[57]+'</div>'
    if (storageEnable) {
        
        if (owner || canAccessStorage) {
             dataHtml += '<div class="buttonManage" id="storage" onclick="onClickStorage()">'+languageRanch[75]+'</div>'
        }
    }
    if (owner) {
        dataHtml += '<div class="buttonManage" id="access" onclick="onClickAccess()">'+languageRanch[60]+'</div>'
        dataHtml += '<div class="buttonManage" id="money" onclick="manipulateMoney()" >'+languageRanch[61]+''+money+' $</div>'
        const jsTime = new Date(prepayedDate);
        jsTime.setDate(jsTime.getDate() + 7);
        const day = jsTime.getDate();
        const month = jsTime.getMonth() + 1;
        const year = jsTime.getFullYear();
        const formattedDate = `${day}.${month}.${year}`;
        dataHtml += '<div class="buttonManage" id="sell" onclick="onSell()">'+languageRanch[43]+'</div>'
        if (isRentTime) {
            dataHtml += '<div class="buttonManage" id="payment" onclick="prepay()">'+languageRanch[62]+''+prepayed+' $</br>'+languageRanch[63]+''+formattedDate+'</div>'
        }
        dataHtml += '<div class="buttonManage" id="money" onclick="animalPosition()" >'+languageRanch[95]+'</div>'
    }
    if (owner) {
        document.getElementById("ranchGiveKey").innerHTML = languageRanch[64];
        $("#ranchGiveKey").show();
    } else {
        $("#ranchGiveKey").hide();
    }
    tableBody.innerHTML = dataHtml
    $("#ranchManage").show();
    fixToDiv()
}

function animalPosition() {
    $.post('http://gum_ranch/animalPosition', JSON.stringify({}));
}

function onClickStorage() {
    $("#ranchManage").hide();
    $.post('http://gum_ranch/storage');
}
function onSell() {
    $("#ranchManage").hide();
    $.post('http://gum_ranch/sell');
}
function manipulateMoney() {
    $.post('http://gum_ranch/money');
}
function prepay() {
    $.post('http://gum_ranch/prepay');
}

function getItems(arg) {
    $.post('http://gum_ranch/getItems', JSON.stringify({arg:arg}));
}

function onClickAccess() {
    $("#ranchInfo").hide();
    $("#ranchInfoAccess").show();
    const userHtml = document.getElementById('ranchInfoAccess');
    var innerHtml = '<table class="table-center" style="width:100%;">';
    innerHtml += '<colgroup>';
    if (owner) {
        innerHtml += '<col style="width: 60%;">';
        innerHtml += '<col style="width: 20%;">';
        innerHtml += '<col style="width: 20%;">';
    } else {
        innerHtml += '<col style="width: 100%;">';
    }
    innerHtml += '</colgroup>';
    innerHtml += '<tr>';
    innerHtml += '<th>'+languageRanch[96]+'</th>';
    if (owner) {
        innerHtml += '<th>'+languageRanch[75]+'</th>';
        innerHtml += '<th>'+languageRanch[97]+'</th>';
    }
    innerHtml += '</tr>';
    for (var a in shared) {
        innerHtml += '<tr>';
        innerHtml += '<td>'+shared[a].firstname+' '+shared[a].lastname+'</td>';
        if (owner) {
            if (shared[a].canAccess) {
                innerHtml += '<td onClick="accessStorage(\''+shared[a].charid+'\', \''+shared[a].steamid+'\', false)"><img id="accept" src="newimages/accept.png" width="30%" height="30%"></td>';
            } else {
                innerHtml += '<td onClick="accessStorage(\''+shared[a].charid+'\', \''+shared[a].steamid+'\', true)"><img id="cancel" src="newimages/cancel.png" width="30%" height="30%"></td>';
            }
        }
        innerHtml += '<td onClick="takeKey(\''+shared[a].charid+'\', \''+shared[a].steamid+'\')"><img id="cancel" src="newimages/cancel.png" width="30%" height="30%"></td>';
        innerHtml += '</tr>';
    }
    innerHtml += '</table>';
    userHtml.innerHTML = innerHtml
}

function accessStorage(charid, steamid, state) {
   $.post('http://gum_ranch/accessStorage', JSON.stringify({charid:charid, steamid:steamid, state:state}));
}


function giveKey(arg) {
    $.post('http://gum_ranch/giveKey', JSON.stringify({arg:arg})); 
}

function takeKey(charid, steamid) {
    $.post('http://gum_ranch/takeKey', JSON.stringify({charid:charid, steamid:steamid}));
}


function onClickThrought() {
    $("#ranchInfo").show();
    $("#ranchInfoAccess").hide();
    const tableBody = document.getElementById('ranchInfo');
    let dataHtml = '';

    dataHtml += '<div class="ranchAnimalsButtonSmallText">'+languageRanch[81]+'</div>'
    for (var a in data) {
        if (a == "trough") {
            const newTable = {};
            const troughData = JSON.parse(data[a]);
            for (var b in troughData) {
                newTable[troughData[b].id] = true;
                dataHtml += '<div class="ranchAnimalsButton" onmouseover="mouseOver(\''+troughData[b].id+'\')" onmouseout="mouseOut(\''+troughData[b].id+'\')">'+languageRanch[65]+'</br><img id="myAnimalIcon'+troughData[b].id+'" src="newimages/animals/'+troughData[b].id+'Icon.png" width="73%" height="70%"></div>'
            }
            for (var b in allAnimals) {
                if (newTable[allAnimals[b]] !== true) {
                    dataHtml += '<div class="ranchAnimalsButton" onClick="buyTrough(\''+b+'\')" onmouseover="mouseOver(\''+b+'\')" onmouseout="mouseOut(\''+b+'\')">Price : '+allSetup[b].troughPrice+'$</br><img id="myAnimalIcon'+b+'" src="newimages/animals/'+b+'Icon.png" width="73%" height="70%"></div>'
                }
            }
        }
    }
    tableBody.innerHTML = dataHtml
}

function buyTrough(arg) {
    $.post('http://gum_ranch/buyTrough', JSON.stringify({arg:arg}));
}
function onClickAnimalsStore() {
    $("#ranchInfo").show();
    $("#ranchInfoAccess").hide();
    const tableBody = document.getElementById('ranchInfo');
        let dataHtml = '';
        var countAnimals = []
        dataHtml += '<div class="ranchAnimalsButtonSmallText">'+languageRanch[82]+'</div>'
        for (var a in allAnimals) {
            countAnimals[allAnimals[a]] = 0;
            for (var b in data) {
                if (allAnimals[a] == b) {
                    const animalData = JSON.parse(data[b]);
                    for (var c in animalData) {
                        if (c !== 'age') {
                            countAnimals[allAnimals[a]] += 1;
                        }
                    }
                }
            }
        }
        for (var a in countAnimals) {
            if (enabledAnimals[a]) {
                if ((maxBuy[a]-countAnimals[a]) <= 0) {
                    dataHtml += '<div class="ranchAnimalsButton" onmouseover="mouseOver(\''+a+'\')" onmouseout="mouseOut(\''+a+'\')"></br>'+languageRanch[67]+'</br><img id="myAnimalIcon'+a+'" src="newimages/animals/'+a+'Icon.png" width="73%" height="70%"></div>';
                } else {
                    dataHtml += '<div class="ranchAnimalsButton" onClick="buyAnimals(\''+a+'\')" onmouseover="mouseOver(\''+a+'\', this.id)" onmouseout="mouseOut(\''+a+'\', this.id)">Price : '+allSetup[a].buyPrice+'$</br>Can buy : '+(maxBuy[a]-countAnimals[a])+'</br><img id="myAnimalIcon'+a+'" src="newimages/animals/'+a+'Icon.png" width="73%" height="70%"></div>';
                }
            }
        }
        tableBody.innerHTML = dataHtml
}

function mouseOver(name, element) {
    document.getElementById('myAnimalIcon' + name).setAttribute('src', "newImages/animals/"+name+"IconHover.png");
}

function mouseOut(name, element) {
    document.getElementById('myAnimalIcon' + name).setAttribute('src', "newImages/animals/"+name+"Icon.png");
}
function buyAnimals(arg) {
    $.post('http://gum_ranch/buyAnimals', JSON.stringify({arg:arg}));
}

function onClickMyAnimals() {
    $("#ranchInfo").show();
    $("#ranchInfoAccess").hide();
    const tableBody = document.getElementById('ranchInfo');
    let dataHtml = '';

    var countAnimals = []
    for (var a in allAnimals) {
        countAnimals[allAnimals[a]] = 0;
        for (var b in data) {
            if (allAnimals[a] == b) {
                const animalData = JSON.parse(data[b]);
                for (var c in animalData) {
                    if (c !== 'age') {
                        countAnimals[allAnimals[a]] += 1;
                    }
                }
            }
        }
    }
    dataHtml += '<div class="ranchAnimalsButtonSmallText">'+languageRanch[68]+'</br><input type="range" min="1" max="5" value="0" class="slider" id="range"></input></div>'
    for (var a in countAnimals) {
        dataHtml += '<div class="ranchAnimalsButton" onClick="openAnimals(\''+a+'\')" onmouseover="mouseOver(\''+a+'\')" onmouseout="mouseOut(\''+a+'\')">'+countAnimals[a]+'</br><img id="myAnimalIcon'+a+'" src="newimages/animals/'+a+'Icon.png" width="80%" height="80%"></div>'
    }
    tableBody.innerHTML = dataHtml 
    setTimeout(() => {
        document.getElementById("range").oninput = function() {rangeLead(this.value)}
    }, 50);
}

function rangeLead(value) {
    $.post('http://gum_ranch/range', JSON.stringify({value:value}));
}

function openAnimals(arg) {
    $("#ranchInfo").hide();
    $("#ranchInfoAccess").show();
    const tableBody = document.getElementById('ranchInfoAccess');
    var innerHtml = '<table class="table-center" style="width:100%;">';
    innerHtml += '<colgroup>';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';
    innerHtml += '<col style="width: 12.5%;">';

    innerHtml += '</colgroup>';
    innerHtml += '<tr>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/gender.png" width="60%" height="60%"></th>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/age.png" width="60%" height="60%"></th>';
    innerHtml += '<th>'+languageRanch[48]+'</th>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/happy.png" width="60%" height="60%"></th>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/health.png" width="60%" height="60%"></th>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/hunger.png" width="60%" height="60%"></th>';
    innerHtml += '<th><img id="myAnimalIcon'+a+'" src="newimages/animals/thirst.png" width="60%" height="60%"></th>';
    innerHtml += '<th>$</th>';
    innerHtml += '</tr>';
    for (var a in allAnimals) {
        for (var b in data) {
            if (allAnimals[a] == b && allAnimals[a] == arg) {
                innerHtml += '<td colspan="8" onclick="leadAnimal(\''+arg+'\')"><b>'+languageRanch[69]+'</b></td>';
                const animalData = JSON.parse(data[b]);
                for (var c in animalData) {
                    if (animalData[c].breedtime == 0) {
                        var result = allSetup[b].manualSellPrice * calculateProductFromExp(animalData[c].exp);
                        var roundedResult = parseFloat(result.toFixed(2));
                        if (animalData[c].age == languageRanch[3]) {
                            innerHtml += '<tr onclick="sellAnimal(\''+arg+'\', \''+(Number(c)+1)+'\', \''+''+roundedResult+''+'\')">';
                            innerHtml += '<td>'+animalData[c].gender+'</td>';
                            innerHtml += '<td>'+languageRanch[3]+'</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].exp*10)/10+'</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].satisfaction*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].health*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].hunger*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].thirst*10)/10+'%</td>';
                            innerHtml += '<td>'+roundedResult+'</td>';
                            innerHtml += '</tr>';
                        } else {
                            innerHtml += '<tr onclick="sellAnimal(\''+arg+'\', \''+(Number(c)+1)+'\', \''+''+roundedResult+''+'\')">';
                            innerHtml += '<td>'+animalData[c].gender+'</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].age*10)/10+'</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].exp*10)/10+'</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].satisfaction*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].health*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].hunger*10)/10+'%</td>';
                            innerHtml += '<td>'+Math.round(animalData[c].thirst*10)/10+'%</td>';
                            innerHtml += '<td>'+roundedResult+'</td>';
                            innerHtml += '</tr>';
                        }
                    } else {
                        var result = allSetup[b].manualSellPrice * calculateProductFromExp(animalData[c].exp);
                        var roundedResult = parseFloat(result.toFixed(2));
                        if (animalData[c].age == languageRanch[3]) {
                            innerHtml += '<tr>';
                            innerHtml += '<td>'+languageRanch[45]+''
                            innerHtml += '<td>'+languageRanch[51]+''
                            innerHtml += '<td>'+languageRanch[52]+''
                            innerHtml += '<td>'+languageRanch[48]+''
                            innerHtml += '<td>'+languageRanch[70]+''
                            innerHtml += '</tr>';
                        }
                    }
                }
            }
        }
    }
    innerHtml += '</table>';
    tableBody.innerHTML = innerHtml
}

function calculateProductFromExp(exp) {
    var counter = 0
    for (var i in expTable) {
        counter += 1
    }
    for (var i in expTable) {
        if (exp <= expTable[i][0]) {
            return expTable[i][1];
        }
    }
    return expTable[counter][1];
}
function leadAnimal(arg) {
    $.post('http://gum_ranch/leadAnimal', JSON.stringify({arg:arg}));
}
function sellAnimal(arg, num, price) {
    if (blockSell !== true) {
        $.post('http://gum_ranch/sellAnimal', JSON.stringify({arg:arg, num:num, price:price}));
    }
}
function fixToDiv() {
    document.getElementById("myAnimals").style.height = "25px"; 
    document.getElementById("animalsBuy").style.height = "25px"; 
    document.getElementById("through").style.height = "25px"; 
    if (owner) {
        document.getElementById("access").style.height = "25px"; 
    }
}