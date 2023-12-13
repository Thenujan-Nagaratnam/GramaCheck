const axios = require("axios");

// API endpoint URL
const nicValidationServiceURL =
  "https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/gramacheckidentitycheck/endpoint-25416-e8a/v1.0";

// Sample NIC to check
const sampleNIC = "123456789V";

// NIC Check request payload
const nicCheckRequest = {
  nic: sampleNIC,
};

// Make a POST request to the Ballerina API
axios
  .post(nicValidationServiceURL, nicCheckRequest)
  .then((response) => {
    // Handle the API response
    const isValidNIC = response.data.valid;
    const nic = response.data.nic;

    if (isValidNIC) {
      console.log(`NIC ${nic} is valid!`);
    } else {
      console.log(`NIC ${nic} is not valid.`);
    }
  })
  .catch((error) => {
    // Handle errors
    console.error("Error calling Ballerina API:", error.message);
  });
