json.values do
  json.array!(@data) do |item|
    json.color item[:color]
    json.label I18n.t("admin.dashboard.statistics.#{item[:name]}")
    json.data do
      json.array!(item[:values]) do |value|
        json.array!(value)
      end
    end
  end
end

json.options do 
  json.xaxis do
    json.mode "time"
    json.timeformat "%d.%m.%Y"
  end

  json.series do
    json.lines do 
      json.show true
    end
    json.points do 
      json.show true
    end
  end
end