Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14321FC0FE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336785; cv=none; b=bAHQHKuyPWhC8rV/V3nN0gWdHTn8AeyKMNw1K5xx/yo6V22q7uhBiP+4VeknS3eL+WIRS/+ijsTYRS+1qzBiezduLci+R+MIRAFj88orhw6iALOi8ci8z3/QB0S+yyqI0qP3g0mtatj4BodlTsN6TZdj2vecEFQASb/7SZo2qpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336785; c=relaxed/simple;
	bh=NZM84OiQAXkoojG1LTw656daP8UvPQf/iadGpDM1Ku4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJIOBxJadXUE0N/gntYU5ileRVdP9P0EPKh0bId1Ymnb7xwu+QxSd+wUZjbUta3ESo452MIyOJnqYtCa6c14KvxOVzmPe5hwcpL37el9xz1HgZWlP4l744ciMoWjPOgJgGcLbVwmKIxQJoMZEmbyPSRdA1sdZ+FLAhYWqO9ilPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkCrYT1W; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkCrYT1W"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43625ceae52so91538165e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336782; x=1736941582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYv/oyiC5/y4Vd4A/vxnaQNzTH0rGNzt4KNFjScWdGU=;
        b=JkCrYT1WMqEAHnoL2yFV+M7Hb+zeyaRWEVLrPP2uSVJTJNHdaNoxkPRdqH9qSD52H3
         ZFQb+exzRVndP8NxYm90bX4L+O8cPVRXGGzIxnrTIirehMS1gTa6AhofcZvT6TRRfBVI
         Ki2zTetwDCpU3HVV3jIMyZEvNkNUVejYcJU2VJ+e7QN2cs/mOp2JXRGhMqxibAqbaefQ
         QiuDhV/jD1y4YrggP9TawGM/4wrw4Wi4qq7ul6wk4SpRgmuNBE1Q8+5um16Rpvduq0ZG
         nIUefJrUGe+a3ziMXslh0wTPalFNtf0wgooRqzE1X1iIbMcQGIMd7hTN4/yKH/pct6Ft
         mR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336782; x=1736941582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYv/oyiC5/y4Vd4A/vxnaQNzTH0rGNzt4KNFjScWdGU=;
        b=NPTTR8x2juo5RQkYZutRyrb9m/Im8twBlW62/7gIiA0m/TM2OsY+Chj4QNFfjAN6d2
         +S4EEwbbX0y51Zzb3qh8Hspx/VzBuqSGP0Xlj9fLYsVz5iuZo5BaxLsl2x4AvcIpH3Nh
         9r7/zbdIYjvt0zTYnXB/3JymPHKL28P719Q0X073Eb1uADHJFNQF7Ch1TfnFoneD/1TG
         7Urx/QBu8bBr8L4ge0sKCYSwtpbx1YgMBxlMy+3K0RTbzlzfC31vOr1DQQhl4A8lqrc+
         odO/1T7rhPme9DmSpoXh8FB+7QoILB73OZbg8PXnQsExpzv/C0phvPDRtWVGxEzsxiFT
         Iicg==
X-Forwarded-Encrypted: i=1; AJvYcCUtugYZhdalpDhh+CPggcpX10RS+H6Lhu9IgNldSCTj7IKKptLt9IqVaa//EZm/jsFdz+Iq/fItv2xB2iQj7Isf3b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DM2foXvujptKGHJOt2GV7J2jmEPTBoiloGPQQXiflMoJvBbt
	ooylXLdjvQw4loPkFMfGPkjOYZPaCkqanwa/z3oyMX0aY+hbIUzm1AXwY/QkCEDbqQVw8+tR+L3
	gmgKYz3CVcnMeUHBejw==
