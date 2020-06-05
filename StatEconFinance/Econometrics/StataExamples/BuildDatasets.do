
  * Import main dataset, dropping extra variables
  insheet using CornwellRupert.csv, clear
  drop *b

  * Build main dataset, no demo
  preserve
  drop blk fem
  save Main.dta, replace
  restore

  * Build race dataset
  preserve
  keep id blk
  drop if id <= 50
  duplicates drop
  save Race.dta, replace
  restore

  * Build gender dataset
  preserve
  keep id fem
  duplicates drop
  replace id = id+100 if id > 550
  save Gender.dta, replace
  restore

