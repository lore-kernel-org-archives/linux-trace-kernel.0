Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9913288C80;
	Mon, 21 Jul 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091254; cv=none; b=AjIEIaHgyUSUB/EdsXdq3qaSdZo20dHCBT1UheqfK6OlIoB+eh2YQwRhaf/8mwT5x1WNvKkRaJxBgMBDDUgvlBKe+WOnef3NhSrMcNxGl4FdJVCmd/lk1QyELfrG9hwOCE5vVLJQe5U6V4pbVNMcKiEFhTuRtq1Uq+q4cP9XgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091254; c=relaxed/simple;
	bh=xiuJRKbsul3hYFglg8y3qqtaoPoUYmCLZ0VbgQ9ZuVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2+sw18Snd4yTlIMGT4/PhTmhYQpyffrr4a1az2mkOBCOzau97tqDpaGQDBVJCRt6pTNaEwKC0QHsOTQexxYfZ06tNpAoNXAv2RRbLztS1g2lXKwB05blN1eLE5pC0I0D8w/npGOerIY8SV+9IxGF7Wyxe91QyqIZBKt4CM9hTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5Ylf4WS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6Vb3qO3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5Ylf4WS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6Vb3qO3"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753091250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQhHhKkS0mZxurIJ/v8ZKi6Pmiiz0GsrsNhfnsYfDHY=;
	b=q5Ylf4WSxCC5Y9DEk/ffWsDkUuO20mvyVq4xMRHf1f8wAWyr2eHML8D+C/qyG/2pu3+f4P
	BRcCwyovhN582y5V0UrrjD2eVUjQ24HifkzRKoC+Ag7hPc+fEbPbbelZNIcR4TMT28q+S6
	wM9N8cX3VTXLJL7sBxx+DyHvmrcmjCSWaO+Hg4hhUC3lnhCZKkYM0tmHNO/okFf6/y22Bz
	wkou1oBKFBL1vWXM1jl4wAlrbFPiXqIsCjabHQLVYg+xCfLS75u8hCYKnsBmWCGEYT02Jc
	aBdcMAPaTLRP4fpH+83z5aGuIB85s0lVum1mev3dI6SavmZVvqheJQZ85QwyBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753091250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQhHhKkS0mZxurIJ/v8ZKi6Pmiiz0GsrsNhfnsYfDHY=;
	b=k6Vb3qO3f1qIyYGVcy2IYW7Whhyjz6w2F5OGmhVkbP61CwbtsbmRN1jHr/F9NUtC76o2dV
	O2tHqsbrOOeFp2Aw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 4/6] rv: Remove rv_reactor's reference counter
Date: Mon, 21 Jul 2025 11:47:11 +0200
Message-Id: <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
In-Reply-To: <cover.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rv_reactor has a reference counter to ensure it is not removed while
monitors are still using it.

However, this is futile, as __exit functions are not expected to fail and
will proceed normally despite rv_unregister_reactor() returning an error.

At the moment, reactors do not support being built as modules, therefore
they are never removed and the reference counters are not necessary.

If we support building RV reactors as modules in the future, MODULE_SOFTDEP
should be used instead of a custom implementation.

Remove this reference counter.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h            |  2 --
 kernel/trace/rv/rv.c          |  1 -
 kernel/trace/rv/rv.h          |  6 ------
 kernel/trace/rv/rv_reactors.c | 33 ++-------------------------------
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index c22c9b8c1567..2f867d6f72ba 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -91,8 +91,6 @@ struct rv_reactor {
 	const char		*description;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
 	struct list_head	list;
-	/* protected by the monitor interface lock */
-	int			counter;
 };
 #endif
=20
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c0be2fdc52d..6c8498743b98 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -769,7 +769,6 @@ static const struct file_operations monitoring_on_fops =
=3D {
=20
 static void destroy_monitor_dir(struct rv_monitor *mon)
 {
-	reactor_cleanup_monitor(mon);
 	rv_remove(mon->root_d);
 }
=20
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 8c38f9dd41bc..1485a70c1bf4 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -31,7 +31,6 @@ bool rv_is_nested_monitor(struct rv_monitor *mon);
=20
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon);
-void reactor_cleanup_monitor(struct rv_monitor *mon);
 int init_rv_reactors(struct dentry *root_dir);
 #else
 static inline int reactor_populate_monitor(struct rv_monitor *mon)
@@ -39,11 +38,6 @@ static inline int reactor_populate_monitor(struct rv_mon=
itor *mon)
 	return 0;
 }
=20
-static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
-{
-	return;
-}
-
 static inline int init_rv_reactors(struct dentry *root_dir)
 {
 	return 0;
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2c7909e6d0e7..a8e849e6cd85 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -172,10 +172,6 @@ static void monitor_swap_reactors_single(struct rv_mon=
itor *mon,
 	if (monitor_enabled)
 		rv_disable_monitor(mon);
=20
-	/* swap reactor's usage */
-	mon->reactor->counter--;
-	reactor->counter++;
-
 	mon->reactor =3D reactor;
 	mon->reacting =3D reacting;
 	mon->react =3D reactor->react;
@@ -343,23 +339,10 @@ int rv_register_reactor(struct rv_reactor *reactor)
  */
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
-	int ret =3D 0;
-
 	mutex_lock(&rv_interface_lock);
-
-	if (!reactor->counter) {
-		list_del(&reactor->list);
-	} else {
-		printk(KERN_WARNING
-		       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
-		       reactor->name, reactor->counter);
-		printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
-		       reactor->name);
-		ret =3D -EBUSY;
-	}
-
+	list_del(&reactor->list);
 	mutex_unlock(&rv_interface_lock);
-	return ret;
+	return 0;
 }
=20
 /*
@@ -456,23 +439,11 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor =3D get_reactor_rdef_by_name("nop");
-	mon->reactor->counter++;
 	mon->reacting =3D false;
=20
 	return 0;
 }
=20
-/**
- * reactor_cleanup_monitor - cleanup a monitor reference
- * @mon:       the monitor.
- */
-void reactor_cleanup_monitor(struct rv_monitor *mon)
-{
-	lockdep_assert_held(&rv_interface_lock);
-	mon->reactor->counter--;
-	WARN_ON_ONCE(mon->reactor->counter < 0);
-}
-
 /*
  * Nop reactor register
  */
--=20
2.39.5

