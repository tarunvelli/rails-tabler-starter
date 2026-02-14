# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "apexcharts", to: "apexcharts.esm.js"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "jsvectormap", to: "jsvectormap.min.js"
pin "world", to: "maps/world.js"
pin "tabler", to: "tabler.js"
