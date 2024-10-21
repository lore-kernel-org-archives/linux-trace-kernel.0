Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63B1F8F01;
	Mon, 21 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523591; cv=none; b=aMZRHCBm2enSJdpQuYspHXyZ3d9u5ITILp6lj5ZeW/JZD7lTwhUYdMaaZbFRlMGcCCe9Nl8BNKgrP2h3udQuVygvc45PMIg+Th2eBtwb0HAZECVMHyJLHtLJa3VMB0LlMARoCDkTfgd6wtcZhhabUATHRJohTLR+nFKfWj2/eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523591; c=relaxed/simple;
	bh=BmrD8P4kXmBSUNzxpOCTHa+WLE1X2hgSlmmP/4vpiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiIzF9yz9Vt+Vkja9DLoryCR3WUzBlPGUj53+HgK+ohJvzsv7iFe6q0zneXzreC2chW+xS0qlsNtyZG8JDKPOP6xbQEXR2FN98JVOEJRqbj4muQFINnsSepEyADoXbK6TFloRou8NFN0dk8scYFhkztWtqMadBa0QaO5EyvcVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qo4c5rWq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7Fec6Zk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qo4c5rWq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7Fec6Zk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729523588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGvx53aEC/g+kE5bhkxfRgADXQtsPpYeRVLsbQC037o=;
	b=Qo4c5rWqFncDfIbbuRC+Rp8DCxZPp4zNxCLSeKpYH5oM7Ypt0+6Htig1f5MI5lZgbFRJ69
	jmx9PJGF5aVLUBLPeO6nSlhGH/N8eq9JOiIOZiJAAKYbp5TPY7EBj7Chm9lhWNtVPLGqPp
	cEFb4HwUFwNP5nvTJG9ev3iENNOXv6Pi3VbL9snAz7BkRWY8Uhzc9f8MbsiRm+iD7Txeqx
	hGaejPBD5Mhz9UXovZLdy/EefnHYxc9gS9CvP5dUrpp7ktrFHS2LKhJ9xY/++TnyPXWTY7
	B0TYwV9MIcdjbRW1vzG9+Lx/QMd21JM/eiUEmJyI5UkiGBOKULLgSzA3Nxf6/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729523588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGvx53aEC/g+kE5bhkxfRgADXQtsPpYeRVLsbQC037o=;
	b=m7Fec6ZkmVQBTktBv5fQBVY1iDAxg54fWHlXfckdwPEpA24GJPlUy//0eBSeJDfODgj6uV
	uKtWzlapiB9DIICQ==
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	tglx@linutronix.de,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ankur.a.arora@oracle.com,
	efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/3] riscv: add PREEMPT_LAZY support
Date: Mon, 21 Oct 2024 17:08:42 +0200
Message-ID: <20241021151257.102296-4-bigeasy@linutronix.de>
In-Reply-To: <20241021151257.102296-1-bigeasy@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jisheng Zhang <jszhang@kernel.org>

riscv has switched to GENERIC_ENTRY, so adding PREEMPT_LAZY is as simple
as adding TIF_NEED_RESCHED_LAZY related definitions and enabling
ARCH_HAS_PREEMPT_LAZY.

[bigeasy: Replace old PREEMPT_AUTO bits with new PREEMPT_LAZY ]

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/riscv/Kconfig                   |    1 +
 arch/riscv/include/asm/thread_info.h |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,9 +107,10 @@ int arch_dup_task_struct(struct task_str
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
+#define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
@@ -117,9 +118,10 @@ int arch_dup_task_struct(struct task_str
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to =
user */
=20
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
