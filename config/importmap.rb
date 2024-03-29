# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "side_menu", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
