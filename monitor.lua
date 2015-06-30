local requests = ngx.shared.requests_limit; 
local function monitor()
    local key = ngx.var.server_name;     local status = ngx.var.status;
    local list = ngx.shared.requests_counter;
    local banned_statuses = { ['444'] = true, ['408'] = true, ['449'] = true, ['400'] = true };

    local keys = {
        ["a"] = key .. ";all", 
        ["be"] = key .. ";backend", 
        ["bn"] = key .. ";banned",
        ["ajax"] = key .. ";ajax", 
        ["bs"] = key .. ";bytes"
    };

    for _, _key in pairs(keys) do
        local temp_val = list:get(keys[_key]);

        if temp_val == nil then
            list:add(_key, 0);
        end

        --anyone know what will be when "temp_val" reach self limit? Its will be equal to zero?
        if temp_val and temp_val >= 70368744177664 then --math.pow(2, 46) value
            list:set(_key, 0);
        end
    end

    list:incr(keys.a, 1);
  
    if ngx.var.upstream_status ~= nil then
        list:incr(keys.be, 1);
    end

    if banned_statuses[status] then
        list:incr(keys.bn, 1);
    end

    if ngx.header['X-RequestWith'] ~= nil then
        list:incr(keys.ajax, 1);
    end


    if ngx.var.body_bytes_sent ~= nil then
        list:incr(keys.bs, ngx.var.body_bytes_sent);
    end
end

monitor();
