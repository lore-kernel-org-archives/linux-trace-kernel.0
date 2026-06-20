Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF541C6A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Jun 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781946847; cv=none; b=DsZgL8TxrePTUIrFqAH8HGpUcCZk2Ha4BIjRoPqjZBc2AlPSMfiB4He1FFfu/Luqc2nv5UccQYNrfSp3H65Dd0x8kx1Sy9fzXI36rvkIEIL5X6YX/cMnmU3e0SUAbw2XGvnuNyPBhFJz7OVUtRaMfi+L7llJj5dJTi3R27p684s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781946847; c=relaxed/simple;
	bh=fOl0Vrrc0iP2T1ti8jkdmHyjIFrCDs2EIXmPJDE8Vzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3Qt7bQw4EffW0GD7LUpreBXZrxmIl/kcU2CrRlHK3dS36S+0eUuLoonquyTmWrcdfD1AD6IzszRRKMP4zIqpwmxUwCHp/cenP1NFu8J/CwTO7MqzjnWS4gJmD/ZHKvKuDKkw64naeLHLIYbZ97wjSgVD1kparwaSwoG20acG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P2kTmUul; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P2kTmUul"
Message-ID: <20d2c460-a13d-4763-ba42-53a790009e5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781946841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dkm2SN9Eg0EL7ZXkDypd/vDTxVjv17DwsPF1q/ThGsM=;
	b=P2kTmUuld5wF1by4mbJ84Id1aNBO7fCOHzOIYlHblm14n+CwECv9xqYANMorJ+s6QHqCQu
	CrOJqhzKFKG1b4ZUGg0SUJq1jwBr1k7MgaBlrdWjFQg8YJwJDX9xsRbGXNt6YwFuWFkcxO
	YHRsH2SiHQSNtKdPDaO0ZTv+fpZBvIQ=
Date: Sat, 20 Jun 2026 17:13:50 +0800
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
 <4053c9bb-6229-438c-8c14-917909c1618f@linux.dev>
 <2de882a2dcf09613580bcb2495e3b2495c58f661.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2de882a2dcf09613580bcb2495e3b2495c58f661.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/18/26 23:35, Gabriele Monaco wrote:
> On Thu, 2026-06-18 at 01:11 +0800, Wen Yang wrote:
>> Thank you for your feedback.
>> I am using a WSL dev environment with 12 cores and 16GB. The config
>> of the tested kernel code is as follows:
> 
> Uhm that's a strange one, I cannot get a machine like that..
> The closest is a 16 CPUs where I can limit the resources in vng.
> 


I switched to a server with 32 cores and 126 GB mem, based on the 
following code:
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git 
8970865b788e

Then, using the above defconfig, and manually enabled:
CONFIG_RV_REACT_PRINTK_KUNIT=y
CONFIG_RV_REACT_PANIC_KUNIT=y

The issue can still be reproduced, as follows:

...
[    2.467818] rtc_cmos PNP0B00:00: setting system clock to 
2026-06-20T08:53:17 UTC (1781945597)
[    2.467959] rtc_cmos PNP0B00:00: alarms up to one day, y3k, 242 bytes 
nvram, hpet irqs
[    2.468796] i6300ESB timer 0000:00:03.0: initialized. heartbeat=30 
sec (nowayout=0)
[    2.469135] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) 
initialised: dm-devel@lists.linux.dev
[    2.471695] NET: Registered PF_PACKET protocol family
[    2.471724] 9pnet: Installing 9P2000 support
[    2.473143] Key type dns_resolver registered
[    2.483567] IPI shorthand broadcast: enabled
[    2.508735] sched_clock: Marking stable (2449003255, 
59304729)->(2516047879, -7739895)
[    2.510654] registered taskstats version 1
[    2.511333] Loading compiled-in X.509 certificates
[    2.535612] Demotion targets for Node 0: null
[    2.536818] netconsole: network logging started
[    2.537105] clk: Disabling unused clocks
[    2.537129] ALSA device list:
[    2.537132]   No soundcards found.
[    2.537133] KTAP version 1
[    2.537134] 1..2
[    2.538768]     KTAP version 1
[    2.538769]     # Subtest: rv_reactor_printk
[    2.538770]     # module: reactor_printk_kunit
[    2.538771]     1..5
[    2.539198]     ok 1 test_printk_register_unregister
[    2.539278] printk violation message
[    2.539309]
[    2.539309] =============================
[    2.539310] [ BUG: Invalid wait context ]
[    2.539310] 7.1.0-rc5-virtme #15 Tainted: G                 N
[    2.539311] -----------------------------
[    2.539311] kunit_try_catch/420 is trying to lock:
[    2.539312] ffff8e347e93e1a0 (&rq->__lock){-...}-{2:2}, at: 
__schedule+0xf5/0x1390
[    2.539317] other info that might help us debug this:
[    2.539317] context-{5:5}
[    2.539317] 1 lock held by kunit_try_catch/420:
[    2.539318]  #0: ffffffffb9d8c3e0 
(rv_react_map-wait-type-override){+.+.}-{1:1}, at: rv_react+0x56/0xd0
[    2.539321] stack backtrace:
[    2.539322] CPU: 22 UID: 0 PID: 420 Comm: kunit_try_catch Tainted: G 
                N  7.1.0-rc5-virtme #15 PREEMPT_{RT,(full)}
