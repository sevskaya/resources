
var inMenu = false;
var inHorseMenu = false;
var inPlayerStore = false;
var language = {};
var stablesInfo = {};
var transferEnable = false;
var isInAnimal = false;
var animalId = 0;
var inDeleteMenu = false;
var company = false;
var firstTime = false;
var blockSpam = false;
var baseAcc = 0;
var baseSpeed = 0;
var baseTurn = 0;
var shotedNails = []
var shotedNailsWheel = []
var oldValuePartShoe = 0
var draggableInstance = null;
var settedBreedHorses = [];
var inBreedList = false;
var jobPermissions = {};
var isInAnimals = false;
var selectedElement = null;
var horseShoeUpdate = 0;
var configHorseStableLogic = {};
var wheelFixMenu = false;
var fixCart = false;
var fps = 0;
var pressDuration = 1;
var lastPress = 0;
var horseId = 0;
var blockUseScript = false;
$(document).keydown(function(e) {
    var close = 27;
    var close2 = 8;
    var ekey = 65;
    var qkey = 68;
    var wkey = 87;
    var skey = 83;
    switch (e.keyCode) {
        case close:
            clearMenu()
        break;
        case close2:
            clearMenu()
            break;
        case qkey:
            $.post('http://gum_stables/ekey');
        break;
        case ekey:
            $.post('http://gum_stables/qkey');
        break;
        case wkey:
            $.post('http://gum_stables/skey');
        break;
        case skey:
            $.post('http://gum_stables/wkey');
        break;
    }
});

function clearMenu() {
    if (blockUseScript) {
        return;
    }
    blockUseScript = true;
    $('#adminContainer').fadeOut(150)
    $("#addonManageContainer").fadeOut(150)
    $("#animalStorageContainer").fadeOut(150)
    $.post('http://gum_stables/clearTarget');
    if (wheelFixMenu) {
        $('#minigameWheel').fadeOut(150)
        shotedNailsWheel = []
        wheelFixMenu = false
        $.post('http://gum_stables/cancelMinigameWheel');
        setTimeout(function() {
            for (var i = 1; i <= 6; i++) {
                document.getElementById('minigameNailWheel'+i).style.backgroundImage = "url('images/minigame/wheel/Nail-State01.png')";
            }
        }, 200);
    }
    if (isInAnimals) {
        $('#animalStorageContainer').fadeOut(150);
        $.post('http://gum_stables/clearAnimals', JSON.stringify({id:isInAnimals}))
        isInAnimals = false
    }
    if (inBreedList) {
        $('#maleSide').fadeIn(150)
        $('#femaleSide').fadeIn(150)
        $('#breedList').fadeIn(150)
        $('#breedAccept').fadeOut(150)
        $('#breedListContainer').fadeOut(150)
        inBreedList = false
        inHorseMenu = false
    } else {
        if (inMenu) { 
            $('#horseCategory').fadeIn(150);
            $('#cartCategory').fadeIn(150);
            $('#baseContainer').fadeOut(150);
            $('#myHorses').fadeIn(150);
            $('#myCarts').fadeIn(150);
            $('#componentContainer').fadeOut(150);
            $('#shoeBars').fadeOut(150);
            $('#breedContainer').fadeOut(150);
            $('#acceptComp').fadeOut(150);
            $('#acceptColor').fadeOut(150);
            $('#cartComponentContainer').fadeOut(150);
            $('#transferContainer').fadeOut(150);
            inMenu = false
            inHorseMenu = false
            firstTime = false
            $.post('http://gum_stables/clearPreview')
        } else {
            $('#buildCartContainer').fadeOut(150)
            $('#playerStoreContainer').fadeOut(150)
            $('#compManageContainer').fadeOut(150);  
            $('#bagsManageContainer').fadeOut(150);  
            $("#stableContainer").fadeOut(150);
            if (inHorseMenu == false && inPlayerStore == false) {
                $.post('http://gum_stables/clearPreview')
            }
            if (inPlayerStore == true) {
                $.post('http://gum_stables/clearPreview', JSON.stringify({rc:true}))
            }
            inMenu = false
            if (isInAnimal) {
                $.post('http://gum_stables/cleanAnimals', JSON.stringify({id:animalId}));
                isInAnimal = false
            }
            if (inHorseMenu == false) {
                $.post('http://gum_stables/closeMenu', JSON.stringify({}));
                inHorseMenu = false
            }
            $.post('http://gum_stables/closeNui')

            firstTime = false
        }
    }
    baseAcc = 0;
    baseSpeed = 0;
    baseTurn = 0;
    setTimeout(() => {
        blockUseScript = false;
    }, 500);
}
$(document).mousedown(function(e){
    if(e.which === 3) {
        $.post('http://gum_stables/canRotate', JSON.stringify({rotate:true}));
    }
});
$(document).mouseup(function(e){
    if(e.which === 3) {
        $.post('http://gum_stables/canRotate', JSON.stringify({rotate:false}));
    }
});
var lastPosition = {};
$(document).on('mousemove', function (event) {
    if (typeof(lastPosition.x) != 'undefined') {
        var deltaX = lastPosition.x - event.offsetX,
            deltaY = lastPosition.y - event.offsetY;
        if (Math.abs(deltaX) > Math.abs(deltaY) && deltaX > 0) {
            $.post('http://gum_stables/rotate', JSON.stringify({direction:"left"}));
        } else if (Math.abs(deltaX) > Math.abs(deltaY) && deltaX < 0) {
            $.post('http://gum_stables/rotate', JSON.stringify({direction:"right"}));
        } else if (Math.abs(deltaY) > Math.abs(deltaX) && deltaY > 0) {
            $.post('http://gum_stables/rotate', JSON.stringify({direction:"up"}));
        } else if (Math.abs(deltaY) > Math.abs(deltaX) && deltaY < 0) {
            $.post('http://gum_stables/rotate', JSON.stringify({direction:"down"}));
        }
    }
    lastPosition = {
        x : event.offsetX,
        y : event.offsetY
    };
});
window.addEventListener('wheel', function(event)
{
 if (event.deltaY < 0)
 {
    $.post('http://gum_stables/rotate', JSON.stringify({direction:"zoom+"}));
}
 else if (event.deltaY > 0)
 {
    $.post('http://gum_stables/rotate', JSON.stringify({direction:"zoom-"}));
 }
});

