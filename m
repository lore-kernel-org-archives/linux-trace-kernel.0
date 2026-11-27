Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795823144;
	b=IFReygGKsK+Kc2V87AvsAmfJ9h5K77bp6ZVypnPTwEio+LuxwxzK5McmOKiQQjuIrpY5
	 7WyYVDn25KCJtFqMaQ0WRi8rvvGFMGwhlgaO+G0MaBEBkceIQUruFQYRgBRjG1U9aCZoJ
	 MDrwzzVaBp+hBaZQ3X6EcnZEauRzH7pXjyZ9DHuArbsGHUpcOU8JcDo7m1t8pz5TrZ3Af
	 mYr2JD3Zo6TkQEvjSUeTXhhRFhP2K+n7BskvDehBTxxkhv868iPwnjkpluHd2817ImSYp
	 er7aMmdHmIsbaKF4ayiDtJXbbKko6cXQnvUQZEw/xA9NgVxiUm9nKVUVVpbxujfZPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0JYQL+cloTOFKXdKvvfoQThZrj8EkD9DkZga/ImDFNc=;
	b=uDyVXR6GsSCVYDdk+MfgEq9SRh+XiutF/e5yc/8an8VYCev2jqaHJ7BvBoxH04xLTSl6
	 PEmYMgxRs+CZIjd5jCTqWacljkCNrvBiLULqSCyiy7wkEb53UIM2RLw/A81mpk5D8T5ir
	 YZyNRX5Lho0L5s2D+Ip4OU8RG38x2Jffw/VN7bA/tcxiax1aQsOn5UJPFbMswIf3PEK1S
	 loEm/eApMiWhYdMQf6/qIEFlrDAqx7PBwgugHU1wCxlarqRtPCWKyie05jMUQjfU2SrXC
	 05rsOohCnB1ZsyBlzHFBbs4Cra5m5KNSjbilPt2rQDN/SqBMLu6RUAEYBIm9qowb+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE9qoqAA;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502A606A31F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 23:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2502A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE9qoqAA
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f02ee04378so66933505ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795823143; x=1796427943; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JYQL+cloTOFKXdKvvfoQThZrj8EkD9DkZga/ImDFNc=;
        b=lE9qoqAATJIFmRZNx4fp+CDcNWB0bsteQY2/N/RZRWeH9ziTbcKHeEUpSMgtR/nMxD
         N0vi75SPM6J0CCSx9SJs8GpvUXgZvNWFr4zW0yQx0/5dRbCvQx+AcK1ZhOp+7G+sfjjm
         fQ+6+yO0vZ51OxkRjpByMEIroLiBybkjDeNcurXvHRl1vUWlHQUNyyQ+W0f4RrEAA7cp
         CN526d1yB0EQL0UEqy3vOXUY34bKfXvybtGUFAUyQgOncZPDgm7QbTsMB6cP3sKDfJYL
         LwABp/fxZQCcaa6bhIPQKPH7gvWvwWoBLkOypndmN7X7tD17BjyfkLcO/iWlTMGOAdvt
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795823143; x=1796427943;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JYQL+cloTOFKXdKvvfoQThZrj8EkD9DkZga/ImDFNc=;
        b=mGm7YcnADgHlLw8DLl3tw0l0sXN7AKfyFJVHLZX5Z9RVclx8v+EVUQQEzE2PazfOP0
         pF2zxUUyLyyNGt+6hIf2zQXr7u5WeT24qvlhSkpxAf8no8vmEMtxBdD5GDMVECwT8MOb
         g+FaE90vV+1ffKfVbU6XONyOZtja5yFT4JvTOoXLWZTHcsPLUMqPUhzsM+rEZz3jP4gU
         mCvN6gmw1tUSXgjeCJoVMvCOQY0UJH9X+AkSzK1ipds04eTwEp8LstuMDQB4azLD3/h3
         E2NGifqm2sFjXQ/jitKU/7xMGt+Vl9TfCMw4DkvguYMRVx3TidffphSQI3KM1bzaNWS5
         QReg==