X-Google-Smtp-Source: AGHT+IG3P/WI6G15aNJhYiqZ/XaORqWTLtGoyKDDxxx8JTZF55g/rJW5XOa81KdseVNGpa4acQA3UBIs69MjbhFm
X-Received: from wmqb11.prod.google.com ([2002:a05:600c:4e0b:b0:434:f621:ac8a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1386:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-436e26aeb43mr20489325e9.12.1736336782317;
 Wed, 08 Jan 2025 03:46:22 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:34 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-11-vdonnefort@google.com>
Subject: [PATCH v2 10/12] KVM: arm64: Add trace interface for hyp tracefs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace interface is solely here to reset tracing. Non-consuming read
is not yet supported due to the lack of support in the ring-buffer
meta page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 81bae121a4fe..08b6a021b84e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -83,6 +83,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_reset_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 };
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index df17683a3b12..1004e1edf24f 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -20,6 +20,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
 void __pkvm_teardown_tracing(void);
 int __pkvm_enable_tracing(bool enable);
+int __pkvm_reset_tracing(unsigned int cpu);
 int __pkvm_swap_reader_tracing(unsigned int cpu);
 #else
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
@@ -30,6 +31,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
 static inline void __pkvm_teardown_tracing(void) { }
 static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
+static inline int __pkvm_reset_tracing(unsigned int cpu) { return -ENODEV; }
 static inline int __pkvm_swap_reader_tracing(unsigned int cpu) { return -ENODEV; }
 #endif
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 89a76af342c8..a69c95e1f5e2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -413,6 +413,13 @@ static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_enable_tracing(enable);
 }
 
+static void handle___pkvm_reset_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_reset_tracing(cpu);
+}
+
 static void handle___pkvm_swap_reader_tracing(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
@@ -455,6 +462,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_load_tracing),
 	HANDLE_FUNC(__pkvm_teardown_tracing),
 	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index 022fe2e24f82..6ea0f1d475bb 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -284,12 +284,20 @@ static int rb_page_init(struct hyp_buffer_page *bpage, unsigned long hva)
 	return 0;
 }
 
+static void rb_page_reset(struct hyp_buffer_page *bpage)
+{
+	bpage->write = 0;
+	bpage->entries = 0;
+
+	local_set(&bpage->page->commit, 0);
+}
+
 static bool rb_cpu_loaded(struct hyp_rb_per_cpu *cpu_buffer)
 {
 	return !!cpu_buffer->bpages;
 }
 
-static void rb_cpu_disable_writing(struct hyp_rb_per_cpu *cpu_buffer)
+static int rb_cpu_disable_writing(struct hyp_rb_per_cpu *cpu_buffer)
 {
 	int prev_status;
 
@@ -299,6 +307,8 @@ static void rb_cpu_disable_writing(struct hyp_rb_per_cpu *cpu_buffer)
 						     HYP_RB_READY,
 						     HYP_RB_UNAVAILABLE);
 	} while (prev_status == HYP_RB_WRITING);
+
+	return prev_status;
 }
 
 static int rb_cpu_enable_writing(struct hyp_rb_per_cpu *cpu_buffer)
@@ -311,6 +321,38 @@ static int rb_cpu_enable_writing(struct hyp_rb_per_cpu *cpu_buffer)
 	return 0;
 }
 
+static int rb_cpu_reset(struct hyp_rb_per_cpu *cpu_buffer)
+{
+	struct hyp_buffer_page *bpage;
+	int prev_status;
+
+	if (!rb_cpu_loaded(cpu_buffer))
+		return -ENODEV;
+
+	prev_status = rb_cpu_disable_writing(cpu_buffer);
+
+	bpage = cpu_buffer->head_page;
+	do {
+		rb_page_reset(bpage);
+		bpage = rb_next_page(bpage);
+	} while (bpage != cpu_buffer->head_page);
+
+	rb_page_reset(cpu_buffer->reader_page);
+
+	cpu_buffer->meta->reader.read = 0;
+	cpu_buffer->meta->reader.lost_events = 0;
+	cpu_buffer->meta->entries = 0;
+	cpu_buffer->meta->overrun = 0;
+	cpu_buffer->meta->read = 0;
+	meta_pages_lost(cpu_buffer->meta) = 0;
+	meta_pages_touched(cpu_buffer->meta) = 0;
+
+	if (prev_status == HYP_RB_READY)
+		rb_cpu_enable_writing(cpu_buffer);
+
+	return 0;
+}
+
 static void rb_cpu_teardown(struct hyp_rb_per_cpu *cpu_buffer)
 {
 	int i;
@@ -602,3 +644,17 @@ int __pkvm_enable_tracing(bool enable)
 
 	return ret;
 }
