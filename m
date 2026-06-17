Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876247D929
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716300; cv=none; b=pxP2piJYolveIx5p8VL6yFr8dQ1pzFp7b1WTbb84BUFuf1YHVpG8Uow28UOxzCfSMdQMVk1x+xWEUgtrPbnopE0iY00XpZQk3fHMWjpJZj+cPUi5VI5PCdGBrU+CdvnZunaB1FuYizSwggh52UHshiq4oRlPs0jU3JeVmZ9USBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716300; c=relaxed/simple;
	bh=JkzK4trGdpzV5L/eneBjl0GXfvCfdwXN7BCUu2KSkmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln0ebYSo5q5vXmJIPoHuMUCjyykfTLNjGrlWcWFGw659VM86kW34/IubfZ9Uyd8sGnAz3uGr9EXr05D1BYu8VdGr+3n2Ttm5bvgKjHFyMxBQn4OxWB6yOYYXNo+y3Ldod04DAzcS3k4iK7iFP2jhN4RPz5+PqMyXb8SZXZjGuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJUjcT1P; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJUjcT1P"
Message-ID: <4053c9bb-6229-438c-8c14-917909c1618f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781716293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaRlgF/QVoHCk+eQREzwVPali2hUiPSazVjirraXCdc=;
	b=lJUjcT1P05a9OFceOOufQ2n5a5FG3sNnDD66wtvWtXMBDDfXCUPnQ6wet0kCqBHpXEZ+FP
	Kv9AlpatXc5cb8AW6QI1xZHPuRpoQTp6kLtDQUUTNWwpZPlwwqhzyJY5CPOmpzFU9KYA8V
	zB58nlsPbgUO0+ybcBMNLaRUcfgDGd0=
Date: Thu, 18 Jun 2026 01:11:22 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/17/26 23:41, Gabriele Monaco wrote:
> On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> We occasionally hit a lockdep "Invalid wait context" warning in
>> production
>> environments when rv_react() callbacks are interrupted.
>>
>> The bug is intermittent in production. KUnit tests with busy-wait
>> callbacks
>> can reproduce it by holding the CPU long enough for a timer interrupt
>> to fire
>> during rv_react(), exposing the lockdep constraint violation:
>>
>> [   44.820913] =============================
>> [   44.820923] [ BUG: Invalid wait context ]
>> [   44.821137] 7.1.0-rc7-next-20260612-virtme #6 Tainted:
>> G                 N
>> [   44.821203] -----------------------------
> 
> It's nice to have reactors kunit coverage, I need to go through them
> more carefully but I like the idea.
> 
> Are those tests supposed to trigger this issue though? Under what
> configuration?
> 
> I reverted the lockdep fix and run the tests in vng on both x86_64 and
> arm64, both preempt_rt and not but I see no splat.
> Repeating the tests multiple times from debugfs also didn't seem to
> help. Both machines were relatively large (128 and 48 CPUs).
> 
> The config was the bare vng one with kunit built-in, lockdep and the
> reactors tests.
> 
> What am I missing?
> 

Thank you for your feedback.
I am using a WSL dev environment with 12 cores and 16GB. The config of 
the tested kernel code is as follows:


$ make savedefconfig

