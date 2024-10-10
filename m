Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DB1C4610;
	Thu, 10 Oct 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563149; cv=none; b=p3JeMzSvXcD+mK3w8dBIkWioooTYwWVafaBmfesPGdFPyXkFqrXb7ELJzqmlNQObndxN+RN474sQcLvVd9LdepS8s0zB2X3mW1xdnTjneyeoh1eVSssD8sf9keUlpgreKpZE8Ga25DdPwpNblTEG5USKDgjPgiusRFLF3exSzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563149; c=relaxed/simple;
	bh=9fH9wulpqdp/Ge5H+zi24V1LwNgG+nqf6Y4SypcfTqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzfzKHnShNacqoeSsbiwaVmYaaGoA2g8jR/vzE0msztV8uq9qZGAwZeHEZnJEbbEyre1FtxMS9FblFApHZiLMpeKlK7NfGtXrWi6OfRjrMRksmG8QPIyv/mVJjtUvs3UnQ9lNZPFSVlNvhE+Oe7QqxYfRRUAkM5XGHdtDodeLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGjskZ4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHb+GC/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGjskZ4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHb+GC/B"
Date: Thu, 10 Oct 2024 14:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728563146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX5RhoJ/MlDzG/mTrF+6FZ25OV+y6FcZq4dFLjVx4SI=;
	b=WGjskZ4medTthYhTN1hTfBi2C+3qJZ4gzTSK59E4KX2R2lENvV8mTzhLvItJrnrejYf40z
	Q5wm4v8ko/nvtu2IKKqjJjGUY2m+LeAbQ8cO5IIfE6f9hr3UfQYmQghc4hoILunPuRfG5s
	U44nadd+ifH6qgfT/Pgl2IzabckesgYmgOGxnef7uVBxxO3/y5hTe9QMmhs2N1KZpfYkVL
	AXu6xd3WyNwUmVT4ZN02k1BaLPboo7PYIOVCQw4W7tUyAR+wjicO54xwzd/5IHRGn4ECTO
	W3nar6q+fAkYlWn0JCE/7IWHVhhZtxE9fkNLyRmlHjaPK9+jNuOpJHdj53MtDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728563146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX5RhoJ/MlDzG/mTrF+6FZ25OV+y6FcZq4dFLjVx4SI=;
	b=GHb+GC/Bkoyk2lO1G6yM5dzZxHOF/pBHJI4gm0V8sOIzQtpo1GzC92nQgNGvsUkqxSCBhx
	y1mpbo/unAXBsMAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: add PREEMPT_LAZY support
Message-ID: <20241010122545.7N_x3GuX@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-4-bigeasy@linutronix.de>
 <20241009130307.GN17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009130307.GN17263@noisy.programming.kicks-ass.net>

=46rom: Jisheng Zhang <jszhang@kernel.org>

riscv has switched to GENERIC_ENTRY, so adding PREEMPT_LAZY is as simple
as adding TIF_NEED_RESCHED_LAZY related definitions and enabling
ARCH_HAS_PREEMPT_LAZY.

[bigeasy: Replace old PREEMPT_AUTO bits with new PREEMPT_LAZY ]

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A6v2:
  - shuffle TIF bits around to make RESCHED next to RESCHED_LAZY.
    Compiles & boots.

 arch/riscv/Kconfig                   |  1 +
 arch/riscv/include/asm/thread_info.h | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf43..3516c58480612 100644
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
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/=
thread_info.h
index 9c10fb180f438..f5916a70879a8 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,9 +107,10 @@ int arch_dup_task_struct(struct task_struct *dst, stru=
ct task_struct *src);
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
@@ -117,9 +118,10 @@ int arch_dup_task_struct(struct task_struct *dst, stru=
ct task_struct *src);
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
--=20
2.45.2

