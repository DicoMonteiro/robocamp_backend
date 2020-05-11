*** Settings ***
Documentation        Testes da rota /auth da Pixel API


# Library              RequestsLibrary
# Library              Collections

Resource             ../../resources/services.robot


*** Test Cases ***
Request Token
    # Create Session      pixel           http://pixel-api:3333

    ${endpoint}=           New Session

    # &{payload}=         Create Dictionary    email=didico@ninjapixel.com    password=pwd123
    # &{headers}=         Create Dictionary    Content-Type=application/json

    # ${resp}=            Post Request    pixel        /auth    data=${payload}    headers=${headers}

    ${resp}=            Post Token    didico@ninjapixel.com    pwd123    ${endpoint}

    Status Should Be    200            ${resp}

    Log                 ${resp.text}


Incorrect password
    # Create Session      pixel           http://pixel-api:3333

    ${endpoint}=           New Session

    # &{payload}=         Create Dictionary    email=didico@ninjapixel.com    password=abc123
    # &{headers}=         Create Dictionary    Content-Type=application/json

    # ${resp}=            Post Request    pixel        /auth    data=${payload}    headers=${headers}

    ${resp}=            Post Token    didico@ninjapixel.com    abc123    ${endpoint}

    Status Should Be    401            ${resp}

    Log                 ${resp.text}


Incorrect email
    # Create Session      pixel           http://pixel-api:3333

    ${endpoint}=           New Session

    # &{payload}=         Create Dictionary    email=test@ninjapixel.com    password=pwd123
    # &{headers}=         Create Dictionary    Content-Type=application/json

    # ${resp}=            Post Request    pixel        /auth    data=${payload}    headers=${headers}

    ${resp}=            Post Token    test@ninjapixel.com    pwd123    ${endpoint}

    Status Should Be    401            ${resp}

    Log                 ${resp.text}