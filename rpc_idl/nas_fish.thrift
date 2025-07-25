namespace go nas_fish

struct SignUpReq {
}

struct SignUpResp {
    1: required i64 id11
}

service NasFish{
    SignUpResp SignUp(1: SignUpReq req)
}
