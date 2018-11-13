def open_asset(file)
  File.open(Rails.root.join('db', 'seed_assets', file))
end