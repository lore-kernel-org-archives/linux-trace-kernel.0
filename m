Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960012EFDA1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764091; cv=none; b=dV19koiS0Zfa5xM7zNZt7kQ0SfDWSBDkaIKpdT/jl59JIPuL3VDGeZEUB1rvuo5eb9Ub3MDS+6eX7tDk/RVTzGQkhz90OWqGmkYyF5yo6WLC3TzDpc4G1i0dYfAv3tBs1uR4a0VEAyu2fSO1D4ch6bBjAXNTiE95LdAGedFC0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764091; c=relaxed/simple;
	bh=ZXS69v8edIZ26QIhI7me1CrGw+npC1oaFT+S08Gd0Oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hYdC4zDOsH7Ssyr+mqWfhT4tM8hVnYT1HnTGD+drO0/xtaANCQCim0BTL+Ais1ZPgsHP7DdNDmEqv05Q3beNxUs4mjThTmLZS7obZdwaLmpIR29ps/xV+Lf9rtCDB6ZM+hgvJIKysZy79npM9sHgw+cTe4teI/Oewdf19PAsiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpBwvT3/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpBwvT3/"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso3712595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764088; x=1756368888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bw6e+GCDTHY52oVDlwJDbxbyIfuCcjYQhqZ+t+m5jN4=;
        b=gpBwvT3/9AUjgdPrkdwacno9AiKncBHHps1Lqm4WI32Hz+V3by3C4mssRtzYXkKWlJ
         XCdZ0zyjR/IocWKNm1bBhCuBs+V7O6Y6b8DTSsXXTNiLlF+nVF7E8i2o5WX0Z7CvR4Mx
         21MxwpOLJy7kY8eXk+LTll9DBrYWFmidoybvGHALphzuYN9mHNFUJAYH9ngPL4YHGrUo
         krPF1an3gp4/TPP37lzspsxfJf4xIiQoVm60DOfPTHejWN4PapkWwsxOeSy3/QpUkv7a
         6DkvXj6HtDhDptrhlO4lXv3WblWCNYYY5rfRTSLi9ETFMhpbSGVjLmYxobDi7ESf2SHF
         98pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764088; x=1756368888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw6e+GCDTHY52oVDlwJDbxbyIfuCcjYQhqZ+t+m5jN4=;
        b=jE2GIJitmzTjm6b2LApMbcAMdhU78yieyNIZdqCy0S7xxCSWrMxZDSt62acYEP3Vsp
         aUJfb4rfsDrL5KnJ190sGkh1tgHEm5S7r/UUj55XbhHkCGm/ZUovuHfbtT6N8vf8ymLs
         HdXWTfbgZMSo0KTHgvrI6NG2LAMpA3ThTu4O801OO85IgZTqj1cTplZTkvBEaeFaSIUx
         3W4QjclDvHCpo+lHq5qdpMi41Tbp9WkBupZQJe/YGGtSXniJ3U3JJISf3k9tuWZJGnrv
         c6+R1B7OTv+URrB0PQqEfaQUKJO+U82suG6HljSWy9o3XMyADoj/M7gqrFNLcJnbBpFk
         9v4g==
X-Forwarded-Encrypted: i=1; AJvYcCXQJnEtW05RgUX21V1TV9nAn0w7ZH3s9MOwMyZz+ZNHZ5n+N8Mfe0oM0Lh6gV/H5Zj7iixdIEwlKfcxyoO4fpwOBIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbopZwnrFHlOXPAifzLmRN8xUoUpCEFFkCj6s5rqIY5MEzFHh
	XOCFvKZYt+J5DHmOqkWggG952BsO7jx/TB3MaojOJ2hT4Z9RuneXuB54YgoK2GWYRp9CyHZLmun
	uiGNXJUUEJtmjCOI1uTvaNA==
X-Google-Smtp-Source: AGHT+IGPzyA25qFjecHs0gQ3AC9lDwQuyNkudvxzGh8C/ChYR9CdWPMy/jduzoJMim6RpSGZ0sYZZUZnqx/s57xK
X-Received: from wmbgw6.prod.google.com ([2002:a05:600c:8506:b0:459:d8e5:ae88])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c86:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-45b4d7d4dfcmr12828505e9.3.1755764088239;
 Thu, 21 Aug 2025 01:14:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:07 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-20-vdonnefort@google.com>
