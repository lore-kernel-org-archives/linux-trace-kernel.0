Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52192347BDC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714665; cv=none; b=mbTaqqOkJTYtCqAQFCw6hpzLZXpHbBQ+Ki6LniGVeT5FcnuBP8pqtH63eduh7It6ONRpZubcvW2C6hpV2zXeDDEyCm+kj5yqEezxotnm8i/Uv8oQi0aZmW3QYVNd5Mf72KIglcf3bjrazd0tX5mbxGbm7zoxTZWntBhMGazlY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714665; c=relaxed/simple;
	bh=f6LFDEMk6FYwVLxOrnUS1Rj4z2TLtUVaSD1UsKyXNRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyMDnEc7UyWsnqmqC6oMIQRT74DQ12mHVI8m+ZjP7w2KwVUGkW+isM0LNYnp0FrhBOrgtNRlX1ORQHiGuv+qDDK5HpZ8T8AAsVN/DQeXvxowg0kEQzbqulB/t4VOmacN8aWV43bwnlpBpVJSHxUf37EoBf7GGLXjdZ7P89BOErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dU3K+dzd; arc=none smtp.client-ip=91.218.175.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dU3K+dzd"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f6LFDEMk6FYwVLxOrnUS1Rj4z2TLtUVaSD1UsKyXNRQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788714661; v=1; x=1789319461;
 b=dU3K+dzdGq9jmAcS9Zw8v6cyktYL3n/olWOyTNiQ0J613s067uCiMtrGfrvLgHcoAYuo3sqp
 Cg8n/IBX0AtTHRRB9NnySnMJXBDLpOuh/h9+6E9okcfSg/KDZLffvMgD8tAlQ+b6nJSoBPLWE+8
 YFQFgejOqc2uTf2uwV4I4RDQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 847577e6d7094564;
	Sun, 06 Sep 2026 17:11:01 +0000
X-Mizu-Trace-ID: 847577e6d7094564
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 3/5] rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
Date: Mon,  7 Sep 2026 01:10:39 +0800
Message-Id: <7c931773dacd7c3da35a22629c3d7dc286b5a0fe.1788705281.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

rv_react() is exported to modules, but the reactor registration helpers
are not.  Export them with EXPORT_SYMBOL_GPL() so reactor modules and
the tristate KUnit test module can register and unregister reactors
without hitting undefined symbol errors at link time(modpost).

Commit 3d3800b4f7f4 ("rv: Remove reactor's reference counter") noted
that if module-based reactors are supported, try_module_get()/module_put()
should be used. Add struct module *owner to struct rv_reactor so a module
cat set owner = THIS_MODULE; pin the module in monitor_swap_reactors_gingle()
and release it when a monitor detaches or is unregistered.

In-tree reactors leave owner = NULL and are unaffected.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/rv.h            |  3 +++
 kernel/trace/rv/rv.c          |  5 +++++
 kernel/trace/rv/rv_reactors.c | 38 +++++++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..ff3289ba4f02 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -128,10 +128,13 @@ union rv_task_monitor {
 };
 
 #ifdef CONFIG_RV_REACTORS
+struct module;
+
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
 	__printf(1, 0) void	(*react)(const char *msg, va_list args);
+	struct module		*owner;
 	struct list_head	list;
 };
 #endif
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 29f155c6968b..458b17c005b3 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -803,6 +803,11 @@ int rv_unregister_monitor(struct rv_monitor *monitor)
 	guard(mutex)(&rv_interface_lock);
 
 	rv_disable_monitor(monitor);
+#ifdef CONFIG_RV_REACTORS
+	if (monitor->reactor)
+		module_put(monitor->reactor->owner);
+
+#endif
 	list_del(&monitor->list);
 	destroy_monitor_dir(monitor);
 
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index ff7d478227c3..136eb7f47c4a 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -62,6 +62,7 @@
  */
 
 #include <linux/lockdep.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "rv.h"
@@ -159,7 +160,7 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 	.show	= monitor_reactor_show
 };
 
-static void monitor_swap_reactors_single(struct rv_monitor *mon,
+static int monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor *reactor,
 					 bool nested)
 {
@@ -167,29 +168,39 @@ static void monitor_swap_reactors_single(struct rv_monitor *mon,
 
 	/* nothing to do */
 	if (mon->reactor == reactor)
-		return;
+		return 0;
+
+	if (reactor->owner && !try_module_get(reactor->owner))
+		return -EBUSY;
 
 	monitor_enabled = mon->enabled;
 	if (monitor_enabled)
 		rv_disable_monitor(mon);
 
+	if (mon->reactor)
+		module_put(mon->reactor->owner);
 	mon->reactor = reactor;
 	mon->react = reactor->react;
 
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
 		rv_enable_monitor(mon);
+
+	return 0;
 }
 
-static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reactor *reactor)
+static int monitor_swap_reactors(struct rv_monitor *mon, struct rv_reactor *reactor)
 {
 	struct rv_monitor *p = mon;
+	int ret;
 
 	if (rv_is_container_monitor(mon))
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent != mon)
 				break;
-			monitor_swap_reactors_single(p, reactor, true);
+			ret = monitor_swap_reactors_single(p, reactor, true);
+			if (ret)
+				return ret;
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -197,7 +208,7 @@ static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reactor *rea
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, reactor, false);
+	return monitor_swap_reactors_single(mon, reactor, false);
 }
 
 static ssize_t
@@ -236,10 +247,14 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 	guard(mutex)(&rv_interface_lock);
 
 	list_for_each_entry(reactor, &rv_reactors_list, list) {
+		int ret;
+
 		if (strcmp(ptr, reactor->name) != 0)
 			continue;
 
-		monitor_swap_reactors(mon, reactor);
+		ret = monitor_swap_reactors(mon, reactor);
+		if (ret)
+			return ret;
 
 		return count;
 	}
@@ -314,6 +329,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
 	guard(mutex)(&rv_interface_lock);
 	return __rv_register_reactor(reactor);
 }
+EXPORT_SYMBOL_GPL(rv_register_reactor);
 
 /**
  * rv_unregister_reactor - unregister a rv reactor.
@@ -327,6 +343,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
 	list_del(&reactor->list);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rv_unregister_reactor);
 
 /*
  * reacting_on interface.
@@ -421,6 +438,15 @@ int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor = get_reactor_rdef_by_name("nop");
+	if (WARN_ON(!mon->reactor)) {
+		rv_remove(tmp);
+		return -EINVAL;
+	}
+
+	if (mon->reactor->owner && !try_module_get(mon->reactor->owner)) {
+		rv_remove(tmp);
+		return -EBUSY;
+	}
 
 	return 0;
 }
-- 
2.25.1

