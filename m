Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62181E04BD;
	Thu, 24 Jul 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378425; cv=none; b=ZHsO2ErWCmdLqvINSlWM1uNvbXoZ89WBRk7E2nxPZUNoq270l9WZ+5PTIE6l5XVOZgN0xrU5fa4eTp4GcefkJFk2zb1U4zSe/uU3I+ZtjbdhePVPi+z9RULVifr3WFNNJUfnkIa78mCi3DQQzo64oXpjzx6vd8+qyrDbt6uQamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378425; c=relaxed/simple;
	bh=PC7amM/TjDy1xtNaykXo0SJjVsSHvr6XZgNoOLyBqCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIKMoiL+oCDps1cOQXxCSf3BllP4Pt6pAbmXCpzaZTqY433PwyjRY/IJtW3t0f427KHNoxZMVkvBIaFzaD02UWevj2GrWy6N5GneguRQcOGfKQbEgZ/H3HGv58lWnSLez2YR+Qw76CBulhzvluXLoUX9MfsQglprrCHdjsA5ndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3jVvLCI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Trk8sIj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3jVvLCI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Trk8sIj"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzgKm3WF76taZAdei5wE8rVCHnR+0mMNMB/Rlu6xhus=;
	b=q3jVvLCIaexl7fqocBk/l02a18fnrgwM4xR/6E+Ljf05KEikhMa+KGE7SeVzotttxmzA0s
	OWOVgCTUGRN62rzsSGyClnuzfmYN3rSDCPclM5slHoEwmLmbRnG+wlRtggzwDGJuWEIK0I
	8A+e8kn687VzgYfahnbMQYeSn29FCQnQSiu0qXkPyNjsPgzTfTTimWfHw3Zv1U3Q2K4Dve
	9w5Uvenuve+fcPQWNkW0d821W/p64bTV6q5PT5d4jcHvDsYI1PHnxhwsyE5edJKARdwWj/
	1FQpj55OtmsHNzu4pRwv8H8zq3RrUbnfvPiLc//geYpKMN5sbbuh5VplSOQlJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzgKm3WF76taZAdei5wE8rVCHnR+0mMNMB/Rlu6xhus=;
	b=0Trk8sIjPwuFj9jpOQK8qDwQ4LIUdQtvcGNF1fyXsVqWnP9G4F6a4WRbDwmRQORsoy4AsX
	JsWFQpilfgapqMBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 2/5] rv: Merge struct rv_monitor_def into struct rv_monitor
Date: Thu, 24 Jul 2025 19:33:27 +0200
Message-Id: <194449c00f87945c207aab4c96920c75796a4f53.1753378331.git.namcao@linutronix.de>
In-Reply-To: <cover.1753378331.git.namcao@linutronix.de>
References: <cover.1753378331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each struct rv_monitor has a unique struct rv_monitor_def associated with
it. struct rv_monitor is statically allocated, while struct rv_monitor_def
is dynamically allocated.

This makes the code more complicated than it should be:

  - Lookup is required to get the associated rv_monitor_def from rv_monitor

  - Dynamic memory allocation is required for rv_monitor_def. This is
    harder to get right compared to static memory. For instance, there is
    an existing mistake: rv_unregister_monitor() does not free the memory
    allocated by rv_register_monitor(). This is fortunately not a real
    memory leak problem, as rv_unregister_monitor() is never called.

Simplify and merge rv_monitor_def into rv_monitor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h            |   8 ++
 kernel/trace/rv/rv.c          | 211 +++++++++++++++-------------------
 kernel/trace/rv/rv.h          |  27 ++---
 kernel/trace/rv/rv_reactors.c |  62 +++++-----
 4 files changed, 140 insertions(+), 168 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 97baf58d88b2..dba53aecdfab 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,6 +7,9 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
=20
+#include <linux/types.h>
+#include <linux/list.h>
+
 #define MAX_DA_NAME_LEN	32
=20
 #ifdef CONFIG_RV
@@ -98,8 +101,13 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
+	struct rv_reactor_def	*rdef;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
+	bool			reacting;
 #endif
+	struct list_head	list;
+	struct rv_monitor	*parent;
+	struct dentry		*root_d;
 };
