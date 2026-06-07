Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84032F7F12
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848874; cv=none; b=k2/zfAh2+L7/mMHbmJ18qVELAP7CIc2YUagnW3mnn9/t+veF5tXkYIpdybVWZ05Xq1DEiZuVx7uHub5dvG3UQMWgsrOWkgkoYLI5pBL4gmB4bUXQsOsE9/6mtKBpsR9oLhF8y2HB2g+WJsYpC5hi2YC819zdevLvOv5NgH4Q1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848874; c=relaxed/simple;
	bh=0Ezp/K/WmLn+Csh3Q4+lS3rtCUT1rsV7U31B4Y3Wy70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7yLrqjr+fvSzYk5DBaTvbDZBUfoKhXoeNXPjXifCr4+KBht7V6nN5lI19fL27fnGHWIGMZj1asmKkrFd4oHF8NujaUp0tGVfHxP7Y9mJlSGzBJD/nCAV/iKx8oL3e5Y+j8iQLRl5nhUZgrnJAzk7EvFaWxuqdc3qefPfcEOXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=izVJQmBX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="izVJQmBX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWsi7CcRncfORyKLkqyq76idz/7Ibe3n+AuG5Xo3RXI=;
	b=izVJQmBX5gx9/lDMtnl9jIkVLKdVoW4yqJfEcgo7k+pabiZZ+dokTcR/mVCYDHKnr6R16R
	f/d1xCObtWU8z3bJAA7Aw6QD6HNAztUE3z4XQLWL4Yxtv28e8u3uOX+125tdT1iVDD/srk
	vILCVjK/kVYJThxPsz3ZnUgHlEeAOGA=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV monitors
Date: Mon,  8 Jun 2026 00:13:50 +0800
Message-Id: <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Introduce rv_uprobe, a thin wrapper around uprobe_consumer providing
rv_uprobe_attach_path(), rv_uprobe_attach(), and rv_uprobe_detach()
for RV monitors.  An opaque priv pointer is forwarded unchanged to
entry/return handlers so monitors can carry per-binding state (e.g. a
latency threshold) to the hot path without any global lookup.

rv_uprobe_detach() is fully synchronous (nosync + sync + path_put +
kfree), closing the use-after-free window present in open-coded
patterns where kfree() precedes uprobe_unregister_sync().

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/rv_uprobe.h      | 119 +++++++++++++++++++++++
 kernel/trace/rv/Kconfig     |   4 +
 kernel/trace/rv/Makefile    |   1 +
 kernel/trace/rv/rv_uprobe.c | 182 ++++++++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c

diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
new file mode 100644
index 000000000000..9106c5c9275e
--- /dev/null
+++ b/include/rv/rv_uprobe.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ *
+ */
+
+#ifndef _RV_UPROBE_H
+#define _RV_UPROBE_H
+
+#include <linux/path.h>
+#include <linux/types.h>
+
+struct pt_regs;
+
+/**
+ * struct rv_uprobe - a single uprobe registered on behalf of an RV monitor
+ *
+ * @offset:   byte offset within the ELF binary where the probe is installed
+ * @priv:     monitor-private pointer; set at attach time, never touched by
+ *            this layer; passed unchanged to entry_fn / ret_fn
+ * @path:     resolved path of the probed binary (read-only after attach);
+ *            callers may use path.dentry for identity comparisons
+ *
+ * The implementation fields (uprobe_consumer, uprobe handle, callbacks) are
+ * private to rv_uprobe.c and are not exposed here; monitors must not access
+ * them directly.
+ */
+struct rv_uprobe {
+	/* public: read-only after rv_uprobe_attach*() */
+	loff_t		 offset;
+	void		*priv;
+	struct path	 path;
+};
+
+/**
+ * rv_uprobe_attach_path - register an uprobe given an already-resolved path
+ * @path:     path of the target binary; rv_uprobe takes its own reference
+ * @offset:   byte offset within the binary
+ * @entry_fn: called on probe hit (entry); may be NULL
+ * @ret_fn:   called on function return (uretprobe); may be NULL
+ * @priv:     opaque pointer forwarded to callbacks unchanged
+ *
+ * Use this variant when the caller has already resolved the path (e.g. to
+ * register multiple probes on the same binary with a single kern_path call).
+ * The inode is derived internally via d_real_inode(), so inode and path are
+ * always consistent.
+ *
+ * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
+ */
+struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
+	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
+	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+			struct pt_regs *regs, __u64 *data),
+	void *priv);
+
+/**
+ * rv_uprobe_attach - resolve binpath and register an uprobe
+ * @binpath:  absolute path to the target binary
+ * @offset:   byte offset within the binary
+ * @entry_fn: called on probe hit (entry); may be NULL
+ * @ret_fn:   called on function return (uretprobe); may be NULL
+ * @priv:     opaque pointer forwarded to callbacks unchanged
+ *
+ * Resolves binpath via kern_path(), then delegates to rv_uprobe_attach_path().
+ *
+ * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
+ */
+struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
+	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
+	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+			struct pt_regs *regs, __u64 *data),
+	void *priv);
+
+/**
+ * rv_uprobe_detach - synchronously unregister an uprobe and free it
+ * @p:  probe to detach; may be NULL (no-op)
+ *
+ * Calls uprobe_unregister_nosync(), then uprobe_unregister_sync() to wait
+ * for any in-progress handler to finish, then releases the path reference
+ * and frees the rv_uprobe struct.  The caller's priv data is NOT freed.
+ *
+ * When removing a single probe, prefer this over the three-phase API.
+ * Safe to call from process context only (uprobe_unregister_sync() may
+ * schedule).
+ */
+void rv_uprobe_detach(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ * @p:  probe to dequeue; may be NULL (no-op)
+ *
+ * Removes the uprobe from the uprobe subsystem but does NOT wait for
+ * in-flight handlers to complete.  The caller must call rv_uprobe_sync()
+ * before calling rv_uprobe_free() on the same probe.
+ *
+ * Use this to batch multiple deregistrations before a single rv_uprobe_sync().
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ *
+ * Global barrier: waits for every in-flight uprobe handler across the system
+ * to finish.  Call once after a batch of rv_uprobe_unregister_nosync() calls
+ * and before any rv_uprobe_free() call.
+ */
+void rv_uprobe_sync(void);
+
+/**
+ * rv_uprobe_free - release resources of a previously deregistered probe
+ * @p:  probe to free; may be NULL (no-op)
+ *
+ * Releases the path reference and frees the rv_uprobe struct.  Must only
+ * be called after rv_uprobe_sync() has returned.  The caller's priv data
+ * is NOT freed.
+ */
+void rv_uprobe_free(struct rv_uprobe *p);
+
+#endif /* _RV_UPROBE_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..e2e0033a00b9 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -59,6 +59,10 @@ config RV_PER_TASK_MONITORS
 	  This option configures the maximum number of per-task RV monitors that can run
 	  simultaneously.
 
+config RV_UPROBE
+	bool
+	depends on RV && UPROBES
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
index 000000000000..3d8b764dded3
--- /dev/null
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ *
+ */
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/uprobes.h>
+#include <rv/rv_uprobe.h>
+
+/*
+ * Private extension of struct rv_uprobe.  Allocated by rv_uprobe_attach*()
+ * and returned to callers as &impl->pub.
+ */
+struct rv_uprobe_impl {
+	struct rv_uprobe	pub;	/* must be first; callers hold &pub */
+	struct uprobe_consumer	uc;
+	struct uprobe		*uprobe;
+	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data);
+	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+			struct pt_regs *regs, __u64 *data);
+};
+
+static int rv_uprobe_handler(struct uprobe_consumer *uc,
+			     struct pt_regs *regs, __u64 *data)
+{
+	struct rv_uprobe_impl *impl = container_of(uc, struct rv_uprobe_impl, uc);
+
+	if (impl->entry_fn)
+		return impl->entry_fn(&impl->pub, regs, data);
+	return 0;
+}
+
+static int rv_uprobe_ret_handler(struct uprobe_consumer *uc,
+				 unsigned long func,
+				 struct pt_regs *regs, __u64 *data)
+{
+	struct rv_uprobe_impl *impl = container_of(uc, struct rv_uprobe_impl, uc);
+
+	if (impl->ret_fn)
+		return impl->ret_fn(&impl->pub, func, regs, data);
+	return 0;
+}
+
+static struct rv_uprobe *
+__rv_uprobe_attach(struct inode *inode, struct path *path, loff_t offset,
+		   int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
+		   int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+				   struct pt_regs *regs, __u64 *data),
+		   void *priv)
+{
+	struct rv_uprobe_impl *impl;
+	int ret;
+
+	if (!entry_fn && !ret_fn)
+		return ERR_PTR(-EINVAL);
+
+	impl = kzalloc_obj(*impl, GFP_KERNEL);
+	if (!impl)
+		return ERR_PTR(-ENOMEM);
+
+	impl->pub.offset = offset;
+	impl->pub.priv   = priv;
+	impl->entry_fn   = entry_fn;
+	impl->ret_fn     = ret_fn;
+	path_get(path);
+	impl->pub.path   = *path;
+
+	if (entry_fn)
+		impl->uc.handler     = rv_uprobe_handler;
+	if (ret_fn)
+		impl->uc.ret_handler = rv_uprobe_ret_handler;
+
+	impl->uprobe = uprobe_register(inode, offset, 0, &impl->uc);
+	if (IS_ERR(impl->uprobe)) {
+		ret = PTR_ERR(impl->uprobe);
+		path_put(&impl->pub.path);
+		kfree(impl);
+		return ERR_PTR(ret);
+	}
+
+	return &impl->pub;
+}
+
+/**
+ * rv_uprobe_attach_path - register an uprobe given an already-resolved path
+ */
+struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
+	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
+	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+			struct pt_regs *regs, __u64 *data),
+	void *priv)
+{
+	struct inode *inode = d_real_inode(path->dentry);
+
+	return __rv_uprobe_attach(inode, path, offset, entry_fn, ret_fn, priv);
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_attach_path);
+
+/**
+ * rv_uprobe_attach - resolve binpath and register an uprobe
+ */
+struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
+	int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data),
+	int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
+			struct pt_regs *regs, __u64 *data),
+	void *priv)
+{
+	struct rv_uprobe *p;
+	struct path path;
+	int ret;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!d_is_reg(path.dentry)) {
+		path_put(&path);
+		return ERR_PTR(-EINVAL);
+	}
+
+	p = rv_uprobe_attach_path(&path, offset, entry_fn, ret_fn, priv);
+	path_put(&path);
+	return p;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_attach);
+
+/**
+ * rv_uprobe_detach - synchronously unregister an uprobe and free it
+ */
+void rv_uprobe_detach(struct rv_uprobe *p)
+{
+	if (!p)
+		return;
+
+	rv_uprobe_unregister_nosync(p);
+	rv_uprobe_sync();
+	rv_uprobe_free(p);
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_detach);
+
+/**
+ * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
+{
+	struct rv_uprobe_impl *impl;
+
+	if (!p)
+		return;
+
+	impl = container_of(p, struct rv_uprobe_impl, pub);
+	uprobe_unregister_nosync(impl->uprobe, &impl->uc);
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
+
+/**
+ * rv_uprobe_free - release resources of a previously deregistered probe
+ */
+void rv_uprobe_free(struct rv_uprobe *p)
+{
+	struct rv_uprobe_impl *impl;
+
+	if (!p)
+		return;
+
+	impl = container_of(p, struct rv_uprobe_impl, pub);
+	path_put(&p->path);
+	kfree(impl);
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_free);
-- 
2.43.0

