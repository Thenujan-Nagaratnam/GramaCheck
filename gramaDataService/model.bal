public type User record {|
    string nic;
    string address;
|};

public type StatusEntry record {|
    string nic;
    int policeCheckStatus;
    int idCheckStatus;
    int addressCheckStatus;

|};

public type Nic record {|
    string nic;
|};

public type StatusRecord record {|
    int id;
    string user_id;
    int police_check_status;
    int id_check_status;
    int address_check_status;

|};

public type UserDetails record {|
    string name;
    string nic;
    string address;
    string phone_no;
    string grama_devision;
|};
