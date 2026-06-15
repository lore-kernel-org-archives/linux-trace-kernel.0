Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509940E8F4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541923; cv=none; b=XKg9rSl3c0o3k1lGAgzfmQozHj32P0+AwnveXyeX69YnsTxAySEsL77HERd92oY61xD/7fynramqFT9OI05n20WgGRjgiVCdcgO7jBHn7/5EciYYQ9n4xUub4oZKt12A7KTBjUF1wGE3drirgzXNZZvva4MssFFiiTYSX2yCBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541923; c=relaxed/simple;
	bh=RiBqeywWeI3b1Rpr8H1Hk9Dc3cIEHX+XSdJ/CwOCUqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a7iA/TiaEpxP3geERqInEqUFPdGt+/F0P3eBOSLdbUjDDQEOcjwg8gBvcH50LtaYWkREjQt5todZrV7/D8oaSGuw+D9Wdo+p28a2SfdisehqHlS2hoytsxqkZ4venGCaGDsUhbmN+6Xo9TQcW9dwA8fVAkOrUTlerUICLGFNFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dF9RQAk6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dF9RQAk6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781541909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pd+jfSSVlSnyTqB7FPjgaNUtNm21pbTrUo2wVp3Q8rw=;
	b=dF9RQAk6IBht0AdV57mn4VmWJ3qo2iLhfvoGUxvWvb1xU57Er1BTU+1sJqcvmHD8My7JpB
	kfuoM4FUlE5e6VX3zNh5N3NQSKN+LGJhtbS34EmGpTTyy27VxUAIYZzKEQdBKMc/nKui9L
	thfifXjn/0sGMKATyzI07ujGg6cDV1c=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
Date: Tue, 16 Jun 2026 00:44:47 +0800
Message-Id: <cover.1781541556.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

We occasionally hit a lockdep "Invalid wait context" warning in production
environments when rv_react() callbacks are interrupted.

The bug is intermittent in production. KUnit tests with busy-wait callbacks
can reproduce it by holding the CPU long enough for a timer interrupt to fire
during rv_react(), exposing the lockdep constraint violation:

[   44.820913] =============================
[   44.820923] [ BUG: Invalid wait context ]
[   44.821137] 7.1.0-rc7-next-20260612-virtme #6 Tainted: G                 N
[   44.821203] -----------------------------
[   44.821211] kunit_try_catch/209 is trying to lock:
[   44.821244] ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}, at: __schedule+0x102/0x13d0
[   44.821688] other info that might help us debug this:
[   44.821708] context-{5:5}
[   44.821730] 1 lock held by kunit_try_catch/209:
[   44.821745]  #0: ffffffffb6ba62c0 (rv_react_map-wait-type-override){+.+.}-{1:1}, at: rv_react+0x9d/0xf0
[   44.821803] stack backtrace:
[   44.822110] CPU: 10 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N  7.1.0-rc7-next-20260612-virtme #6 PREEMPT_{RT,(full)}
[   44.822197] Tainted: [N]=TEST
[   44.822210] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   44.822328] Call Trace:
[   44.822377]  <TASK>
[   44.822806]  dump_stack_lvl+0x78/0xe0
[   44.822860]  __lock_acquire+0x926/0x1c90
[   44.822888]  lock_acquire+0xd3/0x310
[   44.822901]  ? __schedule+0x102/0x13d0
[   44.822919]  ? rcu_qs+0x2d/0x1a0
[   44.822954]  _raw_spin_lock_nested+0x36/0x50
[   44.822966]  ? __schedule+0x102/0x13d0
[   44.822979]  __schedule+0x102/0x13d0
[   44.822993]  ? mark_held_locks+0x40/0x70
[   44.823009]  preempt_schedule_irq+0x37/0x70
[   44.823018]  irqentry_exit+0x1da/0x8c0
[   44.823032]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   44.823093] RIP: 0010:mock_printk_react+0x2a/0x50
[   44.823250] Code: f3 0f 1e fa 0f 1f 44 00 00 41 54 49 89 f4 55 48 89 fd 53 e8 18 8b db ff 4c 89 e6 48 89 ef 48 89 c3 e8 fa 8e ed ff eb 02 f3 90 <e8> 01 8b db ff 48 29 d8 48 3d 3f 4b 4c 00 76 ee 5b 5d 41 5c c3 cc
[   44.823303] RSP: 0018:ffffd1c3c0733d38 EFLAGS: 00000297
[   44.823332] RAX: 00000000000119f3 RBX: 0000000a74e60d1c RCX: 000000000000001f
[   44.823342] RDX: 0000000000000000 RSI: 000000003348c8a2 RDI: ffffffffc1abbfd9
[   44.823351] RBP: ffffffffb671b613 R08: 0000000000000002 R09: 0000000000000000
[   44.823359] R10: 0000000000000001 R11: 0000000000000000 R12: ffffd1c3c0733d60
[   44.823367] R13: ffffffffb575a5fd R14: ffffd1c3c0017be8 R15: ffffd1c3c00179f8
[   44.823397]  ? rv_react+0x9d/0xf0
[   44.823437]  ? mock_printk_react+0x2f/0x50
[   44.823448]  rv_react+0xb4/0xf0
[   44.823455]  ? rv_react+0x9d/0xf0
[   44.823476]  test_printk_react_called+0x83/0xb0
[   44.823486]  ? __pfx_mock_printk_react+0x10/0x10
[   44.823502]  ? __pfx_mock_printk_react+0x10/0x10
[   44.823513]  kunit_try_run_case+0x97/0x190
[   44.823534]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[   44.823544]  kunit_generic_run_threadfn_adapter+0x21/0x40
[   44.823551]  kthread+0x124/0x160
[   44.823562]  ? __pfx_kthread+0x10/0x10
[   44.823574]  ret_from_fork+0x291/0x3b0
[   44.823585]  ? __pfx_kthread+0x10/0x10
[   44.823595]  ret_from_fork_asm+0x1a/0x30
[   44.823641]  </TASK>


Patch 1 fixes the lockdep bug by correcting rv_react()'s wait_type_inner
from LD_WAIT_CONFIG (which inherits the outer context) to LD_WAIT_SPIN
(the tightest constraint callbacks must satisfy).

Patch 2 adds KUnit tests for reactor_printk. The busy-wait in the mock
callback reproduces the timer interrupt scenario that exposes the bug.

Patch 3 adds KUnit tests for reactor_panic, exercising the panic notifier
chain without halting the system.

Tested with CONFIG_PROVE_LOCKING=y and CONFIG_KUNIT=y.


Wen Yang (3):
  rv/reactors: fix lockdep "Invalid wait context" in rv_react()
  rv/reactors: add KUnit tests for reactor_printk
  rv/reactors: add KUnit tests for reactor_panic

 kernel/trace/rv/Kconfig                |  20 ++++
 kernel/trace/rv/Makefile               |   2 +
 kernel/trace/rv/reactor_panic_kunit.c  | 106 +++++++++++++++++++++
 kernel/trace/rv/reactor_printk_kunit.c | 123 +++++++++++++++++++++++++
 kernel/trace/rv/rv_reactors.c          |   8 +-
 5 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/reactor_panic_kunit.c
 create mode 100644 kernel/trace/rv/reactor_printk_kunit.c

-- 
2.25.1

