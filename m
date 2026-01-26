Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F833335540
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424283; cv=none; b=GqvG9HkzWJq31sQuRWrINTvNkFf/8i8obfmLmC9SCWPLFi19KKcA/oXTa7sdeN1v4bpeOVNKEamYql2AUmdktBk0WsoIRy0lTXxUgzcC/bxkS4KGWtg5sUBqQDDl8eYiM3fqQ8MwNUTphuAw993Gm2O9XvC5aJSznyU/wLFBvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424283; c=relaxed/simple;
	bh=bPFRL692BOvU5DvpfyFvfhyxsnSIaPLNNQFJH0MR+7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hulgNuLvlcS5UhyWRpDAKlGVDuyx+23Lbhv/ef7g2VSC5aJBmYOHXXZZ4fvb6OoKzuPO9j407kJZa6FuXLIGpTNt43dlGBdeh81bbluCtkvfkhRtoR2Q7e4Z1yJ2Z4sP3OZD0TWPY/XQvYt/ZMg0IKvyCivoxSt9JPWclkUTLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEnzkRax; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEnzkRax"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso45986425e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424279; x=1770029079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTaG7ti7EadExoRYTduoC20Wwf7BQw6/YXyO13ReAkY=;
        b=WEnzkRaxAG4Lw6Thwvll6HAj+Wvg77ST4ZP2uiEHlUOK2dCNeF2LxWwlbI/rplvPvy
         vJftew6OvGnL3Wu83NogRzdmCH/xBMECfGHzhyzyMaokaE9Gwh1O/01h6SSXVBhaxZL8
         UL0bvzOEHAvxJFJWwuAqNFwdz8tsGyPEz6UmG0qPJu6jpaf1nmzrCbVmzo50Dn/6M0T/
         k/o0kcfEM6M6eb5jN8DJJcBNhKx25LkQasEkxSx+PL1k2kc9j0oKf/+gwOJJ41VIUQB/
         /bK/gfC0vP2YX7Ckt2cdmclaGGvS1LRd7OhjiFMpjzPHCiRKOlolLtUhcRMoaUCOtQXF
         RSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424279; x=1770029079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTaG7ti7EadExoRYTduoC20Wwf7BQw6/YXyO13ReAkY=;
        b=HnvYL5WTNIKCOZNHmxF5SkXOe9e9yoNryTDqDvCSM5+RFYQEy3nmxNKyrme0M5yFYc
         dZV2qlcSOf2DnsaxHNrb8iytxCYFCDaYP3RwwHVRYY5ZXyAx58zGqhiVmrcAHn6x/FpD
         bDIFQVqIkHoEWvW5a/jwcRmzewpuXNDv6X9v8BGV+lxbYwGZeUJLE3PQrxWEXqpcrUVr
         bkvrDQNmeuRe0aOWEy6ycsr56uZNvfYjTVXlwheEyudRbdn6CYqVby5oTwIsu6qV81Hx
         9BaTfUH6Vb5rkrusJOWTx56LQd9TdSccHL6wagdu4ehGVIXqpiqhgzSSuCTpozdT8mRp
         UxUA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNSlxf9tjjolNjXAm40bnmfC+08yR52in00+iRNKaYn2F6IC8EB80DPmz5moG9PPdz8mG1WgiZX/qO2qwEAC/9Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPEleTRyaJsTuytSMiRG/qfqaqbjPE4sB1w4sTorMsnn/xSL/P
	okykmFUsJUgowwbQ7RqNMZQw0RwHHW/pvBTdl1GQjd/s0KmynubNZCqYw3URDKQjuCQGM7qqoIf
	fbAHgvEi8cdgLY1XvQ+hwjg==
