def filter(event)
        c = event.get("[telemetry][geolocation][gps]")
        if c.is_a? Array
            c.each { |x|
                latitude = x["lat"]
                longitude = x["long"]

                if latitude.is_a? Array
                    lat = latitude[latitude.size - 1].to_f
                    long = longitude[longitude.size -1].to_f
                    event.set("Geolocation", [long,lat])
                else
                    lat = latitude.to_f
                    long = longitude.to_f
                    event.set("Geolocation", [long,lat])
                end
            }
        end

        # a = event.get("[telemetry][flux]")
        # if a.is_a? Array
        #    arrayResp = Array.new
        #    a.each{ |x|
        #         operation = x["operation"]
        #         if operation.is_a? Array
        #             operation.each { |e|
        #                 fluxType = e["flux_type"]
        #                 response = e["response"]

        #                 if response == 0
        #                     arrayResp << ["#{fluxType} : #{response}"]
        #                 end
        #             }
        #         end
        #    }
        #    event.set("successOperation", arrayResp)
        # end

        b = event.get("[telemetry][flux]")
        if b.is_a? Array
            b.each{ |x|
                time = x["flux_start"]

                event.set("flux_start_timestamp", time)
            }
        end

        return [event]
    end