$ cat defconfig
CONFIG_WERROR=y
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_CGROUPS=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXPERT=y
CONFIG_PROFILING=y
CONFIG_KEXEC=y
CONFIG_SMP=y
CONFIG_IOSF_MBI=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NUMA=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_HZ_1000=y
CONFIG_HIBERNATION=y
CONFIG_PM_DEBUG=y
CONFIG_PM_TRACE_RTC=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_BGRT=y
CONFIG_IA32_EMULATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
CONFIG_KVM_AMD=y
# CONFIG_SCHED_MC is not set
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BINFMT_MISC=y
# CONFIG_COMPAT_BRK is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_ZONE_DEVICE=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_SCHED=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_EMATCH=y
CONFIG_NET_CLS_ACT=y
CONFIG_DNS_RESOLVER=y
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_WIRELESS is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_PCI=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI=y
CONFIG_PCCARD=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEBUG_DEVRES=y
CONFIG_CONNECTOR=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_AMD=y
CONFIG_PATA_OLDPIIX=y
CONFIG_PATA_SCH=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NETCONSOLE=y
CONFIG_VIRTIO_NET=y
# CONFIG_ETHERNET is not set
CONFIG_PHYLIB=y
CONFIG_REALTEK_PHY=y
# CONFIG_WLAN is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_INPUT_TABLET=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_NVRAM=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_I2C_I801=y
CONFIG_PTP_1588_CLOCK=y
CONFIG_WATCHDOG=y
CONFIG_I6300ESB_WDT=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_CODEC_REALTEK=y
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_X86 is not set
# CONFIG_HID is not set
CONFIG_RTC_CLASS=y
CONFIG_DMADEVICES=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_EEEPC_LAPTOP=y
CONFIG_ACPI_WMI=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_AMD_IOMMU=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_VIRTIO_IOMMU=y
CONFIG_FS_DAX=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_QFMT_V2=y
CONFIG_FUSE_FS=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
CONFIG_9P_FS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_KEYS=y
CONFIG_SECURITYFS=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_WX=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_ATOMIC=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_CSD_LOCK_WAIT_DEBUG=y
CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y
CONFIG_DEBUG_KOBJECT=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
CONFIG_RV_MON_RTAPP=y
CONFIG_RV_MON_STALL=y
CONFIG_RV_MON_DEADLINE=y
CONFIG_RV_REACT_PRINTK_KUNIT=y
CONFIG_RV_REACT_PANIC_KUNIT=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_DEBUG_BOOT_PARAMS=y
CONFIG_DEBUG_ENTRY=y
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set


And then, using vng to build and run kselftests (since kunit is already 
built-in) can reproduce this issue:

$ vng --build

$ vng -v --run arch/x86/boot/bzImage --user root -- 
tools/testing/selftests/verification/verificationtest-ktap


--
Best wishes,
Wen


