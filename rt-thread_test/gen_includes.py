import os


includes = """+-build/kernel/components/lwp/lwp_syscall.o
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_syscall.c
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/libc_musl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_internal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_ipc_internal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_sys_socket.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/posix/ipc/mqueue.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/syscall_generic.h
  +-board/board.h   
  +-/home/xinhuishao/open-source-projects/rt-thread/components/dfs/dfs_v2/include/dfs_dentry.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/dfs/dfs_v2/include/dfs_file.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/posix/io/eventfd/eventfd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/musl/fcntl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/arch/risc-v/rv64/lwp_arch.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_user_mm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/mm_aspace.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/netdev/include/netdev.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/netdev/include/netdev_ipaddr.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/posix/io/poll/poll.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtdbg.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rthw.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtthread.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/sal/include/sal_netdb.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/sal/include/sal_socket.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/ioctl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/select.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/sal/include/socket/sys_socket/sys/socket.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/statfs.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/utsname.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/unistd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_mm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/signal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/drv_uart.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/common64/tick.h
  +-rtconfig.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/dfs/dfs_v2/include/dfs_fs.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/dfs/dfs_v2/include/dfs.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_arch_comm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/mm_fault.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/mm_page.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/common64/mmu.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/avl_adpt.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/mm_flag.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/t-head/c906/cache.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/common64/cpuport.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtdef.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/finsh/finsh.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtatomic.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtklibc.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtservice.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/netdev/include/arpa/inet.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/time.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/net/sal/include/sal_tls.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/sys/unistd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_args.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_avl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_ipc.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_pid.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_shm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_signal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/lwp_syscall.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/lwp/page.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/libraries/mmio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/libraries/cv181x/pinctrl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/rtdevice.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/libc/compilers/common/include/dirent.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/common64/riscv.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/t-head/c906/riscv_mmu.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/utilities/libadt/avl/avl.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/t-head/c906/opcode.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtcompiler.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/klibc/kerrno.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rtsched.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/rttypes.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/klibc/kstdio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/include/klibc/kstring.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/libraries/types.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/libraries/cv181x/cv181x_pinlist_swconfig.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/libraries/cv181x/cv181x_reg_fmux_gpio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/bsp/cvitek/drivers/drv_ioremap.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/adc.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ahci.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/blk.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/clk.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/dm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/numa.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/power_domain.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/cputime.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/crypto.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dac.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_alarm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_audio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_can.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_i2c.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_i2c_bit_ops.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_i2c_dm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_mmcsd_core.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_pin.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_pwm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_rtc.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_sd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_sdio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_serial.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_serial_v2.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_spi.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_touch.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dev_watchdog.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/dma.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/hwtimer.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/iio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/lcd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/led.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mailbox.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mtd_nand.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mtd_nor.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/nvme.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ofw.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ofw_fdt.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ofw_io.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ofw_irq.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/ofw_raw.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pci.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pci_endpoint.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pci_msi.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/phy.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/phye.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pic.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/platform.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pm.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/pulse_encoder.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/regulator.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/reset.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/rt_dev_bus.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/rt_inputcapture.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/scsi.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/sensor.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/sensor_v2.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/serial_bypass.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/syscon.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/thermal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/usb_device.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/usb_host.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/wlan.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/completion.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/condvar.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/dataqueue.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/pipe.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/poll.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/ringblk_buf.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/ringbuffer.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/waitqueue.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/ipc/workqueue.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/classes/block.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/classes/char.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/classes/graphic.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/classes/mtd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/classes/net.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/bus.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/driver.h
  +-/home/xinhuishao/open-source-projects/rt-thread/libcpu/risc-v/common64/encoding.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/mm/ioremap.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/misc.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/utilities/libadt/ref/ref.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/utilities/libadt/bitmap/bitmap.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/byteorder.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/core/master_id.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/cputimer.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mmcsd_card.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mmcsd_cmd.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/mmcsd_host.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/sdio_func_ids.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/pci/pci_ids.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/pci/pci_regs.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/phy/general_phy.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/phy/mdio.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/phy/ofw.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/lptimer.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/dt-bindings/thermal/thermal.h
  +-/home/xinhuishao/open-source-projects/rt-thread/components/drivers/include/drivers/usb_common.h
"""

# 你的RT-Thread根目录（用于替换为$(RTT_ROOT)，可选）
RTT_ROOT = '/home/xinhuishao/open-source-projects/rt-thread'

include_dirs = set()

for line in includes.splitlines():
    line = line.strip()
    if not line or not line.startswith('+'):
        continue
    path = line.lstrip('+-').strip()
    if not path.endswith('.h'):
        continue
    dir_path = os.path.dirname(path)
    if dir_path:
        # 替换为变量（可选）
        if dir_path.startswith(RTT_ROOT):
            dir_path = dir_path.replace(RTT_ROOT, '$(RTT_ROOT)')
        include_dirs.add(dir_path)

for d in sorted(include_dirs):
    print(f'-I{d} \\')
