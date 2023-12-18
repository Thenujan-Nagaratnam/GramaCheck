# Represents an SMS message with sender, recipient, and message content.
# This record type is used to structure the data for sending SMS messages.
#
# + fromMobile - The mobile number from which the SMS is sent.
# + toMobile - The mobile number to which the SMS is sent.
# + message - The content of the SMS message.
#
# Example:
# Message msg = {fromMobile: "+14155238886", toMobile: "+14155552671", message: "Hello, World!"};
type Message record {
    string fromMobile;
    string toMobile;
    string message;
};
