Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CD25BEE1;
	Tue,  1 Jul 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352143; cv=none; b=IZiLzTZZDamqCBzKI+LHgKsNKRKH04Qnb7RJN2XBFPaE8mam2cOqe0IdnOGCae/DUc3rbRlyftSJPDa8m0icmjvQDTCMRCyo8a57Y2gN1Ong9r3XHW6qdDBka94JUauc/smFQzo2oT0NNoJk87LKhYtB4OU4ZaSZ5rFfMJFbf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352143; c=relaxed/simple;
	bh=JX38uJPp2vwSzD5BpBk1ISPL/QlOp0xzhxbrYejwU/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ydshnc9zzIH/LrySBCPiHIBYMCSH/MpcXHcCTiPXInmBNxntqTFBRsN+vbu2gdBGKvbwmopYyoGM6YFWjt6QZ9wHkGaNUGtQHsSODYyin/v1I0P5KfyvbamZtw2S8snYYrno9IMI5mAlUH8BTpRcLSXU4CoxxNvYdcvzV0EzsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Wsa/9rqm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Wsa/9rqm"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0FC7423C9C;
	Tue,  1 Jul 2025 08:42:18 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miHKJyUUy8bF; Tue,  1 Jul 2025 08:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1751352135; bh=JX38uJPp2vwSzD5BpBk1ISPL/QlOp0xzhxbrYejwU/M=;
	h=Date:From:To:Cc:Subject;
	b=Wsa/9rqmI/q3/8Ibu/iePM45/iUAjNT5l3k7zU79L+L9WwSQ78wRoTgQ3TsY9rOR+
	 5wUsGJofo83Pu7kiErjFeyRGgcxm6nIkhRss4qN1IZKOo2ES8KzEooAv7aA3rV0GOc
	 mkqEbI4vav0Ddu9YUdLQtAJm7W3c/jLeZowVofh511iAC/8jnz/bEXEWrxcTBhAhm9
	 JOKSUvyL+oSMRjJCtCkUawSOeRQVEYE4LlHw8g04NXuU31EKLo6SlZj3oJtenkkoSh
	 6IgIB0BeNvQpiYzrMBfrtw7ysWjeWz3T9U1hwhlCx4c/d87Kr7FigM7vH8nArOOJuJ
	 GwuBg5S2KuDdQ==
Date: Tue, 1 Jul 2025 06:41:54 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andy Chiu <andybnac@gmail.com>, alexghiti@rivosinc.com,
	palmer@dabbelt.com, "Andy Chiu" <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Alexandre Ghiti" <alex@ghiti.fr>, puranjay12@gmail.com,
	paul.walmsley@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
	vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com
Cc: Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, regressions@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [REGRESSION] Random oops on SG2042 with Linux 6.16-rc and dynamic
 ftrace
Message-ID: <aGODMpq7TGINddzM@pie.lan>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linux v6.16 built with dynamic ftrace randomly oops or triggers
ftrace_bug() on Sophgo SG2042 when booting systemd-based userspace,

[    9.913462] ------------[ ftrace bug ]------------
[    9.913921] usbcore: registered new interface driver hub
[    9.917914] ftrace faulted on modifying
[    9.922947] usbcore: registered new device driver usb
[    9.928062] [<ffffffff030b7a7c>] 0xffffffff030b7a7c
[    9.941963] Initializing ftrace call sites
[    9.946086] ftrace record flags: 2000000
[    9.950028]  (0)
                expected tramp: ffffffff8001f840