Subject: [PATCH v6 19/24] KVM: arm64: Sync boot clock with the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Configure the pKVM hypervisor tracing clock with the kernel boot clock.
For tracing purpose, the boot clock is interesting as it doesn't stop on
suspend. However, it is corrected on a regular basis, which implies we
need to re-evaluate it every once in a while.

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Christopher S. Hall <christopher.s.hall@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 437ac948d136..d122d79718a0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -87,6 +87,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
 	__KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
+	__KVM_HOST_SMCCC_FUNC___pkvm_update_clock_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_unload_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index 996e90c0974f..4e11dcdf049b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -7,6 +7,7 @@
 void *tracing_reserve_entry(unsigned long length);
 void tracing_commit_entry(void);
 
+void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
 int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
 void __pkvm_unload_tracing(void);
 int __pkvm_enable_tracing(bool enable);
@@ -15,6 +16,8 @@ int __pkvm_swap_reader_tracing(unsigned int cpu);
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
 static inline void tracing_commit_entry(void) { }
 
+static inline
+void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
 static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
 static inline void __pkvm_unload_tracing(void) { }
 static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 02b2fdd9a8e4..36a263422e4e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -574,6 +574,18 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
 }
 
+static void handle___pkvm_update_clock_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u32, mult, host_ctxt, 1);
+	DECLARE_REG(u32, shift, host_ctxt, 2);
+	DECLARE_REG(u64, epoch_ns, host_ctxt, 3);
+	DECLARE_REG(u64, epoch_cyc, host_ctxt, 4);
+
+	__pkvm_update_clock_tracing(mult, shift, epoch_ns, epoch_cyc);
+
+	cpu_reg(host_ctxt, 1) = 0;
+}
+
 static void handle___pkvm_load_tracing(struct kvm_cpu_context *host_ctxt)
 {
 	 DECLARE_REG(unsigned long, desc_hva, host_ctxt, 1);
@@ -642,6 +654,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
 	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
+	HANDLE_FUNC(__pkvm_update_clock_tracing),
 	HANDLE_FUNC(__pkvm_load_tracing),
 	HANDLE_FUNC(__pkvm_unload_tracing),
 	HANDLE_FUNC(__pkvm_enable_tracing),
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index f9949b243844..32fd889315f0 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -249,3 +249,19 @@ int __pkvm_swap_reader_tracing(unsigned int cpu)
 
 	return ret;
 }
+
+void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
+{
+	int cpu;
+
+	/* After this loop, all CPUs are observing the new bank... */
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++) {
+		struct simple_rb_per_cpu *simple_rb = per_cpu_ptr(trace_buffer.simple_rbs, cpu);
+
+		while (READ_ONCE(simple_rb->status) == SIMPLE_RB_WRITING)
+			;
+	}
+
+	/* ...we can now override the old one and swap. */
+	trace_clock_update(mult, shift, epoch_ns, epoch_cyc);
+}
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index ccac2ecaf96f..a6664a03f8a9 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/trace_remote.h>
+#include <linux/tracefs.h>
 #include <linux/simple_ring_buffer.h>
 
 #include <asm/kvm_host.h>
@@ -12,6 +13,121 @@
 
 #include "hyp_trace.h"
 
