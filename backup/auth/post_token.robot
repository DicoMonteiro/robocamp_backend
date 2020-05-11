*** Settings ***
Library               Collections
Library               RequestsLibrary

*** Test Cases ***
# BDD
Login na API com sucesso
    Dado que o usuário informou suas credenciais de acesso:
    ...        didico@ninjapixel.com    pwd123
    Quando solitado via POST para o serviço /auth
    Então o código de resposta deve ser igual a    200

Login com senha incorreta
    Dado que o usuário informou suas credenciais de acesso:
    ...        didico@ninjapixel.com    abc123
    Quando solitado via POST para o serviço /auth
    Então o código de resposta deve ser igual a    401

Post Auth Token
    Create Session     pixel           http://pixel-api:3333

    # {"email": "didico@ninjapixel.com", "password": "pwd123"}
    # {"Content-Type": "application/json"}

    &{payload}=        Create Dictionary    email=didico@ninjapixel.com    password=pwd123
    &{headers}=        Create Dictionary    Content-Type=application/json

    ${resp}=           Post Request    pixel        /auth    data=${payload}    headers=${headers}


    Status Should Be    200            ${resp}

    Log                 ${resp.text}


Unauthorized
    Create Session     pixel           http://pixel-api:3333

    # {"email": "didico@ninjapixel.com", "password": "pwd123"}
    # {"Content-Type": "application/json"}

    &{payload}=        Create Dictionary    email=didico@ninjapixel.com    password=abc123
    &{headers}=        Create Dictionary    Content-Type=application/json

    ${resp}=           Post Request    pixel        /auth    data=${payload}    headers=${headers}


    Status Should Be    401            ${resp}

    Log                 ${resp.text}


*** Keywords ***
Dado que o usuário informou suas credenciais de acesso:
    [Arguments]    ${email}    ${password}

    &{payload}=        Create Dictionary    email=${email}   password=${password}

    Set Test Variable    ${payload}

Quando solitado via POST para o serviço /auth
    Create Session     pixel           http://pixel-api:3333

    &{headers}=        Create Dictionary    Content-Type=application/json

    ${resp}=           Post Request    pixel        /auth    data=${payload}    headers=${headers}

    Set Test Variable    ${resp}


Então o código de resposta deve ser igual a
    [Arguments]    ${code_status}

    Status Should Be    ${code_status}    ${resp}

    Log                 ${resp.text}