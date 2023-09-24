# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-checkbox-select-all", to: "https://ga.jspm.io/npm:stimulus-checkbox-select-all@5.2.0/dist/stimulus-checkbox-select-all.mjs"
pin "import", to: "https://ga.jspm.io/npm:import@0.0.6/index.js"
pin "stimulus-animated-number", to: "https://ga.jspm.io/npm:stimulus-animated-number@4.1.0/dist/stimulus-animated-number.mjs"
pin "fs", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/fs.js"
pin "path", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/path.js"
