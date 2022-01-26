let ButtonsData = [];
let Buttons = [];
let Button = [];

const OpenMenu = (data) => {
    DrawButtons(data);
}

const CloseMenu = () => {
    for (let i = 0; i < ButtonsData.length; i++) {
        let id = ButtonsData[i].id
        $(".button").remove();
    };
    ButtonsData = [];
    Buttons = [];
    Button = [];
};

const DrawButtons = (data) => {
    ButtonsData = data;
    for (let i = 0; i < ButtonsData.length; i++) {
        let header = ButtonsData[i].header;
        let message = ''

        if (ButtonsData[i].txt) {
            message = ButtonsData[i].txt
        }
        if (ButtonsData[i].text) {
            message = ButtonsData[i].text
        }

        let id = ButtonsData[i].id;
        let element;

        element = $(`
            <div class="button" id=` + id + `>
                <div class="header" id=` + id + `>` + header + `</div>
                <div class="text" id=` + id + `>` + message + `</div>
            </div>`);
        $('#buttons').append(element);
        Buttons[id] = element;
        if (ButtonsData[i].params) {
            Button[id] = ButtonsData[i].params
        };
    };
};

$(document).click(function (event) {
    let $target = $(event.target);
    if ($target.closest('.button').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (!Button[id]) return
        PostData(id);
    }
});

const PostData = (id) => {
    $.post(`https://${GetParentResourceName()}/clickedButton`, JSON.stringify(Button[id]));
    return CloseMenu();
};

const CancelMenu = () => {
    $.post(`https://${GetParentResourceName()}/closeMenu`);
    return CloseMenu();
};

window.addEventListener("message", (event) => {
    const data = event.data;
    const infos = data.data;
    const action = data.action;
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(infos);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
            return;
    };
});

document.onkeyup = function (event) {
    event = event || window.event;
    var charCode = event.keyCode || event.which;
    if (charCode == 27) {
        CancelMenu();
    };
};