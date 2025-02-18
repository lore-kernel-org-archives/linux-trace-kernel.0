Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9822475E4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881915; cv=none; b=kAIGiwKDhCgaCRpXmRfOtmcHco4RE5reDbZdhLxY1VbJE3hXGa912jQD+u+Lj0QPIHRk4v4OPLOGVyFVVVcyki119lC/39YrTGZuLUWEYHxPalPGGoP/04EiGpYYfCBIKFY2TkYrrM866YlWMgg3HQHpG6ur8nYC8WysVNoGMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881915; c=relaxed/simple;
	bh=9QeYPcfnbOtmvHi1zMNbXB31PIpWyIVjANaUeMKTx60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7JNSdvHWWAxJtS9mTQCEOvT4KxPMx37Dmb0z2N1ZD61HvN91dNivFhKq61WEJxeYi5hlDJqaK2woJz+CcdULOOvoq6ShmDmoAthU9RPXHt5S/atuGcTf8MiSJ9Dmidm0koMLnU5SZy9dyIhRBOjpOiUhsF0K+H9JzjOE6nuwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka8Po3a+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka8Po3a+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCkcujnBLAqEYg78EWt1+CuGUPkfz6mfY7ffrqmRGnM=;
	b=Ka8Po3a+tE2Qezx8jJnQJZ9UjeKdF41sH0tjNN9QH1FqQw7f+1TP67/5RB+1Ce0j8a0y4/
	fAUmtHxHU7cuw9/m61qAQM8OmUFA5T4RZrCK4DuyCugcm7/TNaJD9KWLHlXpdXMj+art7x
	452VSh1pYXUVQh/bZ+BoBRjfYp/QEgI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-Wqh3oLqdPWiQjsmOCTFHxQ-1; Tue,
 18 Feb 2025 07:31:48 -0500
X-MC-Unique: Wqh3oLqdPWiQjsmOCTFHxQ-1
X-Mimecast-MFC-AGG-ID: Wqh3oLqdPWiQjsmOCTFHxQ_1739881907
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9C2418EB2D3;
	Tue, 18 Feb 2025 12:31:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEB7E180087E;
	Tue, 18 Feb 2025 12:31:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 04/11] rv: Add option for nested monitors and include sched
Date: Tue, 18 Feb 2025 13:31:09 +0100
Message-ID: <20250218123121.253551-5-gmonaco@redhat.com>
In-Reply-To: <20250218123121.253551-1-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Monitors describing complex systems, such as the scheduler, can easily
grow to the point where they are just hard to understand because of the
many possible state transitions.
Often it is possible to break such descriptions into smaller monitors,
sharing some or all events. Enabling those smaller monitors concurrently
is, in fact, testing the system as if we had one single larger monitor.
Splitting models into multiple specification is not only easier to
understand, but gives some more clues when we see errors.

