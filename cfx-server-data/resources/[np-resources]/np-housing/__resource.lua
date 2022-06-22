





resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

files {
    "html/index.html",
    "html/scripts.js",
    "html/css/style.css",
}

client_script 'client/*.lua'
server_script 'server/*.lua'
server_script '@mysql-async/lib/MySQL.lua'

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}

-- By aleks working housing fully :)