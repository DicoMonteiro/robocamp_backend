*** Settings ***
Documentation        Pixel API na rota GET /products 


# Library              RequestsLibrary
# Library              Collections
# Library              OperatingSystem

Resource             ../../resources/services.robot


*** Test Cases ***
List Products
    [tags]    success
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        all_product.json

    Post Product    ${payload}    ${token}    ${endpoint}

    ${resp}=            List All Products    ${token}    ${endpoint}

    Status Should Be    200            ${resp}

    Log                 ${resp.text}


Get Product For Id
    [tags]    success
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        get_unique.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${resp}=            Get Product By Id    ${id_product}    ${token}    ${endpoint}

    Status Should Be    200            ${resp}

    Should Be Equal     ${resp.json()['title']}        ${payload['title']}

    Log                 ${resp.text}


Product Not Found
    [tags]    not_found
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${resp}=            Get Product By Id    99999    ${token}    ${endpoint}

    Status Should Be    404            ${resp}

    Log                 ${resp.text}


Precondition Failed
    [tags]    bad_request
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${resp}=            Get Product By Id    test    ${token}    ${endpoint}

    Status Should Be    412            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        invalid input syntax for type integer: \"test\"

    Dictionary Should Contain Value  ${resp.json()}       invalid input syntax for type integer: \"test\"
