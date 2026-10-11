Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080B457E78
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747626; cv=none; b=oO0wt4GW+UFd/6pf5/l9tzd8+zBmzc50IKSr/SFAOjuZxx/BTdO084ienC3A4cSRjoxYuonTdI7qL0aML87OyFBYaWkRJ23CtLqPqaoRAwwVLuIdl+O3cP87uoWMBE7WHISp70nC83MWyaNiQR50jjENl4xIKR4p3WmZ4KXeEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747626; c=relaxed/simple;
	bh=Z5nwtjyZj02IvrSRdjUUMKGvVUYkzmk63ipjsuwcXcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhUYz8BaVaj1KO2/C89kwgpqYdgH5AHRwjfDUBU5mAArGCPlE40+wb4GJR6SnR8WOZ8BTxsV7lhNS+H4QzpNl99t+7JKM68RsQ5t2jcgtHxuhZbq6x0Tqb+T1I5VCcstspxdwndm7NrE3Wjs6480gzco+UbujzT7U8cXwpLaG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xYaG2Zw3; arc=none smtp.client-ip=91.218.175.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xYaG2Zw3"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z5nwtjyZj02IvrSRdjUUMKGvVUYkzmk63ipjsuwcXcE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747622; v=1; x=1792352422;
 b=xYaG2Zw32ZXeZuMbDZ1sTEtr+DzSu3nW+WsSK8me0ap8T4Nn0Dl5sZ5BWQdUsXPHHrhFruxE
 5I0KM5wWQfYZ3tUOj12CRIPn8x6HBOXWfor1UWBIxszYlaKwaUIa2qf8zjLXFZUlIZ813qqOe4p
 FwbeIl8NqniLfBBLz1vf+fto=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 04b26b2ed007d23c;
	Sun, 11 Oct 2026 19:40:21 +0000
X-Mizu-Trace-ID: 04b26b2ed007d23c
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 09/14] rv: Add generic uprobe infrastructure for RV monitors
Date: Mon, 12 Oct 2026 03:39:15 +0800
Message-Id: <1f311bb81a9270391bb9d3aa03b8b881de928c1a.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Monitors that instrument user-space function boundaries need to register
uprobes and deregister them safely.  Provide a thin wrapper so monitors
share a single implementation of this boilerplate.

struct rv_uprobe embeds struct uprobe_consumer directly, avoiding a
separate heap allocation per probe.  The struct holds an inode reference
(acquired via igrab()) for the probed binary for the full uprobe lifetime,
as uprobe_register() does not take an inode reference.  On unregister,
the inode reference is released with iput() only after
rv_uprobe_unregister_sync().

rv_uprobe_unregister_sync() calls uprobe_unregister_sync(), draining
all in-flight handlers before the containing struct may be freed.

The API provides register, nosync unregister, a global handler barrier
(rv_uprobe_unregister_sync), and an active-state predicate.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/rv_uprobe.h      | 35 +++++++++++++++++++++++
 kernel/trace/rv/Kconfig     |  4 +++
 kernel/trace/rv/Makefile    |  1 +
 kernel/trace/rv/rv_uprobe.c | 56 +++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 include/rv/rv_uprobe.h
 create mode 100644 kernel/trace/rv/rv_uprobe.c

diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
new file mode 100644
index 000000000000..b93c2a81bc22
--- /dev/null
+++ b/include/rv/rv_uprobe.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Wen Yang <wen.yang@linux.dev> */
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ */
+
+#ifndef _RV_UPROBE_H
+#define _RV_UPROBE_H
+
+#include <linux/types.h>
+#include <linux/uprobes.h>
+
+struct inode;
+struct pt_regs;
+
+/*
+ * Free the containing struct only after rv_uprobe_unregister_nosync() +
+ * rv_uprobe_unregister_sync() + iput(p->inode).
+ *
+ * The inode reference does not pin the dentry, so callers that re-resolve the
+ * probed path must hold a struct path: 9p cache=none remints an inode per
+ * lookup.
+ */
+struct rv_uprobe {
+	struct uprobe_consumer	uc;
+	struct uprobe		*uprobe;
+	struct inode		*inode;
+};
+
+bool rv_uprobe_is_registered(const struct rv_uprobe *p);
+int rv_uprobe_register(struct inode *inode, loff_t offset, struct rv_uprobe *p);
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
+void rv_uprobe_unregister_sync(void);
+
+#endif /* _RV_UPROBE_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4..2bc412304293 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -86,6 +86,10 @@ source "kernel/trace/rv/monitors/nomiss/Kconfig"
 
 # Add new monitors here
 
+config RV_UPROBE
+	bool
+	depends on RV && UPROBES
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..e295c9eb8401 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
 # Add new monitors here
+obj-$(CONFIG_RV_UPROBE) += rv_uprobe.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
new file mode 100644
index 000000000000..1c7f8466aeed
--- /dev/null
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic uprobe infrastructure for RV monitors.
+ */
+#include <linux/fs.h>
+#include <linux/uprobes.h>
+#include <rv/rv_uprobe.h>
+
+/*
+ * uprobe_register() takes no inode reference of its own, so grab one here and
+ * drop it only after rv_uprobe_unregister_sync().
+ */
+int rv_uprobe_register(struct inode *inode, loff_t offset, struct rv_uprobe *p)
+{
+	int ret;
+
+	p->inode = igrab(inode);
+	if (!p->inode)
+		return -ESTALE;
+
+	p->uprobe = uprobe_register(inode, offset, 0, &p->uc);
+	if (IS_ERR(p->uprobe)) {
+		ret = PTR_ERR(p->uprobe);
+		p->uprobe = NULL;
+		iput(p->inode);
+		p->inode = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_register);
+
+bool rv_uprobe_is_registered(const struct rv_uprobe *p)
+{
+	return p && p->uprobe;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_is_registered);
+
+/* The inode stays held: in-flight handlers may still reach it. */
+void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
+{
+	if (!p || !p->uprobe)
+		return;
+
+	uprobe_unregister_nosync(p->uprobe, &p->uc);
+	p->uprobe = NULL;
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
+
+/* Global barrier over every probe dequeued so far. */
+void rv_uprobe_unregister_sync(void)
+{
+	uprobe_unregister_sync();
+}
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister_sync);
-- 
2.25.1