$(function() {
    $('#adminContainer').hide()
    $('#shoeBars').hide();
    $('#breedContainer').hide();
    $("#stableContainer").hide();
    $('#cartComponentContainer').hide()
    $('#transferContainer').hide();
    $('#bagsManageContainer').hide();
    $('#compManageContainer').hide();
    $('#hungerActive').hide();
    $('#thirstActive').hide();
    $('#playerStoreContainer').hide();
    $('#buildCartContainer').hide();
    $('#minigameDragging').hide();
    $('#minigameDraggingFilled').hide();
    $('#minigameWhoWin').hide();
    $('#wildStatus').hide();
    $('#animalStorageContainer').hide();
    $("#addonManageContainer").hide();
    $('#minigameWheel').hide();
    $.post('http://gum_stables/screen', JSON.stringify({ x:window.screen.availWidth, y:window.screen.availHeight}))
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "languageLoad"){
            language = {}
            language = item.language
        }
        if (item.type === "showStatusWildTable") {
            $('#wildStatus').show();
            const wildBody = document.getElementById('wildStatus');
            let dataWild = '';   
            dataWild += '<div id="wildGender">Female</div>'
            dataWild += '<div id="wildAge">8 Years</div>'
            dataWild += '<div id="wildStatusAcc">'+language[153]+''
            dataWild += '  <div id="wildAccBar"></div>'
            dataWild += '  <div id="wildAccBarFilled"></div>'
            dataWild += '</div>'
            dataWild += '<div id="wildStatusSpeed">'+language[154]+''
            dataWild += '  <div id="wildSpeedBar"></div>'
            dataWild += '  <div id="wildSpeedBarFilled"></div>'
            dataWild += '</div>'
            dataWild += '<div id="wildStatusTurn">'+language[155]+''
            dataWild += '  <div id="wildTurnBar"></div>'
            dataWild += '  <div id="wildTurnBarFilled"></div>'
            dataWild += '</div>'
            wildBody.innerHTML = dataWild
            document.getElementById('whoWinKey').innerHTML = ''+language[153]+'';
            document.getElementById('wildGender').innerHTML = ''+item.dataHorse.gender+'';
            document.getElementById('wildAge').innerHTML = ''+item.dataHorse.age+' '+language[157]+'';
            document.getElementById('wildAccBarFilled').style.width = ''+item.dataHorse.acceleration*10+'%';
            document.getElementById('wildSpeedBarFilled').style.width = ''+item.dataHorse.speed*10+'%';
            document.getElementById('wildTurnBarFilled').style.width = ''+item.dataHorse.turn*10+'%';
        }
        if (item.type === "hideStatusTableWild") {
            $('#wildStatus').hide();
        }
        if (item.type == "startMinigameShoe"){
            $('#tool').fadeIn(150);
            $('#minigameShoe').fadeIn(150);
            for (var i = 1; i <= 8; i++) {
                $('#minigameNail'+i).fadeIn(150);
            }
            $('#shoesAccept').hide();
            horseShoeUpdate = item.value
        }
        if (item.type == "startMinigameWheel") {
            $('#wildStatus').hide();
            fixCart = item.fixCart
            wheelFixMenu = true
            $('#tool').fadeIn(150);
            $('#minigameWheel').fadeIn(150);
            wheelPosition = item.num
            $(document).ready(function() {
                $(document).on('mousemove', function(e) { 
                    $("#toolWheel").css({
                        left: e.pageX - $("#toolWheel").width() / 3.0,
                        top: e.pageY - $("#toolWheel").height() / 3.0
                    });
                });
            });
        }
        if (item.type == "statusBar") {
            if (item.statusDate) {
                $('#hungerActive').show();
                $('#thirstActive').show(); 
                setHungerBar(item.hunger)
                setThirstBar(item.thirst)
            } else {
                $('#hungerActive').hide();
                $('#thirstActive').hide();            
            }
        }
        if (item.type == "openAnimals") {
            inHorseMenu = true
            loadAnimalStorage(item.cartAnimals, item.maxStorage, item.wagonId)
            isInAnimals = item.wagonId
        }
        if (item.type == "openPlayerStore") {
            inPlayerStore = true
            loadPlayerStore(item.horseData, item.cartData, item.isOwner)
        }
        if (item.type == "openBuild") {
            openBuildMenu(item.items, item.folder, item.enableIcon)
        }
        if (item.type == "startDragging") {
            startDraggingMinigame(item.status)
        }
        if (item.type == "updateData") {
            myHorses = item.myHorses
            allMyHorses = item.allMyHorses
            myCarts = item.myCarts
            allMyCarts = item.allMyCarts
            myMatingHorses = item.myMatingHorses
            if (item.isBreed) {
                openHorseBreed()
            }
        }
        if (item.type === "open_company") {
            if (item.status) {
                companyPos = item.companyPos
                companyData = item.companyData
                companyHorses = item.companyHorses
                companyCarts = item.companyCarts
                stablesInfo = item.stablesInfo
                companyInfo = item.companyInfo
                jobPermissions = item.jobPermissions
                allComponentsMax = item.allComponentsMax
                myMatingHorses = item.myMatingHorses
                language = {}
                language = item.language
                if (configHorseStableLogic.callFromStables) {
                    horseId = item.horseId
                }
                cartId = item.cartId
                if (item.isMenu) {
                    $("#stableContainer").fadeIn(150);
                    const horseBody = document.getElementById('horseCategory');
                    let dataHorse = '';   
                    dataHorse += '<div class="stablesCatButton">'+language[100]+'</div>';
                    dataHorse += '<div class="stablesButton" id="horseCompBtn" onclick="openHorseComponent(\''+item.horseId+'\')">'+language[102]+'</div>'
                    if (companyData.horseSetting.horseShoe == true && jobPermissions.canShoe) {
                        dataHorse += '<div class="stablesButton" id="horseShoeBtn" onclick="openHorseShoe(\''+item.maxShoes+'\', \''+item.horseId+'\')">'+language[103]+'</div>'
                    }
                    if (configHorseStableLogic.whereTheyAreKept.enabled == true && companyData.horseSetting.horseTransfer == true) {
                        dataHorse += '<div class="stablesButton" id="horseColorBtn" onclick="openTransfer()">'+language[104]+'</div>'
                    }
                    if (jobPermissions.canColorHorse && companyData.horseSetting.horseColoring == true) {
                        dataHorse += '<div class="stablesButton" id="horseColorBtn" onclick="openHorseColor(\''+item.horseId+'\')">'+language[105]+'</div>'
                    }
                    if (jobPermissions.canBreed && companyData.horseSetting.horseBreed) {
                        dataHorse += '<div class="stablesButton" id="horseBreedBtn" onclick="openHorseBreed()">'+language[106]+'</div>'
                    }
                    horseBody.innerHTML = dataHorse
    
                    const cartBody = document.getElementById('cartCategory');
                    let dataCart = '';   
                    dataCart += '<div class="stablesCatButton">'+language[107]+'</div>';
                    if (companyData.cartsSetting.cartComponent == true) {
                        dataCart += '<div class="stablesButton" id="cartCompBtn" onclick="openCartComponent(\''+cartId+'\')">'+language[109]+'</div>'
                    }
                    if (configCartStableLogic.whereTheyAreKept.enabled && companyData.cartsSetting.cartTransfer == true) {
                        dataCart += '<div class="stablesButton" id="cartCompBtn" onclick="openTransfer()">'+language[110]+'</div>'
                    }
                    cartBody.innerHTML = dataCart
                    document.getElementById('myHorses').onclick = function() {loadMyHorses('company');};
                    document.getElementById('myCarts').onclick = function() {loadMyCarts('company');};

                    $('#horseCategory').fadeIn(150);
                    $('#cartCategory').fadeIn(150);
                    $('#baseContainer').hide();
                    $('#myHorses').fadeIn(150);
                    $('#myCarts').fadeIn(150);
                    $('#componentContainer').fadeOut(150);
                    $('#acceptComp').fadeOut(150);
                    $('#acceptColor').fadeOut(150);
                }

            } else {
                $("#stableContainer").fadeOut(150);
            }
        }
        if (item.type === "blockOpenStables") {
            blockUseScript = true;
            setTimeout(() => {
                blockUseScript = false;
            }, 500);
        }
        if (item.type === "open_stable") {
            if (item.status == true) {
                company = item.company
                configHorseLogic = item.configHorseLogic
                configCartLogic = item.configCartLogic
                configHorseStableLogic = item.configHorseStableLogic
                configCartStableLogic = item.configCartStableLogic
                
                storeHorses = {}
                storeHorses = item.storeHorses
                storeCarts = {}
                storeCarts = item.storeCarts
                
                myCarts = {}
                myCarts = item.myCarts
                myHorses = {}
                myHorses = item.myHorses

                allMyHorses = {}
                allMyHorses = item.allMyHorses
                allMyCarts = {}
                allMyCarts = item.allMyCarts

                myMatingHorses = {}
                myMatingHorses = item.myMatingHorses

                language = {}
                language = item.language
                
                jobPermissions = item.jobPermissions

                allComponentsMax = item.allComponentsMax

                stablesInfo = item.stablesInfo
                companyInfo = item.companyInfo
                const horsesFiltr = Object.values(storeHorses).sort((a, b) => {
                    return a.category.localeCompare(b.category);
                });
                storeHorses = horsesFiltr
                if (item.isMenu) {
                    $("#stableContainer").fadeIn(150);
                    const horseBody = document.getElementById('horseCategory');
                    let dataHorse = '';   
                    dataHorse += '<div class="stablesCatButton">'+language[100]+'</div>';
                    if (item.stablesInformation.horsesSetting.horseStore) {
                        dataHorse += '<div class="stablesButton" id="horseStoreBtn" onclick="openHorseStore()">'+language[101]+'</div>'
                    }
                    if (item.stablesInformation.horsesSetting.horseComponent) {
                        horseId = item.horseId
                        dataHorse += '<div class="stablesButton" id="horseCompBtn" onclick="openHorseComponent()">'+language[102]+'</div>'
                    }
                    if (jobPermissions.canShoe && item.stablesInformation.horsesSetting.horseShoe) {
                        dataHorse += '<div class="stablesButton" id="horseShoeBtn" onclick="openHorseShoe('+item.maxShoes+')">'+language[103]+'</div>'
                    }
                    if (jobPermissions.canBreed && item.stablesInformation.horsesSetting.horseBreed) {
                        dataHorse += '<div class="stablesButton" id="horseBreedBtn" onclick="openHorseBreed()">'+language[106]+'</div>'
                    }
                    if (configHorseStableLogic.whereTheyAreKept.enabled == true && item.stablesInformation.horsesSetting.horseTransfer) {
                        dataHorse += '<div class="stablesButton" id="horseColorBtn" onclick="openTransfer(\'horse\')">'+language[104]+'</div>'
                    }
                    if (jobPermissions.canColorHorse && item.stablesInformation.horsesSetting.horseColoring) {
                        dataHorse += '<div class="stablesButton" id="horseColorBtn" onclick="openHorseColor()">'+language[105]+'</div>'
                    }
                    horseBody.innerHTML = dataHorse
    
                    const cartBody = document.getElementById('cartCategory');
                    let dataCart = '';   
                    dataCart += '<div class="stablesCatButton">'+language[107]+'</div>';
                    if (item.stablesInformation.cartsSetting.cartStore) {
                        dataCart += '<div class="stablesButton" id="cartStoreBtn" onclick="openCartStore()">'+language[108]+'</div>'
                    }
                    if (item.stablesInformation.cartsSetting.cartComponent) {
                        dataCart += '<div class="stablesButton" id="cartCompBtn" onclick="openCartComponent()">'+language[109]+'</div>'
                    }
                    if (configCartStableLogic.whereTheyAreKept.enabled && item.stablesInformation.cartsSetting.cartTransfer) {
                        dataCart += '<div class="stablesButton" id="cartCompBtn" onclick="openTransfer(\'cart\')">'+language[110]+'</div>'
                    }
                    cartBody.innerHTML = dataCart
                    document.getElementById('myHorses').onclick = function() {loadMyHorses('stable');};
                    document.getElementById('myCarts').onclick = function() {loadMyCarts('stable');};
                    $('#horseCategory').fadeIn(150);
                    $('#cartCategory').fadeIn(150);
                    $('#baseContainer').hide();
                    $('#myHorses').fadeIn(150);
                    $('#myCarts').fadeIn(150);
                    $('#componentContainer').fadeOut(150);
                    $('#acceptComp').fadeOut(150);
                    $('#acceptColor').fadeOut(150);
                }
            } else {
                $("#stableContainer").fadeOut(150);
            }
        }
        if (item.type === "openBagsManage") {
            language = item.language
            inHorseMenu = true
            openBagsManage(item.size, item.id, item.cart, item.bags, item.shared, item.byId)
        }
        if (item.type === "openCompManage") {
            inHorseMenu = true
            componentsLoad()
            myHorses = item.myHorses
        }
        if (item.type === "changeCartStore") {
            loadCartStoreData(item.money, item.craftPrice,item.gold, item.storage, item.storageAnimals, item.category, item.name, item.model, item.description, item.craftRecipe)
        }
        if (item.type == "resetShoe") {
            clearMenu()
        }
        if (item.type === "changeHorseStore") {
            if (firstTime) {
                loadHorseStoreData(item.price, item.gold, item.storage, item.category, item.colorName, item.description)
            }
            firstTime = true
        }
        if (item.type === "loadMyHorseData") {
            loadMyHorsesData(item.data.id, item.data.name, item.data.exp, item.data.sex, item.data.age, item.data.breeding, item.data.friendly, item.data.courage, item.data.isdead, item.data.selected, item.data.model, item.company)
        }
        if (item.type === "deleteClick") {
            inDeleteMenu = item.status
        }
        if (item.type === "loadMyCartData") {
            loadMyCartsData(item.data.id, item.data.name, item.data.selected, item.data.damage_wheel, item.data.health_cart, item.data.cityPosition, item.data.spotPosition, item.company)
        }
        if (item.type === "loadCartCompStore") {
            $.post('http://gum_stables/resetComponentsStore');
            openCartComponentStore(item.id, item.max_extras, item.max_lantern, item.max_livery, item.max_tints, item.max_propset)
        }
        if (item.type === "addToBreed") {
            if (item.gender === language[123]) {
                settedBreedHorses[1] = item.id;
            } else {
                settedBreedHorses[0] = item.id;
            }
            if (settedBreedHorses.length == 2) {
                $("#breedAccept").fadeIn(150);
            }
        }
        if (item.type === "loadComponentCart") {
            TweenLite.to('#propsetWheel', 1, {rotation: item.propset * 60});
            TweenLite.to('#lanternWheel', 1, {rotation: item.lantern * 60});
            TweenLite.to('#liveryWheel', 1, {rotation: item.livery * 60});
            TweenLite.to('#tintWheel', 1, {rotation: item.tint * 60});
            TweenLite.to('#horsesWheel', 1, {rotation: item.horses * 60});
            var lanternString = item.lantern
            if (lanternString == "none" || lanternString == NaN) {
                lanternString = 0
            }
            document.getElementsByClassName('sliderPropsetValue')[0].innerHTML = item.propset;
            document.getElementsByClassName('sliderLanternValue')[0].innerHTML = lanternString;
            document.getElementsByClassName('sliderLiveryValue')[0].innerHTML = item.livery;
            document.getElementsByClassName('sliderTintValue')[0].innerHTML = item.tint;
            document.getElementsByClassName('sliderHorsesValue')[0].innerHTML = item.horses;
        }
        if (item.type === "hideMinigameWheelFix") {
            $('#minigameWheel').fadeOut(150);
            shotedNailsWheel = []
            wheelFixMenu = false
            setTimeout(function() {
                for (var i = 1; i <= 6; i++) {
                    document.getElementById('minigameNailWheel'+i).style.backgroundImage = "url('images/minigame/wheel/Nail-State01.png')";
                }
            }, 200);
        }
        if (item.type === "loadColorHorse") {
            var component = item.horseColoring
            if (component) {
                if (component.scaleValue) {
                    if (component.scaleValue == -1) {
                        component.scaleValue = 0
                    }
                    if (Draggable.get(".sliderScales")) {
                        TweenLite.to('.sliderScales', 1, {rotation: component.scaleValue * 60});
                        document.getElementsByClassName('sliderScalesValue')[0].innerHTML = component.scaleValue;
                    }
                }
                if (component.horseColorPal) {
                    if (component.horseColorPal == -1) {
                        component.horseColorPal = 0
                    }
                    if (Draggable.get(".sliderPalettes")) {
                        TweenLite.to('.sliderPalettes', 1, {rotation: component.horseColorPal * 60});
                        document.getElementsByClassName('sliderPalettesValue')[0].innerHTML = component.horseColorPal;
                    }
                }
                if (component.horseColor1) {
                    if (component.horseColor1 == -1) {
                        component.horseColor1 = 0
                    }
                    if (Draggable.get(".sliderHColor1s")) {
                        TweenLite.to('.sliderHColor1s', 1, {rotation: component.horseColor1 * 60});
                        document.getElementsByClassName('sliderHColor1sValue')[0].innerHTML = component.horseColor1;
                    }
                }
    
                if (component.horseColor2) {
                    if (component.horseColor2 == -1) {
                        component.horseColor2 = 0
                    }
                    if (Draggable.get(".sliderHColor2s")) {
                        TweenLite.to('.sliderHColor2s', 1, {rotation: component.horseColor2 * 60});
                        document.getElementsByClassName('sliderHColor2sValue')[0].innerHTML = component.horseColor2;
                    }
                }
                if (component.horseColor3) {
                    if (component.horseColor3 == -1) {
                        component.horseColor3 = 0
                    }
                    if (Draggable.get(".sliderHColor3s")) {
                        TweenLite.to('.sliderHColor3s', 1, {rotation: component.horseColor3 * 60});
                        document.getElementsByClassName('sliderHColor3sValue')[0].innerHTML = component.horseColor3;
                    }
                }
                if (component.tailColorPal) {
                    if (component.tailColorPal == -1) {
                        component.tailColorPal = 0
                    }
                    if (Draggable.get(".sliderTMPalettes")) {
                        TweenLite.to('.sliderTMPalettes', 1, {rotation: component.tailColorPal * 60});
                        document.getElementsByClassName('sliderTMPalettesValue')[0].innerHTML = component.tailColorPal;
                    }
                }
    
                if (component.tailColor1) {
                    if (component.tailColor1 == -1) {
                        component.tailColor1 = 0
                    }
                    if (Draggable.get(".sliderTMColor1s")) {
                        TweenLite.to('.sliderTMColor1s', 1, {rotation: component.tailColor1 * 60});
                        document.getElementsByClassName('sliderTMColor1sValue')[0].innerHTML = component.tailColor1;
                    }
                }
                if (component.tailColor2) {
                    if (component.tailColor2 == -1) {
                        component.tailColor2 = 0
                    }
                    if (Draggable.get(".sliderTMColor2s")) {
                        TweenLite.to('.sliderTMColor2s', 1, {rotation: component.tailColor2 * 60});
                        document.getElementsByClassName('sliderTMColor2sValue')[0].innerHTML = component.tailColor2;
                    }
                }
                if (component.tailColor3) {
                    if (component.tailColor3 == -1) {
                        component.tailColor3 = 0
                    }
                    if (Draggable.get(".sliderTMColor3s")) {
                        TweenLite.to('.sliderTMColor3s', 1, {rotation: component.tailColor3 * 60});
                        document.getElementsByClassName('sliderTMColor3sValue')[0].innerHTML = component.tailColor3;
                    }
                }
            }
        }
        if (item.type === "openAddon") {
            openAddonStorage(item.items, item.cartItems, item.maxStorage, item.wagonId, item.model, item.typeItem, item.enableIcon, item.folder)
        }
        if (item.type === "updateHorseState") {
            updateHorseState(item.sp, item.acc, item.agi, item.max)
        }
        if (item.type === "updateCompSliders") {
            loadCompSliders(item.components)
        }
        if (item.type === "editDragging") {
            const now = Date.now();
            const fps = Number(item.fps); 
            const minDuration = 1;
            const maxDuration = 100;
            if (now - lastPress >= pressDuration) {
                lastPress = now;
              if (fps <= 20) {
                pressDuration = maxDuration;
              } else if (fps <= 40) {
                pressDuration = (maxDuration - minDuration) * (40 - fps) / (40 - 20) + minDuration;
              } else if (fps <= 60) {
                pressDuration = (maxDuration - minDuration) * (60 - fps) / (60 - 40) + minDuration;
              } else {
                pressDuration = minDuration;
              }
              document.getElementById('minigameDraggingFilled').style.width = `${item.value}%`;
            }
        }
        if (item.type === "editWinDragging") {
            if (item.value == "person") {
                document.getElementById('minigameWhoWin').style.background = 'url("images/minigame/personWinHover.png")';
                document.getElementById('minigameWhoWin').style.backgroundSize = 'cover';
            } else {
                document.getElementById('minigameWhoWin').style.background = 'url("images/minigame/horseWinHover.png")';
                document.getElementById('minigameWhoWin').style.backgroundSize = 'cover';
            }
        }
        if (item.type === "changeHorseCompPrice") {
            if (item.price == 0) {
                document.getElementById(''+item.comp+'').innerHTML = item.text
            } else {
                document.getElementById(''+item.comp+'').innerHTML = item.text+" - "+item.price+"$";
            }
        }
        if (item.type === "openAdmin") {
            inHorseMenu = true
            loadAdministrations(item.datas)
        }
    })
    window.addEventListener('click', event => {
        if (inDeleteMenu) {
            $.post('http://gum_stables/simulateClick')
        }
    });
})

function loadAdministrations(datas) {
    if (blockUseScript) {
        return;
    }
    $('#adminContainer').fadeIn(150)
    const tableBody = document.getElementById('adminContainer');
    var dataHtml = '';
    dataHtml += '<div id="buildCartButton" onclick="adminAction(\'undefined\', \'undefined\', \'add\')">Add user</div>'
    for (var i in datas) {
        dataHtml += '<div id="buildCartButton" onclick="adminAction(\''+datas[i].charidentifier+'\', \''+datas[i].job+'\', \'remove\')">'+datas[i].name+'</div>'
    }
    tableBody.innerHTML = dataHtml
}

function adminAction(charidentifier, job, type) {
    if (blockUseScript) {
        return;
    }
    $.post('http://gum_stables/adminAction', JSON.stringify({charidentifier:charidentifier, job:job, type:type}));
}

function shotNailWheel(nail) {
    if (shotedNailsWheel.includes(nail)) {
        return;
    }
    var tool = document.getElementById('toolWheel');
    tool.style.transform = 'rotate(-140deg)';

    shotedNailsWheel.push(nail);
    document.getElementById('minigameNailWheel'+nail).style.backgroundImage = "url('images/minigame/wheel/Nail-State03.png')";
    setTimeout(() => {
        tool.style.transform = 'rotate(-80deg)';
    }, 100); 
    if (shotedNailsWheel.length >= 6) {
        $("#minigameWheel").fadeOut(150);
        $.post('http://gum_stables/finishMinigameWheel', JSON.stringify({num:wheelPosition, fixCart:fixCart}));
        shotedNailsWheel = []
        wheelFixMenu = false
        setTimeout(function() {
            for (var i = 1; i <= 6; i++) {
                document.getElementById('minigameNailWheel'+i).style.backgroundImage = "url('images/minigame/wheel/Nail-State01.png')";
            }
        }, 250);

    }
        
}
function openAddonStorage(items, cartItems, maxStorage, wagonId, model, typeItem, enableIcon, folder) {
    if (blockUseScript) {
        return;
    }
    $('#addonManageContainer').fadeIn(150)
    const tableBody = document.getElementById('addonManageContainer');
    var dataHtml = '';

    //max storage counting
    var usedStorage = 0
    if (model == "coal_wagon") {
        for (var i in items) {
            var count = 0
            if (cartItems[i] == undefined) {
                count = 0
            } else {
                count = cartItems[i]
            }
            usedStorage += count*configCartLogic.stoneCart[i][1]
        }
    } else {
        for (var i in items) {
            var count = 0
            if (cartItems[i] == undefined) {
                count = 0
            } else {
                count = cartItems[i]
            }
            usedStorage += count*configCartLogic.woodCart[i][1]
        }        
    }
    dataHtml += '<div id="buildCartButton" class="addonStorage")">'+ language[162] +''+usedStorage+'/'+maxStorage+'kg</div>'
    for (var i in items) {
        var count = 0
        if (cartItems[i] == undefined) {
            count = 0
        } else {
            count = cartItems[i]
        }
        if (enableIcon) {
            dataHtml += '<div id="buildCartButton" onclick="addonManipulation(\''+count+'\', \''+i+'\', \''+wagonId+'\', \''+typeItem+'\', \''+model+'\', \''+maxStorage+'\', \''+items[i][0]+'\', \''+items[i][1]+'\')"><img src="nui://'+folder+''+i+'.png" id="buildCartIcon">'+count+'x '+items[i][0]+'</div>'
        } else {
             dataHtml += '<div id="buildCartButton" onclick="addonManipulation(\''+count+'\', \''+i+'\', \''+wagonId+'\', \''+typeItem+'\', \''+model+'\', \''+maxStorage+'\', \''+items[i][0]+'\', \''+items[i][1]+'\')">'+count+'x '+items[i][0]+'</div>'
        }
    }
    $("#addonManageContainer").fadeIn(150)
    tableBody.innerHTML = dataHtml	
}