[    9.956592] ------------[ cut here ]------------
[    9.956597] WARNING: CPU: 3 PID: 673 at kernel/trace/ftrace.c:2213 ftrace_bug+0x278/0x2b0
[    9.956625] Modules linked in: fixed_phy(E+) fwnode_mdio(E) nvme_core(E) usbcore(E) scsi_mod(E) sdhci(E) libphy(E) nvme_keyring(E) scsi_common(E) usb_common(E) nvme_auth(E) cqhci(E) mdio_bus(E) mdio(E) mmc_core(E) gpio_dwapb(E) spi_sg2044_nor(E) i2c_designware_platform(E)
[    9.956667] CPU: 3 UID: 0 PID: 673 Comm: (udev-worker) Tainted: G            E       6.16.0-rc3-pioneer #2025.06.24.16.00+074b194ff VOLUNTARY
[    9.956677] Tainted: [E]=UNSIGNED_MODULE
[    9.956680] Hardware name: Milk-V Pioneer (DT)
[    9.956683] epc : ftrace_bug+0x278/0x2b0
[    9.956689]  ra : ftrace_bug+0x278/0x2b0
[    9.956694] epc : ffffffff80007018 ra : ffffffff80007018 sp : ffffffc60a2b3800
[    9.956698]  gp : ffffffff81dbf1e8 tp : ffffffd70246aac0 t0 : ffffffff8001ff48
[    9.956702]  t1 : 0000000000000020 t2 : 6465746365707865 s0 : ffffffc60a2b3830
[    9.956705]  s1 : ffffffff030b7a7c a0 : 0000000000000022 a1 : fffffff5ffaad8c0
[    9.956708]  a2 : 0000000000000010 a3 : fffffff5ffaad8c0 a4 : 0000000000000000
[    9.956711]  a5 : 0000000000000000 a6 : 0000000000007ffe a7 : 000000000015ffa8
[    9.956715]  s2 : ffffffd722b77130 s3 : fffffffffffffff2 s4 : ffffffd722b77130
[    9.956718]  s5 : fffffff5dda52b60 s6 : ffffffff030ca500 s7 : 0000000002000000
[    9.956721]  s8 : 0000000000000013 s9 : fffffff5dda52b60 s10: 0000000000000046
[    9.956724]  s11: 0000000000000014 t3 : ffffffff81dda237 t4 : ffffffff81dda237
[    9.956727]  t5 : ffffffff81dda238 t6 : ffffffc60a2b3628
[    9.956730] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    9.956735] [<ffffffff80007018>] ftrace_bug+0x278/0x2b0
[    9.956753] [<ffffffff8015cc32>] ftrace_process_locs+0x392/0x4f0
[    9.956762] [<ffffffff80160a3c>] ftrace_module_init+0x3c/0x58
[    9.956768] [<ffffffff800f4c8e>] load_module+0x178e/0x1f78
[    9.956777] [<ffffffff800f5682>] init_module_from_file+0x82/0xc8
[    9.956783] [<ffffffff800f58e8>] __riscv_sys_finit_module+0x1c0/0x300
[    9.956789] [<ffffffff80b10c58>] do_trap_ecall_u+0xa0/0x420
[    9.956795] [<ffffffff80b1e17a>] handle_exception+0x14a/0x156
[    9.956804] ---[ end trace 0000000000000000 ]---

Here's the log when ftrace_bug() is triggered. It's worth noting that
all strange behaviors happen after the userspace starts to load modules.

During debugging, we found if the kernel is built with lockdep enabled,
it triggers tons of warnings during kernel startup and module
initialization, which is reproducible on QEMU as well. A typical log
looks like,

[   30.219049] ------------[ cut here ]------------
[   30.219072] WARNING: CPU: 0 PID: 61 at arch/riscv/kernel/patch.c:135 __patch_insn_write+0x356/0x3b8
[   30.219113] Modules linked in:
[   30.219145] CPU: 0 UID: 0 PID: 61 Comm: modprobe Tainted: G        W           6.16.0-rc4 #64 NONE
[   30.219170] Tainted: [W]=WARN
[   30.219179] Hardware name: riscv-virtio,qemu (DT)
[   30.219189] epc : __patch_insn_write+0x356/0x3b8
[   30.219209]  ra : __patch_insn_write+0x352/0x3b8
[   30.219227] epc : ffffffff80018c7e ra : ffffffff80018c7a sp : ff2000000032b9e0
[   30.219239]  gp : ffffffff81a07500 tp : ff600000823199c0 t0 : ffffffff8001ee78
[   30.219250]  t1 : ff6000008231a9c0 t2 : 0000000000000000 s0 : ff2000000032ba30
[   30.219261]  s1 : 0000000000000008 a0 : 0000000000000000 a1 : ffffffff8181f318
[   30.219272]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ff600000faa43398
[   30.219283]  a5 : 0000000000000000 a6 : 000000000e2d0519 a7 : 0000000000000004
[   30.219294]  s2 : ffffffff0258b3a0 s3 : 0000000000000008 s4 : 00000000000003a0
[   30.219305]  s5 : ff2000000032ba78 s6 : 00000000000003a8 s7 : 0000000002000000
[   30.219316]  s8 : 000000000000007a s9 : ff60000083a8a040 s10: 0000000000000147
[   30.219327]  s11: 000000000000007b t3 : 0000000000001fff t4 : 0000000000000004
[   30.219338]  t5 : 0000000000000002 t6 : 0000000000040000
[   30.219347] status: 0000000200000120 badaddr: ffffffff80018c7e cause: 0000000000000003
[   30.219360] [<ffffffff80018c7e>] __patch_insn_write+0x356/0x3b8
[   30.219380] [<ffffffff80019268>] patch_text_nosync+0x48/0x80
[   30.219400] [<ffffffff8001ebb6>] ftrace_init_nop+0x3e/0xd0
[   30.219417] [<ffffffff8016cbe4>] ftrace_process_locs+0x29c/0x530
[   30.219436] [<ffffffff80170d14>] ftrace_module_init+0x3c/0x58
[   30.219454] [<ffffffff800f8500>] load_module+0x14f0/0x1c70
[   30.219473] [<ffffffff800f8e6a>] init_module_from_file+0x82/0xc8
[   30.219491] [<ffffffff800f9066>] idempotent_init_module+0x1b6/0x2b8
[   30.219510] [<ffffffff800f922c>] __riscv_sys_finit_module+0x64/0xa0
[   30.219528] [<ffffffff80b1c590>] do_trap_ecall_u+0x2b0/0x4e0
[   30.219549] [<ffffffff80b2b172>] handle_exception+0x14a/0x156
[   30.219573] irq event stamp: 5143
[   30.219582] hardirqs last  enabled at (5143): [<ffffffff80b1d55a>] irqentry_exit+0x6a/0x128
[   30.219601] hardirqs last disabled at (5141): [<ffffffff800365fc>] handle_softirqs+0x4a4/0x518
[   30.219620] softirqs last  enabled at (5142): [<ffffffff8003661a>] handle_softirqs+0x4c2/0x518
[   30.219637] softirqs last disabled at (5137): [<ffffffff800367ee>] __irq_exit_rcu+0xe6/0x120
[   30.219656] ---[ end trace 0000000000000000 ]---
[   30.219858] ------------[ cut here ]------------

