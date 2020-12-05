#ifndef SSOEM_H_
#define SSOEM_H_

#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <stdlib.h>

#include "ethercat.h"


void ssoem_init(char *ifname);
void ssoem_fini();
int ssoem_get_slave_count();

char *ssoem_get_slave_name_ptr(int slave);
uint16 ssoem_get_slave_obits(int slave);
uint32 ssoem_get_slave_obytes(int slave);
uint8 *ssoem_get_outputs_ptr(int slave);
uint8 ssoem_get_ostartbit(int slave);
uint16 ssoem_get_slave_ibits(int slave);
uint32 ssoem_get_slave_ibytes(int slave);
uint8 *ssoem_get_inputs_ptr(int slave);
uint8 ssoem_get_istartbit(int slave);

#endif // SSOEM_H_