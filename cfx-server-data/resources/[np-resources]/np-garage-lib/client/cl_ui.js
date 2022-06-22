const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_vui_uiReq:${name}`, cb);

    if (GetResourceState('np-ui') === 'started') exports['np-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['np-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['np-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['np-ui'].GetUIFocus();
}

AddEventHandler('_vui_uiReady', () => {
    registered.forEach((eventName) => exports['np-ui'].RegisterUIEvent(eventName));
});