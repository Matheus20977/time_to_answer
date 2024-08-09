# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "jquery.js", preload: true
pin "bootstrap", to: "bootstrap.min.js"
pin "@popperjs/core", to: "popper.js", preload: true
pin "jquery-easing", to: "jquery.easing.js", preload: true
pin "sb-admin-2"
pin "jquery-bootstrap-growl", to: "jquery.bootstrap-growl.min.js"
pin "@nathanvda/cocoon", to: "@nathanvda--cocoon.js" # @1.2.14