[    2.539323] Tainted: [N]=TEST
[    2.539324] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.15.0-1 04/01/2014
[    2.539324] Call Trace:
[    2.539325]  <TASK>
[    2.539326]  dump_stack_lvl+0x82/0xd0
[    2.539328]  __lock_acquire+0xabc/0x27e0
[    2.539330]  ? desc_read_finalized_seq+0x2e/0x90
[    2.539333]  lock_acquire+0xd5/0x320
[    2.539334]  ? __schedule+0xf5/0x1390
[    2.539336]  _raw_spin_lock_nested+0x39/0x50
[    2.539338]  ? __schedule+0xf5/0x1390
[    2.539339]  __schedule+0xf5/0x1390
[    2.539341]  ? mark_held_locks+0x49/0x80
[    2.539342]  preempt_schedule_irq+0x37/0x70
[    2.539343]  irqentry_exit+0x1c5/0x750
[    2.539344]  ? rcu_is_watching+0x11/0x50
[    2.539346]  ? trace_hardirqs_off_finish+0xac/0xd0
[    2.539348]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    2.539349] RIP: 0010:mock_printk_react+0x2a/0x50
[    2.539351] Code: f3 0f 1e fa 0f 1f 44 00 00 41 54 49 89 f4 55 48 89 
fd 53 e8 c8 a2 dd ff 4c 89 e6 48 89 ef 48 89 c3 e8 ba 21 ee ff eb 02 f3 
90 <e8> b1 a2 dd ff 48 29 d8 48 3d 3f 4b 4c 00 76 ee 5b 5d 41 5c c3 cc
[    2.539352] RSP: 0000:ffffd26a80ebfd48 EFLAGS: 00000297
[    2.539353] RAX: 0000000000005a6c RBX: 0000000097d06aed RCX: 
000000000000001f
[    2.539354] RDX: 0000000000000000 RSI: 00000000282920b2 RDI: 
fffffffff2cc40ea
[    2.539354] RBP: ffffffffb9aac37e R08: 0000000000000002 R09: 
0000000000000000
[    2.539355] R10: 0000000000000001 R11: 0000000000000000 R12: 
ffffd26a80ebfd70
[    2.539355] R13: ffffffffb8a6a366 R14: ffffffffb8e49e70 R15: 
ffffd26a80013be8
[    2.539355]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    2.539357]  ? rv_react+0x56/0xd0
[    2.539360]  ? mock_printk_react+0x2f/0x50
[    2.539362]  rv_react+0x9c/0xd0
[    2.539363]  ? rv_react+0x56/0xd0
[    2.539365]  test_printk_react_called+0x83/0xb0
[    2.539367]  ? __pfx_mock_printk_react+0x10/0x10
[    2.539368]  ? __pfx_mock_printk_react+0x10/0x10
[    2.539370]  kunit_try_run_case+0x74/0x160
[    2.539372]  ? lockdep_hardirqs_on+0xc1/0x140
[    2.539373]  ? _raw_spin_unlock_irqrestore+0x46/0x80
[    2.539375]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    2.539375]  kunit_generic_run_threadfn_adapter+0x21/0x40
[    2.539376]  kthread+0x126/0x170
[    2.539378]  ? __pfx_kthread+0x10/0x10
[    2.539378]  ret_from_fork+0x22b/0x310
[    2.539380]  ? __pfx_kthread+0x10/0x10
[    2.539381]  ret_from_fork_asm+0x1a/0x30
[    2.539384]  </TASK>
[    2.544290] kunit_try_catch (420) used greatest stack depth: 12920 
bytes left
[    2.544542]     ok 2 test_printk_react_called
[    2.544768] Reactor test_printk is already registered
[    2.544819]     ok 3 test_printk_double_register
[    2.544953]     ok 4 test_printk_register_cycle
[    2.545121]     ok 5 test_printk_react_not_null
[    2.545121] # rv_reactor_printk: pass:5 fail:0 skip:0 total:5
[    2.545122] # Totals: pass:5 fail:0 skip:0 total:5
[    2.545123] ok 1 rv_reactor_printk
[    2.545123]     KTAP version 1
[    2.545123]     # Subtest: rv_reactor_panic
[    2.545124]     # module: reactor_panic_kunit
[    2.545124]     1..2
[    2.545284]     ok 1 test_panic_register_unregister
[    2.545337] KUnit: reactor_panic test intercepted panic notifier: 
panic violation message
[    2.547624]     ok 2 test_panic_notifier_called
[    2.547624] # rv_reactor_panic: pass:2 fail:0 skip:0 total:2
[    2.547625] # Totals: pass:2 fail:0 skip:0 total:2
[    2.547625] ok 2 rv_reactor_panic
[    2.612894] ata2: found unknown device (class 0)
[    2.616059] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.621249] kobject: 'devlink' (0000000023b6b59a): 
kobject_add_internal: parent: 'virtual', set: '(null)'
[    2.621380] kobject: ':ata2--scsi:1:0:0:0' (0000000079538692): 
kobject_add_internal: parent: 'devlink', set: 'devices'
[    2.621467] kobject: ':ata2--scsi:1:0:0:0' (0000000079538692): 
kobject_uevent_env
[    2.621473] kobject: ':ata2--scsi:1:0:0:0' (0000000079538692): 
fill_kobj_path: path = '/devices/virtual/devlink/:ata2--scsi:1:0:0:0'
[    2.624159] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM 
2.5+ PQ: 0 ANSI: 5
[    2.637661] kobject: 'target1:0:0' (00000000e7e99ebc): 
kobject_add_internal: parent: 'host1', set: 'devices'
...

The above warning appears in the middle of the screen output, not at the 
end, because kunit is built-in and is executed before the init starts.

In addition, there is another issue at the very end: warning: WARNING: 
kernel/exit.c:902 at do_exit+0x9d8/0xc60, CPU#0: virtme-ng-init/1)...


--
Best wishes,
Wen