=20
 bool rv_monitoring_on(void);
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 3127dbfc722a..08d0bcc715bf 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -210,9 +210,9 @@ void rv_put_task_monitor_slot(int slot)
  * Monitors with a parent are nested,
  * Monitors without a parent could be standalone or containers.
  */
-bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
+bool rv_is_nested_monitor(struct rv_monitor *mon)
 {
-	return mdef->parent !=3D NULL;
+	return mon->parent !=3D NULL;
 }
=20
 /*
@@ -223,16 +223,16 @@ bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
  * for enable()/disable(). Use this condition to find empty containers.
  * Keep both conditions in case we have some non-compliant containers.
  */
-bool rv_is_container_monitor(struct rv_monitor_def *mdef)
+bool rv_is_container_monitor(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *next;
+	struct rv_monitor *next;
=20
-	if (list_is_last(&mdef->list, &rv_monitors_list))
+	if (list_is_last(&mon->list, &rv_monitors_list))
 		return false;
=20
-	next =3D list_next_entry(mdef, list);
+	next =3D list_next_entry(mon, list);
=20
-	return next->parent =3D=3D mdef->monitor || !mdef->monitor->enable;
+	return next->parent =3D=3D mon || !mon->enable;
 }
=20
 /*
@@ -241,10 +241,10 @@ bool rv_is_container_monitor(struct rv_monitor_def *m=
def)
 static ssize_t monitor_enable_read_data(struct file *filp, char __user *us=
er_buf, size_t count,
 					loff_t *ppos)
 {
-	struct rv_monitor_def *mdef =3D filp->private_data;
+	struct rv_monitor *mon =3D filp->private_data;
 	const char *buff;
=20
-	buff =3D mdef->monitor->enabled ? "1\n" : "0\n";
+	buff =3D mon->enabled ? "1\n" : "0\n";
=20
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+=
1);
 }
@@ -252,14 +252,14 @@ static ssize_t monitor_enable_read_data(struct file *=
filp, char __user *user_buf
 /*
  * __rv_disable_monitor - disabled an enabled monitor
  */
