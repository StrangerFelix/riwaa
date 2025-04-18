#include "UniqueID.h"
#include <mbedtls/md5.h>

String UniqueID::generateHashedMAC(const String& macAddress) {
    // const char* mac_cstr = macAddress.c_str();

    // // Create a buffer for the hash (SHA-256 gives a 32-byte hash)
    // unsigned char hash[32];

    // // Perform the SHA-256 hash operation
    // mbedtls_sha256_context sha_ctx;
    // mbedtls_sha256_init(&sha_ctx);
    // mbedtls_sha256_starts(&sha_ctx, 0);  // 0 means use SHA-256, 1 for SHA-224
    // mbedtls_sha256_update(&sha_ctx, (unsigned char*)mac_cstr, strlen(mac_cstr));
    // mbedtls_sha256_finish(&sha_ctx, hash);
    // mbedtls_sha256_free(&sha_ctx);

    // // Convert the hash to a hexadecimal string
    // String hashedMAC = "";
    // for (int i = 0; i < 32; i++) {
    //     char hex[3];
    //     sprintf(hex, "%02x", hash[i]);
    //     hashedMAC += String(hex);
    // }
    // return hashedMAC;

    const char* mac_cstr = macAddress.c_str();

    // Create a buffer for the hash (MD5 gives a 16-byte hash)
    unsigned char hash[16];

    // Perform the MD5 hash operation
    mbedtls_md5_context md5_ctx;
    mbedtls_md5_init(&md5_ctx);
    mbedtls_md5_starts_ret(&md5_ctx); // Use starts_ret instead of starts
    mbedtls_md5_update_ret(&md5_ctx, (unsigned char*)mac_cstr, strlen(mac_cstr)); // Use update_ret
    mbedtls_md5_finish_ret(&md5_ctx, hash); // Use finish_ret
    mbedtls_md5_free(&md5_ctx);

    // Convert the hash to a hexadecimal string
    String hashedMAC = "";
    for (int i = 0; i < 16; i++) {
        char hex[3];
        sprintf(hex, "%02x", hash[i]);
        hashedMAC += String(hex);
    }
    return hashedMAC;
}