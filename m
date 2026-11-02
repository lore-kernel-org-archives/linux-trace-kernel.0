Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603470;
	b=nkDsU5ai6j0OzfRwXt5MMMDBuwUTToWcAmMeTZmqbnZjFoaVPkNrq9nk4IFquRaHKmx5
	 pCbEB0GaZF9lmHv52MWsUYZsjUlueHZNZTWkMJcgoJq2oM7O9OD0tWwWOsx26StRY36W3
	 74TLzevt1cfA72/TFWvKqGJR/gunuQJcasIetthvlbG0lLYoTpZFxd9pmxDsrE8Mh9QnZ
	 54PgHBsWvDRgNhqQg5rT2Y+ZOA6mDxRi6lkCsrx5fuOtJUvF2fqC11sFUgWDThzUdDqkc
	 c9iIgMwaSJo9UQy7a9kovMQDbM8eSM9nPT+VvDbKle413TrRS6SjFKnedOmD6/6a1RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yAzS75saZByb9apMhQrSWjtwxztW1efeFrQVJDeKCUE=;
	b=4s5Z1SZ0114sItNG2e6q8RdvcmujmEHXpGSV/0IHqbAwF7dFWNjFc2X21tupkEEGhZvA
	 YK4x6X/gF3tLSK+iZ6L4fzc4fc6rPl7dcit2w3QYAQ9EIadmYnAhdxFDOGl+mHEf88Y01
	 SPL/Lw9rmJn1SEJLRpXwaayamdI3BYTYabXumwlkXIR6O1Z31zHyjsc+B1y+zM5pGo8Xf
	 17GX9G6vAKJmNbLdppOiCmsTy1ciKYKo9XpJ9GLkBHFK0SrTKz/ljWEaoXOgZnHFsVam2
	 mGdbqOVY84O877b2UCWqWvL+FeHXN5GG4TAajEb9UT/1tNA1aumLKwJ5cbe2BpWnShA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozCn8FnB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA1606A326;
	Mon,  2 Nov 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozCn8FnB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ED91F00A15;
	Mon,  2 Nov 2026 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793603469;
	bh=yAzS75saZByb9apMhQrSWjtwxztW1efeFrQVJDeKCUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ozCn8FnBhg2+g0osZpghCb0aTSKuYKtfipEMGcp+OEXAOaIHF0BQMQX/r+g2nOROn
	 5VI52DW9WBzhhAlB8ogKVB7WqShv0zOrA/V0q399A4q37+MygMO9k39/vC20HdOWyH
	 OV2q73M9dBHn6HK2/Giq0pyDw2FqjmrksRO2e/kCQpO1OqnUPsRLUKU4C/LXpPnK37
	 Xut6suWrNw+0cQRF0pUTBCm1hReLGFOV+cne/KGYN5+hH6djEv274Sg6kQyA4Cxh2O
	 neGRb9oGgPSt/Wy9o60bodY1P+C8cSJrpi1N1lT5hMavXD4v1VKXHW/tDKkpjl3mOX
	 5qfAwyFK4mSWw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/3] samples/kprobes: Use trace_printk() in probe handlers
Date: Mon,  2 Nov 2026 16:11:04 +0900
Message-ID: <179360346488.115681.12990812332058260390.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179360345418.115681.193455787480210412.stgit@devnote2>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Probe handlers execute in atomic/non-preemptible contexts. Furthermore,
unless hit via an unoptimized breakpoint on certain architectures,
they do not run with in_nmi() set (e.g. jump-optimized kprobes,
ftrace-based kprobes, or kretprobe return handlers). Calling printk()
from probe handlers can directly attempt to acquire console and
scheduler locks (via console_unlock()), risking a deadlock if the
probed context or interrupted code already holds one of those locks.

Replace printk() (pr_info) in handler_pre(), handler_post(), and
ret_handler() with trace_printk(), and update the comments to direct
users to /sys/kernel/tracing/trace. Also update the stack backtrace
comment in kprobe_example to reference trace_dump_stack(0).

Also fix a minor format string typo ("p->addr," -> "p->addr =") in the
S390 pre and post handlers while touching those lines.

Additionally, update CONFIG_SAMPLE_KPROBES in samples/Kconfig to
depend on EVENT_TRACING so that the tracing subsystem is enabled
when building the samples.

Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Closes: https://lore.kernel.org/all/d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 samples/Kconfig                     |    2 +
 samples/kprobes/kprobe_example.c    |   69 ++++++++++++++++++-----------------
 samples/kprobes/kretprobe_example.c |   10 +++--
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 00eed83c07df..54414e57ff75 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -71,7 +71,7 @@ config SAMPLE_KOBJECT
 
 config SAMPLE_KPROBES
 	tristate "Build kprobes examples -- loadable modules only"
-	depends on KPROBES && m
+	depends on KPROBES && EVENT_TRACING && m
 	help
 	  This build several kprobes example modules.
 
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 53ec6c8b8c40..0f516a2b04be 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -6,7 +6,7 @@
  * For more information on theory of operation of kprobes, see
  * Documentation/trace/kprobes.rst
  *
- * You will see the trace data in /var/log/messages and on the console
+ * You will see the trace data in /sys/kernel/tracing/trace
  * whenever kernel_clone() is invoked to create a new process.
  */
 
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/trace_printk.h>
 
 static char symbol[KSYM_NAME_LEN] = "kernel_clone";
 module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
