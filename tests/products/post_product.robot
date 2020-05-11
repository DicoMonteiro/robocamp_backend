*** Settings ***
Documentation        Pixel API na rota POST /products 


# Library              RequestsLibrary
# Library              Collections
# Library              OperatingSystem

Resource             ../../resources/services.robot


*** Test Cases ***
Create New Product
    [tags]    success
    
    ${endpoint}=           New Session

    # Create Session      pixel           http://pixel-api:3333

    # &{payload}=         Create Dictionary    email=didico@ninjapixel.com    password=pwd123
    # &{headers}=         Create Dictionary    Content-Type=application/json

    # ${resp}=            Post Request    pixel        /auth    data=${payload}    headers=${headers}

    # # Log To Console      ${resp.json()['token']}

    # ${token}            Convert To String    ${resp.json()['token']}

    # Log To Console      ${token}

    # {
    #   "title": "Donkey Kong Contry",
    #   "category": "Super Nintendo",
    #   "producers": ["Nintendo", "Rare"], 
    #   "price": "199.99", 
    #   "description": "É pura diversão com este clássico de plataforma 2D.",
    #   "cover": "donkey-kong.jpg"
    # }

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    # ${file}=            Get File             ${EXECDIR}/resources/fixtures/dk.json
    # ${payload}=         evaluate             json.loads($file)    json


    # Remove Product By Name        ${payload['title']}

    # &{headers}=         Create Dictionary    Content-Type=application/json    Authorization=JWT ${token}

    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}

    ${payload}=         Get Json        post.json

    ${resp}=            Post Product    ${payload}    ${token}    ${endpoint}

    # ${resp}=         Post Product    dk.json    ${token}    ${endpoint}

    Status Should Be    200            ${resp}

    Log                 ${resp.text}


Post Required Title
    [tags]    bad_request

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    # ${file}=            Get File             ${EXECDIR}/resources/fixtures/no_title.json
    # ${payload}=         evaluate             json.loads($file)    json

    # Remove Product By Name        ${payload['title']}

    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}

    # ${resp}=        Post Product    no_title.json    ${token}    ${endpoint}

    ${payload}=         Get Json        no_title.json 

    ${resp}=            Post Product    ${payload}    ${token}    ${endpoint}


    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    # Should Be Equal     ${resp.json()['msg']}        Oops! title cannot be empty

    # Dictionary Should Contain Value  ${resp.json()}       Oops! title cannot be empty

    # Dictionary Should Contain Value  ${resp['msg']}       Oops! title cannot be empty

    Should Be Equal     ${resp.json()['msg']}        Oops! title cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! title cannot be empty


Post Required Category
    [tags]    bad_request

    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    # ${file}=            Get File             ${EXECDIR}/resources/fixtures/no_category.json
    # ${payload}=         evaluate             json.loads($file)    json

    # Remove Product By Name        ${payload['title']}

    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}

    # ${resp}=        Post Product    no_category.json    ${token}    ${endpoint}

    ${payload}=         Get Json        no_category.json 

    ${resp}=            Post Product    ${payload}    ${token}    ${endpoint}

    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    # Should Be Equal     ${resp.json()['msg']}        Oops! category cannot be empty

    # Dictionary Should Contain Value    ${resp.json()}       Oops! category cannot be empty

    Should Be Equal     ${resp.json()['msg']}        Oops! category cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! category cannot be empty



Post Required Price
    [tags]    bad_request
    
    ${endpoint}=           New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    # ${file}=            Get File             ${EXECDIR}/resources/fixtures/no_price.json
    # ${payload}=         evaluate             json.loads($file)    json

    # Remove Product By Name        ${payload['title']}

    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}

    # ${resp}=        Post Product    no_price.json    ${token}    ${endpoint}

    ${payload}=         Get Json        no_price.json 

    ${resp}=            Post Product    ${payload}    ${token}    ${endpoint}


    Status Should Be    400            ${resp}

    Log                 ${resp.text}

    # Should Be Equal     ${resp.json()['msg']}        Oops! price cannot be empty

    # Dictionary Should Contain Value  ${resp.json()}       Oops! price cannot be empty

    Should Be Equal     ${resp.json()['msg']}        Oops! price cannot be empty

    Dictionary Should Contain Value  ${resp.json()}       Oops! price cannot be empty



Post Duplicated Product
    [tags]    conflict

    ${endpoint}=      New Session

    ${token}=         Get Auth Token    didico@ninjapixel.com    pwd123    ${endpoint}

    # ${file}=            Get File             ${EXECDIR}/resources/fixtures/dk.json
    # ${payload}=         evaluate             json.loads($file)    json

    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}
    
    # ${resp}=            Post Request    pixel        /products    data=${payload}    headers=${headers}

    # ${resp}=        Post Product          duplicated.json    ${token}    ${endpoint}

    # ${resp}=        Product Duplicated    duplicated.json    ${token}    ${endpoint}


    ${payload}=         Get Json        duplicated.json 

    ${resp}=            Post Product    ${payload}    ${token}    ${endpoint}

    # ${payload}=         Get Json        duplicated.json

    ${resp}=            Product Duplicated    ${payload}   ${token}    ${endpoint}


    Status Should Be    409            ${resp}

    Log                 ${resp.text}

    # Should Be Equal     ${resp.json()['msg']}        title must be unique

    # Dictionary Should Contain Value  ${resp.json()}       title must be unique

    Should Be Equal     ${resp.json()['msg']}        title must be unique

    Dictionary Should Contain Value  ${resp.json()}       title must be unique

