# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js"
pin "@fortawesome/fontawesome-free", to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.5.2/js/all.js' # @6.5.2
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2"