function addonManipulation(itemCount, itemId, wagonId, typeItem, model, maxStorage, name, itemWeight) {
    $.post('http://gum_stables/addonManipulation', JSON.stringify({itemCount:itemCount, itemId:itemId, wagonId:wagonId, typeItem:typeItem, model:model, maxStorage:maxStorage, name:name, itemWeight:itemWeight}));
}

function loadAnimalStorage(cartAnimals, maxStorage, wagonId) {
    $('#animalStorageContainer').fadeIn(150)
    const tableBody = document.getElementById('animalStorageButtons');
    var dataHtml = '';
    var countAnimals = 0;
    for (var i in cartAnimals) {
        countAnimals++
        if (cartAnimals[i].textQuality) {
            dataHtml += '<div id="animalStorageButton" onclick="takeAnimal(\''+i+'\',  \''+wagonId+'\')">'+cartAnimals[i].name+' - '+cartAnimals[i].textQuality+'</div>'
        } else {
            dataHtml += '<div id="animalStorageButton" onclick="takeAnimal(\''+i+'\',  \''+wagonId+'\')">'+cartAnimals[i].name+'</div>'
        }
    }
    tableBody.innerHTML = dataHtml
    document.getElementById('animalWeight').innerHTML = countAnimals+'/'+maxStorage
}

function takeAnimal(key, wagonId) {
    clearMenu()
    isInAnimals = false
    $.post('http://gum_stables/takeAnimal', JSON.stringify({key:key, wagonId:wagonId}));
}

function startDraggingMinigame(status) {
    if (status) {
        $('#minigameDragging').show();
        $('#minigameDraggingFilled').show();
        $('#minigameWhoWin').show();
    } else {
        $('#minigameDragging').hide();
        $('#minigameDraggingFilled').hide();
        $('#minigameWhoWin').hide();
    }
}

function openBuildMenu(itemsForBuild, folder, enableIcon) {
    if (blockUseScript) {
        return;
    }
    $('#buildCartContainer').fadeIn(150)
    const tableBody = document.getElementById('buildCartContainer');
    var dataHtml = '';
    inHorseMenu = true;
    var isFinished = true;
    for (var i in itemsForBuild) {
        if (itemsForBuild[i][1] > 0) {
            isFinished = false
        }
        if (itemsForBuild[i][1] > 0) {
            if (enableIcon) {
                dataHtml += '<div id="buildCartButton" onclick="buildCart(\'build\', \''+i+'\', \''+itemsForBuild[i][0]+'\', \''+itemsForBuild[i][1]+'\')"><img src="nui://'+folder+''+i+'.png" id="buildCartIcon">'+itemsForBuild[i][1]+'x '+itemsForBuild[i][0]+'</div>'
            } else {
                dataHtml += '<div id="buildCartButton" onclick="buildCart(\'build\', \''+i+'\', \''+itemsForBuild[i][0]+'\', \''+itemsForBuild[i][1]+'\')">'+itemsForBuild[i][1]+'x '+itemsForBuild[i][0]+'</div>'
            }
        }
    }
    if (isFinished) {
        dataHtml += '<div id="buildCartButton" onclick="buildCart(\'finish\')">'+language[111]+'</div>'
    }

    tableBody.innerHTML = dataHtml
}

function buildCart(type, itemId, itemName, itemAmount) {
    $.post('http://gum_stables/buildCart', JSON.stringify({type:type, itemId:itemId, itemAmount:itemAmount, itemName:itemName}));
}


function loadPlayerStore(horseData, cartData, isOwner) {
    if (blockUseScript) {
        return;
    }
    $('#playerStoreContainer').fadeIn(150)
    const tableBody = document.getElementById('playerStoreContainer');
    var dataHtml = '';
    if (isOwner == true || isOwner == "true") {
        dataHtml += '<div id="putHorseToStore" onclick="addToPlayerStore()">'+language[112]+'</div>'
    }
    for (var i in horseData) {
        if (horseData[i].isBuyed == 0) {
            dataHtml += '<div id="playerHorseStoreInformations" onclick="showFromPlayerStore(\'horse\', \''+horseData[i].id+'\')">'
            dataHtml += '   <div id="playerHorseName">'+language[113]+''+horseData[i].name+'</div>'
            dataHtml += '   <div id="playerHorseGender">'+language[114]+''+horseData[i].sex+'</div>'
            dataHtml += '   <div id="playerHorseExp">'+language[115]+''+horseData[i].exp+'</div>'
            dataHtml += '   <div id="playerHorsePrice">'+language[116]+''+horseData[i].price+'$</div>'
            dataHtml += '   <div id="playerHorseAge">'+language[117]+''+horseData[i].age+'</div>'
            dataHtml += '   <div id="playerHorseDesc">'+language[121]+'<br>'+horseData[i].descriptions+'</div>'
            dataHtml += '   <div id="playerHorseStoreBuy" onclick="buyFromPlayerStore(\'horse\', \''+horseData[i].id+'\', \''+horseData[i].price+'\', \''+isOwner+'\', \''+horseData[i].isBuyed+'\')"></div>'
            dataHtml += '</div>'
        } else if (horseData[i].isBuyed == 1 && (isOwner == true || isOwner == "true")) {
            dataHtml += '<div id="playerHorseStoreInformations" onclick="showFromPlayerStore(\'horse\', \''+horseData[i].id+'\')">'
            dataHtml += '   <div id="playerHorseName">'+language[113]+''+horseData[i].name+'</div>'
            dataHtml += '   <div id="playerHorseGender">'+language[114]+''+horseData[i].sex+'</div>'
            dataHtml += '   <div id="playerHorseExp">'+language[115]+''+horseData[i].exp+'</div>'
            dataHtml += '   <div id="playerHorsePrice">'+language[116]+''+horseData[i].price+'$</div>'
            dataHtml += '   <div id="playerHorseAge">'+language[117]+''+horseData[i].age+'</div>'
            dataHtml += '   <div id="playerHorseDesc">'+language[121]+'<br>'+horseData[i].descriptions+'</div>'
            dataHtml += '   <div id="playerHorseStoreBuyed" onclick="buyFromPlayerStore(\'horse\', \''+horseData[i].id+'\', \''+horseData[i].price+'\', \''+isOwner+'\', \''+horseData[i].isBuyed+'\')"></div>'
            dataHtml += '</div>'
        }
    }
    for (var i in cartData) {
        if (cartData[i].isBuyed == 0) {
            dataHtml += '<div id="playerCartStoreInformations" onclick="showFromPlayerStore(\'cart\', \''+cartData[i].id+'\')">'
            dataHtml += '   <div id="playerCartName">'+language[113]+''+cartData[i].name+'</div>'
            dataHtml += '   <div id="playerCartPrice">'+language[116]+''+cartData[i].price+'$</div>'
            dataHtml += '   <div id="playerCartDesc">'+language[121]+'<br>'+cartData[i].descriptions+'</div>'
            dataHtml += '   <div id="playerCartStoreBuy" onclick="buyFromPlayerStore(\'cart\', \''+cartData[i].id+'\', \''+cartData[i].price+'\', \''+isOwner+'\', \''+cartData[i].isBuyed+'\')"></div>'
            dataHtml += '</div>'
        } else if (cartData[i].isBuyed == 1 && (isOwner == true || isOwner == "true")) {
            dataHtml += '<div id="playerCartStoreInformations" onclick="showFromPlayerStore(\'cart\', \''+cartData[i].id+'\')">'
            dataHtml += '   <div id="playerCartName">'+language[113]+''+cartData[i].name+'</div>'
            dataHtml += '   <div id="playerCartPrice">'+language[116]+''+cartData[i].price+'$</div>'
            dataHtml += '   <div id="playerCartDesc">'+language[121]+'<br>'+cartData[i].descriptions+'</div>'
            dataHtml += '   <div id="playerCartStoreBuyed" onclick="buyFromPlayerStore(\'cart\', \''+cartData[i].id+'\', \''+cartData[i].price+'\', \''+isOwner+'\', \''+cartData[i].isBuyed+'\')"></div>'
            dataHtml += '</div>'
        }
    }
    tableBody.innerHTML = dataHtml
}

function showFromPlayerStore(type, id) {
    if (blockUseScript) {
        return;
    }
    $.post('http://gum_stables/showFromPlayerStore', JSON.stringify({type:type, id:id}));
}

function buyFromPlayerStore(type, id, price, isOwner, isBuyed) {
    $.post('http://gum_stables/buyFromPlayerStore', JSON.stringify({type:type, id:id, price:price, isOwner:isOwner, isBuyed:isBuyed}));
}

function addToPlayerStore() {
    $.post('http://gum_stables/addToPlayerStore')
}


function openBagsManage(size, id, cart, bags, shared, byId) {
    if (blockUseScript) {
        return;
    }
    $('#bagsManageContainer').fadeIn(150);  
    const tableBody = document.getElementById('bagsManageContainer');
    var dataBagsHtml = '';
    if (bags || cart) {
        dataBagsHtml += '<div id="openInventory" onclick="openStorage(\''+id+'\',\''+size+'\',\''+cart+'\')""></div>'
    }
    if (configHorseLogic.accessOnlyById) {
        dataBagsHtml += '<div id="accessInventory" onclick="manageAccess(\''+id+'\',\''+size+'\',\''+cart+'\')"></div>'
    }
    tableBody.innerHTML = dataBagsHtml

}

function componentsLoad() {
    if (blockUseScript) {
        return;
    }
    const tableBody = document.getElementById('compManageContainer');
    var dataHtml = '';
    var components = []
    for (var i in myHorses) {
        if (myHorses[i].selected == 1) {
            components = JSON.parse(myHorses[i].components)
            break
        }
    }
    if (components.bags) {
        dataHtml += '<div id="compBags" onclick="manipulateWithComponents(\'bags\',\''+components.bags+'\')"></div>'
    }
    if (components.Mask) {
        dataHtml += '<div id="compMask" onclick="manipulateWithComponents(\'Mask\',\''+components.Mask+'\')"></div>'
    } 
    if (components.saddles) {
        dataHtml += '<div id="compSaddle" onclick="manipulateWithComponents(\'saddles\',\''+components.saddles+'\')"></div>'
    } 
    if (components.holster) {
        dataHtml += '<div id="compHolster" onclick="manipulateWithComponents(\'holster\',\''+components.holster+'\')"></div>'
    } 
    if (components.lantern) {
        dataHtml += '<div id="compLantern" onclick="manipulateWithComponents(\'lantern\',\''+components.lantern+'\')"></div>'
    } 
    if (components.saddlecloths) {
        dataHtml += '<div id="compSaddleCloth" onclick="manipulateWithComponents(\'saddlecloths\',\''+components.saddlecloths+'\')"></div>'
    }
    if (components.acsluggage) {
        dataHtml += '<div id="compSleepingBag" onclick="manipulateWithComponents(\'acsluggage\',\''+components.acsluggage+'\')"></div>'
    } 
    if (configHorseLogic.transferComponents.enabled) {
        dataHtml += '<div id="saddleTransfer" onclick="transferSaddle()"></div>'
    }
    tableBody.innerHTML = dataHtml
    $('#compManageContainer').show();
}
function transferSaddle() {
    $.post('http://gum_stables/transferSaddle');

}

function manipulateWithComponents(a, compHash) {
    $.post('http://gum_stables/manipulateWithComponents', JSON.stringify({
        comp: a,
        hash: compHash
    }));
}

function openStorage(id, size, cart){
    $('#bagsManageContainer').fadeOut(150);
    $.post('http://gum_stables/openStorage', JSON.stringify({id:id, size:size, cart:cart}));
}
function manageAccess(id, size, cart) {
    $('#bagsManageContainer').fadeOut(150);
    $.post('http://gum_stables/manageAccess', JSON.stringify({id:id, size:size, cart:cart}));
}

function buyComponents(type) {
    if (blockUseScript) {
        return;
    }
    $.post('http://gum_stables/buyComponents', JSON.stringify({type:type}));
}

function openCartComponent(isCompany) {
    if (blockUseScript) {
        return;
    }
    $.post('http://gum_stables/openCartComponent', JSON.stringify({isCompany:isCompany}));
}

function openHorseBreed() {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    settedBreedHorses = [];
    $.post('http://gum_stables/breedCamera');
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150)
    $('#myHorses').fadeOut(150)
    $('#myCarts').fadeOut(150)
    $('#breedContainer').fadeIn(150)
    $('#componentContainer').fadeOut(150)
    $('#breedAccept').fadeOut(150)
    $('#breedListContainer').fadeOut(150)
    const tableMaleBody = document.getElementById('maleSide');
    let dataMaleHtml = '';
    dataMaleHtml = '<div class="stablesBreedHeader">'+language[122]+'</div>'
    for (var i in myHorses) {
        if ((myHorses[i].sex !== language[123] && myHorses[i].breeding == language[124] && myHorses[i].age > 5) || (myHorses[i].sex !== language[123] && configHorseStableLogic.mating.giveMatingToMaleHorse && myHorses[i].age > 5 && myHorses[i].breeding == language[125])) {
            dataMaleHtml += '<div id="breedingButton" onclick="breedHorse(\'1\', \''+myHorses[i].id+'\', \''+myHorses[i].sex+'\', \''+myHorses[i].model+'\')">'+ myHorses[i].name +'</div>'
        }
    }
    tableMaleBody.innerHTML = dataMaleHtml

    const tableFemaleBody = document.getElementById('femaleSide');
    let dataFemaleHtml = '';
    dataFemaleHtml = '<div class="stablesBreedHeader">'+language[123]+'</div>'
    for (var i in myHorses) {
        if ((myHorses[i].sex === language[123] && myHorses[i].breeding == language[124] && myHorses[i].age > 5 )|| (myHorses[i].sex === language[123] && configHorseStableLogic.mating.giveMatingToFemaleHorse && myHorses[i].age > 5 && myHorses[i].breeding == language[125])) {
            dataFemaleHtml += '<div id="breedingButton" onclick="breedHorse(\'2\', \''+myHorses[i].id+'\', \''+myHorses[i].sex+'\', \''+myHorses[i].model+'\')">'+ myHorses[i].name +'</div>'
        }
    }
    tableFemaleBody.innerHTML = dataFemaleHtml
}

