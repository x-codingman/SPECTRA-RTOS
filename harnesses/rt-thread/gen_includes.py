import os
from pathlib import Path

_RTT_ABS = (Path(__file__).resolve().parents[2] / "test-rtos" / "rt-thread").resolve()


includes_raw = """+-build/kernel/components/lwp/lwp_syscall.o
  +-${RTT_TREE}/components/lwp/lwp_syscall.c
  +-${RTT_TREE}/components/lwp/libc_musl.h
  +-${RTT_TREE}/components/lwp/lwp_internal.h
  +-${RTT_TREE}/components/lwp/lwp_ipc_internal.h
  +-${RTT_TREE}/components/lwp/lwp_sys_socket.h
  +-${RTT_TREE}/components/libc/posix/ipc/mqueue.h
  +-${RTT_TREE}/components/lwp/syscall_generic.h
  +-board/board.h   
  +-${RTT_TREE}/components/dfs/dfs_v2/include/dfs_dentry.h
  +-${RTT_TREE}/components/dfs/dfs_v2/include/dfs_file.h
  +-${RTT_TREE}/components/libc/posix/io/eventfd/eventfd.h
  +-${RTT_TREE}/components/libc/compilers/musl/fcntl.h
  +-${RTT_TREE}/components/lwp/arch/risc-v/rv64/lwp_arch.h
  +-${RTT_TREE}/components/lwp/lwp_user_mm.h
  +-${RTT_TREE}/components/mm/mm_aspace.h
  +-${RTT_TREE}/components/net/netdev/include/netdev.h
  +-${RTT_TREE}/components/net/netdev/include/netdev_ipaddr.h
  +-${RTT_TREE}/components/libc/posix/io/poll/poll.h
  +-${RTT_TREE}/include/rtdbg.h
  +-${RTT_TREE}/include/rthw.h
  +-${RTT_TREE}/include/rtthread.h
  +-${RTT_TREE}/components/net/sal/include/sal_netdb.h
  +-${RTT_TREE}/components/net/sal/include/sal_socket.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/ioctl.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/select.h
  +-${RTT_TREE}/components/net/sal/include/socket/sys_socket/sys/socket.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/statfs.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/utsname.h
  +-${RTT_TREE}/components/libc/compilers/common/include/unistd.h
  +-${RTT_TREE}/components/lwp/lwp.h
  +-${RTT_TREE}/components/lwp/lwp_mm.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/signal.h
  +-${RTT_TREE}/bsp/cvitek/drivers/drv_uart.h
  +-${RTT_TREE}/libcpu/risc-v/common64/tick.h
  +-rtconfig.h
  +-${RTT_TREE}/components/dfs/dfs_v2/include/dfs_fs.h
  +-${RTT_TREE}/components/dfs/dfs_v2/include/dfs.h
  +-${RTT_TREE}/components/lwp/lwp_arch_comm.h
  +-${RTT_TREE}/components/mm/mm_fault.h
  +-${RTT_TREE}/components/mm/mm_page.h
  +-${RTT_TREE}/libcpu/risc-v/common64/mmu.h
  +-${RTT_TREE}/components/mm/avl_adpt.h
  +-${RTT_TREE}/components/mm/mm_flag.h
  +-${RTT_TREE}/libcpu/risc-v/t-head/c906/cache.h
  +-${RTT_TREE}/libcpu/risc-v/common64/cpuport.h
  +-${RTT_TREE}/include/rtdef.h
  +-${RTT_TREE}/components/finsh/finsh.h
  +-${RTT_TREE}/include/rtatomic.h
  +-${RTT_TREE}/include/rtklibc.h
  +-${RTT_TREE}/include/rtm.h
  +-${RTT_TREE}/include/rtservice.h
  +-${RTT_TREE}/components/net/netdev/include/arpa/inet.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/time.h
  +-${RTT_TREE}/components/net/sal/include/sal_tls.h
  +-${RTT_TREE}/components/libc/compilers/common/include/sys/unistd.h
  +-${RTT_TREE}/components/lwp/lwp_args.h
  +-${RTT_TREE}/components/lwp/lwp_avl.h
  +-${RTT_TREE}/components/lwp/lwp_ipc.h
  +-${RTT_TREE}/components/lwp/lwp_pid.h
  +-${RTT_TREE}/components/lwp/lwp_shm.h
  +-${RTT_TREE}/components/lwp/lwp_signal.h
  +-${RTT_TREE}/components/lwp/lwp_syscall.h
  +-${RTT_TREE}/components/lwp/page.h
  +-${RTT_TREE}/bsp/cvitek/drivers/libraries/mmio.h
  +-${RTT_TREE}/bsp/cvitek/drivers/libraries/cv181x/pinctrl.h
  +-${RTT_TREE}/components/drivers/include/rtdevice.h
  +-${RTT_TREE}/components/libc/compilers/common/include/dirent.h
  +-${RTT_TREE}/libcpu/risc-v/common64/riscv.h
  +-${RTT_TREE}/libcpu/risc-v/t-head/c906/riscv_mmu.h
  +-${RTT_TREE}/components/utilities/libadt/avl/avl.h
  +-${RTT_TREE}/libcpu/risc-v/t-head/c906/opcode.h
  +-${RTT_TREE}/include/rtcompiler.h
  +-${RTT_TREE}/include/klibc/kerrno.h
  +-${RTT_TREE}/include/rtsched.h
  +-${RTT_TREE}/include/rttypes.h
  +-${RTT_TREE}/include/klibc/kstdio.h
  +-${RTT_TREE}/include/klibc/kstring.h
  +-${RTT_TREE}/bsp/cvitek/drivers/libraries/types.h
  +-${RTT_TREE}/bsp/cvitek/drivers/libraries/cv181x/cv181x_pinlist_swconfig.h
  +-${RTT_TREE}/bsp/cvitek/drivers/libraries/cv181x/cv181x_reg_fmux_gpio.h
  +-${RTT_TREE}/bsp/cvitek/drivers/drv_ioremap.h
  +-${RTT_TREE}/components/drivers/include/drivers/adc.h
  +-${RTT_TREE}/components/drivers/include/drivers/ahci.h
  +-${RTT_TREE}/components/drivers/include/drivers/blk.h
  +-${RTT_TREE}/components/drivers/include/drivers/clk.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/dm.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/numa.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/power_domain.h
  +-${RTT_TREE}/components/drivers/include/drivers/cputime.h
  +-${RTT_TREE}/components/drivers/include/drivers/crypto.h
  +-${RTT_TREE}/components/drivers/include/drivers/dac.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_alarm.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_audio.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_can.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_i2c.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_i2c_bit_ops.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_i2c_dm.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_mmcsd_core.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_pin.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_pwm.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_rtc.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_sd.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_sdio.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_serial.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_serial_v2.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_spi.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_touch.h
  +-${RTT_TREE}/components/drivers/include/drivers/dev_watchdog.h
  +-${RTT_TREE}/components/drivers/include/drivers/dma.h
  +-${RTT_TREE}/components/drivers/include/drivers/hwtimer.h
  +-${RTT_TREE}/components/drivers/include/drivers/iio.h
  +-${RTT_TREE}/components/drivers/include/drivers/lcd.h
  +-${RTT_TREE}/components/drivers/include/drivers/led.h
  +-${RTT_TREE}/components/drivers/include/drivers/mailbox.h
  +-${RTT_TREE}/components/drivers/include/drivers/mtd_nand.h
  +-${RTT_TREE}/components/drivers/include/drivers/mtd_nor.h
  +-${RTT_TREE}/components/drivers/include/drivers/nvme.h
  +-${RTT_TREE}/components/drivers/include/drivers/ofw.h
  +-${RTT_TREE}/components/drivers/include/drivers/ofw_fdt.h
  +-${RTT_TREE}/components/drivers/include/drivers/ofw_io.h
  +-${RTT_TREE}/components/drivers/include/drivers/ofw_irq.h
  +-${RTT_TREE}/components/drivers/include/drivers/ofw_raw.h
  +-${RTT_TREE}/components/drivers/include/drivers/pci.h
  +-${RTT_TREE}/components/drivers/include/drivers/pci_endpoint.h
  +-${RTT_TREE}/components/drivers/include/drivers/pci_msi.h
  +-${RTT_TREE}/components/drivers/include/drivers/phy.h
  +-${RTT_TREE}/components/drivers/include/drivers/phye.h
  +-${RTT_TREE}/components/drivers/include/drivers/pic.h
  +-${RTT_TREE}/components/drivers/include/drivers/platform.h
  +-${RTT_TREE}/components/drivers/include/drivers/pm.h
  +-${RTT_TREE}/components/drivers/include/drivers/pulse_encoder.h
  +-${RTT_TREE}/components/drivers/include/drivers/regulator.h
  +-${RTT_TREE}/components/drivers/include/drivers/reset.h
  +-${RTT_TREE}/components/drivers/include/drivers/rt_dev_bus.h
  +-${RTT_TREE}/components/drivers/include/drivers/rt_inputcapture.h
  +-${RTT_TREE}/components/drivers/include/drivers/scsi.h
  +-${RTT_TREE}/components/drivers/include/drivers/sensor.h
  +-${RTT_TREE}/components/drivers/include/drivers/sensor_v2.h
  +-${RTT_TREE}/components/drivers/include/drivers/serial_bypass.h
  +-${RTT_TREE}/components/drivers/include/drivers/syscon.h
  +-${RTT_TREE}/components/drivers/include/drivers/thermal.h
  +-${RTT_TREE}/components/drivers/include/drivers/usb_device.h
  +-${RTT_TREE}/components/drivers/include/drivers/usb_host.h
  +-${RTT_TREE}/components/drivers/include/drivers/wlan.h
  +-${RTT_TREE}/components/drivers/include/ipc/completion.h
  +-${RTT_TREE}/components/drivers/include/ipc/condvar.h
  +-${RTT_TREE}/components/drivers/include/ipc/dataqueue.h
  +-${RTT_TREE}/components/drivers/include/ipc/pipe.h
  +-${RTT_TREE}/components/drivers/include/ipc/poll.h
  +-${RTT_TREE}/components/drivers/include/ipc/ringblk_buf.h
  +-${RTT_TREE}/components/drivers/include/ipc/ringbuffer.h
  +-${RTT_TREE}/components/drivers/include/ipc/waitqueue.h
  +-${RTT_TREE}/components/drivers/include/ipc/workqueue.h
  +-${RTT_TREE}/components/drivers/include/drivers/classes/block.h
  +-${RTT_TREE}/components/drivers/include/drivers/classes/char.h
  +-${RTT_TREE}/components/drivers/include/drivers/classes/graphic.h
  +-${RTT_TREE}/components/drivers/include/drivers/classes/mtd.h
  +-${RTT_TREE}/components/drivers/include/drivers/classes/net.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/bus.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/driver.h
  +-${RTT_TREE}/libcpu/risc-v/common64/encoding.h
  +-${RTT_TREE}/components/mm/ioremap.h
  +-${RTT_TREE}/components/drivers/include/drivers/misc.h
  +-${RTT_TREE}/components/utilities/libadt/ref/ref.h
  +-${RTT_TREE}/components/utilities/libadt/bitmap/bitmap.h
  +-${RTT_TREE}/components/drivers/include/drivers/byteorder.h
  +-${RTT_TREE}/components/drivers/include/drivers/core/master_id.h
  +-${RTT_TREE}/components/drivers/include/drivers/cputimer.h
  +-${RTT_TREE}/components/drivers/include/drivers/mmcsd_card.h
  +-${RTT_TREE}/components/drivers/include/drivers/mmcsd_cmd.h
  +-${RTT_TREE}/components/drivers/include/drivers/mmcsd_host.h
  +-${RTT_TREE}/components/drivers/include/drivers/sdio_func_ids.h
  +-${RTT_TREE}/components/drivers/pci/pci_ids.h
  +-${RTT_TREE}/components/drivers/pci/pci_regs.h
  +-${RTT_TREE}/components/drivers/phy/general_phy.h
  +-${RTT_TREE}/components/drivers/phy/mdio.h
  +-${RTT_TREE}/components/drivers/phy/ofw.h
  +-${RTT_TREE}/components/drivers/include/drivers/lptimer.h
  +-${RTT_TREE}/components/drivers/include/dt-bindings/thermal/thermal.h
  +-${RTT_TREE}/components/drivers/include/drivers/usb_common.h
"""

includes = includes_raw.replace("${RTT_TREE}", str(_RTT_ABS))
RTT_ROOT = str(_RTT_ABS)

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
        if dir_path.startswith(RTT_ROOT):
            dir_path = dir_path.replace(RTT_ROOT, '$(RTT_ROOT)')
        include_dirs.add(dir_path)

for d in sorted(include_dirs):
    print(f'-I{d} \\')
