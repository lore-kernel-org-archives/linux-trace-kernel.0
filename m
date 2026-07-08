Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474D21D00A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525158; cv=none; b=LThpXenUUDLWK0MGmdJezKp8qo/qK6ZGlHqZW+5GE/3PYKd72ykUS9IwJlmqhaEMQ3fe+2R1E+EYbY8f4sGCv5UYhL4YUV85JMQcmtjFfTvqxrrkCHnx4nA9gyEkX3qFKXz4c4H11dimZnJ/a5HVlxFJUFhBHAd/azRoWxfvxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525158; c=relaxed/simple;
	bh=g8ytAzCnw6Y+4iv02waxH+DYsyMf1uT7WrsdiDe9HOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn1jxxjd7g8Ex8FepUvYHqzD0hQrFCqUFvi5SG4we3yOsHor8MA+tAIyIfxFbPW8YCmTeWuWQToz7ZPHKZUm4vGN2uXq/IiCqhqsm05zq2iRJZ8Mn4vi7ufFvaeNWjEWobKV/TODvwG5iYvTbr9kqDEKoUfItcK3cEeV7J3GtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vG7prRM9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vG7prRM9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+eOfnJTdry0uWC1pEFvrTgvF3XCOc5syTxn+ho6Epk=;
	b=vG7prRM9xaheaGjf+eN0duBMAbwDe1TUzo/L8Xm9/5ro3t9wWXLLz7tjL+kNGeStQg6FoD
	QDTbGtf4uMPUjyddfG/4T3R5RCM5MwirtPKkABL3BjGd8Oa5S1hoCGhKre+CXxB8C9Yx8c
	xLTTawnPm08Ib5jit6ljU71UeCMw3xI=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 2/8] rv: add generic uprobe infrastructure for RV monitors
Date: Wed,  8 Jul 2026 23:38:28 +0800
Message-Id: <31d0438f98e80503370a6fb3932d0ec7df0673c3.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Monitors that instrument user-space function boundaries need to resolve
paths, register uprobes, and deregister them safely.  Provide a thin
wrapper so monitors share a single implementation of this boilerplate.

struct rv_uprobe embeds struct uprobe_consumer directly, avoiding a
separate heap allocation per probe.  Embedding is safe after
rv_uprobe_unregister(): rv_uprobe_sync() calls uprobe_unregister_sync()
which performs synchronize_rcu_tasks_trace(), waiting for all
rcu_read_lock_trace() readers (handler_chain()) to complete on all CPUs
before returning; the caller may then free the containing struct.

The API provides register, synchronous and nosync unregister, a global
handler barrier (rv_uprobe_sync), and an active-state predicate.
Handlers receive the uprobe_consumer pointer and recover per-probe state
via container_of(uc, struct rv_uprobe, uc) or the containing struct.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/rv_uprobe.h      |  93 ++++++++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig     |   7 +++
 kernel/trace/rv/Makefile    |   1 +
 kernel/trace/rv/rv_uprobe.c | 104 ++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c

diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
new file mode 100644
index 000000000000..2eab5d193e13
--- /dev/null
+++ b/include/rv/rv_uprobe.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ *
+ */
+
+#ifndef _RV_UPROBE_H
+#define _RV_UPROBE_H
+
+#include <linux/types.h>
+#include <linux/uprobes.h>
+
+struct pt_regs;
+struct inode;
+
+/**
+ * struct rv_uprobe - embeddable uprobe handle for RV monitors
+ *
+ * Embed via DECLARE_RV_UPROBE() in the caller's struct and pass &name to
+ * rv_uprobe_register().
+ *
+ * Lifetime: after rv_uprobe_unregister() (or rv_uprobe_unregister_nosync()
+ * followed by rv_uprobe_sync()) returns, synchronize_rcu_tasks_trace() has
+ * completed and no handler_chain() iteration can reference this struct.
+ * The caller may free the containing struct immediately after.
+ *
+ * @uc:     embedded uprobe_consumer; set uc.handler / uc.ret_handler before
+ *          calling rv_uprobe_register(); use container_of(uc, rv_uprobe, uc)
+ *          inside handlers to reach this struct or its container
+ * @uprobe: registered uprobe pointer (NULL when not registered)
+ * @inode:  inode of the probed binary (valid while registered)
+ */
+struct rv_uprobe {
+	struct uprobe_consumer	uc;
+	struct uprobe		*uprobe;
+	struct inode		*inode;
+};
+
+/* Embed a named rv_uprobe inside a caller struct */
+#define DECLARE_RV_UPROBE(name)		struct rv_uprobe name
+
+/**
+ * rv_uprobe_is_registered - test whether an uprobe is currently active
+ * @p: probe to test; may be NULL
+ */
+bool rv_uprobe_is_registered(const struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_register - initialise and register an uprobe
+ * @binpath: absolute path to the target binary
+ * @offset:  byte offset within the binary
+ * @p:       caller-provided rv_uprobe (embedded via DECLARE_RV_UPROBE);
+ *           p->uc.handler and/or p->uc.ret_handler must be set before this call
+ *
+ * Resolves the path and registers p->uc with the uprobe subsystem.
+ * No heap allocation is performed.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_unregister - synchronously unregister a uprobe
+ * @p: probe to unregister; may be NULL (no-op)
+ *
+ * Removes the consumer from the uprobe subsystem and waits for all in-flight
+ * handlers to complete (via synchronize_rcu_tasks_trace()).  After this
+ * returns, the containing struct may be safely freed by the caller.
+ * Use rv_uprobe_unregister_nosync() + rv_uprobe_sync() to batch multiple
+ * deregistrations before a single synchronisation.
+ */
+void rv_uprobe_unregister(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ * @p: probe to dequeue; may be NULL (no-op)
+ *
+ * Removes the consumer without waiting for in-flight handlers.  The caller
+ * must call rv_uprobe_sync() before freeing the containing struct.
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ *
+ * Global barrier: calls uprobe_unregister_sync() which performs
+ * synchronize_rcu_tasks_trace() + synchronize_srcu(&uretprobes_srcu).
+ * After this returns, no handler_chain() iteration referencing any
+ * previously deregistered consumer is still in progress.
+ */
+void rv_uprobe_sync(void);
+
+#endif /* _RV_UPROBE_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..5bad1d63f411 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -59,6 +59,13 @@ config RV_PER_TASK_MONITORS
 	  This option configures the maximum number of per-task RV monitors that can run
 	  simultaneously.
 
+config RV_UPROBE
+	bool
+	depends on RV && UPROBES
+	help
+	  Generic uprobe infrastructure for RV monitors.  Provides path
+	  resolution, registration, and safe synchronous teardown.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..f139b904bea3 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 # Add new monitors here
+obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
new file mode 100644
index 000000000000..a80bfa64578b
--- /dev/null
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ *
+ * struct rv_uprobe embeds struct uprobe_consumer directly.  This is safe
+ * because rv_uprobe_sync() calls uprobe_unregister_sync(), which calls
+ * synchronize_rcu_tasks_trace().  handler_chain() runs under
+ * rcu_read_lock_trace(), so after synchronize_rcu_tasks_trace() returns,
+ * all in-flight handler_chain() iterations, including any pending
+ * uc->cons_node.next reads, have completed on all CPUs.  The caller may
+ * then free the struct containing rv_uprobe immediately.
+ */
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/uprobes.h>
+#include <rv/rv_uprobe.h>
+
+/**
+ * rv_uprobe_register - initialise and register an uprobe
+ */
+int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprobe *p)
+{
+	struct inode *inode;
+	struct path path;
+	int ret;
+
+	if (!p->uc.handler && !p->uc.ret_handler)
+		return -EINVAL;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+
+	if (!d_is_reg(path.dentry)) {
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	inode = d_real_inode(path.dentry);
+	p->inode = inode;
+
+	/*
+	 * uprobe_register() requires the inode (and mount) to remain
+	 * referenced across the call.  Keep the path alive until after
+	 * uprobe_register() has stored its own reference, then release it.
+	 */
+	p->uprobe = uprobe_register(inode, offset, 0, &p->uc);
+	path_put(&path);
+	if (IS_ERR(p->uprobe)) {
+		ret = PTR_ERR(p->uprobe);
+		p->uprobe = NULL;
+		p->inode = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_register);
+
+/**
+ * rv_uprobe_is_registered - test whether an uprobe is currently active
+ */
+bool rv_uprobe_is_registered(const struct rv_uprobe *p)
+{
+	return p && p->uprobe;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_is_registered);
+
+/**
+ * rv_uprobe_unregister - synchronously unregister a uprobe
+ */
+void rv_uprobe_unregister(struct rv_uprobe *p)
+{
+	if (!p || !p->uprobe)
+		return;
+
+	rv_uprobe_unregister_nosync(p);
+	rv_uprobe_sync();
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
+
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
+{
+	if (!p || !p->uprobe)
+		return;
+
+	uprobe_unregister_nosync(p->uprobe, &p->uc);
+	p->uprobe = NULL;
+	p->inode = NULL;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ */
+void rv_uprobe_sync(void)
+{
+	uprobe_unregister_sync();
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_sync);
-- 
2.25.1

