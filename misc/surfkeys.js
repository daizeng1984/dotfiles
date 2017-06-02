mapkey('<Ctrl-h>', '#3Go one tab left', 'RUNTIME("previousTab")');
mapkey('<Ctrl-l>', '#3Go one tab right', 'RUNTIME("nextTab")');mapkey('<Ctrl-u>', '#2Scroll a page up', 'Normal.scroll("pageUp")', {repeatIgnore: true});
mapkey('<Ctrl-d>', '#2Scroll a page down', 'Normal.scroll("pageDown")', {repeatIgnore: true})
mapkey('H', '#4Go back in history', 'history.go(-1)', {repeatIgnore: true});
mapkey('<Ctrl-r>', '#4Go forward in history', 'history.go(1)', {repeatIgnore: true});
mapkey('<Ctrl-f>', '', 'Insert.keydown()', {repeatIgnore: true});
mapkey('p', "Open the clipboard's URL in the current tab", function() {
    Front.getContentFromClipboard(function(response) {
        window.location.href = response.data;
    });
});
mapkey('ym', "#7Copy current page's URL as markdown", function() {
  Front.writeClipboard('[' + document.title + '](' + window.location.href + ')');
});
mapkey(',h', '#1Mouse over elements.', 'Hints.create("", Hints.dispatchMouseClick, {mouseEvents: ["mouseover"]})');

imap('<Ctrl-w>', '<Alt-w>');
imap('<Ctrl-f>', '<Alt-f>');
imap('<Ctrl-b>', '<Alt-b>');
imap('<Ctrl-n>', '<ArrowDown>');
imap('<Ctrl-b>', '<ArrowUp>');
map('L', '<Ctrl-r>');
map(',q', 'x');
map('F', 'gf');
map(',r', 'X');
map('<Ctrl-[>', '<Esc>');
map(',wf', 'T');

settings.hintAlign = "left";
settings.stealFocusOnLoad = false;
settings.tabsThreshold = 9;

// click `Save` button to make above settings to take effect.
// set theme
settings.theme = `
.sk_theme {
    background: #000;
    color: #fff;
}
.sk_theme tbody {
    color: #000;
}
.sk_theme input {
    color: #317ef3;
}
.sk_theme .url {
    color: #38f;
}
.sk_theme .annotation {
    color: #38f;
}

.sk_theme .focused {
    background: #aaa;
}`;

