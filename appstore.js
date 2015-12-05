#!/usr/bin/env osascript -l JavaScript

// Requires assistive access first
// $ brew install tccutil
// $ sudo tccutil -i com.apple.Terminal

var appStore = Application("App Store");
var sys = Application("System Events");
var proc = sys.applicationProcesses.byName("App Store");
var app = proc.windows.byName("App Store");

var _ = {
  forEach: function forEach(array, cb) {
    Array.prototype.forEach.call(array, cb);
  }
};

ObjC.import('stdlib'); // For environment variables
appStore.launch();
delay(10); // prefer some kind of executeWhenAvailable function
appStore.activate();
delay(10);
signIntoAppStore();
delay(20);
gotoPurchasedTab();
delay(10);
installApps('Xcode');
delay(30);
installApps('Dash 3', 'Day One', 'Deckset', 'Degrees Pro', 'Reeder', 'Paw', 'Pixelmator', 'Sip');
delay(10);
Application('Terminal').activate();

function signIntoAppStore () {
  var TAB_KEYCODE = 48;
  var APPLE_ID = 'sscotth@me.com';
  var APPLE_ID_PASSWORD = $.getenv('APPLE_ID_PASSWORD');
  var signInMenuItem = proc.menuBars[0].menuBarItems["Store"].menus["Store"].menuItems["Sign In…"];

  if (signInMenuItem.exists()) {
    signInMenuItem.click();
    delay(5);
    app.sheets.at(0).textFields["Apple ID "].value = APPLE_ID;
    Application("System Events").keyCode(TAB_KEYCODE);
    app.sheets.at(0).textFields["Password"].value = APPLE_ID_PASSWORD;
    app.sheets.at(0).buttons["Sign In"].click()
  }
}

function gotoPurchasedTab () {
  appStore.activate();
  app.toolbars.at(0).groups.at(4).radioButtons.at(0).click();
}

function installApps () {
  var apps = Array.prototype.slice.call(arguments);
  var purchasedAppTable = app.groups[0].groups[0].scrollAreas[0].uiElements[0].tables[0].rows;

  _.forEach(apps, function installApp (appName) {
    var row = purchasedAppTable.whose({
      _or: [
        {
          _match: [
            ObjectSpecifier().uiElements[0].uiElements[0].name, { _beginsWith: appName }
          ]
        },
        {
          _match: [
            ObjectSpecifier().uiElements[0].groups[1].groups[0].uiElements[0].name, { _beginsWith: appName }
          ]
        }
      ]
    });

    var installButton = row.uiElements[3].groups[0].buttons[0];

    appStore.activate();
    installButton.click();
    delay(5);
    // close app incase of reinstall because I can't determine if button is 'Open' or 'Install'
  });
}