+/* Same 10min used by clocksource when width is more than 32-bits */
+#define CLOCK_MAX_CONVERSION_S	600
+/*
+ * Time to give for the clock init. Long enough to get a good mult/shift
+ * estimation. Short enough to not delay the tracing start too much.
+ */
+#define CLOCK_INIT_MS		100
+/*
+ * Time between clock checks. Must be small enough to catch clock deviation when
+ * it is still tiny.
+ */
+#define CLOCK_UPDATE_MS		500
+
+static struct hyp_trace_clock {
+	u64			cycles;
+	u64			cyc_overflow64;
+	u64			boot;
+	u32			mult;
+	u32			shift;
+	struct delayed_work	work;
+	struct completion	ready;
+	struct mutex		lock;
+	bool			running;
+} hyp_clock;
+
+static void __hyp_clock_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct hyp_trace_clock *hyp_clock;
+	struct system_time_snapshot snap;
+	u64 rate, delta_cycles;
+	u64 boot, delta_boot;
+
+	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
+
+	ktime_get_snapshot(&snap);
+	boot = ktime_to_ns(snap.boot);
+
+	delta_boot = boot - hyp_clock->boot;
+	delta_cycles = snap.cycles - hyp_clock->cycles;
+
+	/* Compare hyp clock with the kernel boot clock */
+	if (hyp_clock->mult) {
+		u64 err, cur = delta_cycles;
+
+		if (WARN_ON_ONCE(cur >= hyp_clock->cyc_overflow64)) {
+			__uint128_t tmp = (__uint128_t)cur * hyp_clock->mult;
+
+			cur = tmp >> hyp_clock->shift;
+		} else {
+			cur *= hyp_clock->mult;
+			cur >>= hyp_clock->shift;
+		}
+		cur += hyp_clock->boot;
+
+		err = abs_diff(cur, boot);
+		/* No deviation, only update epoch if necessary */
+		if (!err) {
+			if (delta_cycles >= (hyp_clock->cyc_overflow64 >> 1))
+				goto fast_forward;
+
+			goto resched;
+		}
+
+		/* Warn if the error is above tracing precision (1us) */
+		if (err > NSEC_PER_USEC)
+			pr_warn_ratelimited("hyp trace clock off by %lluus\n",
+					    err / NSEC_PER_USEC);
+	}
+
+	rate = div64_u64(delta_cycles * NSEC_PER_SEC, delta_boot);
+
+	clocks_calc_mult_shift(&hyp_clock->mult, &hyp_clock->shift,
+			       rate, NSEC_PER_SEC, CLOCK_MAX_CONVERSION_S);
+
+	/* Add a comfortable 50% margin */
+	hyp_clock->cyc_overflow64 = (U64_MAX / hyp_clock->mult) >> 1;
+
+fast_forward:
+	hyp_clock->cycles = snap.cycles;
+	hyp_clock->boot = boot;
+	kvm_call_hyp_nvhe(__pkvm_update_clock_tracing, hyp_clock->mult,
+			  hyp_clock->shift, hyp_clock->boot, hyp_clock->cycles);
+	complete(&hyp_clock->ready);
+
+resched:
+	schedule_delayed_work(&hyp_clock->work,
+			      msecs_to_jiffies(CLOCK_UPDATE_MS));
+}
+
+static void hyp_trace_clock_enable(struct hyp_trace_clock *hyp_clock, bool enable)
+{
+	struct system_time_snapshot snap;
+
+	if (hyp_clock->running == enable)
+		return;
+
+	if (!enable) {
+		cancel_delayed_work_sync(&hyp_clock->work);
+		hyp_clock->running = false;
+	}
+
+	ktime_get_snapshot(&snap);
+
+	hyp_clock->boot = ktime_to_ns(snap.boot);
+	hyp_clock->cycles = snap.cycles;
+	hyp_clock->mult = 0;
+
+	init_completion(&hyp_clock->ready);
+	INIT_DELAYED_WORK(&hyp_clock->work, __hyp_clock_work);
+	schedule_delayed_work(&hyp_clock->work, msecs_to_jiffies(CLOCK_INIT_MS));
+	wait_for_completion(&hyp_clock->ready);
+	hyp_clock->running = true;
+}
+
 /* Access to this struct within the trace_remote_callbacks are protected by the trace_remote lock */
 struct hyp_trace_buffer {
 	struct hyp_trace_desc	*desc;
@@ -173,6 +289,8 @@ static void hyp_trace_unload(struct trace_buffer_desc *desc, void *priv)
 
 static int hyp_trace_enable_tracing(bool enable, void *priv)
 {
+	hyp_trace_clock_enable(&hyp_clock, enable);
+
 	return kvm_call_hyp_nvhe(__pkvm_enable_tracing, enable);
 }
 
@@ -191,7 +309,22 @@ static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
 	return 0;
 }
 
+static int hyp_trace_clock_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, "[boot]\n");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hyp_trace_clock);
+
+static int hyp_trace_init_tracefs(struct dentry *d, void *priv)
+{
+	return tracefs_create_file("trace_clock", 0440, d, NULL, &hyp_trace_clock_fops) ?
+		0 : -ENOMEM;
+}
+
 static struct trace_remote_callbacks trace_remote_callbacks = {
+	.init			= hyp_trace_init_tracefs,
 	.load_trace_buffer	= hyp_trace_load,
 	.unload_trace_buffer	= hyp_trace_unload,
 	.enable_tracing		= hyp_trace_enable_tracing,
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