-static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
+static int __rv_disable_monitor(struct rv_monitor *mon, bool sync)
 {
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (mdef->monitor->enabled) {
-		mdef->monitor->enabled =3D 0;
-		if (mdef->monitor->disable)
-			mdef->monitor->disable();
+	if (mon->enabled) {
+		mon->enabled =3D 0;
+		if (mon->disable)
+			mon->disable();
=20
 		/*
 		 * Wait for the execution of all events to finish.
@@ -273,90 +273,90 @@ static int __rv_disable_monitor(struct rv_monitor_def=
 *mdef, bool sync)
 	return 0;
 }
=20
-static void rv_disable_single(struct rv_monitor_def *mdef)
+static void rv_disable_single(struct rv_monitor *mon)
 {
-	__rv_disable_monitor(mdef, true);
+	__rv_disable_monitor(mon, true);
 }
=20
-static int rv_enable_single(struct rv_monitor_def *mdef)
+static int rv_enable_single(struct rv_monitor *mon)
 {
 	int retval;
=20
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (mdef->monitor->enabled)
+	if (mon->enabled)
 		return 0;
=20
-	retval =3D mdef->monitor->enable();
+	retval =3D mon->enable();
=20
 	if (!retval)
-		mdef->monitor->enabled =3D 1;
+		mon->enabled =3D 1;
=20
 	return retval;
 }
=20
-static void rv_disable_container(struct rv_monitor_def *mdef)
+static void rv_disable_container(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *p =3D mdef;
+	struct rv_monitor *p =3D mon;
 	int enabled =3D 0;
=20
 	list_for_each_entry_continue(p, &rv_monitors_list, list) {
-		if (p->parent !=3D mdef->monitor)
+		if (p->parent !=3D mon)
 			break;
 		enabled +=3D __rv_disable_monitor(p, false);
 	}
 	if (enabled)
 		tracepoint_synchronize_unregister();
-	mdef->monitor->enabled =3D 0;
+	mon->enabled =3D 0;
 }
=20
-static int rv_enable_container(struct rv_monitor_def *mdef)
+static int rv_enable_container(struct rv_monitor *mon)
 {
-	struct rv_monitor_def *p =3D mdef;
+	struct rv_monitor *p =3D mon;
 	int retval =3D 0;
=20
 	list_for_each_entry_continue(p, &rv_monitors_list, list) {
-		if (retval || p->parent !=3D mdef->monitor)
+		if (retval || p->parent !=3D mon)
 			break;
 		retval =3D rv_enable_single(p);
 	}
 	if (retval)
-		rv_disable_container(mdef);
+		rv_disable_container(mon);
 	else
-		mdef->monitor->enabled =3D 1;
+		mon->enabled =3D 1;
 	return retval;
 }
=20
 /**
  * rv_disable_monitor - disable a given runtime monitor
- * @mdef: Pointer to the monitor definition structure.
+ * @mon: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
-int rv_disable_monitor(struct rv_monitor_def *mdef)
+int rv_disable_monitor(struct rv_monitor *mon)
 {
-	if (rv_is_container_monitor(mdef))
-		rv_disable_container(mdef);
+	if (rv_is_container_monitor(mon))
+		rv_disable_container(mon);
 	else
-		rv_disable_single(mdef);
+		rv_disable_single(mon);
=20
 	return 0;
 }
=20
 /**
  * rv_enable_monitor - enable a given runtime monitor
- * @mdef: Pointer to the monitor definition structure.
+ * @mon: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
-int rv_enable_monitor(struct rv_monitor_def *mdef)
+int rv_enable_monitor(struct rv_monitor *mon)
 {
 	int retval;
=20
-	if (rv_is_container_monitor(mdef))
-		retval =3D rv_enable_container(mdef);
+	if (rv_is_container_monitor(mon))
+		retval =3D rv_enable_container(mon);
 	else
-		retval =3D rv_enable_single(mdef);
+		retval =3D rv_enable_single(mon);
=20
 	return retval;
 }
@@ -367,7 +367,7 @@ int rv_enable_monitor(struct rv_monitor_def *mdef)
 static ssize_t monitor_enable_write_data(struct file *filp, const char __u=
ser *user_buf,
 					 size_t count, loff_t *ppos)
 {
-	struct rv_monitor_def *mdef =3D filp->private_data;
+	struct rv_monitor *mon =3D filp->private_data;
 	int retval;
 	bool val;
=20
@@ -378,9 +378,9 @@ static ssize_t monitor_enable_write_data(struct file *f=
ilp, const char __user *u
 	mutex_lock(&rv_interface_lock);
=20
 	if (val)
-		retval =3D rv_enable_monitor(mdef);
+		retval =3D rv_enable_monitor(mon);
 	else
-		retval =3D rv_disable_monitor(mdef);
+		retval =3D rv_disable_monitor(mon);
=20
 	mutex_unlock(&rv_interface_lock);
=20
@@ -399,12 +399,12 @@ static const struct file_operations interface_enable_=
fops =3D {
 static ssize_t monitor_desc_read_data(struct file *filp, char __user *user=
_buf, size_t count,
 				      loff_t *ppos)
 {
-	struct rv_monitor_def *mdef =3D filp->private_data;
+	struct rv_monitor *mon =3D filp->private_data;
 	char buff[256];
=20
 	memset(buff, 0, sizeof(buff));
=20
-	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
+	snprintf(buff, sizeof(buff), "%s\n", mon->description);
=20
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) =
+ 1);
 }
@@ -419,37 +419,37 @@ static const struct file_operations interface_desc_fo=
ps =3D {
  * the monitor dir, where the specific options of the monitor
  * are exposed.
  */
-static int create_monitor_dir(struct rv_monitor_def *mdef, struct rv_monit=
or_def *parent)
+static int create_monitor_dir(struct rv_monitor *mon, struct rv_monitor *p=
arent)
 {
 	struct dentry *root =3D parent ? parent->root_d : get_monitors_root();
-	const char *name =3D mdef->monitor->name;
+	const char *name =3D mon->name;
 	struct dentry *tmp;
 	int retval;
=20
-	mdef->root_d =3D rv_create_dir(name, root);
-	if (!mdef->root_d)
+	mon->root_d =3D rv_create_dir(name, root);
+	if (!mon->root_d)
 		return -ENOMEM;
=20
-	tmp =3D rv_create_file("enable", RV_MODE_WRITE, mdef->root_d, mdef, &inte=
rface_enable_fops);
+	tmp =3D rv_create_file("enable", RV_MODE_WRITE, mon->root_d, mon, &interf=
ace_enable_fops);
 	if (!tmp) {
 		retval =3D -ENOMEM;
 		goto out_remove_root;
 	}
=20
-	tmp =3D rv_create_file("desc", RV_MODE_READ, mdef->root_d, mdef, &interfa=
ce_desc_fops);
+	tmp =3D rv_create_file("desc", RV_MODE_READ, mon->root_d, mon, &interface=
_desc_fops);
 	if (!tmp) {
 		retval =3D -ENOMEM;
 		goto out_remove_root;
 	}
=20
-	retval =3D reactor_populate_monitor(mdef);
+	retval =3D reactor_populate_monitor(mon);
 	if (retval)
 		goto out_remove_root;
=20
 	return 0;
=20
 out_remove_root:
-	rv_remove(mdef->root_d);
+	rv_remove(mon->root_d);
 	return retval;
 }
=20
@@ -458,13 +458,12 @@ static int create_monitor_dir(struct rv_monitor_def *=
mdef, struct rv_monitor_def
  */
 static int monitors_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor_def *mon_def =3D p;
+	struct rv_monitor *mon =3D p;
=20
-	if (mon_def->parent)
-		seq_printf(m, "%s:%s\n", mon_def->parent->name,
-			   mon_def->monitor->name);
+	if (mon->parent)
+		seq_printf(m, "%s:%s\n", mon->parent->name, mon->name);
 	else
-		seq_printf(m, "%s\n", mon_def->monitor->name);
+		seq_printf(m, "%s\n", mon->name);
 	return 0;
 }
=20
@@ -496,13 +495,13 @@ static void *available_monitors_next(struct seq_file =
*m, void *p, loff_t *pos)
  */
 static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *po=
s)
 {
-	struct rv_monitor_def *m_def =3D p;
+	struct rv_monitor *mon =3D p;
=20
 	(*pos)++;
=20
-	list_for_each_entry_continue(m_def, &rv_monitors_list, list) {
-		if (m_def->monitor->enabled)
-			return m_def;
+	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
+		if (mon->enabled)
+			return mon;
 	}
=20
 	return NULL;
@@ -510,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, =
void *p, loff_t *pos)
=20
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor_def *m_def;
+	struct rv_monitor *mon;
 	loff_t l;
=20
 	mutex_lock(&rv_interface_lock);
@@ -518,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *=
m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
=20
-	m_def =3D list_entry(&rv_monitors_list, struct rv_monitor_def, list);
+	mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
=20
 	for (l =3D 0; l <=3D *pos; ) {
-		m_def =3D enabled_monitors_next(m, m_def, &l);
-		if (!m_def)
+		mon =3D enabled_monitors_next(m, mon, &l);
+		if (!mon)
 			break;
 	}
=20
-	return m_def;
+	return mon;
 }
=20
 /*
@@ -566,13 +565,13 @@ static const struct file_operations available_monitor=
s_ops =3D {
  */
 static void disable_all_monitors(void)
 {
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	int enabled =3D 0;
=20
 	mutex_lock(&rv_interface_lock);
=20
-	list_for_each_entry(mdef, &rv_monitors_list, list)
-		enabled +=3D __rv_disable_monitor(mdef, false);
+	list_for_each_entry(mon, &rv_monitors_list, list)
+		enabled +=3D __rv_disable_monitor(mon, false);
=20
 	if (enabled) {
 		/*
@@ -598,7 +597,7 @@ static ssize_t enabled_monitors_write(struct file *filp=
, const char __user *user
 				      size_t count, loff_t *ppos)
 {
 	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	int retval =3D -EINVAL;
 	bool enable =3D true;
 	char *ptr, *tmp;
@@ -633,17 +632,17 @@ static ssize_t enabled_monitors_write(struct file *fi=
lp, const char __user *user
 	if (tmp)
 		ptr =3D tmp+1;
=20
-	list_for_each_entry(mdef, &rv_monitors_list, list) {
-		if (strcmp(ptr, mdef->monitor->name) !=3D 0)
+	list_for_each_entry(mon, &rv_monitors_list, list) {
+		if (strcmp(ptr, mon->name) !=3D 0)
 			continue;
=20
 		/*
 		 * Monitor found!
 		 */
 		if (enable)
-			retval =3D rv_enable_monitor(mdef);
+			retval =3D rv_enable_monitor(mon);
 		else
-			retval =3D rv_disable_monitor(mdef);
+			retval =3D rv_disable_monitor(mon);
=20
 		if (!retval)
 			retval =3D count;
@@ -698,11 +697,11 @@ static void turn_monitoring_off(void)
=20
 static void reset_all_monitors(void)
 {
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
=20
-	list_for_each_entry(mdef, &rv_monitors_list, list) {
-		if (mdef->monitor->enabled && mdef->monitor->reset)
-			mdef->monitor->reset();
+	list_for_each_entry(mon, &rv_monitors_list, list) {
+		if (mon->enabled && mon->reset)
+			mon->reset();
 	}
 }
=20
@@ -762,10 +761,10 @@ static const struct file_operations monitoring_on_fop=
s =3D {
 	.read   =3D monitoring_on_read_data,
 };
=20
-static void destroy_monitor_dir(struct rv_monitor_def *mdef)
+static void destroy_monitor_dir(struct rv_monitor *mon)
 {
-	reactor_cleanup_monitor(mdef);
-	rv_remove(mdef->root_d);
+	reactor_cleanup_monitor(mon);
+	rv_remove(mon->root_d);
 }
=20
 /**
@@ -777,7 +776,7 @@ static void destroy_monitor_dir(struct rv_monitor_def *=
mdef)
  */
 int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *par=
ent)
 {
-	struct rv_monitor_def *r, *p =3D NULL;
+	struct rv_monitor *r;
 	int retval =3D 0;
=20
 	if (strlen(monitor->name) >=3D MAX_RV_MONITOR_NAME_SIZE) {
@@ -789,49 +788,31 @@ int rv_register_monitor(struct rv_monitor *monitor, s=
truct rv_monitor *parent)
 	mutex_lock(&rv_interface_lock);
=20
 	list_for_each_entry(r, &rv_monitors_list, list) {
-		if (strcmp(monitor->name, r->monitor->name) =3D=3D 0) {
+		if (strcmp(monitor->name, r->name) =3D=3D 0) {
 			pr_info("Monitor %s is already registered\n", monitor->name);
 			retval =3D -EEXIST;
 			goto out_unlock;
 		}
 	}
=20
-	if (parent) {
-		list_for_each_entry(r, &rv_monitors_list, list) {
-			if (strcmp(parent->name, r->monitor->name) =3D=3D 0) {
-				p =3D r;
-				break;
-			}
-		}
-	}
-
-	if (p && rv_is_nested_monitor(p)) {
+	if (parent && rv_is_nested_monitor(parent)) {
 		pr_info("Parent monitor %s is already nested, cannot nest further\n",
 			parent->name);
 		retval =3D -EINVAL;
 		goto out_unlock;
 	}
=20
-	r =3D kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
-	if (!r) {
-		retval =3D -ENOMEM;
-		goto out_unlock;
-	}
-
-	r->monitor =3D monitor;
-	r->parent =3D parent;
+	monitor->parent =3D parent;
=20
-	retval =3D create_monitor_dir(r, p);
-	if (retval) {
-		kfree(r);
-		goto out_unlock;
-	}
+	retval =3D create_monitor_dir(monitor, parent);
+	if (retval)
+		return retval;
=20
 	/* keep children close to the parent for easier visualisation */
-	if (p)
-		list_add(&r->list, &p->list);
+	if (parent)
+		list_add(&monitor->list, &parent->list);
 	else
-		list_add_tail(&r->list, &rv_monitors_list);
+		list_add_tail(&monitor->list, &rv_monitors_list);
=20
 out_unlock:
 	mutex_unlock(&rv_interface_lock);
@@ -846,17 +827,11 @@ int rv_register_monitor(struct rv_monitor *monitor, s=
truct rv_monitor *parent)
  */
 int rv_unregister_monitor(struct rv_monitor *monitor)
 {
-	struct rv_monitor_def *ptr, *next;
-
 	mutex_lock(&rv_interface_lock);
=20
-	list_for_each_entry_safe(ptr, next, &rv_monitors_list, list) {
-		if (strcmp(monitor->name, ptr->monitor->name) =3D=3D 0) {
-			rv_disable_monitor(ptr);
-			list_del(&ptr->list);
-			destroy_monitor_dir(ptr);
-		}
-	}
+	rv_disable_monitor(monitor);
+	list_del(&monitor->list);
+	destroy_monitor_dir(monitor);
=20
 	mutex_unlock(&rv_interface_lock);
 	return 0;
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 873364094402..f039ec1c9156 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -32,34 +32,23 @@ struct rv_reactor_def {
 };
 #endif
=20
-struct rv_monitor_def {
-	struct list_head	list;
-	struct rv_monitor	*monitor;
-	struct rv_monitor	*parent;
-	struct dentry		*root_d;
-#ifdef CONFIG_RV_REACTORS
-	struct rv_reactor_def	*rdef;
-	bool			reacting;
-#endif
-};
-
 struct dentry *get_monitors_root(void);
-int rv_disable_monitor(struct rv_monitor_def *mdef);
-int rv_enable_monitor(struct rv_monitor_def *mdef);
-bool rv_is_container_monitor(struct rv_monitor_def *mdef);
-bool rv_is_nested_monitor(struct rv_monitor_def *mdef);
+int rv_disable_monitor(struct rv_monitor *mon);
+int rv_enable_monitor(struct rv_monitor *mon);
+bool rv_is_container_monitor(struct rv_monitor *mon);
+bool rv_is_nested_monitor(struct rv_monitor *mon);
=20
 #ifdef CONFIG_RV_REACTORS
-int reactor_populate_monitor(struct rv_monitor_def *mdef);
-void reactor_cleanup_monitor(struct rv_monitor_def *mdef);
+int reactor_populate_monitor(struct rv_monitor *mon);
+void reactor_cleanup_monitor(struct rv_monitor *mon);
 int init_rv_reactors(struct dentry *root_dir);
 #else
-static inline int reactor_populate_monitor(struct rv_monitor_def *mdef)
+static inline int reactor_populate_monitor(struct rv_monitor *mon)
 {
 	return 0;
 }
=20
-static inline void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	return;
 }
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 740603670dd1..7cc620a1be1a 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -138,10 +138,10 @@ static const struct file_operations available_reactor=
s_ops =3D {
  */
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor_def *mdef =3D m->private;
+	struct rv_monitor *mon =3D m->private;
 	struct rv_reactor_def *rdef =3D p;
=20
-	if (mdef->rdef =3D=3D rdef)
+	if (mon->rdef =3D=3D rdef)
 		seq_printf(m, "[%s]\n", rdef->reactor->name);
 	else
 		seq_printf(m, "%s\n", rdef->reactor->name);
@@ -158,41 +158,41 @@ static const struct seq_operations monitor_reactors_s=
eq_ops =3D {
 	.show	=3D monitor_reactor_show
 };
=20
-static void monitor_swap_reactors_single(struct rv_monitor_def *mdef,
+static void monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor_def *rdef,
 					 bool reacting, bool nested)
 {
 	bool monitor_enabled;
=20
 	/* nothing to do */
-	if (mdef->rdef =3D=3D rdef)
+	if (mon->rdef =3D=3D rdef)
 		return;
=20
-	monitor_enabled =3D mdef->monitor->enabled;
+	monitor_enabled =3D mon->enabled;
 	if (monitor_enabled)
-		rv_disable_monitor(mdef);
+		rv_disable_monitor(mon);
=20
 	/* swap reactor's usage */
-	mdef->rdef->counter--;
+	mon->rdef->counter--;
 	rdef->counter++;
=20
-	mdef->rdef =3D rdef;
-	mdef->reacting =3D reacting;
-	mdef->monitor->react =3D rdef->reactor->react;
+	mon->rdef =3D rdef;
+	mon->reacting =3D reacting;
+	mon->react =3D rdef->reactor->react;
=20
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
-		rv_enable_monitor(mdef);
+		rv_enable_monitor(mon);
 }
=20
-static void monitor_swap_reactors(struct rv_monitor_def *mdef,
+static void monitor_swap_reactors(struct rv_monitor *mon,
 				  struct rv_reactor_def *rdef, bool reacting)
 {
-	struct rv_monitor_def *p =3D mdef;
+	struct rv_monitor *p =3D mon;
=20
-	if (rv_is_container_monitor(mdef))
+	if (rv_is_container_monitor(mon))
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
-			if (p->parent !=3D mdef->monitor)
+			if (p->parent !=3D mon)
 				break;
 			monitor_swap_reactors_single(p, rdef, reacting, true);
 		}
@@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct rv_monitor_def=
 *mdef,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mdef, rdef, reacting, false);
+	monitor_swap_reactors_single(mon, rdef, reacting, false);
 }
=20
 static ssize_t
@@ -210,7 +210,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 		      size_t count, loff_t *ppos)
 {
 	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
-	struct rv_monitor_def *mdef;
+	struct rv_monitor *mon;
 	struct rv_reactor_def *rdef;
 	struct seq_file *seq_f;
 	int retval =3D -EINVAL;
@@ -237,7 +237,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 	 * See monitor_reactors_open()
 	 */
 	seq_f =3D file->private_data;
-	mdef =3D seq_f->private;
+	mon =3D seq_f->private;
=20
 	mutex_lock(&rv_interface_lock);
=20
@@ -252,7 +252,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 		else
 			enable =3D true;
=20
-		monitor_swap_reactors(mdef, rdef, enable);
+		monitor_swap_reactors(mon, rdef, enable);
=20
 		retval =3D count;
 		break;
@@ -268,7 +268,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
  */
 static int monitor_reactors_open(struct inode *inode, struct file *file)
 {
-	struct rv_monitor_def *mdef =3D inode->i_private;
+	struct rv_monitor *mon =3D inode->i_private;
 	struct seq_file *seq_f;
 	int ret;
=20
@@ -284,7 +284,7 @@ static int monitor_reactors_open(struct inode *inode, s=
truct file *file)
 	/*
 	 * Copy the create file "private" data to the seq_file private data.
 	 */
-	seq_f->private =3D mdef;
+	seq_f->private =3D mon;
=20
 	return 0;
 };
@@ -454,37 +454,37 @@ static const struct file_operations reacting_on_fops =
=3D {
=20
 /**
  * reactor_populate_monitor - creates per monitor reactors file
- * @mdef:	monitor's definition.
+ * @mon:	The monitor.
  *
  * Returns 0 if successful, error otherwise.
  */
-int reactor_populate_monitor(struct rv_monitor_def *mdef)
+int reactor_populate_monitor(struct rv_monitor *mon)
 {
 	struct dentry *tmp;
=20
-	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mdef->root_d, mdef, &mo=
nitor_reactors_ops);
+	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mon->root_d, mon, &moni=
tor_reactors_ops);
 	if (!tmp)
 		return -ENOMEM;
=20
 	/*
 	 * Configure as the rv_nop reactor.
 	 */
-	mdef->rdef =3D get_reactor_rdef_by_name("nop");
-	mdef->rdef->counter++;
-	mdef->reacting =3D false;
+	mon->rdef =3D get_reactor_rdef_by_name("nop");
+	mon->rdef->counter++;
+	mon->reacting =3D false;
=20
 	return 0;
 }
=20
 /**
  * reactor_cleanup_monitor - cleanup a monitor reference
- * @mdef:       monitor's definition.
+ * @mon:       the monitor.
  */
-void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	lockdep_assert_held(&rv_interface_lock);
-	mdef->rdef->counter--;
-	WARN_ON_ONCE(mdef->rdef->counter < 0);
+	mon->rdef->counter--;
+	WARN_ON_ONCE(mon->rdef->counter < 0);
 }
=20
 /*
--=20
2.39.5