function openBreedList() {
    if (blockUseScript) {
        return;
    }
    // $.post('http://gum_stables/clearPreview')
    $('#maleSide').fadeOut(150)
    $('#femaleSide').fadeOut(150)
    $('#breedList').fadeOut(150)
    $('#breedAccept').fadeOut(150)
    $('#breedListContainer').fadeIn(150);
    settedBreedHorses = [];
    inBreedList = true
    const tableBody = document.getElementById('breedListContainer');
    var dataHtml = '';
    for (var i in myMatingHorses) {
        if (language[126] == myMatingHorses[i].breeding_time) {
            dataHtml += '<div id="breedListButton" onclick="showBreedHorses(\'' + myMatingHorses[i].breeding_id_horse_1 + '\', \'' + myMatingHorses[i].breeding_model_horse_1 + '\', \'' + myMatingHorses[i].breeding_horse_outfit_1 + '\', \'' + myMatingHorses[i].breeding_id_horse_2 + '\', \'' + myMatingHorses[i].breeding_model_horse_2 + '\', \'' + myMatingHorses[i].breeding_horse_outfit_2 + '\', \'' + myMatingHorses[i].reward_model + '\', \'' + myMatingHorses[i].reward_sex + '\', \'' + myMatingHorses[i].reward_id + '\', \'' + myMatingHorses[i].reward_outfit + '\')"><div class="line line-left"></div><div class="line line-right"></div><div id="firstHorseBreed">'+myMatingHorses[i].breeding_name_horse_1+'</div><div id="secondHorseBreed">'+myMatingHorses[i].breeding_name_horse_2+'</div><div id="horseBreedReward" onclick="saveBreedHorse(\''+myMatingHorses[i].reward_id+'\', \''+myMatingHorses[i].breeding_id_horse_1+'\', \''+myMatingHorses[i].breeding_id_horse_2+'\')"></div></div>'
        } else {
            dataHtml += '<div id="breedListButton" onclick="showBreedHorses(\'' + myMatingHorses[i].breeding_id_horse_1 + '\', \'' + myMatingHorses[i].breeding_model_horse_1 + '\', \'' + myMatingHorses[i].breeding_horse_outfit_1 + '\', \'' + myMatingHorses[i].breeding_id_horse_2 + '\', \'' + myMatingHorses[i].breeding_model_horse_2 + '\', \'' + myMatingHorses[i].breeding_horse_outfit_2 + '\')"><div class="line line-left"></div><div class="line line-right"></div><div id="firstHorseBreed">'+myMatingHorses[i].breeding_name_horse_1+'</div><div id="secondHorseBreed">'+myMatingHorses[i].breeding_name_horse_2+'</div><div id="horseBreedTime">'+ myMatingHorses[i].breeding_time+' s</div></div>'
        }
    }
    tableBody.innerHTML = dataHtml
}

function saveBreedHorse(id, breedId1, breedId2) {
    clearMenu()
    clearMenu()
    $.post('http://gum_stables/saveBreedHorse', JSON.stringify({id:id, breedId1:breedId1, breedId2:breedId2}));
}

function showBreedHorses(id1, model1, outfit1, id2, model2, outfit2, rewardModel, rewardSex, rewardId, rewardOutfit) {
    $.post('http://gum_stables/showBreedHorses', JSON.stringify({id1:id1, model1:model1, outfit1:outfit1, id2:id2, model2:model2, outfit2:outfit2, rewardModel:rewardModel, rewardSex:rewardSex, rewardId:rewardId, rewardOutfit:rewardOutfit}));
}


function startBreed() {
    if (settedBreedHorses.length == 2) {
        $.post('http://gum_stables/startBreed', JSON.stringify({breedsHorses:settedBreedHorses}));
    }
}

function breedHorse(position, id, gender, model) {
    if (blockSpam === false) {
        blockSpam = true;
        $.post('http://gum_stables/showBreedHorse', JSON.stringify({position:position, id:id, gender:gender, model:model}));
        setTimeout(function() {
            blockSpam = false;
        }, 400);
    }
}

function openHorseShoe(max, isCompany) {
    if (blockUseScript) {
        return;
    }
    var selectedExist = false
    if (isCompany) {
        for (var i in companyHorses) {
            if (companyHorses[i].id == isCompany) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || myHorses[i].id == horseId) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    }
    inMenu = true
    $.post('http://gum_stables/createShoeNpc')
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150)
    $('#myHorses').fadeOut(150)
    $('#myCarts').fadeOut(150)
    $('#baseContainer').fadeIn(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeOut(150);
    $('#shoeBars').fadeIn(150);
    oldValuePartShoe = 0;
    baseAcc = 0;
    baseSpeed = 0;
    baseTurn = 0;
    const tableBaseBody = document.getElementById('baseContainer');
    let dataBaseHtml = '';
    dataBaseHtml += '<div class="sliderShoes"></div>'
    dataBaseHtml += '<div id="shoesAccept" onclick="startShoe()"></div>'
    dataBaseHtml += '<div id="minigameShoe"></div>'
    dataBaseHtml += '<div id="minigameNail1" onclick="shotNail(1)"></div>'
    dataBaseHtml += '<div id="minigameNail2" onclick="shotNail(2)"></div>'
    dataBaseHtml += '<div id="minigameNail3" onclick="shotNail(3)"></div>'
    dataBaseHtml += '<div id="minigameNail4" onclick="shotNail(4)"></div>'
    dataBaseHtml += '<div id="minigameNail5" onclick="shotNail(5)"></div>'
    dataBaseHtml += '<div id="minigameNail6" onclick="shotNail(6)"></div>'
    dataBaseHtml += '<div id="minigameNail7" onclick="shotNail(7)"></div>'
    dataBaseHtml += '<div id="minigameNail8" onclick="shotNail(8)"></div>'
    dataBaseHtml += '<div id="tool"></div>'
    tableBaseBody.innerHTML = dataBaseHtml
    shotedNails = [];

    const tableBody = document.getElementById('shoeBars');
    let dataHtml = '';
    dataHtml += '<div id="horseStatusAcc">'+language[127]+'<div id="accelerationBar"></div><div id="accelerationBarFilled"></div></div>'
    dataHtml += '<div id="horseStatusSpeed">'+language[128]+'<div id="speedBar"></div><div id="speedBarFilled"></div></div>'
    dataHtml += '<div id="horseStatusTurn">'+language[129]+'<div id="turnBar"></div><div id="turnBarFilled"></div></div>'
    tableBody.innerHTML = dataHtml

    document.getElementById('accelerationBarFilled').style.width = '0%';
    document.getElementById('speedBarFilled').style.width = '0%';
    document.getElementById('turnBarFilled').style.width = '0%';

    if (isCompany) {
        for (var i in companyHorses) {
            if (companyHorses[i].id == isCompany) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:companyHorses[i].model, id:companyHorses[i].id, isCompany:true}));
            }
        }
    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || myHorses[i].id == horseId) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:myHorses[i].model, id:myHorses[i].id}));
            }
        }
    }

    $('#minigameShoe').hide();
    for (var i = 1; i <= 8; i++) {
        $('#minigameNail'+i).hide();
    }
    $('#tool').hide();
    $(document).ready(function() {
        $(document).on('mousemove', function(e) { 
            $("#tool").css({
                left: e.pageX - $("#tool").width() / 3.0,
                top: e.pageY - $("#tool").height() / 3.0
            });
        });
    });
    setTimeout(() => {
        draggableInstance = Draggable.create(".sliderShoes", {
            type: "rotation",
            inertia: true,
            bounds: {minRotation: 0, maxRotation: max * 60},
            onDrag() {
                var rotationValue = Math.floor(this.rotation / 60);
                if (this.rotation < 0) {
                    this.rotation = 0;
                    rotationValue = 0;
                }  if ($('#tool').is(':visible')) {
                } else {
                    if (rotationValue !== oldValuePartShoe) {
                        var diff = Math.abs(rotationValue - oldValuePartShoe);
                        if (rotationValue < oldValuePartShoe) {
                            oldValuePartShoe = rotationValue;
                            updateHorseState(baseSpeed - diff, baseAcc - diff, baseTurn - diff, true);
                        } else {
                            oldValuePartShoe = rotationValue;
                            updateHorseState(baseSpeed + diff, baseAcc + diff, baseTurn + diff, true);
                        }
                    }
                }

            }
        });
        var maxRotation = max-Math.max(baseSpeed, baseAcc, baseTurn);
        draggableInstance[0].vars.bounds.maxRotation = maxRotation * 60;
    }, 500);
}

function startShoe() {
    if (oldValuePartShoe == 0) {
        return false;
    }
    $.post('http://gum_stables/startShoe', JSON.stringify({value:oldValuePartShoe}));
    oldValuePartShoe = 0;
}

function shotNail(nail) {
    if (shotedNails.includes(nail)) {
        return;
    }
    var tool = document.getElementById('tool');
    tool.style.transform = 'rotate(-140deg)';

    shotedNails.push(nail);
    document.getElementById('minigameNail'+nail).style.backgroundImage = "url('images/minigame/Nail-State03.png')";
    setTimeout(() => {
        tool.style.transform = 'rotate(-80deg)';
    }, 100); 
    if (shotedNails.length == 8) {
        blockUseScript = true;
        $('#minigameShoe').fadeOut(150);
        for (var i = 1; i <= 8; i++) {
            $('#minigameNail'+i).fadeOut(150);
        }
        $('#shoesAccept').fadeIn(150);
        $.post('http://gum_stables/updateShoe', JSON.stringify({value:horseShoeUpdate}));
        shotedNails = [];
        $('#tool').fadeOut(150);
        $('#horseCategory').fadeIn(150);
        $('#cartCategory').fadeIn(150);
        $('#baseContainer').fadeOut(150);
        $('#myHorses').fadeIn(150);
        $('#myCarts').fadeIn(150);
        $('#componentContainer').fadeOut(150);
        $('#shoeBars').fadeOut(150);
        inMenu = false;
        firstTime = false;
        $.post('http://gum_stables/clearPreview');
        baseAcc = 0;
        baseSpeed = 0;
        baseTurn = 0;
        setTimeout(() => {
            blockUseScript = false;
        }, 500);
    }
}