X-Received: from wmjv4.prod.google.com ([2002:a7b:cb44:0:b0:480:2051:60e1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:699a:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-4805d066135mr64170645e9.36.1769424278959;
 Mon, 26 Jan 2026 02:44:38 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:03 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-15-vdonnefort@google.com>
Subject: [PATCH v10 14/30] tracing: Add a trace remote module for testing
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a module to help testing the tracefs support for trace remotes. This
module:

  * Use simple_ring_buffer to write into a ring-buffer.
  * Declare a single "selftest" event that can be triggered from
    user-space.
  * Register a "test" trace remote.

This is intended to be used by trace remote selftests.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9d8932a7b9c..43812bb7fcf8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -664,6 +664,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
 }
+EXPORT_SYMBOL_GPL(tracefs_create_file);
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dfaf1af8862e..994d0c279060 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1284,4 +1284,12 @@ config TRACE_REMOTE
 config SIMPLE_RING_BUFFER
 	bool
 
+config TRACE_REMOTE_TEST
+	tristate "Test module for remote tracing"
+	select TRACE_REMOTE
+	select SIMPLE_RING_BUFFER
+	help
+	  This trace remote includes a ring-buffer writer implementation using
+	  "simple_ring_buffer". This is solely intending for testing.
+
 endif # FTRACE
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index efe12e282f8c..9e86c43bf320 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -129,4 +129,6 @@ obj-$(CONFIG_RV) += rv/
 
 obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
+obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
+
 libftrace-y := ftrace.o
diff --git a/kernel/trace/remote_test.c b/kernel/trace/remote_test.c
new file mode 100644
index 000000000000..059127489c99
--- /dev/null
+++ b/kernel/trace/remote_test.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 - Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <linux/module.h>
+#include <linux/simple_ring_buffer.h>
+#include <linux/trace_remote.h>
+#include <linux/tracefs.h>
+#include <linux/types.h>
+
+#define REMOTE_EVENT_INCLUDE_FILE kernel/trace/remote_test_events.h
+#include <trace/define_remote_events.h>
+
+static DEFINE_PER_CPU(struct simple_rb_per_cpu *, simple_rbs);
+static struct trace_buffer_desc *remote_test_buffer_desc;
+
+/*
+ * The trace_remote lock already serializes accesses from the trace_remote_callbacks.
+ * However write_event can still race with load/unload.
+ */
+static DEFINE_MUTEX(simple_rbs_lock);
+
+static int remote_test_load_simple_rb(int cpu, struct ring_buffer_desc *rb_desc)
+{
+	struct simple_rb_per_cpu *cpu_buffer;
+	struct simple_buffer_page *bpages;
+	int ret = -ENOMEM;
+
+	cpu_buffer = kmalloc(sizeof(*cpu_buffer), GFP_KERNEL);
+	if (!cpu_buffer)
+		return ret;
+
+	bpages = kmalloc_array(rb_desc->nr_page_va, sizeof(*bpages), GFP_KERNEL);
+	if (!bpages)
+		goto err_free_cpu_buffer;
+
+	ret = simple_ring_buffer_init(cpu_buffer, bpages, rb_desc);
+	if (ret)
+		goto err_free_bpages;
+
+	scoped_guard(mutex, &simple_rbs_lock)
+		*per_cpu_ptr(&simple_rbs, cpu) = cpu_buffer;
+
+	return 0;
+
+err_free_bpages:
+	kfree(bpages);
+
+err_free_cpu_buffer:
+	kfree(cpu_buffer);
+
+	return ret;
+}
+
+static void remote_test_unload_simple_rb(int cpu)
+{
+	struct simple_rb_per_cpu *cpu_buffer = *per_cpu_ptr(&simple_rbs, cpu);
+	struct simple_buffer_page *bpages;
+
+	if (!cpu_buffer)
+		return;
+
+	guard(mutex)(&simple_rbs_lock);
+
+	bpages = cpu_buffer->bpages;
+	simple_ring_buffer_unload(cpu_buffer);
+	kfree(bpages);
+	kfree(cpu_buffer);
+	*per_cpu_ptr(&simple_rbs, cpu) = NULL;
+}
+
+static struct trace_buffer_desc *remote_test_load(unsigned long size, void *unused)
+{
+	struct ring_buffer_desc *rb_desc;
+	struct trace_buffer_desc *desc;
+	size_t desc_size;
+	int cpu, ret;
+
+	if (WARN_ON(remote_test_buffer_desc))
+		return ERR_PTR(-EINVAL);
+
+	desc_size = trace_buffer_desc_size(size, num_possible_cpus());
+	if (desc_size == SIZE_MAX) {
+		ret = -E2BIG;
+		goto err_unlock_cpus;
+	}
+
+	desc = kmalloc(desc_size, GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_unlock_cpus;
+	}
+
+	ret = trace_remote_alloc_buffer(desc, desc_size, size, cpu_possible_mask);
+	if (ret)
+		goto err_free_desc;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, desc) {
+		ret = remote_test_load_simple_rb(rb_desc->cpu, rb_desc);
+		if (ret)
+			goto err;
+	}
+
+	remote_test_buffer_desc = desc;
+
+	return remote_test_buffer_desc;
+
+err:
+	for_each_ring_buffer_desc(rb_desc, cpu, remote_test_buffer_desc)
+		remote_test_unload_simple_rb(rb_desc->cpu);
+	trace_remote_free_buffer(remote_test_buffer_desc);
+
+err_free_desc:
+	kfree(desc);
+
+err_unlock_cpus:
+	cpus_read_unlock();
+
+	return ERR_PTR(ret);
+}
+
+static void remote_test_unload(struct trace_buffer_desc *desc, void *unused)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu;
+
+	if (WARN_ON(desc != remote_test_buffer_desc))
+		return;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, desc)
+		remote_test_unload_simple_rb(rb_desc->cpu);
+
+	remote_test_buffer_desc = NULL;
+	trace_remote_free_buffer(desc);
+	kfree(desc);
+}
+
+static int remote_test_enable_tracing(bool enable, void *unused)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu;
+
+	if (!remote_test_buffer_desc)
+		return -ENODEV;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, remote_test_buffer_desc)
+		WARN_ON(simple_ring_buffer_enable_tracing(*per_cpu_ptr(&simple_rbs, rb_desc->cpu),
+							  enable));
+	return 0;
+}
+
+static int remote_test_swap_reader_page(unsigned int cpu, void *unused)
+{
+	struct simple_rb_per_cpu *cpu_buffer;
+
+	if (cpu >= NR_CPUS)
+		return -EINVAL;
+
+	cpu_buffer = *per_cpu_ptr(&simple_rbs, cpu);
+	if (!cpu_buffer)
+		return -EINVAL;
+
+	return simple_ring_buffer_swap_reader_page(cpu_buffer);
+}
+
+static int remote_test_reset(unsigned int cpu, void *unused)
+{
+	struct simple_rb_per_cpu *cpu_buffer;
+
+	if (cpu >= NR_CPUS)
+		return -EINVAL;
+
+	cpu_buffer = *per_cpu_ptr(&simple_rbs, cpu);
+	if (!cpu_buffer)
+		return -EINVAL;
+
+	return simple_ring_buffer_reset(cpu_buffer);
+}
+
+static int remote_test_enable_event(unsigned short id, bool enable, void *unused)
+{
+	if (id != REMOTE_TEST_EVENT_ID)
+		return -EINVAL;
+
+	/*
+	 * Let's just use the struct remote_event enabled field that is turned on and off by
+	 * trace_remote. This is a bit racy but good enough for a simple test module.
+	 */
+	return 0;
+}
+
+static ssize_t
+write_event_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *pos)
+{
+	struct remote_event_format_selftest *evt_test;
+	struct simple_rb_per_cpu *cpu_buffer;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&simple_rbs_lock);
+
+	if (!remote_event_selftest.enabled)
+		return -ENODEV;
+
+	cpu_buffer = *this_cpu_ptr(&simple_rbs);
+	if (!cpu_buffer)
+		return -ENODEV;
+
+	evt_test = simple_ring_buffer_reserve(cpu_buffer,
+					      sizeof(struct remote_event_format_selftest),
+					      trace_clock_global());
+	if (!evt_test)
+		return -ENODEV;
+
+	evt_test->hdr.id = REMOTE_TEST_EVENT_ID;
+	evt_test->id = val;
+
+	simple_ring_buffer_commit(cpu_buffer);
+
+	return cnt;
+}
+
+static const struct file_operations write_event_fops = {
+	.write	= write_event_write,
+};
+
+static int remote_test_init_tracefs(struct dentry *d, void *unused)
+{
+	return tracefs_create_file("write_event", 0200, d, NULL, &write_event_fops) ?
+		0 : -ENOMEM;
+}
+
+static struct trace_remote_callbacks trace_remote_callbacks = {
+	.init			= remote_test_init_tracefs,
+	.load_trace_buffer	= remote_test_load,
+	.unload_trace_buffer	= remote_test_unload,
+	.enable_tracing		= remote_test_enable_tracing,
+	.swap_reader_page	= remote_test_swap_reader_page,
+	.reset			= remote_test_reset,
+	.enable_event		= remote_test_enable_event,
+};
+
+static int __init remote_test_init(void)
+{
+	return trace_remote_register("test", &trace_remote_callbacks, NULL,
+				     &remote_event_selftest, 1);
+}
+
+module_init(remote_test_init);
+
+MODULE_DESCRIPTION("Test module for the trace remote interface");
+MODULE_AUTHOR("Vincent Donnefort");
+MODULE_LICENSE("GPL");
diff --git a/kernel/trace/remote_test_events.h b/kernel/trace/remote_test_events.h
new file mode 100644
index 000000000000..26b93b3406fc
--- /dev/null
+++ b/kernel/trace/remote_test_events.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define REMOTE_TEST_EVENT_ID 1
+
+REMOTE_EVENT(selftest, REMOTE_TEST_EVENT_ID,
+	RE_STRUCT(
+		re_field(u64, id)
+	),
+	RE_PRINTK("id=%llu", __entry->id)
+);
-- 
2.52.0.457.g6b5491de43-goog