+
+int __pkvm_reset_tracing(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_rb_lock);
+	ret = rb_cpu_reset(per_cpu_ptr(&trace_rb, cpu));
+	hyp_spin_unlock(&trace_rb_lock);
+
+	return ret;
+}
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 3d2a58977442..7c9548bef8f8 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -206,6 +206,11 @@ static int __get_reader_page(int cpu)
 	return kvm_call_hyp_nvhe(__pkvm_swap_reader_tracing, cpu);
 }
 
+static int __reset(int cpu)
+{
+	return kvm_call_hyp_nvhe(__pkvm_reset_tracing, cpu);
+}
+
 static void hyp_trace_free_pages(struct hyp_trace_desc *desc)
 {
 	struct rb_page_desc *rb_desc;
@@ -364,6 +369,7 @@ static int hyp_trace_buffer_load(struct hyp_trace_buffer *hyp_buffer, size_t siz
 
 	hyp_buffer->remote.pdesc = &desc->page_desc;
 	hyp_buffer->remote.get_reader_page = __get_reader_page;
+	hyp_buffer->remote.reset = __reset;
 	hyp_buffer->trace_buffer = ring_buffer_remote(&hyp_buffer->remote);
 	if (!hyp_buffer->trace_buffer) {
 		ret = -ENOMEM;
@@ -828,6 +834,49 @@ static const struct file_operations hyp_trace_raw_fops = {
 	.release        = hyp_trace_raw_release,
 };
 
+static void hyp_trace_reset(int cpu)
+{
+	struct hyp_trace_buffer *hyp_buffer = &hyp_trace_buffer;
+
+	mutex_lock(&hyp_buffer->lock);
+
+	if (!hyp_trace_buffer_loaded(hyp_buffer))
+		goto out;
+
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		ring_buffer_reset(hyp_buffer->trace_buffer);
+	else
+		ring_buffer_reset_cpu(hyp_buffer->trace_buffer, cpu);
+
+out:
+	mutex_unlock(&hyp_buffer->lock);
+}
+
+static int hyp_trace_open(struct inode *inode, struct file *file)
+{
+	int cpu = (s64)inode->i_private;
+
+	if (file->f_mode & FMODE_WRITE) {
+		hyp_trace_reset(cpu);
+
+		return 0;
+	}
+
+	return -EPERM;
+}
+
+static ssize_t hyp_trace_write(struct file *filp, const char __user *ubuf,
+			       size_t count, loff_t *ppos)
+{
+	return count;
+}
+
+static const struct file_operations hyp_trace_fops = {
+	.open           = hyp_trace_open,
+	.write          = hyp_trace_write,
+	.release        = NULL,
+};
+
 static int hyp_trace_clock_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "[boot]\n");
@@ -860,6 +909,9 @@ int hyp_trace_init_tracefs(void)
 	tracefs_create_file("trace_pipe", TRACEFS_MODE_WRITE, root,
 			    (void *)RING_BUFFER_ALL_CPUS, &hyp_trace_pipe_fops);
 
+	tracefs_create_file("trace", TRACEFS_MODE_WRITE, root,
+			    (void *)RING_BUFFER_ALL_CPUS, &hyp_trace_fops);
+
 	tracefs_create_file("trace_clock", TRACEFS_MODE_READ, root, NULL,
 			    &hyp_trace_clock_fops);
 
@@ -885,6 +937,9 @@ int hyp_trace_init_tracefs(void)
 
 		tracefs_create_file("trace_pipe_raw", TRACEFS_MODE_READ, per_cpu_dir,
 				    (void *)cpu, &hyp_trace_pipe_fops);
+
+		tracefs_create_file("trace", TRACEFS_MODE_READ, per_cpu_dir,
+				    (void *)cpu, &hyp_trace_fops);
 	}
 
 	return 0;
-- 
2.47.1.613.gc27f4b7a9f-goog