Add the possibility to create container monitors, whose only purpose is
to host other nested monitors. Enabling a container monitor enables all
nested ones, but it's still possible to enable nested monitors
independently.
Add the sched monitor as first container, for now empty.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h                     |   2 +-
 kernel/trace/rv/Kconfig                |   1 +
 kernel/trace/rv/Makefile               |   1 +
 kernel/trace/rv/monitors/sched/Kconfig |  11 ++
 kernel/trace/rv/monitors/sched/sched.c |  38 ++++++
 kernel/trace/rv/monitors/sched/sched.h |   3 +
 kernel/trace/rv/monitors/wip/wip.c     |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c   |   2 +-
 kernel/trace/rv/rv.c                   | 154 +++++++++++++++++++++----
 kernel/trace/rv/rv.h                   |   4 +
 kernel/trace/rv/rv_reactors.c          |  28 ++++-
 11 files changed, 217 insertions(+), 29 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/sched/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sched/sched.c
 create mode 100644 kernel/trace/rv/monitors/sched/sched.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 55d458be53a4c..3452b5e4b29e7 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -56,7 +56,7 @@ struct rv_monitor {
 
 bool rv_monitoring_on(void);
 int rv_unregister_monitor(struct rv_monitor *monitor);
-int rv_register_monitor(struct rv_monitor *monitor);
+int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent);
 int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 8226352a00626..84c98a5327f3e 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -27,6 +27,7 @@ menuconfig RV
 
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
+source "kernel/trace/rv/monitors/sched/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 188b64668e1fa..1c784df03b9a7 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,6 +5,7 @@ ccflags-y += -I $(src)		# needed for trace events
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
+obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sched/Kconfig b/kernel/trace/rv/monitors/sched/Kconfig
new file mode 100644
index 0000000000000..ae3eb410abd78
--- /dev/null
+++ b/kernel/trace/rv/monitors/sched/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SCHED
+	depends on RV
+	bool "sched monitor"
+	help
+	  Collection of monitors to check the scheduler behaves according to specifications.
+	  Enable this to enable all scheduler specification supported by the current kernel.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
new file mode 100644
index 0000000000000..905e03c3c934d
--- /dev/null
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "sched"
+
+#include "sched.h"
+
+struct rv_monitor rv_sched;
+
+struct rv_monitor rv_sched = {
+	.name = "sched",
+	.description = "container for several scheduler monitor specifications.",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_sched(void)
+{
+	rv_register_monitor(&rv_sched, NULL);
+	return 0;
+}
+
+static void __exit unregister_sched(void)
+{
+	rv_unregister_monitor(&rv_sched);
+}
+
+module_init(register_sched);
+module_exit(unregister_sched);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sched: container for several scheduler monitor specifications.");
diff --git a/kernel/trace/rv/monitors/sched/sched.h b/kernel/trace/rv/monitors/sched/sched.h
new file mode 100644
index 0000000000000..ba148dd8d48b1
--- /dev/null
+++ b/kernel/trace/rv/monitors/sched/sched.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_sched;
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index db7389157c87e..ed758fec8608f 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -71,7 +71,7 @@ static struct rv_monitor rv_wip = {
 
 static int __init register_wip(void)
 {
-	rv_register_monitor(&rv_wip);
+	rv_register_monitor(&rv_wip, NULL);
 	return 0;
 }
 
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 3b16994a99845..172f31c4b0f34 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -70,7 +70,7 @@ static struct rv_monitor rv_wwnr = {
 
 static int __init register_wwnr(void)
 {
-	rv_register_monitor(&rv_wwnr);
+	rv_register_monitor(&rv_wwnr, NULL);
 	return 0;
 }
 
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 8657fc8806e7c..50344aa9f7f93 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -162,7 +162,7 @@ struct dentry *get_monitors_root(void)
 /*
  * Interface for the monitor register.
  */
-static LIST_HEAD(rv_monitors_list);
+LIST_HEAD(rv_monitors_list);
 
 static int task_monitor_count;
 static bool task_monitor_slots[RV_PER_TASK_MONITORS];
@@ -206,6 +206,30 @@ void rv_put_task_monitor_slot(int slot)
 	task_monitor_slots[slot] = false;
 }
 
+/*
+ * Monitors with a parent are nested,
+ * Monitors without a parent could be standalone or containers.
+ */
+bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
+{
+	return mdef->parent != NULL;
+}
+
+/*
+ * We set our list to have nested monitors listed after their parent
+ * if a monitor has a child element its a container.
+ * Containers can be also identified based on their function pointers:
+ * as they are not real monitors they do not need function definitions
+ * for enable()/disable(). Use this condition to find empty containers.
+ * Keep both conditions in case we have some non-compliant containers.
+ */
+bool rv_is_container_monitor(struct rv_monitor_def *mdef)
+{
+	struct rv_monitor_def *next = list_next_entry(mdef, list);
+
+	return next->parent == mdef->monitor || !mdef->monitor->enable;
+}
+
 /*
  * This section collects the monitor/ files and folders.
  */
@@ -229,7 +253,8 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 	if (mdef->monitor->enabled) {
 		mdef->monitor->enabled = 0;
-		mdef->monitor->disable();
+		if (mdef->monitor->disable)
+			mdef->monitor->disable();
 
 		/*
 		 * Wait for the execution of all events to finish.
@@ -243,6 +268,60 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 	return 0;
 }
 
+static void rv_disable_single(struct rv_monitor_def *mdef)
+{
+	__rv_disable_monitor(mdef, true);
+}
+
+static int rv_enable_single(struct rv_monitor_def *mdef)
+{
+	int retval;
+
+	lockdep_assert_held(&rv_interface_lock);
+
+	if (mdef->monitor->enabled)
+		return 0;
+
+	retval = mdef->monitor->enable();
+
+	if (!retval)
+		mdef->monitor->enabled = 1;
+
+	return retval;
+}
+
+static void rv_disable_container(struct rv_monitor_def *mdef)
+{
+	struct rv_monitor_def *p = mdef;
+	int enabled = 0;
+
+	list_for_each_entry_continue(p, &rv_monitors_list, list) {
+		if (p->parent != mdef->monitor)
+			break;
+		enabled += __rv_disable_monitor(p, false);
+	}
+	if (enabled)
+		tracepoint_synchronize_unregister();
+	mdef->monitor->enabled = 0;
+}
+
+static int rv_enable_container(struct rv_monitor_def *mdef)
+{
+	struct rv_monitor_def *p = mdef;
+	int retval = 0;
+
+	list_for_each_entry_continue(p, &rv_monitors_list, list) {
+		if (retval || p->parent != mdef->monitor)
+			break;
+		retval = rv_enable_single(p);
+	}
+	if (retval)
+		rv_disable_container(mdef);
+	else
+		mdef->monitor->enabled = 1;
+	return retval;
+}
+
 /**
  * rv_disable_monitor - disable a given runtime monitor
  * @mdef: Pointer to the monitor definition structure.
@@ -251,7 +330,11 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
  */
 int rv_disable_monitor(struct rv_monitor_def *mdef)
 {
-	__rv_disable_monitor(mdef, true);
+	if (rv_is_container_monitor(mdef))
+		rv_disable_container(mdef);
+	else
+		rv_disable_single(mdef);
+
 	return 0;
 }
 
@@ -265,15 +348,10 @@ int rv_enable_monitor(struct rv_monitor_def *mdef)
 {
 	int retval;
 
-	lockdep_assert_held(&rv_interface_lock);
-
-	if (mdef->monitor->enabled)
-		return 0;
-
-	retval = mdef->monitor->enable();
-
-	if (!retval)
-		mdef->monitor->enabled = 1;
+	if (rv_is_container_monitor(mdef))
+		retval = rv_enable_container(mdef);
+	else
+		retval = rv_enable_single(mdef);
 
 	return retval;
 }
@@ -336,9 +414,9 @@ static const struct file_operations interface_desc_fops = {
  * the monitor dir, where the specific options of the monitor
  * are exposed.
  */
-static int create_monitor_dir(struct rv_monitor_def *mdef)
+static int create_monitor_dir(struct rv_monitor_def *mdef, struct rv_monitor_def *parent)
 {
-	struct dentry *root = get_monitors_root();
+	struct dentry *root = parent ? parent->root_d : get_monitors_root();
 	const char *name = mdef->monitor->name;
 	struct dentry *tmp;
 	int retval;
@@ -377,7 +455,11 @@ static int monitors_show(struct seq_file *m, void *p)
 {
 	struct rv_monitor_def *mon_def = p;
 
-	seq_printf(m, "%s\n", mon_def->monitor->name);
+	if (mon_def->parent)
+		seq_printf(m, "%s:%s\n", mon_def->parent->name,
+			   mon_def->monitor->name);
+	else
+		seq_printf(m, "%s\n", mon_def->monitor->name);
 	return 0;
 }
 
@@ -514,7 +596,7 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 	struct rv_monitor_def *mdef;
 	int retval = -EINVAL;
 	bool enable = true;
-	char *ptr;
+	char *ptr, *tmp;
 	int len;
 
 	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
@@ -541,6 +623,11 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 
 	retval = -EINVAL;
 
+	/* we support 1 nesting level, trim the parent */
+	tmp = strstr(ptr, ":");
+	if (tmp)
+		ptr = tmp+1;
+
 	list_for_each_entry(mdef, &rv_monitors_list, list) {
 		if (strcmp(ptr, mdef->monitor->name) != 0)
 			continue;
@@ -613,7 +700,7 @@ static void reset_all_monitors(void)
 	struct rv_monitor_def *mdef;
 
 	list_for_each_entry(mdef, &rv_monitors_list, list) {
-		if (mdef->monitor->enabled)
+		if (mdef->monitor->enabled && mdef->monitor->reset)
 			mdef->monitor->reset();
 	}
 }
@@ -685,18 +772,19 @@ static void destroy_monitor_dir(struct rv_monitor_def *mdef)
 /**
  * rv_register_monitor - register a rv monitor.
  * @monitor:    The rv_monitor to be registered.
+ * @parent:     The parent of the monitor to be registered, NULL if not nested.
  *
  * Returns 0 if successful, error otherwise.
  */
-int rv_register_monitor(struct rv_monitor *monitor)
+int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 {
-	struct rv_monitor_def *r;
+	struct rv_monitor_def *r, *p = NULL;
 	int retval = 0;
 
 	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
 		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
 			MAX_RV_MONITOR_NAME_SIZE);
-		return -1;
+		return -EINVAL;
 	}
 
 	mutex_lock(&rv_interface_lock);
@@ -704,11 +792,26 @@ int rv_register_monitor(struct rv_monitor *monitor)
 	list_for_each_entry(r, &rv_monitors_list, list) {
 		if (strcmp(monitor->name, r->monitor->name) == 0) {
 			pr_info("Monitor %s is already registered\n", monitor->name);
-			retval = -1;
+			retval = -EEXIST;
 			goto out_unlock;
 		}
 	}
 
+	if (parent) {
+		list_for_each_entry(r, &rv_monitors_list, list) {
+			if (strcmp(parent->name, r->monitor->name) == 0) {
+				p = r;
+				break;
+			}
+		}
+	}
+
+	if (p && rv_is_nested_monitor(p)) {
+		pr_info("Parent monitor %s is already nested, cannot nest further\n",
+			parent->name);
+		return -EINVAL;
+	}
+
 	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
 	if (!r) {
 		retval = -ENOMEM;
@@ -716,14 +819,19 @@ int rv_register_monitor(struct rv_monitor *monitor)
 	}
 
 	r->monitor = monitor;
+	r->parent = parent;
 
-	retval = create_monitor_dir(r);
+	retval = create_monitor_dir(r, p);
 	if (retval) {
 		kfree(r);
 		goto out_unlock;
 	}
 
-	list_add_tail(&r->list, &rv_monitors_list);
+	/* keep children close to the parent for easier visualisation */
+	if (p)
+		list_add(&r->list, &p->list);
+	else
+		list_add_tail(&r->list, &rv_monitors_list);
 
 out_unlock:
 	mutex_unlock(&rv_interface_lock);
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index db6cb0913dbd5..98fca0a1adbc7 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -21,6 +21,7 @@ struct rv_interface {
 #define MAX_RV_REACTOR_NAME_SIZE	32
 
 extern struct mutex rv_interface_lock;
+extern struct list_head rv_monitors_list;
 
 #ifdef CONFIG_RV_REACTORS
 struct rv_reactor_def {
@@ -34,6 +35,7 @@ struct rv_reactor_def {
 struct rv_monitor_def {
 	struct list_head	list;
 	struct rv_monitor	*monitor;
+	struct rv_monitor	*parent;
 	struct dentry		*root_d;
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor_def	*rdef;
@@ -45,6 +47,8 @@ struct rv_monitor_def {
 struct dentry *get_monitors_root(void);
 int rv_disable_monitor(struct rv_monitor_def *mdef);
 int rv_enable_monitor(struct rv_monitor_def *mdef);
+bool rv_is_container_monitor(struct rv_monitor_def *mdef);
+bool rv_is_nested_monitor(struct rv_monitor_def *mdef);
 
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor_def *mdef);
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 7b49cbe388d4c..9501ca886d837 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -158,8 +158,9 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 	.show	= monitor_reactor_show
 };
 
-static void monitor_swap_reactors(struct rv_monitor_def *mdef, struct rv_reactor_def *rdef,
-				    bool reacting)
+static void monitor_swap_reactors_single(struct rv_monitor_def *mdef,
+					 struct rv_reactor_def *rdef,
+					 bool reacting, bool nested)
 {
 	bool monitor_enabled;
 
@@ -179,10 +180,31 @@ static void monitor_swap_reactors(struct rv_monitor_def *mdef, struct rv_reactor
 	mdef->reacting = reacting;
 	mdef->monitor->react = rdef->reactor->react;
 
-	if (monitor_enabled)
+	/* enable only once if iterating through a container */
+	if (monitor_enabled && !nested)
 		rv_enable_monitor(mdef);
 }
 
+static void monitor_swap_reactors(struct rv_monitor_def *mdef,
+				  struct rv_reactor_def *rdef, bool reacting)
+{
+	struct rv_monitor_def *p = mdef;
+
+	if (rv_is_container_monitor(mdef))
+		list_for_each_entry_continue(p, &rv_monitors_list, list) {
+			if (p->parent != mdef->monitor)
+				break;
+			monitor_swap_reactors_single(p, rdef, reacting, true);
+		}
+	/*
+	 * This call enables and disables the monitor if they were active.
+	 * In case of a container, we already disabled all and will enable all.
+	 * All nested monitors are enabled also if they were off, we may refine
+	 * this logic in the future.
+	 */
+	monitor_swap_reactors_single(mdef, rdef, reacting, false);
+}
+
 static ssize_t
 monitor_reactors_write(struct file *file, const char __user *user_buf,
 		      size_t count, loff_t *ppos)
-- 
2.48.1

