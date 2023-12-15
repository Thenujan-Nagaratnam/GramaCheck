public type StatusEntry record {|
    string nic;
    int policeCheckStatus;
    int idCheckStatus;
    int addressCheckStatus;
|};

public type Nic record {|
    string nic;
|};

public type GramaDevision record {|
    string gramadevision;
|};

public type StatusRecord record {|
    int id;
    string user_id;
    int police_check_status;
    int id_check_status;
    int address_check_status;
    string account_owner;

|};

public type UserDetails record {|
    string name;
    string id;
    string address;
    string phone_no;
    string gramadevision;
|};

public type StatusDetails record {|
    string name;
    string address;
    string nicNumber;
    string certificateNo;
    int police_check_status;
    int id_check_status;
    int address_check_status;
|};