function openHorseStore() {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeIn(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeOut(150);
    const tableBody = document.getElementById('baseContainer');
    let dataHtml = '';
    if (storeHorses[0]) {
        dataHtml += '<div id="moneyIcon" onclick="buyData(\'horse\', \'money\', \''+storeHorses[0].colorName+'\', \''+ storeHorses[0].category + '\')"><div id="moneyText" style="font-size: '+sizeCheck(storeHorses[0].dollarPrice)+';"><b>'+storeHorses[0].dollarPrice+'</b></div></div>'
        dataHtml += '<div id="goldIcon" onclick="buyData(\'horse\', \'gold\', \''+storeHorses[0].colorName+'\', \''+ storeHorses[0].category + '\')"><div id="goldText" style="font-size: '+sizeCheck(storeHorses[0].goldPrice)+';"><b>'+storeHorses[0].goldPrice+'</b></div></div>'
        dataHtml += '<div id="storageIcon"><div id="storageText" style="font-size: '+sizeCheck(storeHorses[0].storageSlot)+';"><b>'+storeHorses[0].storageSlot+'</b></div></div>'
        dataHtml += '<div id="horseButton">'
        dataHtml += '   <div id="horseTitle">'
        dataHtml += '       <div id="catArrowLeft" onclick="changeCategory(\''+storeHorses[0].category+'\', \'left\', \'false\')"></div>'
        dataHtml += '           '+storeHorses[0].category+''
        dataHtml += '       <div id="catArrowRight" onclick="changeCategory(\''+storeHorses[0].category+'\', \'right\', \'false\')"></div>'
        dataHtml += '   </div>'
        dataHtml += '   <div id="horseName">'
        dataHtml += '       <div id="horseArrowLeft" onclick="changeHorse(\'' + storeHorses[0].colorName + '\', \'' + storeHorses[0].category + '\', \'left\')"></div>'
        dataHtml += '           '+storeHorses[0].colorName+''
        dataHtml += '       <div id="horseArrowRight" onclick="changeHorse(\'' + storeHorses[0].colorName + '\', \'' + storeHorses[0].category + '\', \'right\')"></div>'
        dataHtml += '   </div>'
        dataHtml += '</div>'
        dataHtml += '<div id="horseStatusAcc">'+language[127]+'<div id="accelerationBar"></div><div id="accelerationBarFilled"></div></div>'
        dataHtml += '<div id="horseStatusSpeed">'+language[128]+'<div id="speedBar"></div><div id="speedBarFilled"></div></div>'
        dataHtml += '<div id="horseStatusTurn">'+language[129]+'<div id="turnBar"></div><div id="turnBarFilled"></div></div>'
        dataHtml += '<div id="horseDescription"><b>'+storeHorses[0].description+'</b></div>'
        tableBody.innerHTML = dataHtml
        if (storeHorses[0].dollarPrice === 0) {$('#moneyIcon').hide();} else {$('#moneyIcon').fadeIn(150);}
        if (storeHorses[0].goldPrice === 0) {$('#goldIcon').hide();} else {$('#goldIcon').fadeIn(150);}
        document.getElementById('accelerationBarFilled').style.width = '0%';
        document.getElementById('speedBarFilled').style.width = '0%';
        document.getElementById('turnBarFilled').style.width = '0%';
        $.post('http://gum_stables/showStoreHorse', JSON.stringify({horse:storeHorses[0].colorName, category:storeHorses[0].category}));
    }
}

function buyData(type, currency, name, category) {
    $.post('http://gum_stables/buyData', JSON.stringify({type:type, currency:currency, name:name, category:category}));
}

function openCartStore() {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeIn(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeOut(150);
    const tableBody = document.getElementById('baseContainer');
    let dataHtml = '';
    let firstCart = "";
    for (var i in storeCarts) {
        firstCart = i;
        break;
    }
    if (storeCarts[firstCart]) {
        dataHtml += '<div id="moneyIcon" onclick="buyData(\'cart\', \'money\', \''+storeCarts[firstCart].name+'\')"><div id="moneyText" style="font-size: '+sizeCheck(storeCarts[firstCart].dollarPrice)+';"><b>'+storeCarts[firstCart].dollarPrice+'</b></div></div>'
        dataHtml += '<div id="goldIcon" onclick="buyData(\'cart\', \'gold\', \''+storeCarts[firstCart].name+'\')"><div id="goldText" style="font-size: '+sizeCheck(storeCarts[firstCart].goldPrice)+';"><b>'+storeCarts[firstCart].goldPrice+'</b></div></div>'
        dataHtml += '<div id="storageIcon"><div id="storageText" style="font-size: '+sizeCheck(storeCarts[firstCart].storageSlot)+';"><b>'+storeCarts[firstCart].storageSlot+'</b></div></div>'
        dataHtml += '<div id="craftIcon"></div>'
        dataHtml += '<div id="animalIcon"><div id="animalText" style="font-size: '+sizeCheck(storeCarts[firstCart].storageAnimals)+';"><b>'+storeCarts[firstCart].storageAnimals+'</b></div></div>'
        dataHtml += '<div id="horseButton">'
        dataHtml += '   <div id="horseTitle">'
        dataHtml += '       <div id="catArrowLeft" onclick="changeCategory(\''+storeCarts[firstCart].category+'\', \'left\', \'true\')"></div>'
        dataHtml += '           '+storeCarts[firstCart].category+''
        dataHtml += '       <div id="catArrowRight" onclick="changeCategory(\''+storeCarts[firstCart].category+'\', \'right\', \'true\')"></div>'
        dataHtml += '   </div>'
        dataHtml += '   <div id="horseName">'
        dataHtml += '       <div id="horseArrowLeft" onclick="changeCart(\'' + storeCarts[firstCart].model + '\', \'' + storeCarts[firstCart].category + '\', \'left\')"></div>'
        dataHtml += '           '+storeCarts[firstCart].name+''
        dataHtml += '       <div id="horseArrowRight" onclick="changeCart(\'' + storeCarts[firstCart].model + '\', \'' + storeCarts[firstCart].category + '\', \'right\')"></div>'
        dataHtml += '   </div>'
        dataHtml += '</div>'
        dataHtml += '<div id="horseDescription"><b>'+storeCarts[firstCart].description+'</b></div>'
        tableBody.innerHTML = dataHtml
        if (storeCarts[firstCart].dollarPrice === 0 && storeCarts[firstCart].craftPrice == 0) {$('#moneyIcon').hide();} else {$('#moneyIcon').fadeIn(150);}
        if (storeCarts[firstCart].goldPrice === 0) {$('#goldIcon').hide();} else {$('#goldIcon').fadeIn(150);}
        if (storeCarts[firstCart].craftRecipe !== undefined) {$('#craftIcon').fadeIn(150);} else {$('#craftIcon').hide(0);}
        $.post('http://gum_stables/showStoreCart', JSON.stringify({cart:storeCarts[firstCart].model, category:storeCarts[firstCart].category}));
    }
}

function changeCategory(category, direction) {
    $.post('http://gum_stables/changeCategory', JSON.stringify({category:category, direction:direction}));
}


function loadCartStoreData(price, craftPrice, gold, storage, storageAnimals, category, name, model, description, craftRecipe) {
    if (price === 0 && craftPrice === 0) {$('#moneyIcon').hide();} else {$('#moneyIcon').fadeIn(150);}
    if (gold === 0) {$('#goldIcon').hide();} else {$('#goldIcon').fadeIn(150);}
    if (craftRecipe !== undefined) {$('#craftIcon').fadeIn(150);} else {$('#craftIcon').fadeOut(150);}
    document.getElementById('moneyIcon').onclick = function() {buyData('cart', 'money', name);};
    document.getElementById('goldIcon').onclick = function() {buyData('cart', 'gold', name);};
    document.getElementById('horseTitle').innerHTML =
        '<div id="catArrowLeft" onclick="changeCategory(\'' + category + '\', \'left\', \'true\')"></div>' +
        category +
        '<div id="catArrowRight" onclick="changeCategory(\'' + category + '\', \'right\', \'true\')"></div>';
    document.getElementById('horseName').innerHTML =
        '<div id="horseArrowLeft" onclick="changeCart(\'' + model + '\', \'' + category + '\', \'left\')"></div>' +
        name +
        '<div id="horseArrowRight" onclick="changeCart(\'' + model + '\', \'' + category + '\', \'right\')"></div>';
    if (description === undefined) {
        document.getElementById('horseDescription').innerHTML = '';
    } else {
        document.getElementById('horseDescription').innerHTML = '<b>' + description + '</b>';
    }

    setTimeout(function() {
        document.getElementById('moneyIcon').classList.remove('rotateIcon');
        document.getElementById('goldIcon').classList.remove('rotateIcon');
        document.getElementById('storageIcon').classList.remove('rotateIcon');
        document.getElementById('animalIcon').classList.remove('rotateIcon');
        document.getElementById('craftIcon').classList.remove('rotateIcon');
        setTimeout(function() {
            document.getElementById('moneyText').innerHTML = '<b>' + price + '</b>';
            document.getElementById('moneyText').style.fontSize = sizeCheck(price) + 'px';
            document.getElementById('goldText').innerHTML = '<b>' + gold + '</b>';
            document.getElementById('goldText').style.fontSize = sizeCheck(gold) + 'px';
            document.getElementById('storageText').innerHTML = '<b>' + storage + '</b>';
            document.getElementById('storageText').style.fontSize = sizeCheck(storage) + 'px';
            document.getElementById('animalText').innerHTML = '<b>' + storageAnimals + '</b>';
            document.getElementById('animalText').style.fontSize = sizeCheck(storageAnimals) + 'px';
        }, 300);

        setTimeout(function() {
            document.getElementById('moneyIcon').classList.add('rotateIcon');
            document.getElementById('goldIcon').classList.add('rotateIcon');
            document.getElementById('storageIcon').classList.add('rotateIcon');
            document.getElementById('animalIcon').classList.add('rotateIcon');
            document.getElementById('craftIcon').classList.add('rotateIcon');
        }, 300);
    }, 0);
}


function loadHorseStoreData(price, gold, storage, category, colorName, description) {
    if (price === 0) {$('#moneyIcon').hide();} else {$('#moneyIcon').fadeIn(150);}
    if (gold === 0) {$('#goldIcon').hide();} else {$('#goldIcon').fadeIn(150);}
    document.getElementById('moneyIcon').onclick = function() {buyData('horse', 'money', colorName, category);};
    document.getElementById('goldIcon').onclick = function() {buyData('horse', 'gold', colorName, category);};
    document.getElementById('horseTitle').innerHTML =
        '<div id="catArrowLeft" onclick="changeCategory(\'' + category + '\', \'left\', \'false\')"></div>' +
        category +
        '<div id="catArrowRight" onclick="changeCategory(\'' + category + '\', \'right\', \'false\')"></div>';
    document.getElementById('horseName').innerHTML =
        '<div id="horseArrowLeft" onclick="changeHorse(\'' + colorName + '\', \'' + category + '\', \'left\')"></div>' +
        colorName +
        '<div id="horseArrowRight" onclick="changeHorse(\'' + colorName + '\', \'' + category + '\', \'right\')"></div>';
    if (description === undefined) {
        document.getElementById('horseDescription').innerHTML = '';
    } else {
        document.getElementById('horseDescription').innerHTML = '<b>' + description + '</b>';
    }

    setTimeout(function() {
        document.getElementById('moneyIcon').classList.remove('rotateIcon');
        document.getElementById('goldIcon').classList.remove('rotateIcon');
        document.getElementById('storageIcon').classList.remove('rotateIcon');
        setTimeout(function() {
            document.getElementById('moneyText').innerHTML = '<b>' + price + '</b>';
            document.getElementById('moneyText').style.fontSize = sizeCheck(price) + 'px';
            document.getElementById('goldText').innerHTML = '<b>' + gold + '</b>';
            document.getElementById('goldText').style.fontSize = sizeCheck(gold) + 'px';
            document.getElementById('storageText').innerHTML = '<b>' + storage + '</b>';
            document.getElementById('storageText').style.fontSize = sizeCheck(storage) + 'px';
        }, 180);

        setTimeout(function() {
            document.getElementById('moneyIcon').classList.add('rotateIcon');
            document.getElementById('goldIcon').classList.add('rotateIcon');
            document.getElementById('storageIcon').classList.add('rotateIcon');
        }, 180);
    }, 0);
}

function loadMyHorses(type) {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeIn(150);
    const tableBody = document.getElementById('baseContainer');
    let dataHtml = '';

    var newName = ""
    if (type == "stable") {
        if (myHorses[0]) {
            if (Number(myHorses[0].selected) == 1) {
                newName = '<b>- '+myHorses[0].name+' -</b>'
            } else {
                newName = ''+myHorses[0].name+''
            }
            dataHtml += '<div id="myHorseButton">'
            dataHtml += '   <div id="myHorseTitle">'
            dataHtml += '       <div id="catArrowLeft" onclick="changeMyHorse(\''+myHorses[0].id+'\', \'left\')"></div>'
            dataHtml += '           '+newName+''
            dataHtml += '       <div id="catArrowRight" onclick="changeMyHorse(\''+myHorses[0].id+'\', \'right\')"></div>'
            dataHtml += '   </div>'
            dataHtml += '</div>'
            dataHtml += '<div id="selectBar">'
            dataHtml += '   <div id="remove" onclick="sellData(\''+myHorses[0].id+'\', \'horse\')"></div>'
            dataHtml += '   <div id="select" onclick="selectData(\''+myHorses[0].id+'\', \'horse\')"></div>'
            dataHtml += '   <div id="breed"></div>'
            dataHtml += '   <div id="heal" onclick="healData(\''+myHorses[0].id+'\', \'horse\', \''+myHorses[0].model+'\')"></div>'
            dataHtml += '</div>'
            dataHtml += '<div id="horseStatusAcc">'+language[127]+'<div id="accelerationBar"></div><div id="accelerationBarFilled"></div></div>'
            dataHtml += '<div id="horseStatusSpeed">'+language[128]+'<div id="speedBar"></div><div id="speedBarFilled"></div></div>'
            dataHtml += '<div id="horseStatusTurn">'+language[129]+'<div id="turnBar"></div><div id="turnBarFilled"></div></div>'
            dataHtml += '<div id="myHorseDescription"><b>'+language[115]+''+myHorses[0].exp+'</br>'+language[114]+''+myHorses[0].sex+'</br>'+language[117]+''+myHorses[0].age+'</br>'+language[118]+''+myHorses[0].breeding+'</br>'+language[119]+''+myHorses[0].friendly+'</br>'+language[120]+''+myHorses[0].courage+'</b></div>'
            tableBody.innerHTML = dataHtml
            document.getElementById('accelerationBarFilled').style.width = '0%';
            document.getElementById('speedBarFilled').style.width = '0%';
            document.getElementById('turnBarFilled').style.width = '0%';
            if (Number(myHorses[0].selected) == 0) {$("#select").fadeIn(150);} else {$("#select").fadeOut(150);}
            if (myHorses[0].breeding == language[130] && myHorses[0].sex == language[122]) {
                $('#select').hide();
            }
            if (myHorses[0].breeding == language[130]) {$("#breed").fadeIn(150);} else {$("#breed").fadeOut(150);}
            if (Number(myHorses[0].isdead) == 1) {$("#heal").fadeIn(150);} else {$("#heal").fadeOut(150);}
            $.post('http://gum_stables/showMyHorse', JSON.stringify({model:myHorses[0].model, id:myHorses[0].id}));
        } else {
            dataHtml += ''
            tableBody.innerHTML = dataHtml
        }
    } else if (type == "company") {
        if (companyHorses[0]) {
            if (Number(companyHorses[0].selected) == 1) {
                newName = '<b>- '+companyHorses[0].name+' -</b>'
            } else {
                newName = ''+companyHorses[0].name+''
            }
            dataHtml += '<div id="myHorseButton">'
            dataHtml += '   <div id="myHorseTitle">'
            dataHtml += '       <div id="catArrowLeft" onclick="changeMyHorse(\''+companyHorses[0].id+'\', \'left\', \'company\')"></div>'
            dataHtml += '           '+newName+''
            dataHtml += '       <div id="catArrowRight" onclick="changeMyHorse(\''+companyHorses[0].id+'\', \'right\', \'company\')"></div>'
            dataHtml += '   </div>'
            dataHtml += '</div>'
            dataHtml += '<div id="selectBar">'
            dataHtml += '   <div id="remove" onclick="sellData(\''+companyHorses[0].id+'\', \'horse\', \'company\')"></div>'
            dataHtml += '   <div id="select" onclick="selectData(\''+companyHorses[0].id+'\', \'horse\', \'company\')"></div>'
            dataHtml += '   <div id="breed"></div>'
            dataHtml += '   <div id="heal" onclick="healData(\''+companyHorses[0].id+'\', \'horse\', \''+companyHorses[0].model+'\', \'company\')"></div>'
            dataHtml += '</div>'
            dataHtml += '<div id="horseStatusAcc">'+language[127]+'<div id="accelerationBar"></div><div id="accelerationBarFilled"></div></div>'
            dataHtml += '<div id="horseStatusSpeed">'+language[128]+'<div id="speedBar"></div><div id="speedBarFilled"></div></div>'
            dataHtml += '<div id="horseStatusTurn">'+language[129]+'<div id="turnBar"></div><div id="turnBarFilled"></div></div>'
            dataHtml += '<div id="myHorseDescription"><b>'+language[115]+''+companyHorses[0].exp+'</br>'+language[114]+''+companyHorses[0].sex+'</br>'+language[117]+''+companyHorses[0].age+'</br>'+language[118]+''+companyHorses[0].breeding+'</br>'+language[119]+''+companyHorses[0].friendly+'</br>'+language[120]+''+companyHorses[0].courage+'</b></div>'
            tableBody.innerHTML = dataHtml
            if (companyHorses[0].breeding == language[130] && companyHorses[0].sex == language[122]) {
                $('#select').hide();
            }
            document.getElementById('accelerationBarFilled').style.width = '0%';
            document.getElementById('speedBarFilled').style.width = '0%';
            document.getElementById('turnBarFilled').style.width = '0%';
            if (Number(companyHorses[0].selected) == 0) {$("#select").fadeIn(150);} else {$("#select").fadeOut(150);}
            if (companyHorses[0].breeding == language[130]) {$("#breed").fadeIn(150);} else {$("#breed").fadeOut(150);}
            if (Number(companyHorses[0].isdead) == 1) {$("#heal").fadeIn(150);} else {$("#heal").fadeOut(150);}
            $.post('http://gum_stables/showMyHorse', JSON.stringify({model:companyHorses[0].model, id:companyHorses[0].id, isComp:false, isCompany:true}));
        } else {
            dataHtml += ''
            tableBody.innerHTML = dataHtml
        }
    }
}

function healData(id, type, model) {
    clearMenu()
    $.post('http://gum_stables/healData', JSON.stringify({id:id, type:type, model:model}));
}

function loadMyCarts(type) {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeIn(150);
    if (type == "stable") {
        const tableBody = document.getElementById('baseContainer');
        let dataHtml = '';
        var newName = ""
        if (myCarts && myCarts[0]) {
            if (Number(myCarts[0].selected) == 1) {
                newName = '<b>- '+myCarts[0].name+' -</b>'
            } else {
                newName = ''+myCarts[0].name+''
            }
            dataHtml += '<div id="myHorseButton">'
            dataHtml += '   <div id="myHorseTitle">'
            dataHtml += '       <div id="catArrowLeft" onclick="changeMyCart(\''+myCarts[0].id+'\', \'left\')"></div>'
            dataHtml += '           '+newName+''
            dataHtml += '       <div id="catArrowRight" onclick="changeMyCart(\''+myCarts[0].id+'\', \'right\')"></div>'
            dataHtml += '   </div>'
            dataHtml += '</div>'
            dataHtml += '<div id="selectBar">'
            dataHtml += '   <div id="remove" onclick="sellData(\''+myCarts[0].id+'\', \'cart\')"></div>'
            dataHtml += '   <div id="select" onclick="selectData(\''+myCarts[0].id+'\', \'cart\')"></div>'
            dataHtml += '</div>'
            if (myCarts[0].cityPosition == 0) {myCarts[0].cityPosition = language[131]} else {myCarts[0].cityPosition = stablesInfo[myCarts[0].cityPosition-1]}
            var dmgWheel = JSON.parse(myCarts[0].damage_wheel)
            if (dmgWheel.length == 0) {dmgWheel = language[125]} else {dmgWheel = language[124]}
            dataHtml += '<div id="myHorseDescription"><b>'+language[132]+''+myCarts[0].cityPosition+'</br></br>'+language[133]+''+myCarts[0].health_cart+'</br>'+language[134]+''+dmgWheel+'</br></b></div>'
        
            tableBody.innerHTML = dataHtml
        
            if (Number(myCarts[0].selected) == 0) {$("#select").fadeIn(150);} else {$("#select").fadeOut(150);}
            $.post('http://gum_stables/showMyCart', JSON.stringify({model:myCarts[0].model, id:myCarts[0].id}));
        } else {
            dataHtml += ''
            tableBody.innerHTML = dataHtml
        }
    } else if (type == "company") {
        const tableBody = document.getElementById('baseContainer');
        let dataHtml = '';
        var newName = ""
        if (companyCarts && companyCarts[0]) {
            if (Number(companyCarts[0].selected) == 1) {
                newName = '<b>- '+companyCarts[0].name+' -</b>'
            } else {
                newName = ''+companyCarts[0].name+''
            }
            dataHtml += '<div id="myHorseButton">'
            dataHtml += '   <div id="myHorseTitle">'
            dataHtml += '       <div id="catArrowLeft" onclick="changeMyCart(\''+companyCarts[0].id+'\', \'left\', \'company\')"></div>'
            dataHtml += '           '+newName+''
            dataHtml += '       <div id="catArrowRight" onclick="changeMyCart(\''+companyCarts[0].id+'\', \'right\', \'company\')"></div>'
            dataHtml += '   </div>'
            dataHtml += '</div>'
            dataHtml += '<div id="selectBar">'
            dataHtml += '   <div id="remove" onclick="sellData(\''+companyCarts[0].id+'\', \'cart\', \'company\')"></div>'
            dataHtml += '   <div id="select" onclick="selectData(\''+companyCarts[0].id+'\', \'cart\', \'company\')"></div>'
            dataHtml += '</div>'
            if (companyCarts[0].cityPosition == 0) {companyCarts[0].cityPosition = language[131]} else {companyCarts[0].cityPosition = stablesInfo[companyCarts[0].cityPosition-1]}
            var dmgWheel = JSON.parse(companyCarts[0].damage_wheel)
            if (dmgWheel.length == 0) {dmgWheel = language[125]} else {dmgWheel = language[124]}
            dataHtml += '<div id="myHorseDescription"><b>'+language[132]+''+companyCarts[0].cityPosition+'</br></br>'+language[133]+''+companyCarts[0].health_cart+'</br>'+language[134]+''+dmgWheel+'</br></b></div>'
        
            tableBody.innerHTML = dataHtml
        
            if (Number(companyCarts[0].selected) == 0) {$("#select").fadeIn(150);} else {$("#select").fadeOut(150);}
            $.post('http://gum_stables/showMyCart', JSON.stringify({model:companyCarts[0].model, id:companyCarts[0].id, isCompany:true}));
        } else {
            dataHtml += ''
            tableBody.innerHTML = dataHtml
        }
    }
}

function changeMyCart(id, direction, type) {
    $.post('http://gum_stables/changeMyCart', JSON.stringify({id:id, direction:direction, company:type}));
}



function openHorseColor(isCompany) {
    if (blockUseScript) {
        return;
    }
    var selectedExist = false
    if (isCompany) {
        for (var i in companyHorses) {
            if (companyHorses[i].id == isCompany) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || myHorses[i].id == horseId) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    }

    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeIn(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeOut(150);
    $('#acceptColor').fadeIn(150);

    const tableBody = document.getElementById('baseContainer');
    let dataHtml = '';
    dataHtml += '<div id="colorsButton">'+language[158]+'<div id="resetColorHorse" onclick="compColor(\'horseColor\', \'reset\')"></div>'
    dataHtml += '   <div id="scaleHorse" class="sliderScales"></div><div class="sliderScalesValue">0</div>'
    dataHtml += '   <div id="paletteHorse" class="sliderPalettes"></div><div class="sliderPalettesValue">0</div>'
    dataHtml += '   <div id="color1Horse" class="sliderHColor1s"></div><div class="sliderHColor1sValue">0</div>'
    dataHtml += '   <div id="color2Horse" class="sliderHColor2s"></div><div class="sliderHColor2sValue">0</div>'
    dataHtml += '   <div id="color3Horse" class="sliderHColor3s"></div><div class="sliderHColor3sValue">0</div>'
    dataHtml += '</div>'
    dataHtml += '<div id="colorsButton">'+language[159]+'<div id="resetColorHorse" onclick="compColor(\'tailColor\', \'reset\')"></div>'
    dataHtml += '   <div id="paletteHorseT" class="sliderTMPalettes"></div><div class="sliderTMPalettesValue">0</div>'
    dataHtml += '   <div id="color1HorseT" class="sliderTMColor1s"></div><div class="sliderTMColor1sValue">0</div>'
    dataHtml += '   <div id="color2HorseT" class="sliderTMColor2s"></div><div class="sliderTMColor2sValue">0</div>'
    dataHtml += '   <div id="color3HorseT" class="sliderTMColor3s"></div><div class="sliderTMColor3sValue">0</div>'
    dataHtml += '</div>'
    if (configHorseStableLogic.componentPrices.horseTransformation) {
        dataHtml += '<div id="colorsButtonSmall">' + language[164] + ''
        dataHtml += '   <input type="range" min="1" max="27" value="0" class="slider" id="texturechange" oninput="changeModelStructure(\'texturechange\', this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[399]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="8147" oninput="changeModelStructure(8147, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[400]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="57577" oninput="changeModelStructure(57577, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[401]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="10002" oninput="changeModelStructure(10002, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[402]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="63348" oninput="changeModelStructure(63348, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[403]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="19812" oninput="changeModelStructure(19812, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[404]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="19813" oninput="changeModelStructure(19813, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[405]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="19780" oninput="changeModelStructure(19780, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[406]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="19781" oninput="changeModelStructure(19781, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[407]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="54287" oninput="changeModelStructure(54287, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[408]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="26933" oninput="changeModelStructure(26933, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[409]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="3054" oninput="changeModelStructure(3054, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[410]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="55026" oninput="changeModelStructure(55026, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[411]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="23050" oninput="changeModelStructure(23050, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[412]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="22538" oninput="changeModelStructure(22538, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[413]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="22549" oninput="changeModelStructure(22549, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[414]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="29982" oninput="changeModelStructure(29982, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[415]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="36120" oninput="changeModelStructure(36120, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[416]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="35608" oninput="changeModelStructure(35608, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[417]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="43213" oninput="changeModelStructure(43213, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[418]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="2075" oninput="changeModelStructure(2075, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[419]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="34850" oninput="changeModelStructure(34850, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[420]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="17697" oninput="changeModelStructure(17697, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[421]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="17698" oninput="changeModelStructure(17698, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[422]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="34338" oninput="changeModelStructure(34338, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[423]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="17185" oninput="changeModelStructure(17185, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[424]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="17186" oninput="changeModelStructure(17186, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[425]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="9675" oninput="changeModelStructure(9675, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[426]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="10726" oninput="changeModelStructure(10726, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[427]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="3015" oninput="changeModelStructure(3015, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[428]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="18278" oninput="changeModelStructure(18278, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[429]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="60649" oninput="changeModelStructure(60649, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[430]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="42991" oninput="changeModelStructure(42991, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[431]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="26839" oninput="changeModelStructure(26839, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[432]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="15833" oninput="changeModelStructure(15833, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[433]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="41478" oninput="changeModelStructure(41478, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[434]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="62347" oninput="changeModelStructure(62347, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[435]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="11904" oninput="changeModelStructure(11904, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[436]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="36550" oninput="changeModelStructure(36550, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[437]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="8420" oninput="changeModelStructure(8420, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[438]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="16934" oninput="changeModelStructure(16934, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[440]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="60975" oninput="changeModelStructure(60975, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[441]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="39436" oninput="changeModelStructure(39436, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[442]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="48003" oninput="changeModelStructure(48003, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[443]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="1589" oninput="changeModelStructure(1589, this.value)"></input>'
        dataHtml += '</div>'
        dataHtml += '<div id="colorsButtonSmall">'+language[444]+''
        dataHtml += '   <input type="range" min="-10" max="10" value="0" class="slider" id="62196" oninput="changeModelStructure(62196, this.value)"></input>'
        dataHtml += '</div>'
    }

    tableBody.innerHTML = dataHtml
    if (isCompany) {
        for (var i in companyHorses) {
            if (companyHorses[i].id == isCompany) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:companyHorses[i].model, id:companyHorses[i].id, isComp:true, isCompany:true}));
            }
        }

    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || myHorses[i].id == horseId) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:myHorses[i].model, id:myHorses[i].id, isComp:true}));
            }
        }
    }

    $.post('http://gum_stables/loadColorHorse');
    loadSliderColorHorse("scaleHorse", "scale", configHorseStableLogic.horseScale[0], configHorseStableLogic.horseScale[1]);
    loadSliderColorHorse("paletteHorse", "palette", 0, 21);
    loadSliderColorHorse("color1Horse", "c1", 0, 254);
    loadSliderColorHorse("color2Horse", "c2", 0, 254);
    loadSliderColorHorse("color3Horse", "c3", 0, 254);

    loadSliderColorHorse("paletteHorseT", "palette", 0, 21);
    loadSliderColorHorse("color1HorseT", "c1", 0, 254);
    loadSliderColorHorse("color2HorseT", "c2", 0, 254);
    loadSliderColorHorse("color3HorseT", "c3", 0, 254);
}

