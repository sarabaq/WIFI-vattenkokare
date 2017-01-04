wifi.setmode(wifi.STATION)
wifi.sta.config("KaffeServer","kokakaffe") --TN_24GHz_CB0419 --84FD15B6D9
print(wifi.sta.getip())
D0 = 0
D1 = 1
D2 = 2


gpio.mode(D0, gpio.OUTPUT)
gpio.mode(D1, gpio.OUTPUT)
gpio.mode(D2, gpio.OUTPUT)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end

        buf = buf.."<!DOCTYPE html>";
        buf = buf.."<html>";
        buf = buf.."<head>";
        buf = buf.."<title>IoT Server</title>";
        buf = buf.."<meta charset='utf-8'>";
        buf = buf.."<meta name='viewport' content='width=device-width, initial-scale=1'>";
        buf = buf.."<link rel=\"stylesheet\" type=\"text/css\" href=\"ftp://10.0.0.1/sdcard/kaffe/bootstrap.min.css\">";
        buf = buf.."<link rel=\"stylesheet\" type=\"text/css\" href=\"ftp://10.0.0.1/sdcard/kaffe/style.css\">";
        buf = buf.."<script src=\"ftp://10.0.0.1/sdcard/kaffe/jquery.min.js\"></script>";
        buf = buf.."<script src=\"ftp://10.0.0.1/sdcard/kaffe/bootstrap.min.js\"></script>";
        buf = buf.."<script src=\"ftp://10.0.0.1/sdcard/kaffe/main.js\"></script>";
        buf = buf.."</head><body>";
        buf = buf.."<h1>Wifi Vattenkokare </h1>";
        buf = buf.."<p>";
        buf = buf.."<label class=\"switch\">";
        buf = buf.."<input class='switch-input' type='checkbox' onclick='handleCooking()' />";
        buf = buf.."<span class=\"switch-label\" id=\"off\" data-on=\"On\" data-off=\"Off\"></span>"; 
        buf = buf.."<span class=\"switch-handle\"></span>"; 
        buf = buf.."</label></p>";
        buf = buf.."</body></html>";


        
        local _on,_off = "",""
        if(_GET.pin == "ON0")then
              gpio.write(D0, gpio.HIGH);
        elseif(_GET.pin == "OFF0")then
              gpio.write(D0, gpio.LOW);
              
        elseif(_GET.pin == "ON1")then
              gpio.write(D1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
              gpio.write(D1, gpio.LOW);

              

        
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
