Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C82EB5AA;
	Thu, 24 Jul 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378425; cv=none; b=g11wBLl12vDcHa7rRgB5zg6ZxWsj7BiCOuGRPevQ1bigtX9rsykc3/1O/Rcj2NOJ9hLWB+5YktU3MS2KRg1vHUnWIw8wJoHQTKawr8sd74U7ox+qE9PUDvyJiDKDVSuiSIsSPZ5I25aEVlzBvoIvujgq6yhqFmBFGTz/XS08Sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378425; c=relaxed/simple;
	bh=USx5NKsflIxM3SaPbXE+gJBLbbHpds2LQ5EaNRGvHTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPtl0LcqaI2lB/FI2O8W0AyY8jcwin2HP2SY41V02il56CplPL+sLE0oNUKoHKdBDlbY3bUSLny7j+HbeMi20x20+jKJpWGMtTwx6Sx1oUlEQcXhNJzMSKFSywiOaCbXhzv4s2FX1AZ5PW09nsUeD+sBHrdLQJ9QoKI98vrDLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuTM5W65; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaabzRrb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuTM5W65";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaabzRrb"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sbRYsXpNG5ZjXONmRclZGrm/qmskgyivkyJG5KlPIM=;
	b=SuTM5W65t7VSJVvAj22ipe/W4kjabh5vn8HxGG0nEdVVq+2goecEtAxFxnZgSmltQbPkDh
	c92XAuhAHoQXpb1W5x9/HgXPzO/UqpGOyfgP4pS/H4bGy5p4kjQRSvHgVq0dXddw0pUi/S
	PD/8YNZnEVDilxGg1qfWdVyheOWZV0nYxXDLiTLxkKQXQterfa2ksMV+JsWUznrVvWyNWV
	2uvgLWSW762gIasm2g1i3rw1M6qgWsjseUSOaihRb7nsnephSTT1AKse5YnaG6SHZXB5p6
	8lQgvUHHr2gkTNqQXmLOcT0GLf9Rp1sXGacNJV+CopvySJiVQq/gaN+t6Dq0MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sbRYsXpNG5ZjXONmRclZGrm/qmskgyivkyJG5KlPIM=;
	b=IaabzRrb4BZU/mQ8y7Llj6QXhOBN+fSFLV7DDMh9Nmc47VJM+avjU5B5oav35VcY5HK7jf
	iFP9QmBGSftXZHDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 3/5] rv: Merge struct rv_reactor_def into struct rv_reactor
Date: Thu, 24 Jul 2025 19:33:28 +0200
Message-Id: <71cb91c86cd40df5b8c492b788787f2a73c3eaa3.1753378331.git.namcao@linutronix.de>
In-Reply-To: <cover.1753378331.git.namcao@linutronix.de>
References: <cover.1753378331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each struct rv_reactor has a unique struct rv_reactor_def associated with
it. struct rv_reactor is statically allocated, while struct rv_reactor_def
is dynamically allocated.

This makes the code more complicated than it should be:

  - Lookup is required to get the associated rv_reactor_def from rv_reactor

  - Dynamic memory allocation is required for rv_reactor_def. This is
    harder to get right compared to static memory. For instance, there is
    an existing mistake: rv_unregister_reactor() does not free the memory
    allocated by rv_register_reactor(). This is fortunately not a real
    memory leak problem as rv_unregister_reactor() is never called.

Simplify and merge rv_reactor_def into rv_reactor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h            |  5 +-
 kernel/trace/rv/rv.h          |  9 ----
 kernel/trace/rv/rv_reactors.c | 92 +++++++++++++++--------------------
 3 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index dba53aecdfab..c22c9b8c1567 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -90,6 +90,9 @@ struct rv_reactor {
 	const char		*name;
 	const char		*description;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
+	struct list_head	list;
+	/* protected by the monitor interface lock */
+	int			counter;
 };
 #endif
