// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { tabler } from "@tabler/core"
import * as jsVectorMap from "jsvectormap"
import * as world from "world"
import * as bootstrap from "bootstrap"
import ApexCharts from "apexcharts"

window.tabler = tabler
window.ApexCharts = ApexCharts

Turbo.session.drive = false