X-Forwarded-Encrypted: i=1; AL+hErHu6ra/sNGin9BBeLlM1g2YRkuH/VbKhzSghJcFWLlXX2V/TKnw8FciIYA+BM+U1NseNB/2t7smwSR8jYK18+NUYtQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gR+4/gj3qDU5PsscU6DR6WwPsryJ2xiUbqRfH125OKg42YEPG
	cKewiCxDRpiD+UlJ6SqKc/1zvlk5iFCuN8WrAbCL9jNKk3YFbf1RbkQx
X-Gm-Gg: AZFdTZfCEZIViYQe2o8YhsLIGit/2eZArQhaACqbNMqp1mRLbFFtPpPk1+rwLoGB5Go
	7LHqMN25gS7+o17PipA+DMaBKCYgg3m2+4F+YL2tx59pZ3IIwwLv3ucsnP403EH7f3Fq/6DkjeO
	rvL49/glskT9BNeB3VyRW/GFgePSjCKocEjfrCr8dpbH+71wJA+Gb9SB7e5N55aler7KYMXeGGo
	2lKQfffbBq4gASdt07atFAbCrDiVxcnm3Qh0nw7ssVcW04nupTKfrkEkkZNQzpb/XP6S5/bfWNj
	zOOtvKfVx2MOm/HjlYFmei1IZkhLRevhU5YdqTRwqU4XhYXjhEC0iZGeKImRaJFGTQcyoNf1KbQ
	K8v142nX79CrPxUrTFcu+6QPiQwLhfjOMcfValgK16XEOuB6tSMCj5DhPr71Fv34oxa68ZLPNbl
	OYQCG2m2erU0FtBmUkiMSl9Thp0i1fq1kfU8iGPIiNLHwa1FEhac4uPGLZTAA6m+kiLFW62CGsz
	FbMYz4/jAa/NBvm1m6FkmqH+QUAM9C7HWCzQZlgmaGEMCc/WxYJET4i6y66YsgBtgq2BPULmeM1
	L2PuBpBE35jLqdg8IjNguVAYm8/PUYE9wxUeoP4M5NbNX+VOSXaMpPEyk/4K1jMByCmQa9gO4zN
	dJKRi1x+F2crVGrICfAmRLfUkyCbWRtKX8A==
X-Received: by 2002:a17:902:f54c:b0:2f0:25ea:8fbe with SMTP id d9443c01a7336-2f03efb104cmr283988045ad.7.1795823143289;
        Fri, 27 Nov 2026 15:45:43 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0ebsm123686035ad.33.2026.11.27.15.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 15:45:42 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 23:45:42 +0000
Message-Id: <DN6E6AI3KW0Y.GIGIAPTDZFS@gmail.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>
Cc: "Shuah Khan" <shuah@kernel.org>, "Aniket Gattani"
 <aniketgattani@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 <bpf@vger.kernel.org>, "Naveen N Rao" <naveen@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/16] selftests/membarrier: Check the memory
 barriers of each thread
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261127185822.158216-16-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com> <20261127185822.158216-16-mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 27, 2026 at 10:58 AM Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>  - The test lists the kernel functions which hold the instructions,
>    and the kind of instruction to look for in each. It finds them by
>    their bytes in the kernel text, which it reads from /proc/kcore.
>    The kernel refuses a kprobe which is not on the first byte of an
>    instruction, so a wrong match is dropped.

A bunch of x86 specific kprobes?
Wow. I haven't seen such a heavy duty selftest before.
I'm glad that it works, but I asked my bot for a simpler solution...

ipi_mb(), ipi_sync_core() and ipi_rseq() are straight-line code.
smp_mb() is their first statement. A call of the handler is an
executed barrier.
csd_do_func() has trace_csd_function_entry(func, csd) right before
func(info).

count the IPIs there instead:

                   kprobe on the insn          csd_function_entry
  ---------------  --------------------------  ----------------------
  finds the place  kallsyms, kcore, opcodes    __ksym, libbpf does it
  arch             x86-64                      all
  lost hits        nested kprobe,              none, irqs are off
                   bpf_prog_active
  global state     kprobes-optimization = 0    none

