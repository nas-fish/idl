namespace go nas_fish

struct SignUpReq {
    1: required string email
}

struct SignUpResp {
    1: required i64 id
}

service NasFish{
    SignUpResp SignUp(1: SignUpReq req)
}
