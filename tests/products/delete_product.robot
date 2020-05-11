*** Settings ***
Documentation        Pixel API na rota Delete /products 


# Library              RequestsLibrary
# Library              Collections
# Library              OperatingSystem

Resource             ../../resources/services.robot


*** Test Cases ***
Remover Product
    [tags]    success
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        delete.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${resp}=            Delete Product    ${id_product}    ${token}    ${endpoint}

    Status Should Be    204            ${resp}


Product Já Removido
    [tags]    not_found
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        delete.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${resp}=            Delete Product    ${id_product}    ${token}    ${endpoint}

    ${resp}=            Delete Product    ${id_product}    ${token}    ${endpoint}

    Status Should Be    204            ${resp}

    Log                 ${resp.text}


Precondition Failed
    [tags]    bad_request
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${resp}=            Delete Product    test   ${token}    ${endpoint}

    Status Should Be    412            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        invalid input syntax for type integer: \"test\"

    Dictionary Should Contain Value  ${resp.json()}       invalid input syntax for type integer: \"test\"