read_kernel(), scan_function(), probe_sites(), sites[], the cookies,
set_optprobes(), the signal handlers and the "probe hits were lost"
warning go away.

diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c b/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c
new file mode 100644
index 0000000..ffaa899
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Count the membarrier IPIs and the context switches of each registered
+ * thread.
+ *
+ * See membarrier_test_barrier.c.
+ */
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "membarrier_test_barrier.h"
+
+struct mm_struct;
+
+/* The fields which this program reads. CO-RE relocates them. */
+struct task_struct {
+	struct mm_struct *mm;
+} __attribute__((preserve_access_index));
+
+/*
+ * The IPI handlers. libbpf finds them in /proc/kallsyms. The address is 0
+ * when the kernel has no such handler.
+ */
+extern const void ipi_mb __ksym __weak;
+extern const void ipi_sync_core __ksym __weak;
+extern const void ipi_rseq __ksym __weak;
+
+/* Slot of a registered thread. */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u32);
+} task_slot SEC(".maps");
+
+/* The counters of each slot. User-space maps them. */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, MBT_MAX_SLOTS);
+	__type(key, __u32);
+	__type(value, struct mbt_counters);
+} counters SEC(".maps");
+
+/*
+ * Only the CPU which runs a thread, or which switches to it, counts for
+ * that thread. So the increments need no lock.
+ */
+static __always_inline struct mbt_counters *counters_of(struct task_struct *task)
+{
+	__u32 *slot = bpf_task_storage_get(&task_slot, task, 0, 0);
+
+	return slot ? bpf_map_lookup_elem(&counters, slot) : NULL;
+}
+
+/* csd_do_func() is about to call func(). Interrupts are disabled. */
+SEC("tp_btf/csd_function_entry")
+int BPF_PROG(csd_function_entry, void *func)
+{
+	struct mbt_counters *c;
+
+	if (func != &ipi_mb && func != &ipi_sync_core && func != &ipi_rseq)
+		return 0;
+	c = counters_of(bpf_get_current_task_btf());
+	if (!c)
+		return 0;
+	c->c[MBT_IPI]++;
+	if (func == &ipi_sync_core)
+		c->c[MBT_SYNC_CORE]++;
+	return 0;
+}
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next)
+{
+	struct mbt_counters *c;
+
+	c = counters_of(prev);
+	if (c)
+		c->c[MBT_SCHED_OUT]++;
+	if (!next->mm || prev->mm == next->mm)
+		return 0;
+	c = counters_of(next);
+	if (c)
+		c->c[MBT_SCHED_IN]++;
+	return 0;
+}
+
+/* Give a slot to the calling thread. User-space runs this program. */
+SEC("syscall")
+int register_thread(struct mbt_register *ctx)
+{
+	__u32 slot = ctx->slot;
+
+	if (!bpf_task_storage_get(&task_slot, bpf_get_current_task_btf(), &slot,
+				  BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return -1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.h b/tools/testing/selftests/membarrier/membarrier_test_barrier.h
new file mode 100644
index 0000000..da8edfd
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MEMBARRIER_TEST_BARRIER_H
+#define MEMBARRIER_TEST_BARRIER_H
+
+#include <linux/types.h>
+
+/* Counters of a thread. */
+enum {
+	/* A membarrier IPI handler interrupted the thread. */
+	MBT_IPI,
+	/* The handler was ipi_sync_core(). */
+	MBT_SYNC_CORE,
+	/* The thread was scheduled out. */
+	MBT_SCHED_OUT,
+	/*
+	 * The thread was scheduled in after a task of another mm, or
+	 * after a kernel thread.
+	 */
+	MBT_SCHED_IN,
+	MBT_NR_COUNTERS,
+};
+
+struct mbt_counters {
+	__u64 c[16];
+};
+
+/* Argument of the register_thread program. */
+struct mbt_register {
+	__u32 slot;
+};
+
+#define MBT_MAX_SLOTS		512
+
+#endif /* MEMBARRIER_TEST_BARRIER_H */

pw-bot: cr
