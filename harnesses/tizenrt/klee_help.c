    #include "stdbool.h"
    #include <stdint.h>
    #include <stdlib.h>
    #include "tinyara/sched.h"
    #include "tinyara/mm/mm.h"
    #include "macro_all.h"
    #include "klee_help.h"


    int klee_help(void)
    {
        return 0;
    }

    bool up_checkarch(FAR const Elf32_Ehdr *ehdr){
        if (ehdr->e_machine == EM_ARM) {
            return true;
        }
        return false;
    }


        