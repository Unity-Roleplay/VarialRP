MC = {}
MC.AdminMenu = {}
MC.Coords = {}

MC.AdminMenu.Action = {}
MC.AdminMenu.Category = {}
MC.AdminMenu.Sidebar = {}
MC.AdminMenu.PlayerList = {}

MC.AdminMenu.DebugEnabled = false
MC.AdminMenu.Opened = false;
MC.AdminMenu.IsGeneratingDropdown = false;

MC.AdminMenu.Action.SelectedCat = null;
MC.AdminMenu.Action.Selected = "All";
MC.AdminMenu.Sidebar.Selected = "Actions";
MC.AdminMenu.Sidebar.Size = "Small";

MC.AdminMenu.FavoritedItems = {};
MC.AdminMenu.PinnedTargets = {};
MC.AdminMenu.EnabledItems = {};
MC.AdminMenu.Settings = {};

MC.AdminMenu.Players = null;
MC.AdminMenu.Items = null;
MC.AdminMenu.CurrentTarget = null;

MC.AdminMenu.Update = function(Data) {
    DebugMessage(`Menu Updating`);
    MC.AdminMenu.FavoritedItems = Data.Favorited;
    MC.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    MC.AdminMenu.Settings = Data.MenuSettings;
    MC.AdminMenu.Players = Data.AllPlayers
    MC.AdminMenu.Items = Data.AdminItems
    MC.AdminMenu.LoadItems();
}
 
MC.AdminMenu.Open = function(Data) {
    DebugMessage(`Menu Opening`);
    MC.AdminMenu.DebugEnabled = Data.Debug;
    MC.AdminMenu.FavoritedItems = Data.Favorited;
    MC.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    MC.AdminMenu.Settings = Data.MenuSettings;
    $('.menu-main-container').css('pointer-events', 'auto');
    $('.menu-main-container').fadeIn(450, function() {
        $('.menu-page-actions-search input').focus();
        if (MC.AdminMenu.Items == null && MC.AdminMenu.Players == null) {
            MC.AdminMenu.Players = Data.AllPlayers
            MC.AdminMenu.Items = Data.AdminItems
            if (MC.AdminMenu.Sidebar.Selected == 'Actions') {
                $('.menu-pages').find(`[data-Page="${MC.AdminMenu.Sidebar.Selected}"`).fadeIn(150);
                MC.AdminMenu.LoadItems();
            }
        };
        MC.AdminMenu.Players = Data.AllPlayers
        MC.AdminMenu.Opened = true;
    });
}


MC.AdminMenu.Close = function() {
    DebugMessage(`Menu Closing`);
    MC.AdminMenu.ClearDropdown();
    $.post(`https://${GetParentResourceName()}/Admin/Close`);
    $('.menu-main-container').css('pointer-events', 'none');
    $('.menu-main-container').fadeOut(150, function() {
        MC.AdminMenu.Opened = false; 
    });
}

MC.AdminMenu.ChangeSize = function() {
    if (MC.AdminMenu.Sidebar.Size == 'Small') {
        $('.menu-size-change').html('<i class="fas fa-chevron-right"></i>');
        MC.AdminMenu.Sidebar.Size = 'Large';
        $('.menu-main-container').css({
            width: 50+"%",
            right: 25+"%",
        });
    } else {
        $('.menu-size-change').html('<i class="fas fa-chevron-left"></i>');
        MC.AdminMenu.Sidebar.Size = 'Small';
        $('.menu-main-container').css({
            width: 24.24+"%",
            right: 3+"%",
        });
    }
}

MC.Coords.Copy = function(Data) {
    let TextArea = document.createElement('textarea');
    let Selection = document.getSelection();
    TextArea.textContent = Data.Coords;
    document.body.appendChild(TextArea);
    Selection.removeAllRanges();
    TextArea.select();
    document.execCommand('copy');
    Selection.removeAllRanges();
    document.body.removeChild(TextArea);
}

// [ CLICKS ] \\

$(document).on('click', '.menu-size-change', function(e) {
    e.preventDefault();
    MC.AdminMenu.ChangeSize()
});

$(document).on('click', '.menu-current-target', function(e){
    $(this).parent().find('.ui-styles-input').each(function(Elem, Obj){
        if ($(this).find('input').data("PlayerId")) {
            if (MC.AdminMenu.CurrentTarget != null) {
                if ($('.admin-menu-item').find('.admin-menu-items-option-input').first().find('.ui-input-label').text() == 'Player') {
                    $(this).find('input').data("PlayerId", null)
                    $(this).find('input').val(" ");
                }
            }
        }
    });
    $('.admin-menu-items').animate({
        'max-height': 72.6+'vh',
    }, 100);
    $('.menu-current-target').fadeOut(150);
    MC.AdminMenu.CurrentTarget = null;
});

// [ FUNCTIONS ] \\

DebugMessage = function(Message) {
    if (MC.AdminMenu.DebugEnabled) {
        console.log(`[DEBUG]: ${Message}`);
    }
}

// [ LISTENER ] \\

document.addEventListener('DOMContentLoaded', (event) => {
    DebugMessage(`Menu Initialised`)
    MC.AdminMenu.Action.SelectedCat = $('.menu-page-action-header-categories').find('.active');
    window.addEventListener('message', function(event){
        let Action = event.data.Action;
        let Data = event.data
        switch(Action) {
            case "Open":
                MC.AdminMenu.Open(Data);
                break;
            case "Close":
                if (!MC.AdminMenu.Opened) return;
                MC.AdminMenu.Close();
                break;
            case "Update":
                if (!MC.AdminMenu.Opened) return;
                MC.AdminMenu.Update(Data);
                break;
            case "SetItemEnabled":
                MC.AdminMenu.EnabledItems[Data.Name] = Data.State;
                Data.State ? $(`#admin-option-${Data.Name}`).addClass('enabled') : $(`#admin-option-${Data.Name}`).removeClass('enabled');
                break;
            case 'copyCoords':
                MC.Coords.Copy(event.data);
                break;
        }
    });
});

$(document).on({
    keydown: function(e) {
        if (e.keyCode == 27 && MC.AdminMenu.Opened) {
            MC.AdminMenu.Close();
        }
    },
});