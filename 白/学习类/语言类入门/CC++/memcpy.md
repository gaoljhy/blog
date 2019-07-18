# memecpy

## NAME

    memcpy - copy bytes in memory

## SYNOPSIS

 `#include <string.h>`

`void *memcpy(void *restrict s1, const void *restrict s2, size_t n);`

## DESCRIPTION

 1. 标准C库
 2. `memcpy()` 函数应将`s2`指向的对象中的`n`个字节复制到`s1`指向的对象中。
 如果在重叠的对象之间进行复制，则行为未定义

## RETURN VALUE

The memcpy() function shall return s1;

no return value is reserved to indicate an error.

## ERRORS

No errors are defined.

----
The following sections are informative.

## EXAMPLES

None.

## APPLICATION USAGE

The memcpy() function does not check for the overflow of the receiving memory area.
> 不检查内存溢出

## RATIONALE

None.

## FUTURE DIRECTIONS

None.

SEE ALSO

`XBD <string.h>`

## CHANGE HISTORY

First released in Issue 1. Derived from Issue 1 of the SVID.

## Issue 6

The memcpy() prototype is updated for alignment with the ISO/IEC 9899:1999 standard.