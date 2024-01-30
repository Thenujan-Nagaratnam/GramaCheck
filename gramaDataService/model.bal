# Description.
#
# + nic - nic of the user who requested the certificate
# + policeCheckStatus - status of the police check  
# + idCheckStatus - status of the identity check  
# + addressCheckStatus - status of the address check
# + accountOwner - nic of the applicant
public type StatusEntry record {|
    string|int nic;
    int policeCheckStatus;
    int idCheckStatus;
    int addressCheckStatus;
    string accountOwner;
|};

# Description.
#
# + id - id of the requested certificate
# + policeCheckStatus - status of the police check  
# + idCheckStatus - status of the identity check  
# + addressCheckStatus - status of the address check
public type UpdateStatusEntry record {|
    int id;
    int policeCheckStatus;
    int idCheckStatus;
    int addressCheckStatus;
|};

# Description.
#
# + nic - nic of the user
public type Nic record {|
    string nic;
|};

# Description.
#
# + gramadevision - grama niladhari devision of the user
public type GramaDevision record {|
    string gramadevision;
|};

# Description.
#
# + id - id of the user 
# + user_id - id of the user who requested the certificate 
# + police_check_status - status of the police check
# + id_check_status - status of the identity check
# + address_check_status - status of the address check
# + account_owner - nic of the applicant
public type StatusRecord record {|
    int id;
    string user_id;
    int police_check_status;
    int id_check_status;
    int address_check_status;
    string account_owner;

|};

# Description.
#
# + name - user's name 
# + id - id of the user  
# + address - user's address  
# + phone_no - user's phone number  
# + gramadevision - user's grama niladhari devision
public type UserDetails record {|
    string name;
    string id;
    string address;
    string phone_no;
    string gramadevision;
|};

# Description.
#
# + name - user's name 
# + address - user's address
# + nicNumber - user's nic number
# + certificateNo - certificate number
# + police_check_status - status of the police check
# + id_check_status - status of the identity check
# + address_check_status - status of the address check
public type StatusDetails1 record {|
    string name;
    string land_id;
    string street_name;
    string nicNumber;
    string certificateNo;
    int police_check_status;
    int id_check_status;
    int address_check_status;
|};

public type StatusDetails2 record {|
    string name;
    string address;
    string nicNumber;
    string certificateNo;
    int police_check_status;
    int id_check_status;
    int address_check_status;
|};
