Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129B3CE0A2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163362; cv=none; b=ShvcCz9eAX96KoP6BoDZFtmPyS4Srtojoo8jk7RXS30ynmD7tUDO8Nf7agrv0edkl0mNDsfoP01hMIv9ZRlSi0X6pXK5IP+cS2OGBwNWfKaT02DXeCfybqeQM3+pD2dXHR+tS8AUhUiFWLx8r8N9aGiyOq6U7ndDC5ZxXVDAKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163362; c=relaxed/simple;
	bh=TS3ZDcHvUCkTFRaanHAVStsBRSNFD9cbGqfVt5d28/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWj/ZSkvc4fYyovLIzb1hHRzGQxOyNLLuHyWHzGfgglwiV57BE7PfHVoTSNh1+VNuIgQp7NfjG48z6D2GaPDngrsCBsya2lQcvQ/U1g7EsUpsu7uP6PjWmgH4xRwurcxOAKMmw+QfAd8djczuwtrnCCEU7SaLh4G9w5UcS3Mkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijreruji; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ijreruji"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TS3ZDcHvUCkTFRaanHAVStsBRSNFD9cbGqfVt5d28/0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163355; v=1; x=1787768155;
 b=ijrerujiITKqCTBfejdETM7+nLdxB0M9bd658v1V8xjZPoI7dASCdRMf/p0akdTwGgLsvk9I
 mVKULGCe0igh++fqasbJBYPIu/GRh6vvklSSKbssqrH/LpLdSOmfZouRuodneNC8qnPz/30U/RG
 ic9S/4tsy8DBlEUkeiN/rPX0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 75d16aa775c92bf5;
	Wed, 19 Aug 2026 18:15:55 +0000
X-Mizu-Trace-ID: 75d16aa775c92bf5
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 2/9] rv: Add generic uprobe infrastructure for RV monitors
Date: Thu, 20 Aug 2026 02:15:19 +0800
Message-Id: <683751e6d588baf407a96a0a7a2e9ec12c5d865b.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Monitors that instrument user-space function boundaries need to resolve
paths, register uprobes, and deregister them safely.  Provide a thin
wrapper so monitors share a single implementation of this boilerplate.

struct rv_uprobe embeds struct uprobe_consumer directly, avoiding a
separate heap allocation per probe.  The struct holds a struct path for
the probed binary so that the inode and its mount remain referenced for
the full uprobe lifetime; uprobe_register() does not take its own
reference to the inode.  The path is released in
rv_uprobe_unregister_nosync() after the consumer has been removed.

rv_uprobe_sync() calls uprobe_unregister_sync() which performs
synchronize_rcu_tasks_trace(), waiting for all rcu_read_lock_trace()
readers (handler_chain()) to complete on all CPUs before returning;
the caller may then free the containing struct.

The API provides register, synchronous and nosync unregister, a global
handler barrier (rv_uprobe_sync), and an active-state predicate.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/rv_uprobe.h      | 90 ++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/rv_uprobe.c | 91 +++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c

diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
new file mode 100644
index 000000000000..d0a9079ac5be
--- /dev/null
+++ b/include/rv/rv_uprobe.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Wen Yang <wen.yang@linux.dev> */
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
+#include <linux/uprobes.h>
+
+struct pt_regs;
+
+/**
+ * struct rv_uprobe - embeddable uprobe handle for RV monitors
+ *
+ * Embed via DECLARE_RV_UPROBE() and pass &name to rv_uprobe_register().
+ * The caller may free the containing struct after rv_uprobe_unregister()
+ * (or rv_uprobe_unregister_nosync() + rv_uprobe_sync()) returns.
+ *
+ * @uc:     embedded uprobe_consumer; set handler/ret_handler before registering
+ * @uprobe: registered uprobe pointer (NULL when not registered)
+ * @path:   path of the probed binary, held until unregistration
+ */
+struct rv_uprobe {
+	struct uprobe_consumer	uc;
+	struct uprobe		*uprobe;
+	struct path		path;
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
+ * Removes the consumer without waiting for in-flight handlers.  The path
+ * (p->path) is NOT released here; the caller must call rv_uprobe_sync()
+ * followed by path_put(&p->path) before freeing the containing struct.
+ * Use rv_uprobe_unregister() to handle both in one step.
+ */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
+
+/**
+ * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
+ *
+ * Global barrier: calls uprobe_unregister_sync(), which runs
+ * synchronize_rcu_tasks_trace() and synchronize_srcu(&uretprobes_srcu).
+ * After this returns, no handler_chain() iteration referencing any
+ * previously deregistered consumer is still in progress.
+ */
+void rv_uprobe_sync(void);
+
+#endif /* _RV_UPROBE_H */
diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
new file mode 100644
index 000000000000..b412a8e28a6e
--- /dev/null
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ *
+ * rv_uprobe embeds struct uprobe_consumer; rv_uprobe_sync() drains in-flight
+ * handlers before the containing struct may be freed (see rv_uprobe.h).
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
+	int ret;
+
+	ret = kern_path(binpath, LOOKUP_FOLLOW, &p->path);
+	if (ret)
+		return ret;
+
+	if (!d_is_reg(p->path.dentry)) {
+		path_put(&p->path);
+		return -EINVAL;
+	}
+
+	inode = d_real_inode(p->path.dentry);
+
+	/* uprobe_register() takes no inode reference; the path is held in p->path */
+	p->uprobe = uprobe_register(inode, offset, 0, &p->uc);
+	if (IS_ERR(p->uprobe)) {
+		ret = PTR_ERR(p->uprobe);
+		p->uprobe = NULL;
+		path_put(&p->path);
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
+	uprobe_unregister_nosync(p->uprobe, &p->uc);
+	p->uprobe = NULL;
+	rv_uprobe_sync();
+	path_put(&p->path);
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
+	/* path held; caller must call rv_uprobe_sync() then path_put(&p->path) */
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