> Thanks,
> Gabriele
> 
>> [   44.821211] kunit_try_catch/209 is trying to lock:
>> [   44.821244] ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}, at:
>> __schedule+0x102/0x13d0
>> [   44.821688] other info that might help us debug this:
>> [   44.821708] context-{5:5}
>> [   44.821730] 1 lock held by kunit_try_catch/209:
>> [   44.821745]  #0: ffffffffb6ba62c0 (rv_react_map-wait-type-
>> override){+.+.}-{1:1}, at: rv_react+0x9d/0xf0
>> [   44.821803] stack backtrace:
>> [   44.822110] CPU: 10 UID: 0 PID: 209 Comm: kunit_try_catch Tainted:
>> G                 N  7.1.0-rc7-next-20260612-virtme #6
>> PREEMPT_{RT,(full)}
>> [   44.822197] Tainted: [N]=TEST
>> [   44.822210] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
>> arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   44.822328] Call Trace:
>> [   44.822377]  <TASK>
>> [   44.822806]  dump_stack_lvl+0x78/0xe0
>> [   44.822860]  __lock_acquire+0x926/0x1c90
>> [   44.822888]  lock_acquire+0xd3/0x310
>> [   44.822901]  ? __schedule+0x102/0x13d0
>> [   44.822919]  ? rcu_qs+0x2d/0x1a0
>> [   44.822954]  _raw_spin_lock_nested+0x36/0x50
>> [   44.822966]  ? __schedule+0x102/0x13d0
>> [   44.822979]  __schedule+0x102/0x13d0
>> [   44.822993]  ? mark_held_locks+0x40/0x70
>> [   44.823009]  preempt_schedule_irq+0x37/0x70
>> [   44.823018]  irqentry_exit+0x1da/0x8c0
>> [   44.823032]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [   44.823093] RIP: 0010:mock_printk_react+0x2a/0x50
>> [   44.823250] Code: f3 0f 1e fa 0f 1f 44 00 00 41 54 49 89 f4 55 48
>> 89 fd 53 e8 18 8b db ff 4c 89 e6 48 89 ef 48 89 c3 e8 fa 8e ed ff eb
>> 02 f3 90 <e8> 01 8b db ff 48 29 d8 48 3d 3f 4b 4c 00 76 ee 5b 5d 41
>> 5c c3 cc
>> [   44.823303] RSP: 0018:ffffd1c3c0733d38 EFLAGS: 00000297
>> [   44.823332] RAX: 00000000000119f3 RBX: 0000000a74e60d1c RCX:
>> 000000000000001f
>> [   44.823342] RDX: 0000000000000000 RSI: 000000003348c8a2 RDI:
>> ffffffffc1abbfd9
>> [   44.823351] RBP: ffffffffb671b613 R08: 0000000000000002 R09:
>> 0000000000000000
>> [   44.823359] R10: 0000000000000001 R11: 0000000000000000 R12:
>> ffffd1c3c0733d60
>> [   44.823367] R13: ffffffffb575a5fd R14: ffffd1c3c0017be8 R15:
>> ffffd1c3c00179f8
>> [   44.823397]  ? rv_react+0x9d/0xf0
>> [   44.823437]  ? mock_printk_react+0x2f/0x50
>> [   44.823448]  rv_react+0xb4/0xf0
>> [   44.823455]  ? rv_react+0x9d/0xf0
>> [   44.823476]  test_printk_react_called+0x83/0xb0
>> [   44.823486]  ? __pfx_mock_printk_react+0x10/0x10
>> [   44.823502]  ? __pfx_mock_printk_react+0x10/0x10
>> [   44.823513]  kunit_try_run_case+0x97/0x190
>> [   44.823534]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>> [   44.823544]  kunit_generic_run_threadfn_adapter+0x21/0x40
>> [   44.823551]  kthread+0x124/0x160
>> [   44.823562]  ? __pfx_kthread+0x10/0x10
>> [   44.823574]  ret_from_fork+0x291/0x3b0
>> [   44.823585]  ? __pfx_kthread+0x10/0x10
>> [   44.823595]  ret_from_fork_asm+0x1a/0x30
>> [   44.823641]  </TASK>
>>
>>
>> Patch 1 fixes the lockdep bug by correcting rv_react()'s
>> wait_type_inner
>> from LD_WAIT_CONFIG (which inherits the outer context) to
>> LD_WAIT_SPIN
>> (the tightest constraint callbacks must satisfy).
>>
>> Patch 2 adds KUnit tests for reactor_printk. The busy-wait in the
>> mock
>> callback reproduces the timer interrupt scenario that exposes the
>> bug.
>>
>> Patch 3 adds KUnit tests for reactor_panic, exercising the panic
>> notifier
>> chain without halting the system.
>>
>> Tested with CONFIG_PROVE_LOCKING=y and CONFIG_KUNIT=y.
>>
>>
>> Wen Yang (3):
>>    rv/reactors: fix lockdep "Invalid wait context" in rv_react()
>>    rv/reactors: add KUnit tests for reactor_printk
>>    rv/reactors: add KUnit tests for reactor_panic
>>
>>   kernel/trace/rv/Kconfig                |  20 ++++
>>   kernel/trace/rv/Makefile               |   2 +
>>   kernel/trace/rv/reactor_panic_kunit.c  | 106 +++++++++++++++++++++
>>   kernel/trace/rv/reactor_printk_kunit.c | 123
>> +++++++++++++++++++++++++
>>   kernel/trace/rv/rv_reactors.c          |   8 +-
>>   5 files changed, 258 insertions(+), 1 deletion(-)
>>   create mode 100644 kernel/trace/rv/reactor_panic_kunit.c
>>   create mode 100644 kernel/trace/rv/reactor_printk_kunit.c
> 