function changeModelStructure(num, value) {
    $.post('http://gum_stables/changeModelStructure', JSON.stringify({num:num, value:value}));
}

function openCartComponentStore(id, extrasMax, lanternMax, liveryMax, tintMax, propsetMax) {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeOut(150);
    $('#stableContainer').fadeIn(150);
    $('#cartComponentContainer').fadeIn(150);
    $('#acceptComp').fadeIn(150);
    const tableBody = document.getElementById('cartComponentContainer');
    let dataHtml = '';
    dataHtml += '<div id="cartCompButton">'
    dataHtml += '   <div id="lanternWheel2" class="sliderLantern"></div><div class="sliderLanternValue">0</div>'
    dataHtml += '   <div id="liveryWheel" class="sliderLivery"></div><div class="sliderLiveryValue">-1</div>'
    dataHtml += '   <div id="tintWheel" class="sliderTint"></div><div class="sliderTintValue">-1</div>'
    dataHtml += '   <div id="propsetWheel" class="sliderPropset"></div><div class="sliderPropsetValue">0</div>'
    dataHtml += '   <div id="horsesWheel" class="sliderHorses"></div><div class="sliderHorsesValue">0</div>'
    dataHtml += '</div>'
    for (var i = 1; i <= extrasMax; i++) {
        dataHtml += '<div id="cartComponentButton" onclick="useExtras('+i+')">'+language[135]+''+i+'</div>'
    }

    tableBody.innerHTML = dataHtml
    loadSliderCartComp("liveryWheel", -1, liveryMax-1) 
    loadSliderCartComp("tintWheel", -1, tintMax-1) 
    loadSliderCartComp("propsetWheel", 0, propsetMax) 
    loadSliderCartComp("horsesWheel", 0, 255) 
    loadSliderCartComp("lanternWheel2", 0, lanternMax) 
    TweenLite.to('.sliderTint', 0, {rotation: -1 * 60});
    document.getElementById('acceptComp').onclick = function() {buyComponents("cart");};
    $.post('http://gum_stables/loadComponentCart');
}

function useExtras(num) {
    $.post('http://gum_stables/selectCartComponent', JSON.stringify({comp:"extrasWheel", value:num}))
}

