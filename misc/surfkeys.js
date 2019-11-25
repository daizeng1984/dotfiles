mapkey('H', '#4Go back in history', function() {
    history.go(-1);
}, {repeatIgnore: true});
mapkey('L', '#4Go forward in history', function() {
    history.go(1);
}, {repeatIgnore: true});

mapkey('p', '#7Open selected link or link from clipboard', function() {
    if (window.getSelection().toString()) {
        tabOpenLink(window.getSelection().toString());
    } else {
        Clipboard.read(function(response) {
            tabOpenLink(response.data);
        });
    }
});

mapkey('yy', "#7Copy current page's URL", function() {
    Clipboard.write(window.location.href);
});
mapkey('yh', "#7Copy current page's host", function() {
    var url = new URL(window.location.href);
    Clipboard.write(url.host);
});

mapkey('ym', "#7Copy current page's URL as markdown", function() {
    Clipboard.write('[' + document.title + '](' + window.location.href + ')');
});

mapkey(',h', '#1Mouse over elements.', function() {
    Hints.create("", Hints.dispatchMouseClick, {mouseEvents: ["mouseover"]});
});
mapkey(',j', '#1Mouse out elements.', function() {
    Hints.create("", Hints.dispatchMouseClick, {mouseEvents: ["mouseout"]});
});


mapkey('<Ctrl-o>', '#4Go one tab history back', function() {
    RUNTIME("historyTab", {backward: true});
}, {repeatIgnore: true});
mapkey('<Ctrl-i>', '#4Go one tab history forward', function() {
    RUNTIME("historyTab", {backward: false});
}, {repeatIgnore: true});

imap('<Ctrl-w>', '<Alt-w>');
imap('<Ctrl-f>', '<Alt-f>');
imap('<Ctrl-b>', '<Alt-b>');
imap('<Ctrl-n>', '<ArrowDown>');
imap('<Ctrl-p>', '<ArrowUp>');
map('<Ctrl-[>', '<Esc>');
map(',wb', 'T');
map(',wf', 'b');
map('<Ctrl-d>', 'd');
map('<Ctrl-u>', 'u');
map('<Ctrl-h>', 'E');
map('<Ctrl-l>', 'R');

settings.hintAlign = "left";
settings.stealFocusOnLoad = false;
settings.tabsThreshold = 9;
