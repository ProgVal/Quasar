AS = nasm

all: disk.img

disk.img: bootloader/loader stage1/stage1.bin stage2/stage2.bin writeloader/writeloader
	./diskmaker.sh bootloader/loader stage1/stage1.bin stage2/stage2.bin disk.img

writeloader/writeloader:
	make -C writeloader/

stage1/stage1.bin:
	make -C stage1/

bootloader/loader:
	make -C bootloader/

runqemu: disk.img
	qemu-system-i386 -monitor stdio -boot a -hda disk.img

clean:
	make -C writeloader/ clean
	make -C bootloader/ clean
	make -C stage1/ clean
	rm disk.img