=20
@@ -101,7 +104,7 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
-	struct rv_reactor_def	*rdef;
+	struct rv_reactor	*reactor;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
 	bool			reacting;
 #endif
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index f039ec1c9156..8c38f9dd41bc 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -23,15 +23,6 @@ struct rv_interface {
 extern struct mutex rv_interface_lock;
 extern struct list_head rv_monitors_list;
=20
-#ifdef CONFIG_RV_REACTORS
-struct rv_reactor_def {
-	struct list_head	list;
-	struct rv_reactor	*reactor;
-	/* protected by the monitor interface lock */
-	int			counter;
-};
-#endif
-
 struct dentry *get_monitors_root(void);
 int rv_disable_monitor(struct rv_monitor *mon);
 int rv_enable_monitor(struct rv_monitor *mon);
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 7cc620a1be1a..2c7909e6d0e7 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -70,12 +70,12 @@
  */
 static LIST_HEAD(rv_reactors_list);
=20
-static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
+static struct rv_reactor *get_reactor_rdef_by_name(char *name)
 {
-	struct rv_reactor_def *r;
+	struct rv_reactor *r;
=20
 	list_for_each_entry(r, &rv_reactors_list, list) {
-		if (strcmp(name, r->reactor->name) =3D=3D 0)
+		if (strcmp(name, r->name) =3D=3D 0)
 			return r;
 	}
 	return NULL;
@@ -86,9 +86,9 @@ static struct rv_reactor_def *get_reactor_rdef_by_name(ch=
ar *name)
  */
 static int reactors_show(struct seq_file *m, void *p)
 {
-	struct rv_reactor_def *rea_def =3D p;
+	struct rv_reactor *reactor =3D p;
=20
-	seq_printf(m, "%s\n", rea_def->reactor->name);
+	seq_printf(m, "%s\n", reactor->name);
 	return 0;
 }
=20
@@ -139,12 +139,12 @@ static const struct file_operations available_reactor=
s_ops =3D {
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
 	struct rv_monitor *mon =3D m->private;
-	struct rv_reactor_def *rdef =3D p;
+	struct rv_reactor *reactor =3D p;
=20
-	if (mon->rdef =3D=3D rdef)
-		seq_printf(m, "[%s]\n", rdef->reactor->name);
+	if (mon->reactor =3D=3D reactor)
+		seq_printf(m, "[%s]\n", reactor->name);
 	else
-		seq_printf(m, "%s\n", rdef->reactor->name);
+		seq_printf(m, "%s\n", reactor->name);
 	return 0;
 }
=20
@@ -159,13 +159,13 @@ static const struct seq_operations monitor_reactors_s=
eq_ops =3D {
 };
=20
 static void monitor_swap_reactors_single(struct rv_monitor *mon,
-					 struct rv_reactor_def *rdef,
+					 struct rv_reactor *reactor,
 					 bool reacting, bool nested)
 {
 	bool monitor_enabled;
=20
 	/* nothing to do */
-	if (mon->rdef =3D=3D rdef)
+	if (mon->reactor =3D=3D reactor)
 		return;
=20
 	monitor_enabled =3D mon->enabled;
@@ -173,12 +173,12 @@ static void monitor_swap_reactors_single(struct rv_mo=
nitor *mon,
 		rv_disable_monitor(mon);
=20
 	/* swap reactor's usage */
-	mon->rdef->counter--;
-	rdef->counter++;
+	mon->reactor->counter--;
+	reactor->counter++;
=20
-	mon->rdef =3D rdef;
+	mon->reactor =3D reactor;
 	mon->reacting =3D reacting;
-	mon->react =3D rdef->reactor->react;
+	mon->react =3D reactor->react;
=20
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
@@ -186,7 +186,7 @@ static void monitor_swap_reactors_single(struct rv_moni=
tor *mon,
 }
=20
 static void monitor_swap_reactors(struct rv_monitor *mon,
-				  struct rv_reactor_def *rdef, bool reacting)
+				  struct rv_reactor *reactor, bool reacting)
 {
 	struct rv_monitor *p =3D mon;
=20
@@ -194,7 +194,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent !=3D mon)
 				break;
-			monitor_swap_reactors_single(p, rdef, reacting, true);
+			monitor_swap_reactors_single(p, reactor, reacting, true);
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, rdef, reacting, false);
+	monitor_swap_reactors_single(mon, reactor, reacting, false);
 }
=20
 static ssize_t
@@ -211,7 +211,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 {
 	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
 	struct rv_monitor *mon;
-	struct rv_reactor_def *rdef;
+	struct rv_reactor *reactor;
 	struct seq_file *seq_f;
 	int retval =3D -EINVAL;
 	bool enable;
@@ -243,16 +243,16 @@ monitor_reactors_write(struct file *file, const char =
__user *user_buf,
=20
 	retval =3D -EINVAL;
=20
-	list_for_each_entry(rdef, &rv_reactors_list, list) {
-		if (strcmp(ptr, rdef->reactor->name) !=3D 0)
+	list_for_each_entry(reactor, &rv_reactors_list, list) {
+		if (strcmp(ptr, reactor->name) !=3D 0)
 			continue;
=20
-		if (rdef =3D=3D get_reactor_rdef_by_name("nop"))
+		if (strcmp(reactor->name, "nop"))
 			enable =3D false;
 		else
 			enable =3D true;
=20
-		monitor_swap_reactors(mon, rdef, enable);
+		monitor_swap_reactors(mon, reactor, enable);
=20
 		retval =3D count;
 		break;
@@ -299,23 +299,16 @@ static const struct file_operations monitor_reactors_=
ops =3D {
=20
 static int __rv_register_reactor(struct rv_reactor *reactor)
 {
-	struct rv_reactor_def *r;
+	struct rv_reactor *r;
=20
 	list_for_each_entry(r, &rv_reactors_list, list) {
-		if (strcmp(reactor->name, r->reactor->name) =3D=3D 0) {
+		if (strcmp(reactor->name, r->name) =3D=3D 0) {
 			pr_info("Reactor %s is already registered\n", reactor->name);
 			return -EINVAL;
 		}
 	}
=20
-	r =3D kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
-	if (!r)
-		return -ENOMEM;
-
-	r->reactor =3D reactor;
-	r->counter =3D 0;
-
-	list_add_tail(&r->list, &rv_reactors_list);
+	list_add_tail(&reactor->list, &rv_reactors_list);
=20
 	return 0;
 }
@@ -350,26 +343,19 @@ int rv_register_reactor(struct rv_reactor *reactor)
  */
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
-	struct rv_reactor_def *ptr, *next;
 	int ret =3D 0;
=20
 	mutex_lock(&rv_interface_lock);
=20
-	list_for_each_entry_safe(ptr, next, &rv_reactors_list, list) {
-		if (strcmp(reactor->name, ptr->reactor->name) =3D=3D 0) {
-
-			if (!ptr->counter) {
-				list_del(&ptr->list);
-			} else {
-				printk(KERN_WARNING
-				       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
-				       ptr->reactor->name, ptr->counter);
-				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
-				       ptr->reactor->name);
-				ret =3D -EBUSY;
-				break;
-			}
-		}
+	if (!reactor->counter) {
+		list_del(&reactor->list);
+	} else {
+		printk(KERN_WARNING
+		       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
+		       reactor->name, reactor->counter);
+		printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
+		       reactor->name);
+		ret =3D -EBUSY;
 	}
=20
 	mutex_unlock(&rv_interface_lock);
@@ -469,8 +455,8 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	/*
 	 * Configure as the rv_nop reactor.
 	 */
-	mon->rdef =3D get_reactor_rdef_by_name("nop");
-	mon->rdef->counter++;
+	mon->reactor =3D get_reactor_rdef_by_name("nop");
+	mon->reactor->counter++;
 	mon->reacting =3D false;
=20
 	return 0;
@@ -483,8 +469,8 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 void reactor_cleanup_monitor(struct rv_monitor *mon)
 {
 	lockdep_assert_held(&rv_interface_lock);
-	mon->rdef->counter--;
-	WARN_ON_ONCE(mon->rdef->counter < 0);
+	mon->reactor->counter--;
+	WARN_ON_ONCE(mon->reactor->counter < 0);
 }
=20
 /*
--=20
2.39.5

