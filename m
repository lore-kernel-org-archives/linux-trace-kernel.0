Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D9270542;
	Wed, 23 Jul 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253082; cv=none; b=Beo358on0LBHXmn/zRj30DGx9eJ62J68nHO/InhHivMbNydFuQGb8xVUiDKBFVSPle5gek+zKtWoQSYMzFqp04O63sHz03DhGL7K5n1ZP0eZQLm5XOnOhOTdL6i1L64gdoFFSL+eBJ6D+clwz0Xi77Yc8Y+pwmsIPmDf6/LOrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253082; c=relaxed/simple;
	bh=I+lXNbsZC1+8aPUONGXG5X+OuKuy1oMTiTHgi5RyqSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvSIVhPN4LOJnBNTxd+19EWiYKNSYu+6yjscr/Ff/NioF6Zt4DyFwio03rWwDjQ2V3lk2Low7DJNYSXX9hGPF2oeWwfOzDDa9lsdKfor4L1nhYRm7evAYEZk+G+mWausbHx8CNql56oOr88N/TrC/Z9eAjTC1dFbG6mZV0pYLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQ5joO+Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYG8qZx+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQ5joO+Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYG8qZx+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753253071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTq1AUkVqTkyuHLcR0Lq3ieETcyGVgvTh7SphrDjMDs=;
	b=XQ5joO+YFa0fX4S+Rm9UTddyutio3qWnxvdwjM4IF+Ds27QlOz47m4gwUl+B3XjwhbamUN
	iNfStfHws6VSU/GPJv0zqPknnT87peAX8uKctqwYOKd9d/xeSHtY1yve8nKw4ole6Qi1M1
	hQ7cgcTIjblNNmootEwLKsc07DTkjw/qElQu+c2GA+ff1nRRK8LJ7OtvC9d/ZQrtmckl7J
	mrmf5DK16vHHK1zoUG04SUlppzy0ODAbUoQ/xMx5RhOLQB+kLB2UM5+cBYNdKbmDsyjZGL
	pGxzXRfCVHBXboG8Xd57/5Ezxl2XVV/J/6EQwa4t0auSijCdWjuYj0FM/CWTtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753253071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTq1AUkVqTkyuHLcR0Lq3ieETcyGVgvTh7SphrDjMDs=;
	b=bYG8qZx+YNlZplO3GH5WFWfQNRvaF5SJcmO7gTX5DWQoR6cd+/2vvcmA7arKDfeEjJme38
	1waQImuZTKJBBPBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 5/5] rv: Remove struct rv_monitor::reacting
Date: Wed, 23 Jul 2025 08:44:23 +0200
Message-Id: <58c63faec76ffb36552fcd1fdcc4b9dd841efd94.1753252872.git.namcao@linutronix.de>
In-Reply-To: <cover.1753252872.git.namcao@linutronix.de>
References: <cover.1753252872.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The field 'reacting' in struct rv_monitor is set but never used. Delete it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h            |  1 -
 kernel/trace/rv/rv_reactors.c | 13 +++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 2f867d6f72ba..80731242fe60 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -104,7 +104,6 @@ struct rv_monitor {
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor	*reactor;
 	__printf(1, 2) void	(*react)(const char *msg, ...);
-	bool			reacting;
 #endif
 	struct list_head	list;
 	struct rv_monitor	*parent;
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index a8e849e6cd85..5e52886b4511 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -160,7 +160,7 @@ static const struct seq_operations monitor_reactors_seq=
_ops =3D {
=20
 static void monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor *reactor,
-					 bool reacting, bool nested)
+					 bool nested)
 {
 	bool monitor_enabled;
=20
@@ -173,7 +173,6 @@ static void monitor_swap_reactors_single(struct rv_moni=
tor *mon,
 		rv_disable_monitor(mon);
=20
 	mon->reactor =3D reactor;
-	mon->reacting =3D reacting;
 	mon->react =3D reactor->react;
=20
 	/* enable only once if iterating through a container */
@@ -181,8 +180,7 @@ static void monitor_swap_reactors_single(struct rv_moni=
tor *mon,
 		rv_enable_monitor(mon);
 }
=20
-static void monitor_swap_reactors(struct rv_monitor *mon,
-				  struct rv_reactor *reactor, bool reacting)
+static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reacto=
r *reactor)
 {
 	struct rv_monitor *p =3D mon;
=20
@@ -190,7 +188,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent !=3D mon)
 				break;
-			monitor_swap_reactors_single(p, reactor, reacting, true);
+			monitor_swap_reactors_single(p, reactor, true);
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -198,7 +196,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, reactor, reacting, false);
+	monitor_swap_reactors_single(mon, reactor, false);
 }
=20
 static ssize_t
@@ -248,7 +246,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 		else
 			enable =3D true;
=20
-		monitor_swap_reactors(mon, reactor, enable);
+		monitor_swap_reactors(mon, reactor);
=20
 		retval =3D count;
 		break;
@@ -439,7 +437,6 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor =3D get_reactor_rdef_by_name("nop");
-	mon->reacting =3D false;
=20
 	return 0;
 }
--=20
2.39.5

