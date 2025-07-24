Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043A2EB5D1;
	Thu, 24 Jul 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378425; cv=none; b=OztwXcTvDOavipDmS0niG0at6tdP1WFmeLhjMaPc8CBgcjMwbBD1+ukaZD8Fn4Mk3iOHJRvbZ6c5Y2tPDTRr30Mdq6k4pvCcr4GK0AzZG+DFVm/iO0Ib8M2i7pPSInfBINNiVZRWoTvnqd8QC/2ph1riKdio/pIxcnX6FO52O4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378425; c=relaxed/simple;
	bh=ohHwgHEGcn2p7iHq4+D+pcPNRxF5edhG+X8OSMH0wfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTUPECJKmzOYMoP92MG3bo9OZdxvNO2H51ovohNHyeiZFfTZ6//Yoe4OkmTq9bnI31PtSsjPHYY71l3IDkuYtVLU/gMPCux2KO3cHHP0g4z+E5r11YJ01WNhi1LM/1rputmleCPQ11c1cK3Xmi+eUhzuHcZAtZ6coJBafE6LTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCQZFlU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFubIXR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCQZFlU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFubIXR1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aENYh4UgvY9x1ap0h28owNIgbETirlVACfaxaFmhmwg=;
	b=ZCQZFlU2W6nbRwKf5cm7Gqa2m7ULu70eFuHtRE6g7wp39NkqJwUdFwaSD4O5RqLCN+E5UI
	Ye2kRpQfq8OmZf17e7ZoGmU2RtRIG/ksBCvQVpot3tndB9V0mohJEugzQ19unOc5hokHLv
	vxa0WFvpNpB3WnoetT2vEqMbstiHtRRFgMbXO1tdhfG88gPiWEBBsWecXaRRZLrNsAL75J
	zGZxv97Pb0xV8aRn9JuPuqFPh+3Gu/RlfwLzaRT9a6On3zSXq/cuv0JKcPS6LbvKt5OmsB
	vU+aIEEvme0rGBrQPgABDX8DEI+zhiCtBxc4OyuXSRKWokLAlU/mV6u0VXs1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aENYh4UgvY9x1ap0h28owNIgbETirlVACfaxaFmhmwg=;
	b=MFubIXR187yXRkm9MqqZa/GPac8c/ZDkHrkkQ3n/eNnbaMtr9i0PshPlOBa6RDTx7t0Idd
	ADB9jY3anY4oSWBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 4/5] rv: Remove rv_reactor's reference counter
Date: Thu, 24 Jul 2025 19:33:29 +0200
Message-Id: <bb946398436a5e17fb0f5b842ef3313c02291852.1753378331.git.namcao@linutronix.de>
In-Reply-To: <cover.1753378331.git.namcao@linutronix.de>
References: <cover.1753378331.git.namcao@linutronix.de>
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

If we support building RV reactors as modules in the future, kernel
module's centralized facilities such as try_module_get(), module_put() or
MODULE_SOFTDEP should be used instead of this custom implementation.

Remove this reference counter.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
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
index 08d0bcc715bf..2ac0e8bf4e60 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -763,7 +763,6 @@ static const struct file_operations monitoring_on_fops =
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

