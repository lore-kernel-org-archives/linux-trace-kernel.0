Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFD54764;
	Tue, 10 Jun 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566863; cv=none; b=DGaC+hnWn5Hyfjcr/0pTSnaxCULDcWT5ET4PktuQq++yBpFc49BCNza6sSERiCvx0WATpNuA5BNfgX6txdYksmUplgOwEk5Dh/gV9IIrK3RtopoVI0vP63whJl/e/leZPnLDV3r0FL3FfTAbVX3P1WM4JfgupG/d1Zpts1VfZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566863; c=relaxed/simple;
	bh=iic1ABt9KyTTjm0Llg0Eh0qFg1jiqfTpJEbRjNXzdgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGvULK7SsL6RoxUbe7HRFr0gxqb3a8pRmOdHxcRNEUxHwZpl1lCh2SvouCz58XKGJE4cA7yW8AZ/lFqfh5abDmMaAL2yPt3VYTrZmfWGfBxO5dksD2IMuVq5RvKAHJiBzFHIR/mA4ReR1iJtJ7jalZi8SeXX4jf6kjxSsHp1DDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhm+8hr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhm+8hr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C8BC4CEED;
	Tue, 10 Jun 2025 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566863;
	bh=iic1ABt9KyTTjm0Llg0Eh0qFg1jiqfTpJEbRjNXzdgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xhm+8hr2FG9j9dkt9Zvpog5qRK8b5/nzB0g3UyF9Dp1bbeZOhOLDR6DKwpfeGWiTh
	 W3EzWQBn3FtuEJziWXj0l2x4HBAf2D6l8Y3jYZ6v2uJnmOHUSJN6YU4xAlIR0dfmJi
	 UVBQD6zJOzpUasXqrXeOds+Sw4+PLr2Qt0K4858RPsiV3eB3Q7AwAFgnw1qYdTg3Ug
	 jwRzRsBfPQQEKfuTURpnZQ1DRMj05jMQnkwD5OMwQXLWl3IEAKd1wmyxyiJXOC6t39
	 7l9VsaAcLm9i7Ir5Cf+sc1Afls/ssQwAQDMPPn4WurzaNi4v0W/0aF0CRgvLkMRRfc
	 ZtoLRZDSTIpWQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 1/2] x86: Retry with new instruction if INT3 is disappaered
Date: Tue, 10 Jun 2025 23:47:38 +0900
Message-ID:  <174956685825.1494782.929110313017233978.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
In-Reply-To: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

An Oops caused by a stray INT3 is reported by LKFT.

 ## Test log
 ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
 starting test ftrace-stress-test (ftrace_stress_test.sh 90)
 <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
 <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
 6.15.0-next-20250605 #1 PREEMPT(voluntary)
 <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
 <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
 12 e4 fe

But INT3(cc) is not shown in the dumped code. This means there is a
chance to handle an INT3 exception when the INT3 is replaecd with
the original instruction.

To evacuate the kernel from this stuation, when the kernel failed to
handle the INT3, check whether there is an INT3 at the trapped
address. If there isn't, retry executing the new instruction.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/traps.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..f489e86c1b5e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -880,6 +880,29 @@ static void do_int3_user(struct pt_regs *regs)
 	cond_local_irq_disable(regs);
 }
 
+static int handle_disappeared_int3(struct pt_regs *regs)
+{
+	unsigned long addr = instruction_pointer(regs) - INT3_INSN_SIZE;
+	unsigned char opcode;
+	int ret;
+
+	/*
+	 * Evacuate the kernel from disappeared int3, which was there when
+	 * the exception happens, but it is removed now by another CPU.
+	 */
+	ret = copy_from_kernel_nofault(&opcode, (void *)addr, INT3_INSN_SIZE);
+	if (ret < 0)
+		return ret;
+	if (opcode == INT3_INSN_OPCODE)
+		return -EFAULT;
+
+	/* There is no INT3 here. Retry with the new instruction. */
+	WARN_ONCE(1, "A disappeared INT3 was handled at %pS.", (void *)addr);
+	instruction_pointer_set(regs, addr);
+
+	return 0;
+}
+
 DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
@@ -907,7 +930,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 
 		instrumentation_begin();
-		if (!do_int3(regs))
+		if (!do_int3(regs) && handle_disappeared_int3(regs) < 0)
 			die("int3", regs, 0);
 		instrumentation_end();
 		irqentry_nmi_exit(regs, irq_state);