function openTransfer(openType) {
    if (blockUseScript) {
        return;
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeOut(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeOut(150);
    $('#acceptComp').fadeOut(150);
    $('#transferContainer').fadeIn(150);
    $('#transferAccept').fadeIn(150);
    $('#horseCartSide').fadeIn(150);
    const tableDataBody = document.getElementById('horseCartSide');
    let dataDataHtml = '';
    if (openType === "horse") {
        if (configHorseStableLogic.whereTheyAreKept.enabled || configHorseStableLogic.callFromStables) {
            for (var a in allMyHorses) {
                let text = allMyHorses[a].name;
                if (text.length > 15) {
                    text = text.substring(0, 15) + '..';
                }
                dataDataHtml += '<div id="horseTransferButton" onclick="transferThisType(this, \''+allMyHorses[a].id+'\', \''+allMyHorses[a].model+'\', \'horse\')">'+text+'</div>'
            }
        }
    } else {
        if (configCartStableLogic.whereTheyAreKept.enabled || configCartStableLogic.callFromStables) {
            for (var a in allMyCarts) {
                let text = allMyCarts[a].name;
                if (text.length > 15) {
                    text = text.substring(0, 15) + '..';
                }
                dataDataHtml += '<div id="horseTransferButton" onclick="transferThisType(this, \''+allMyCarts[a].id+'\', \''+allMyCarts[a].model+'\', \'cart\')">'+text+'</div>'
            }
        }
    }
    tableDataBody.innerHTML = dataDataHtml
    
    const tableSpotBody = document.getElementById('citySpotSide');
    let dataSpotHtml = '';
    if (configHorseStableLogic.whereTheyAreKept.enabled || configCartStableLogic.whereTheyAreKept.enabled) {
        dataSpotHtml += '<div class="stablesBreedHeader">'+language[136]+'</div>'
        for (var a in stablesInfo) {
            if (stablesInfo[a]) {
                let text = stablesInfo[a].replace('Stable -', '');
                if (text.length > 15) {
                    text = text.substring(0, 15) + '..';
                }
                dataSpotHtml += '<div id="cityButton" onclick="transferThisCity(this, \''+stablesInfo[a]+'\', \'city\')">'+text+'</div>'
            }
        }
    }
  
    dataSpotHtml += '<div class="stablesBreedHeader">'+language[156]+'</div>'
    for (var a in companyInfo) {
        if (companyInfo[a]) {
            let text = companyInfo[a].replace('Horse company -', '');
            if (text.length > 15) {
                text = text.substring(0, 15) + '..';
            }
            dataSpotHtml += '<div id="cityButton" onclick="transferThisCity(this, \''+companyInfo[a]+'\', \'company\')">'+text+'</div>'
        }
    }
    tableSpotBody.innerHTML = dataSpotHtml
}

function transferToSpot() {
    $.post('http://gum_stables/transferToSpot')
}


function transferThisType(here, id, model, type) {
    const buttons = document.querySelectorAll('#horseTransferButton');
    buttons.forEach(btn => {
        btn.style.backgroundColor = '';
    });
    $(here).css('background-color', 'rgba(34, 34, 34, 0.1)');
    $.post('http://gum_stables/transferThisType', JSON.stringify({id:id, type:type, model:model, isComp:true}))
}

function transferThisCity(here, city, type) {
    const buttons = document.querySelectorAll('#cityButton');
    buttons.forEach(btn => {
        btn.style.backgroundColor = '';
    });
    $(here).css('background-color', 'rgba(34, 34, 34, 0.1)');
    $.post('http://gum_stables/transferThisCity', JSON.stringify({city:city, type:type}))
}
var maxValuesData = [];

function openHorseComponent(isCompany) {
    if (blockUseScript) {
        return;
    }
    var selectedExist = false
    if (isCompany) {
        for (var i in companyHorses) {
            if (isCompany == companyHorses[i].id) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || horseId == myHorses[i].id) {
                selectedExist = true
                break
            }
        }
        if (selectedExist == false) {
            return false
        }
    }
    inMenu = true
    $('#horseCategory').fadeOut(150)
    $('#cartCategory').fadeOut(150);
    $('#myHorses').fadeOut(150);
    $('#myCarts').fadeOut(150);
    $('#baseContainer').fadeOut(150);
    $('#stableContainer').fadeIn(150);
    $('#componentContainer').fadeIn(150);
    $('#acceptComp').fadeIn(150);
    const tableBody = document.getElementById('componentContainer');
    let dataHtml = '';
    var sliders = [];
    var maxValues = [];
    dataHtml += '<div id="compButton"><span id="saddlecloths">'+language[137]+'</span><div id="resetColor" onclick="compColor(\'saddlecloths\', \'reset\')"></div>'
    dataHtml += '   <div id="saddlecloths0" class="sliderPart"></div>'
    dataHtml += '   <div id="saddlecloths1" class="sliderColor1"></div>'
    dataHtml += '   <div id="saddlecloths2" class="sliderColor2"></div>'
    dataHtml += '   <div id="saddlecloths3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["saddlecloths"] = allComponentsMax.blankets
    sliders.push('saddlecloths0')
    sliders.push('saddlecloths1')
    sliders.push('saddlecloths2')
    sliders.push('saddlecloths3')

    maxValuesData["saddlecloths0"] = allComponentsMax.blankets
    maxValuesData["saddlecloths1"] = 254
    maxValuesData["saddlecloths2"] = 254
    maxValuesData["saddlecloths3"] = 254

    dataHtml += '<div id="compButton"><span id="saddles">'+language[138]+'</span><div id="resetColor" onclick="compColor(\'saddles\', \'reset\')"></div>'
    dataHtml += '   <div id="saddles0" class="sliderPart"></div>'
    dataHtml += '   <div id="saddles1" class="sliderColor1"></div>'
    dataHtml += '   <div id="saddles2" class="sliderColor2"></div>'
    dataHtml += '   <div id="saddles3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["saddles"] = allComponentsMax.saddles
    sliders.push('saddles0')
    sliders.push('saddles1')
    sliders.push('saddles2')
    sliders.push('saddles3')

    maxValuesData["saddles0"] = allComponentsMax.saddles
    maxValuesData["saddles1"] = 254
    maxValuesData["saddles2"] = 254
    maxValuesData["saddles3"] = 254

    dataHtml += '<div id="compButton"><span id="acshorn">'+language[139]+'</span>'
    dataHtml += '   <div id="acshorn0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["acshorn"] = allComponentsMax.horns
    sliders.push('acshorn0')
    maxValuesData["acshorn0"] = allComponentsMax.horns

    dataHtml += '<div id="compButton"><span id="stirrups">'+language[140]+'</span>'
    dataHtml += '   <div id="stirrups0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["stirrups"] = allComponentsMax.stirrups
    sliders.push('stirrups0')
    maxValuesData["stirrups0"] = allComponentsMax.stirrups


    dataHtml += '<div id="compButton"><span id="bags">'+language[141]+'</span><div id="resetColor" onclick="compColor(\'bags\', \'reset\')"></div>'
    dataHtml += '   <div id="bags0" class="sliderPart"></div>'
    dataHtml += '   <div id="bags1" class="sliderColor1"></div>'
    dataHtml += '   <div id="bags2" class="sliderColor2"></div>'
    dataHtml += '   <div id="bags3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["bags"] = allComponentsMax.bags
    sliders.push('bags0')
    sliders.push('bags1')
    sliders.push('bags2')
    sliders.push('bags3')

    maxValuesData["bags0"] = allComponentsMax.bags
    maxValuesData["bags1"] = 254
    maxValuesData["bags2"] = 254
    maxValuesData["bags3"] = 254

    dataHtml += '<div id="compButton"><span id="acsluggage">'+language[142]+'</span><div id="resetColor" onclick="compColor(\'acsluggage\', \'reset\')"></div>'
    dataHtml += '   <div id="acsluggage0" class="sliderPart"></div>'
    dataHtml += '   <div id="acsluggage1" class="sliderColor1"></div>'
    dataHtml += '   <div id="acsluggage2" class="sliderColor2"></div>'
    dataHtml += '   <div id="acsluggage3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["acsluggage"] = allComponentsMax.bedrolls
    sliders.push('acsluggage0')
    sliders.push('acsluggage1')
    sliders.push('acsluggage2')
    sliders.push('acsluggage3')

    maxValuesData["acsluggage0"] = allComponentsMax.bedrolls
    maxValuesData["acsluggage1"] = 254
    maxValuesData["acsluggage2"] = 254
    maxValuesData["acsluggage3"] = 254

    dataHtml += '<div id="compButton"><span id="lantern">'+language[143]+'</span>'
    dataHtml += '   <div id="lantern0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["lantern"] = allComponentsMax.lantern
    sliders.push('lantern0')
    maxValuesData["lantern0"] = allComponentsMax.lantern


    dataHtml += '<div id="compButton"><span id="Mask">'+language[144]+'</span><div id="resetColor" onclick="compColor(\'Mask\', \'reset\')"></div>'
    dataHtml += '   <div id="Mask0" class="sliderPart"></div>'
    dataHtml += '   <div id="Mask1" class="sliderColor1"></div>'
    dataHtml += '   <div id="Mask2" class="sliderColor2"></div>'
    dataHtml += '   <div id="Mask3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["Mask"] = allComponentsMax.accessories
    sliders.push('Mask0')
    sliders.push('Mask1')
    sliders.push('Mask2')
    sliders.push('Mask3')

    maxValuesData["Mask0"] = allComponentsMax.accessories
    maxValuesData["Mask1"] = 254
    maxValuesData["Mask2"] = 254
    maxValuesData["Mask3"] = 254

    dataHtml += '<div id="compButton"><span id="holster">'+language[145]+'</span><div id="resetColor" onclick="compColor(\'holster\', \'reset\')"></div>'
    dataHtml += '   <div id="holster0" class="sliderPart"></div>'
    dataHtml += '   <div id="holster1" class="sliderColor1"></div>'
    dataHtml += '   <div id="holster2" class="sliderColor2"></div>'
    dataHtml += '   <div id="holster3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["holster"] = allComponentsMax.holsters
    sliders.push('holster0')
    sliders.push('holster1')
    sliders.push('holster2')
    sliders.push('holster3')

    maxValuesData["holster0"] = allComponentsMax.holsters
    maxValuesData["holster1"] = 254
    maxValuesData["holster2"] = 254
    maxValuesData["holster3"] = 254

    dataHtml += '<div id="compButton"><span id="bridle">'+language[146]+'</span><div id="resetColor" onclick="compColor(\'bridle\', \'reset\')"></div>'
    dataHtml += '   <div id="bridle0" class="sliderPart"></div>'
    dataHtml += '   <div id="bridles1" class="sliderColor1"></div>'
    dataHtml += '   <div id="bridles2" class="sliderColor2"></div>'
    dataHtml += '   <div id="bridles3" class="sliderColor3"></div>'
    dataHtml += '</div>'
    maxValues["bridle"] = allComponentsMax.bridles
    sliders.push('bridle0')
    sliders.push('bridles1')
    sliders.push('bridles2')
    sliders.push('bridles3')

    maxValuesData["bridle0"] = allComponentsMax.bridles
    maxValuesData["bridles1"] = 254
    maxValuesData["bridles2"] = 254
    maxValuesData["bridles3"] = 254
    if (configHorseStableLogic.componentPrices.enabledColorTailAndMane) {
        dataHtml += '<div id="compButton"><span id="tails">'+language[147]+'</span><div id="resetColor" onclick="compColor(\'tails\', \'reset\')"></div>'
        dataHtml += '   <div id="tails0" class="sliderPart"></div>'
        dataHtml += '   <div id="tail1" class="sliderColor1"></div>'
        dataHtml += '   <div id="tail2" class="sliderColor2"></div>'
        dataHtml += '   <div id="tail3" class="sliderColor3"></div>'
        dataHtml += '</div>'
        maxValues["tails"] = allComponentsMax.tails
        sliders.push('tails0')
        sliders.push('tail1')
        sliders.push('tail2')
        sliders.push('tail3')
    
        maxValuesData["tails0"] = allComponentsMax.tails
        maxValuesData["tail1"] = 254
        maxValuesData["tail2"] = 254
        maxValuesData["tail3"] = 254
    } else {
        dataHtml += '<div id="compButton"><span id="tails">'+language[147]+'</span>'
        dataHtml += '   <div id="tails0" class="sliderPart"></div>'
        dataHtml += '</div>'
        maxValues["tails"] = allComponentsMax.tails
        sliders.push('tails0')
        maxValuesData["tails0"] = allComponentsMax.tails
    }

    dataHtml += '<div id="compButton"><span id="manes">'+language[148]+'</span><div id="resetColor" onclick="compColor(\'manes\', \'reset\')"></div>'
    dataHtml += '   <div id="manes0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["manes"] = allComponentsMax.manes
    sliders.push('manes0')

    maxValuesData["manes0"] = allComponentsMax.manes

    dataHtml += '<div id="compButton"><span id="mustache">'+language[151]+'</span><div id="resetColor" onclick="compColor(\'mustache\', \'reset\')"></div>'
    dataHtml += '   <div id="mustache0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["mustache"] = allComponentsMax.mustaches
    sliders.push('mustache0')

    maxValuesData["mustache0"] = allComponentsMax.mustaches

    dataHtml += '<div id="compButton"><span id="propsData">'+language[149]+'</span>'
    dataHtml += '   <div id="propsData0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["propsData"] = allComponentsMax.propsData
    sliders.push('propsData0')

    maxValuesData["propsData0"] = allComponentsMax.propsData

    dataHtml += '<div id="compButton"><span id="propsHeadData">'+language[150]+'</span>'
    dataHtml += '   <div id="propsHeadData0" class="sliderPart"></div>'
    dataHtml += '</div>'
    maxValues["propsHeadData"] = allComponentsMax.propsHeadData
    sliders.push('propsHeadData0')

    maxValuesData["propsHeadData0"] = allComponentsMax.propsHeadData

    document.getElementById('acceptComp').onclick = function() {buyComponents("horse");};


    tableBody.innerHTML = dataHtml
    if (isCompany) {
        for (var i in companyHorses) {
            if (isCompany == companyHorses[i].id) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:companyHorses[i].model, id:companyHorses[i].id, isComp:true, isCompany:true}));
            }
        }
    } else {
        for (var i in myHorses) {
            if (myHorses[i].selected == 1 || horseId == myHorses[i].id) {
                $.post('http://gum_stables/showMyHorse', JSON.stringify({model:myHorses[i].model, id:myHorses[i].id, isComp:true}));
            }
        }
    }

    loadSlider(sliders, maxValues)
    for (var i in myHorses) {
        if (myHorses[i].selected == 1 || horseId == myHorses[i].id) {
            $.post('http://gum_stables/loadMyComponents', JSON.stringify({components:myHorses[i].components}));
        }
    }
}

function loadCompSliders(components) {
    for (var i in components) {
        if (components[i][0] == undefined) {
            var sliderID0 = i;
            var value0 = components[i];
            if (Draggable.get("#"+sliderID0+"")) {
                TweenLite.to('#' + sliderID0, 1, {rotation: value0 * 1000});
            }
        } else {
            var sliderID0 = i+'0';
            var value0 = components[i][0];
            if (Draggable.get("#"+sliderID0+"")) {
                TweenLite.to('#' + sliderID0, 1, {rotation: value0 * 60});
            }
    
            var sliderID1 = i+'1';
            var value1 = components[i][1];
            if (Draggable.get("#"+sliderID1+"")) {
                TweenLite.to('#' + sliderID1, 1, {rotation: value1 * 60});
            }
    
            var sliderID2 = i+'2';
            var value2 = components[i][2];
            if (Draggable.get("#"+sliderID2+"")) {
                TweenLite.to('#' + sliderID2, 1, {rotation: value2 * 60});
            }
    
            var sliderID3 = i+'3';
            var value3 = components[i][3];
            if (Draggable.get("#"+sliderID3+"")) {
                TweenLite.to('#' + sliderID3, 1, {rotation: value3 * 60});
            }
            setTimeout(function() {
                if (Draggable.get("#"+sliderID0+"")) {
                    gsap.set("#"+sliderID0+"", { rotation: value0 * 60 });
                }
                if (Draggable.get("#"+sliderID1+"")) {
                    gsap.set("#"+sliderID1+"", { rotation: value1 * 60 });
                }
                if (Draggable.get("#"+sliderID2+"")) {
                    gsap.set("#"+sliderID2+"", { rotation: value2 * 60 });
                }
                if (Draggable.get("#"+sliderID3+"")) {
                    gsap.set("#"+sliderID3+"", { rotation: value3 * 60 });
                }
            }, 2000);
        }
    }
}

var oldValuePart = 0;

function compColor(comp, value) {
    if (value == "reset") {
        resetSlider(comp)
    }
}
function loadSlider(sliders, maxValues) {
    for (var i in sliders) {
        var withoutNum = sliders[i].replace(/\d+$/, '');
        var positionOfZero = sliders[i].indexOf('0');
        if (positionOfZero == -1) {
            Draggable.create("#"+sliders[i]+"", {
                type: "rotation",
                inertia: true,
                bounds: {minRotation: 0, maxRotation: 254 * 60},
                onDrag() {
                    var rotationValue = Math.floor(this.rotation / 60);
                    if (rotationValue !== oldValuePart) {
                        var elementID = this.target.id;
                        loadComponent(elementID, rotationValue);
                        oldValuePart = rotationValue;
                    }
                },
                onPress() {
                    selectedElement = this.target.id;
                }
            });
        } else {
            if (sliders[i] == "propsData0" || sliders[i] == "propsHeadData0") {
                Draggable.create("#"+sliders[i]+"", {
                    type: "rotation",
                    inertia: true,
                    bounds: {minRotation: 0, maxRotation: maxValues[withoutNum] * 1000},
                    onDrag() {
                        var rotationValue = Math.floor(this.rotation / 1000);
                        if (rotationValue !== oldValuePart) {
                            var elementID = this.target.id;
                            loadComponent(elementID, rotationValue);
                            oldValuePart = rotationValue;
                        }
                    },
                    onPress() {
                        selectedElement = this.target.id;
                    }
                });
            } else {
                Draggable.create("#"+sliders[i]+"", {
                    type: "rotation",
                    inertia: true,
                    bounds: { minRotation: 0, maxRotation: maxValues[withoutNum] * 60 },
                    onDrag() {
                        var rotationValue = Math.floor(this.rotation / 60);
                        if (rotationValue !== oldValuePart) {
                            var elementID = this.target.id;
                            loadComponent(elementID, rotationValue);
                            oldValuePart = rotationValue;
                        }
                    },
                    onPress() {
                        selectedElement = this.target.id;
                    }
                });
            }
        }
    }
}
let rotationSteps = {};
let oldHorseValues = {};

