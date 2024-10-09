Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212B18E028;
	Wed,  9 Oct 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471442; cv=none; b=SN7QPOCo5PmtE8MFaxtBdso6nCpBL3OU6T0Go3ooVpWzfnXfUMuYMlXGvWO8OuWLrG+Tten494jGkmJFN/1WkTedepvp9YHozP2X8oo9TSg69JRpfa+RAza/CauGDJoSu6BIQFgA2iohnSKjbNe2gWqkB5Ws3x5lf49oG2EX4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471442; c=relaxed/simple;
	bh=yW0IdweyOm15doJLVg/h0S2faD8U88AwBF3+5UhkGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIAdS/IDPqrXdQ8DwVEDGAUI+L3VbQYtQrleWB8sRFxB41fmBarJp9qY6PmCG92aW6FfVtAdIUzQBNUA4dobC+e11d8jz0Lk+crfyW7mP8xJBI1UpgImAiDAnY4I/gFibO8TL5aUYMddXRGgAI/NDL0L1CxCNbetbOoFbNnmGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bz++JAuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9sUCqac; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bz++JAuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9sUCqac"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMLrliO9lAbb+dJaG2LlaA1SSyEScnNEwlBTF2eF/dI=;
	b=Bz++JAuDWa3PCULVNbkOYe1NjQAHb4suiUw5KTd/ClMg2LC9b4aJWPRfiNJQwwMvYC+7+Z
	sl5n5YodQ97tWyKw7NX3aFQRiKq7Uc6rDHfWIlTxb+PHEhQBp+0bFdwqVoP0E7QpkgcLJp
	U75G3FwnqTQYnAuPn5EijoupkIYyqHIkvk8zVoaRQPlIl7TkpjTwZBR22KVvdEycX6ARYz
	Lk6X/s5WyK5/YmaogR6qSgTvjremFTMpAN5aR/+hUpsluY/ljxxCOP3eqearkzfpkVKHBA
	u+2ar/ejibmt6Dw+lrjGipJQAwd0a9Yb6T06ZQ0TfULLidwH2EWMrBM1NIW9eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMLrliO9lAbb+dJaG2LlaA1SSyEScnNEwlBTF2eF/dI=;
	b=L9sUCqacxH9ZpLdofZVOeTpbD/iXzqiub6ab3qtt8TLPPEQnO4gfx+F15rOYfvQDrwZAux
	DKTF505J55Kk/XCw==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] riscv: add PREEMPT_LAZY support
Date: Wed,  9 Oct 2024 12:50:57 +0200
Message-ID: <20241009105709.887510-4-bigeasy@linutronix.de>
In-Reply-To: <20241009105709.887510-1-bigeasy@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
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
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/riscv/Kconfig                   | 1 +
 arch/riscv/include/asm/thread_info.h | 2 ++
 2 files changed, 3 insertions(+)

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
index 9c10fb180f438..8b5a5ddea4293 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,6 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struc=
t task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
+#define TIF_NEED_RESCHED_LAZY	0       /* Lazy rescheduling needed */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
@@ -117,6 +118,7 @@ int arch_dup_task_struct(struct task_struct *dst, struc=
t task_struct *src);
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to =
user */
=20
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
--=20
2.45.2