@@ -28,39 +29,39 @@ static struct kprobe kp = {
 static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86
-	pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->ip, regs->flags);
+	trace_printk("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->ip, regs->flags);
 #endif
 #ifdef CONFIG_PPC
-	pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
-		p->symbol_name, p->addr, regs->nip, regs->msr);
+	trace_printk("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->nip, regs->msr);
 #endif
 #ifdef CONFIG_MIPS
-	pr_info("<%s> p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
-		p->symbol_name, p->addr, regs->cp0_epc, regs->cp0_status);
+	trace_printk("<%s> p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->cp0_epc, regs->cp0_status);
 #endif
 #ifdef CONFIG_ARM64
-	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, pstate = 0x%lx\n",
-		p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
+	trace_printk("<%s> p->addr = 0x%p, pc = 0x%lx, pstate = 0x%lx\n",
+		     p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
 #endif
 #ifdef CONFIG_ARM
-	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
-		p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
+	trace_printk("<%s> p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
+		     p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
 #endif
 #ifdef CONFIG_RISCV
-	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
-		p->symbol_name, p->addr, regs->epc, regs->status);
+	trace_printk("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->epc, regs->status);
 #endif
 #ifdef CONFIG_S390
-	pr_info("<%s> p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
+	trace_printk("<%s> p->addr = 0x%p, ip = 0x%lx, flags = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->psw.addr, regs->flags);
 #endif
 #ifdef CONFIG_LOONGARCH
-	pr_info("<%s> p->addr = 0x%p, era = 0x%lx, estat = 0x%lx\n",
-		p->symbol_name, p->addr, regs->csr_era, regs->csr_estat);
+	trace_printk("<%s> p->addr = 0x%p, era = 0x%lx, estat = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->csr_era, regs->csr_estat);
 #endif
 
-	/* A dump_stack() here will give a stack backtrace */
+	/* A trace_dump_stack(0) here will give a stack backtrace */
 	return 0;
 }
 
@@ -69,36 +70,36 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 				unsigned long flags)
 {
 #ifdef CONFIG_X86
-	pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->flags);
+	trace_printk("<%s> p->addr = 0x%p, flags = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->flags);
 #endif
 #ifdef CONFIG_PPC
-	pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
-		p->symbol_name, p->addr, regs->msr);
+	trace_printk("<%s> p->addr = 0x%p, msr = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->msr);
 #endif
 #ifdef CONFIG_MIPS
-	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
-		p->symbol_name, p->addr, regs->cp0_status);
+	trace_printk("<%s> p->addr = 0x%p, status = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->cp0_status);
 #endif
 #ifdef CONFIG_ARM64
-	pr_info("<%s> p->addr = 0x%p, pstate = 0x%lx\n",
-		p->symbol_name, p->addr, (long)regs->pstate);
+	trace_printk("<%s> p->addr = 0x%p, pstate = 0x%lx\n",
+		     p->symbol_name, p->addr, (long)regs->pstate);
 #endif
 #ifdef CONFIG_ARM
-	pr_info("<%s> p->addr = 0x%p, cpsr = 0x%lx\n",
-		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
+	trace_printk("<%s> p->addr = 0x%p, cpsr = 0x%lx\n",
+		     p->symbol_name, p->addr, (long)regs->ARM_cpsr);
 #endif
 #ifdef CONFIG_RISCV
-	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
-		p->symbol_name, p->addr, regs->status);
+	trace_printk("<%s> p->addr = 0x%p, status = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->status);
 #endif
 #ifdef CONFIG_S390
-	pr_info("<%s> p->addr, 0x%p, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->flags);
+	trace_printk("<%s> p->addr = 0x%p, flags = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->flags);
 #endif
 #ifdef CONFIG_LOONGARCH
-	pr_info("<%s> p->addr = 0x%p, estat = 0x%lx\n",
-		p->symbol_name, p->addr, regs->csr_estat);
+	trace_printk("<%s> p->addr = 0x%p, estat = 0x%lx\n",
+		     p->symbol_name, p->addr, regs->csr_estat);
 #endif
 }
 
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 65d6dcafd742..9dd5cf9a7432 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -14,9 +14,8 @@
  * Documentation/trace/kprobes.rst
  *
  * Build and insert the kernel module as done in the kprobe example.
- * You will see the trace data in /var/log/messages and on the console
- * whenever the probed function returns. (Some messages may be suppressed
- * if syslogd is configured to eliminate duplicate messages.)
+ * You will see the trace data in /sys/kernel/tracing/trace
+ * whenever the probed function returns.
  */
 
 #include <linux/kernel.h>
@@ -24,6 +23,7 @@
 #include <linux/kprobes.h>
 #include <linux/ktime.h>
 #include <linux/sched.h>
+#include <linux/trace_printk.h>
 
 static char func_name[KSYM_NAME_LEN] = "kernel_clone";
 module_param_string(func, func_name, KSYM_NAME_LEN, 0644);
@@ -63,8 +63,8 @@ static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 
 	now = ktime_get();
 	delta = ktime_to_ns(ktime_sub(now, data->entry_stamp));
-	pr_info("%s returned %lu and took %lld ns to execute\n",
-			func_name, retval, (long long)delta);
+	trace_printk("%s returned %lu and took %lld ns to execute\n",
+		     func_name, retval, (long long)delta);
 	return 0;
 }
 NOKPROBE_SYMBOL(ret_handler);