document.addEventListener('keydown', function(event) {
    if (!selectedElement) return;

    const draggable = Draggable.get("#" + selectedElement);
    if (!draggable) return;

    const id = selectedElement;
    const isColor = id.includes("Horse");
      if (selectedElement === "propsData0") {
        rotationUnit = 1000;
    } else {
        rotationUnit = 60;
    }
    let step = 75;
    let maxStep = 254;

    let type = null;
    if (id === "scaleHorse") return;
    if (id.includes("paletteHorse")) { type = "palette"; maxStep = 21; }
    else if (id.includes("color1Horse")) { type = "c1"; }
    else if (id.includes("color2Horse")) { type = "c2"; }
    else if (id.includes("color3Horse")) { type = "c3"; }

    if (rotationSteps[id] === undefined) {
        rotationSteps[id] = Math.floor(draggable.rotation / rotationUnit);
    }

    if (event.key === 'ArrowRight') {
        rotationSteps[id]++;
    } else if (event.key === 'ArrowLeft') {
        rotationSteps[id]--;
    } else {
        return;
    }

    if (rotationSteps[id] < 0) rotationSteps[id] = 0;
    if (rotationSteps[id] > maxStep) rotationSteps[id] = maxStep;

    const newRotation = rotationSteps[id] * rotationUnit;

    gsap.to(draggable.target, {
        rotation: newRotation,
        onStart: () => {
            draggable.update();
            const value = rotationSteps[id];

            if (isColor && type) {
                if (oldHorseValues[id] !== value) {
                    oldHorseValues[id] = value;

                    $.post('http://gum_stables/colorHorse', JSON.stringify({
                        colorType: type,
                        value: value,
                        className: draggable.target.className
                    }));

                    const classId = draggable.target.className;
                    document.getElementsByClassName(`${classId}Value`)[0].innerHTML = value;
                }
            } else {
                loadComponent(draggable.target.id, value);
                oldValuePart = value;
            }
        }
    });
});

function loadComponent(comp, value) {
    var withoutNum = comp.replace(/\d+$/, '');
    var color1 = Math.floor(gsap.getProperty("#"+withoutNum+"1", "rotation") / 60);
    var color2 = Math.floor(gsap.getProperty("#"+withoutNum+"2", "rotation") / 60);
    var color3 = Math.floor(gsap.getProperty("#"+withoutNum+"3", "rotation") / 60);
    $.post('http://gum_stables/selectComponent', JSON.stringify({comp:comp, value:value, color:{color1:color1, color2:color2, color3:color3}}));
}

function resetSlider(comp) {
    $.post('http://gum_stables/resetComponent', JSON.stringify({comp:comp}));
    if (comp == "horseColor" || comp == "tailColor") {
        if (comp == "horseColor") {
            if (Draggable.get(".sliderPalettes")) {
                gsap.set(".sliderPalettes", { x: 0, y: 0, rotation: 0 });
                gsap.to(".sliderPalettes", { duration: 0, x: 0, y: 0, rotation: 0 });
            }
            for (var i = 1; i <= 3; i++) {
                if (Draggable.get(".sliderHColor"+i+"s")) {
                    gsap.set(".sliderHColor"+i+"s", { x: 0, y: 0, rotation: 0 });
                    gsap.to(".sliderHColor"+i+"s", { duration: 0, x: 0, y: 0, rotation: 0 });
                }
            }

        } else {
            if (Draggable.get(".sliderTMPalettes")) {
                gsap.set(".sliderTMPalettes", { x: 0, y: 0, rotation: 0 });
                gsap.to(".sliderTMPalettes", { duration: 0, x: 0, y: 0, rotation: 0 });
            }
            for (var i = 1; i <= 3; i++) {
                if (Draggable.get(".sliderTMColor"+i+"s")) {
                    gsap.set(".sliderTMColor"+i+"s", { x: 0, y: 0, rotation: 0 });
                    gsap.to(".sliderTMColor"+i+"s", { duration: 0, x: 0, y: 0, rotation: 0 });
                }
            }
        }

    } else {
        for (var i = 1; i <= 3; i++) {
            if (Draggable.get("#"+comp+i)) {
                gsap.set("#"+comp+i, { x: 0, y: 0, rotation: 0 });
                gsap.to("#"+comp+i, { duration: 0, x: 0, y: 0, rotation: 0 });
            }
        }
    }
}

function loadMyHorsesData(id, name, exp, sex, age, breeding, friendly, courage, isdead, selected, model, company) {
    inMenu = true
    if (Number(selected) == 0) {if ($("#select").is(":visible")) {$("#select").show();} else {$("#select").fadeIn(150);}} else {if ($("#select").is(":visible")) {$("#select").hide();} else {$("#select").fadeOut(150);}}
    if (breeding == language[130]) {if ($("#breed").is(":visible")) {$("#breed").show();} else {$("#breed").fadeIn(150);}} else {if ($("#breed").is(":visible")) {$("#breed").hide();} else {$("#breed").fadeOut(150);}}
    if (isdead == 1) {if ($("#heal").is(":visible")) {$("#heal").show();} else {$("#heal").fadeIn(150);}} else {if ($("#heal").is(":visible")) {$("#heal").hide();} else {$("#heal").fadeOut(150);}}

    var newName = ""
    if (Number(selected) == 1) {
        newName = '<b>- '+name+' -</b>'
    } else {
        newName = ''+name+''
    }
    document.getElementById('remove').onclick = function() {sellData(id, "horse", company);};
    document.getElementById('select').onclick = function() {selectData(id, "horse", company);};
    document.getElementById('heal').onclick = function() {healData(id, "horse", model);};

    if (company) {
        document.getElementById('myHorseTitle').innerHTML =
        '<div id="catArrowLeft" onclick="changeMyHorse(\'' + id + '\', \'left\', \'company\')"></div>' +
        newName +
        '<div id="catArrowRight" onclick="changeMyHorse(\'' + id + '\', \'right\', \'company\')"></div>';
    } else {
        document.getElementById('myHorseTitle').innerHTML =
        '<div id="catArrowLeft" onclick="changeMyHorse(\'' + id + '\', \'left\')"></div>' +
        newName +
        '<div id="catArrowRight" onclick="changeMyHorse(\'' + id + '\', \'right\')"></div>';
    }

    document.getElementById('myHorseDescription').innerHTML = '<b>'+language[115]+''+exp+'</br>'+language[114]+''+sex+'</br>'+language[117]+''+age+'</br>'+language[118]+''+breeding+'</br>'+language[119]+''+friendly+'</br>'+language[120]+''+courage+'</b>' 
    if (breeding == language[130] && sex == language[122]) {
        $('#select').hide();
    }
    setTimeout(function() {
        document.getElementById('remove').classList.remove('rotateIcon');
        document.getElementById('select').classList.remove('rotateIcon');
        document.getElementById('breed').classList.remove('rotateIcon');
        document.getElementById('heal').classList.remove('rotateIcon');
        setTimeout(function() {
            document.getElementById('remove').classList.add('rotateIcon');
            document.getElementById('select').classList.add('rotateIcon');
            document.getElementById('breed').classList.add('rotateIcon');
            document.getElementById('heal').classList.add('rotateIcon');
        }, 10);
    }, 0);
}

function selectData(id, type, isCompany) {
    clearMenu()
    if (configHorseStableLogic.callFromStables) {
        horseId = id
    }
    $.post('http://gum_stables/selectData', JSON.stringify({id:id, type:type, isCompany:isCompany}));
}

function sellData(id, type, isCompany) {
    clearMenu()
    clearMenu()
    $.post('http://gum_stables/sellData', JSON.stringify({id:id, type:type, isCompany:isCompany}));
}


function loadMyCartsData(id, name, selected, damage_wheel, health_cart, cityPosition, spotPosition, company) {
    inMenu = true
    if (Number(selected) == 0) {$("#select").fadeIn(150);} else {$("#select").fadeOut(150);}
    document.getElementById('select').onclick = function() {selectData(id, "cart", company);};
    document.getElementById('remove').onclick = function() {sellData(id, "cart", company);};

    var newName = ""
    if (Number(selected) == 1) {
        newName = '<b>- '+name+' -</b>'
    } else {
        newName = ''+name+''
    } 
    if (company) {
        document.getElementById('myHorseTitle').innerHTML =
            '<div id="catArrowLeft" onclick="changeMyCart(\'' + id + '\', \'left\', \'company\')"></div>' +
            newName +
            '<div id="catArrowRight" onclick="changeMyCart(\'' + id + '\', \'right\', \'company\')"></div>';
    } else {
        document.getElementById('myHorseTitle').innerHTML =
            '<div id="catArrowLeft" onclick="changeMyCart(\'' + id + '\', \'left\')"></div>' +
            newName +
            '<div id="catArrowRight" onclick="changeMyCart(\'' + id + '\', \'right\')"></div>';
    }
    
    if (cityPosition == 0) {cityPosition = language[131]} else {cityPosition = stablesInfo[cityPosition-1]}
    var dmgWheel = JSON.parse(damage_wheel)
    if (dmgWheel.length == 0) {dmgWheel = language[125]} else {dmgWheel = language[124]}
    document.getElementById('myHorseDescription').innerHTML = '<b>'+language[132]+''+cityPosition+'</br>'+language[133]+''+health_cart+'</br>'+language[134]+''+dmgWheel+'</b>' 
    setTimeout(function() {
        document.getElementById('remove').classList.remove('rotateIcon');
        document.getElementById('select').classList.remove('rotateIcon');
        setTimeout(function() {
            document.getElementById('remove').classList.add('rotateIcon');
            document.getElementById('select').classList.add('rotateIcon');
        }, 10);
    }, 0);
}


function changeMyHorse(id, direction, company) {
    if (blockSpam === false) {
        blockSpam = true;
        $.post('http://gum_stables/changeMyHorse', JSON.stringify({id:id, direction:direction, company:company}));
        setTimeout(function() {
            blockSpam = false;
        }, 500);
    }
}


function changeCategory(category, direction, isCart) {
    if (blockSpam === false) {
        blockSpam = true;
        $.post('http://gum_stables/changeCategory', JSON.stringify({category:category, direction:direction, isCart:isCart}));
        setTimeout(function() {
            blockSpam = false;
        }, 500);
    }
}

function changeHorse(colorName, category, direction) {
    if (blockSpam === false) {
        blockSpam = true;
        $.post('http://gum_stables/changeHorse', JSON.stringify({horse:colorName, category:category, direction:direction}));
        setTimeout(function() {
            blockSpam = false;
        }, 500);
    }
}

function changeCart(name, category, direction) {
    if (blockSpam === false) {
        blockSpam = true;
        $.post('http://gum_stables/changeCart', JSON.stringify({cart:name, category:category, direction:direction}));
        setTimeout(function() {
            blockSpam = false;
        }, 500);
    }
}

function GetFPS(){
    return fps
}

function updateHorseState(spe, acce, agie, state) {
    baseAcc = acce;
    baseSpeed = spe;
    baseTurn = agie;
    document.getElementById('accelerationBarFilled').style.width = ''+baseAcc*10+'%';
    document.getElementById('speedBarFilled').style.width = ''+baseSpeed*10+'%';
    document.getElementById('turnBarFilled').style.width = ''+baseTurn*10+'%';
}

function sizeCheck(num) {
    var number = parseFloat(num);
    const numberLength = number.toString().length;
    if (numberLength >= 6) {
        return '1.1vw';
    } else if (numberLength >= 4 && numberLength <= 5) {
        return '1.4vw';
    } else if (numberLength == 3) {
        return '1.5vw';
    } else if (numberLength <= 2) {
        return '1.5vw';
    } else {
        return '1.6vw';
    }
}

function saveColor() {
    clearMenu()
    $.post('http://gum_stables/saveColor', JSON.stringify({}));
}

function loadSliderColorHorse(id, type, min, max) {
    var oldHorseValue = 0;

    Draggable.create("#"+id+"", {
        type: "rotation",
        inertia: true,
        bounds: {minRotation: min * 60, maxRotation: max * 60},
        onDrag() {
            var rotationValue = Math.floor(this.rotation / 60);
            var element = this.target;
            var className = element.className;
            if (rotationValue !== oldHorseValue) {
                oldHorseValue = rotationValue;
                $.post('http://gum_stables/colorHorse', JSON.stringify({colorType:type, value:rotationValue, className:className}))

                var element = document.getElementById(this.target.id);
                var classId = element.className;
                if (isNaN(rotationValue)) {
                    rotationValue = 0;
                }
                document.getElementsByClassName(""+classId+"Value")[0].innerHTML = rotationValue;
            }
            if (this.rotation == 0) {
                oldHorseValue = rotationValue;
                $.post('http://gum_stables/colorHorse', JSON.stringify({colorType:type, value:0, className:className}))

                var element = document.getElementById(this.target.id);
                var classId = element.className;
                if (isNaN(rotationValue)) {
                    rotationValue = 0;
                }
                document.getElementsByClassName(""+classId+"Value")[0].innerHTML = rotationValue;
            }
        },
        onPress() {
            selectedElement = this.target.id;
        }
    });
}


function loadSliderCartComp(id, min, max) {
    var oldCartValue = 0;

    Draggable.create("#"+id+"", {
        type: "rotation",
        inertia: true,
        bounds: {minRotation: min * 60, maxRotation: max * 60},
        onDrag() {
            var rotationValue = Math.floor(this.rotation / 60);
            var elementID = this.target.id;
            if (rotationValue !== oldCartValue) {
                oldCartValue = rotationValue;
                $.post('http://gum_stables/selectCartComponent', JSON.stringify({comp:elementID, value:rotationValue}))
                
                var element = document.getElementById(this.target.id);
                var classId = element.className;
                if (isNaN(rotationValue)) {
                    rotationValue = 0;
                }
                document.getElementsByClassName(""+classId+"Value")[0].innerHTML = rotationValue;
            }
            if (this.rotation == 0) {
                oldCartValue = rotationValue;

                $.post('http://gum_stables/selectCartComponent', JSON.stringify({comp:elementID, value:rotationValue}))

                var element = document.getElementById(this.target.id);
                var classId = element.className;
                if (isNaN(rotationValue)) {
                    rotationValue = 0;
                }
                document.getElementsByClassName(""+classId+"Value")[0].innerHTML = rotationValue;
            }
        }
    });
}

function setHungerBar(value) {
    var hungerDiv = document.getElementsByClassName('hungerPercent')[0];
    hungerDiv.innerHTML = value;
    hungerBar()
}

function hungerBar(){
    var hungerActive = $("#hungerActive");
    var prec = hungerActive.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        hungerActive.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        hungerActive.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}
function setThirstBar(value) {
    var thirstDiv = document.getElementsByClassName('thirstPercent')[0];
    thirstDiv.innerHTML = value;
    thirstBar()
}

function thirstBar(){
    var thirstActive = $("#thirstActive");
    var prec = thirstActive.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        thirstActive.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        thirstActive.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}