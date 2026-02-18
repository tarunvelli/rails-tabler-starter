// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { tabler, bootstrap } from "@tabler/core"
import * as jsVectorMap from "jsvectormap"
import * as world from "world"
import ApexCharts from "apexcharts"

window.tabler = tabler
window.bootstrap = bootstrap
window.ApexCharts = ApexCharts

Turbo.session.drive = false