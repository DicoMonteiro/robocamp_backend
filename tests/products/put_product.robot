*** Settings ***
Documentation        Pixel API na rota PUT /products 

Resource             ../../resources/services.robot


*** Test Cases ***
Update Of Product
    [tags]    success
    
    ${endpoint}=        New Session

    ${token}=           Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${payload}=         Get Json        update.json

    ${resp}=            Update Product    ${id_product}    ${payload}    ${token}    ${endpoint}

    Status Should Be    204            ${resp}

    Log                 ${resp.text}


Put Required Title
    [tags]    bad_request

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${payload}=         Get Json        no_title.json

    ${resp}=            Update Product    ${id_product}    ${payload}    ${token}    ${endpoint}

    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        Oops! title cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! title cannot be empty


Put Required Category
    [tags]    bad_request

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${payload}=         Get Json        no_category.json

    ${resp}=            Update Product    ${id_product}    ${payload}    ${token}    ${endpoint}

    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        Oops! category cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! category cannot be empty


Put Required Price
    [tags]    bad_request

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${payload}=         Get Json        no_price.json

    ${resp}=            Update Product    ${id_product}    ${payload}    ${token}    ${endpoint}

    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        Oops! price cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! price cannot be empty


Put Not Foun
    [tags]    not_found

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        update.json

    ${resp}=            Update Product    9999    ${payload}    ${token}    ${endpoint}

    Status Should Be    204            ${resp}

    Log                 ${resp.text}



Put Duplicated Productct
    [tags]    conflict
    
    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}

    ${payload}=         Get Json        duplicated.json

    Update Product Duplicated    ${id_product}    ${payload}    ${token}    ${endpoint}

    
    ${payload}=         Get Json        post.json

    ${product}=         Post Product    ${payload}    ${token}    ${endpoint}

    ${id_product}=      Convert To String    ${product.json()['id']}
 
    ${payload}=         Get Json        update_duplicated.json

    ${resp}=            Update Product Duplicated   ${id_product}    ${payload}    ${token}    ${endpoint}    

    Status Should Be    409            ${resp}

    Log                 ${resp.text}

    Should Be Equal     ${resp.json()['msg']}        title must be unique

    Dictionary Should Contain Value  ${resp.json()}       title must be unique