With some digging, it's found that mutex_lock isn't correctly held when
ftrace_init_nop() initializes the address of ops stored before the
function entry., which is the cause of crashes: without correct lock
protection, __patch_insn_write() may wrongly modify the text segment if
the userspace concurrently issues module initialization, since all code
patching functions share two fixmap pages to modify the code.

The bug was newly introduced by recent RISC-V ftrace changes[1] in
v6.16-rc1, precisely saying commit 881dadf0792c ("Merge patch series
"riscv: ftrace: atmoic patching and preempt improvements"").

We also found another lockdep failure introduced by the series, which
could be reproduced by loading a module after enabling a tracer,

        cd /sys/kernel/debug/tracing
        echo 0 > tracing_on
        echo function > current_tracer
        echo printk > set_ftrace_filter
        echo 1 > tracing_on
        modprobe xxx    # loading anything causes lockdep failures

a typical log for the issue looks like,

[   40.420039] ------------[ cut here ]------------
[   40.420078] WARNING: CPU: 1 PID: 60 at arch/riscv/kernel/patch.c:135 __patch_insn_write+0x356/0x3b8
[   40.420145] Modules linked in: fuse(+)
[   40.420229] CPU: 1 UID: 0 PID: 60 Comm: modprobe Tainted: G        W           6.16.0-rc4+ #69 NONE
[   40.420272] Tainted: [W]=WARN
[   40.420296] Hardware name: riscv-virtio,qemu (DT)
[   40.420323] epc : __patch_insn_write+0x356/0x3b8
[   40.420367]  ra : __patch_insn_write+0x352/0x3b8
[   40.420409] epc : ffffffff80018c7e ra : ffffffff80018c7a sp : ff2000000030b9d0
[   40.420437]  gp : ffffffff81a07500 tp : ff60000083433380 t0 : ffffffff80024060
[   40.420465]  t1 : ffffffff81a0a250 t2 : 0000000000000001 s0 : ff2000000030ba20
[   40.420492]  s1 : 0000000000000004 a0 : 0000000000000000 a1 : ffffffff8181f318
[   40.420519]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ff600000fac22398
[   40.420546]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
[   40.420573]  s2 : ffffffff02581804 s3 : 0000000000000004 s4 : 0000000000000804
[   40.420600]  s5 : ff2000000030ba74 s6 : 0000000000000808 s7 : 0000000000000002
[   40.420628]  s8 : 0000000000000001 s9 : ffffffff818b09d8 s10: 00000000efffffff
[   40.420655]  s11: 0000000040000000 t3 : 0000000000100000 t4 : 0000000000000064
[   40.420682]  t5 : ff6000008392a9d0 t6 : ff600000837c6fff
[   40.420708] status: 0000000200000120 badaddr: ffffffff80018c7e cause: 0000000000000003
[   40.420740] [<ffffffff80018c7e>] __patch_insn_write+0x356/0x3b8
[   40.420783] [<ffffffff800191f8>] patch_insn_write+0x48/0x70
[   40.420825] [<ffffffff8001eacc>] ftrace_make_call+0x8c/0xc0
[   40.420866] [<ffffffff8016c928>] __ftrace_replace_code+0xc0/0xd0
[   40.420909] [<ffffffff80170c82>] ftrace_module_enable+0x292/0x2d8
[   40.420951] [<ffffffff800f85e4>] load_module+0x15e4/0x1c70
[   40.420993] [<ffffffff800f8e5a>] init_module_from_file+0x82/0xc8
[   40.421035] [<ffffffff800f9056>] idempotent_init_module+0x1b6/0x2b8
[   40.421076] [<ffffffff800f921c>] __riscv_sys_finit_module+0x64/0xa0
[   40.421118] [<ffffffff80b1c580>] do_trap_ecall_u+0x2b0/0x4e0
[   40.421160] [<ffffffff80b2b162>] handle_exception+0x14a/0x156
[   40.421210] irq event stamp: 5977
[   40.421234] hardirqs last  enabled at (5977): [<ffffffff80b1d54a>] irqentry_exit+0x6a/0x128
[   40.421275] hardirqs last disabled at (5975): [<ffffffff800365ec>] handle_softirqs+0x4a4/0x518
[   40.421315] softirqs last  enabled at (5976): [<ffffffff8003660a>] handle_softirqs+0x4c2/0x518
[   40.421355] softirqs last disabled at (5969): [<ffffffff800367de>] __irq_exit_rcu+0xe6/0x120
[   40.421397] ---[ end trace 0000000000000000 ]---

the text_mutex lock isn't taken when ftrace_module_enable() indirectly
calls ftrace_make_call(), which *theoretically* may trigger a race, too.

Reverting the series fixes the second problem as well, but it's worth
noting that lockdep still reports a possible dead lock condition when
setting the tracer with

        echo function > /sys/kernel/debug/tracing/current_tracer

[   21.344316] ======================================================
[   21.345382] WARNING: possible circular locking dependency detected
[   21.346914] 6.16.0-rc4+ #70 Not tainted
[   21.347924] ------------------------------------------------------
[   21.348961] bash/58 is trying to acquire lock:
[   21.349844] ffffffff8181a0a0 (cpu_hotplug_lock){++++}-{0:0}, at: stop_machine+0x24/0x4c
[   21.354283]
[   21.354283] but task is already holding lock:
[   21.355431] ffffffff8181f318 (text_mutex){+.+.}-{4:4}, at: ftrace_arch_code_modify_prepare+0x1a/0x2c
[   21.357233]
[   21.357233] which lock already depends on the new lock.
[   21.357233]
[   21.358534]
[   21.358534] the existing dependency chain (in reverse order) is:
[   21.359668]
[   21.359668] -> #2 (text_mutex){+.+.}-{4:4}:
[   21.360862]        lock_acquire+0xf0/0x30e
[   21.361749]        __mutex_lock+0xa6/0x8ee
[   21.362566]        mutex_lock_nested+0x20/0x28
[   21.363310]        arch_jump_label_transform_queue+0x48/0x100
[   21.364226]        __jump_label_update+0x42/0xe8
[   21.365034]        jump_label_update+0x126/0x1da
[   21.365764]        static_key_slow_inc_cpuslocked+0x6c/0xa4
[   21.366579]        static_key_slow_inc+0x26/0x3c
[   21.367305]        sched_clock_init+0x20/0x50
[   21.368041]        start_kernel+0x9b8/0xa94
[   21.368940]
[   21.368940] -> #1 (jump_label_mutex){+.+.}-{4:4}:
[   21.370062]        lock_acquire+0xf0/0x30e
[   21.370748]        __mutex_lock+0xa6/0x8ee
[   21.371459]        mutex_lock_nested+0x20/0x28
[   21.372136]        jump_label_init+0x38/0xee
[   21.372894]        setup_arch+0xd0/0x634
[   21.373568]        start_kernel+0x90/0xa94
[   21.374310]
[   21.374310] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[   21.375509]        check_noncircular+0x144/0x15c
[   21.376313]        __lock_acquire+0xd88/0x2176
[   21.377029]        lock_acquire+0xf0/0x30e
[   21.377683]        cpus_read_lock+0x44/0x118
[   21.378447]        stop_machine+0x24/0x4c
[   21.379123]        arch_ftrace_update_code+0x38/0x56
[   21.379896]        ftrace_startup+0xd0/0x170
[   21.380673]        register_ftrace_function+0x11c/0x1f0
[   21.381489]        function_trace_init+0x6c/0xae
[   21.382238]        tracing_set_tracer+0xba/0x14c
[   21.383044]        tracing_set_trace_write+0x96/0xd0
[   21.383871]        vfs_writev+0x1b8/0x400
[   21.384501]        do_writev+0x6e/0xe8
[   21.385168]        __riscv_sys_writev+0x22/0x2a
[   21.385919]        do_trap_ecall_u+0x2b0/0x4de
[   21.386695]        handle_exception+0x14a/0x156
[   21.387516]
[   21.387516] other info that might help us debug this:
[   21.387516]
[   21.388995] Chain exists of:
[   21.388995]   cpu_hotplug_lock --> jump_label_mutex --> text_mutex
[   21.388995]
[   21.390786]  Possible unsafe locking scenario:
[   21.390786]
[   21.391724]        CPU0                    CPU1
[   21.392608]        ----                    ----
[   21.393357]   lock(text_mutex);
[   21.394035]                                lock(jump_label_mutex);
[   21.395118]                                lock(text_mutex);
[   21.396157]   rlock(cpu_hotplug_lock);
[   21.397030]
[   21.397030]  *** DEADLOCK ***
[   21.397030]
[   21.398110] 5 locks held by bash/58:
[   21.398751]  #0: ff60000080a59430 (sb_writers#6){.+.+}-{0:0}, at: do_writev+0x6e/0xe8
[   21.400343]  #1: ffffffff818b1548 (trace_types_lock){+.+.}-{4:4}, at: tracing_set_tracer+0x24/0x14c
[   21.401948]  #2: ffffffff818b0df8 (direct_mutex){+.+.}-{4:4}, at: register_ftrace_function+0x20/0x1f0
[   21.403531]  #3: ffffffff818b0908 (ftrace_lock){+.+.}-{4:4}, at: register_ftrace_function+0x110/0x1f0
[   21.405208]  #4: ffffffff8181f318 (text_mutex){+.+.}-{4:4}, at: ftrace_arch_code_modify_prepare+0x1a/0x2c
[   21.406948]
[   21.406948] stack backtrace:
[   21.408285] CPU: 1 UID: 0 PID: 58 Comm: bash Not tainted 6.16.0-rc4+ #70 NONE
[   21.408915] Hardware name: riscv-virtio,qemu (DT)
[   21.409325] Call Trace:
[   21.409448] [<ffffffff80016fa8>] dump_backtrace+0x28/0x30
[   21.409546] [<ffffffff80002534>] show_stack+0x38/0x44
[   21.409595] [<ffffffff8000fe1a>] dump_stack_lvl+0x70/0x9c
[   21.409644] [<ffffffff8000fe5e>] dump_stack+0x18/0x20
[   21.409691] [<ffffffff800a764c>] print_circular_bug+0x26c/0x2bc
[   21.409744] [<ffffffff800a77e0>] check_noncircular+0x144/0x15c
[   21.409797] [<ffffffff800aa1a6>] __lock_acquire+0xd88/0x2176
[   21.409850] [<ffffffff800ab684>] lock_acquire+0xf0/0x30e
[   21.409902] [<ffffffff8002bd76>] cpus_read_lock+0x44/0x118
[   21.409954] [<ffffffff80144498>] stop_machine+0x24/0x4c
[   21.410000] [<ffffffff8001d1ea>] arch_ftrace_update_code+0x38/0x56
[   21.410050] [<ffffffff80161fe4>] ftrace_startup+0xd0/0x170
[   21.410102] [<ffffffff80162ee8>] register_ftrace_function+0x11c/0x1f0
[   21.410154] [<ffffffff8017d9ac>] function_trace_init+0x6c/0xae
[   21.410207] [<ffffffff80176444>] tracing_set_tracer+0xba/0x14c
[   21.410262] [<ffffffff8017656c>] tracing_set_trace_write+0x96/0xd0
[   21.410318] [<ffffffff80292d70>] vfs_writev+0x1b8/0x400
[   21.410365] [<ffffffff80293026>] do_writev+0x6e/0xe8
[   21.410411] [<ffffffff80294982>] __riscv_sys_writev+0x22/0x2a
[   21.410460] [<ffffffff80ab6704>] do_trap_ecall_u+0x2b0/0x4de
[   21.410508] [<ffffffff80ac4b0e>] handle_exception+0x14a/0x156

which seems to exist since at least v6.15.

Not sure either reverting the commits or fixing them up is a better
idea, but anyway the fatal first issue shouidn't go into the stable
release.

Thanks for your suggestions on the problems.

Regards,
Yao Zi

[1]: https://lore.kernel.org/all/20250407180838.42877-1-andybnac@gmail.com/

#regzbot introduced: 881dadf0792c
