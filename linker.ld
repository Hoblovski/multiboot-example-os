OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
	/* No paging. So all address are physical mem.
	 *
	 * Skip the first 1M memory because that's where numerous devices reside.
	 *
	 * Skip the ELF header so the entire kernel elf image can be loaded to
	 * a page-aligned starting address.
	 */
	. = 1M + SIZEOF_HEADERS;

	.text : { *(.text) *(.text.*) }
	.rodata : { *(.rodata) *(.rodata.*) }
	.data : { *(.data) *(.data.*) }
	.bss : { *(.bss) *(.bss.*) *(.comm) *(.comm.*) }
}
