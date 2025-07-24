Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787A2ECD23;
	Thu, 24 Jul 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378427; cv=none; b=AHzI58evfKTo9FAu2ZK2+wVLCWqo5FojZziTyF8QPFDgHImF3x9IIbDftVHHwcFgf2dmf952ELiNjJ7YEGsRGBCsv5/4dhfoalM8xxS+J+P3wo/hFhUWOJdZm+bc451+TuBgxMVtAlnCgIF6+uzicdwBvo0gMRXaFta338y0vfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378427; c=relaxed/simple;
	bh=fP5avm7xzAqqGo4XnEJHq7hCYGbG9fC5uQHA6BI2dlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcUay8XA9xTdLtA5Ai4AlAAkLxn9ch3wmXjOHXJFM7fdQSs+HG4Ki5NybmC+JZHhGEqp2XsgusV+cGvWO+MjBrIIISK6kB6SKsg1XDkoB/JH8JoQd46jVLGyaQuWNH3sfufFqGlvUbotgs/SkD+UUSZNX2iqYJiLokrZJl2c0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6oahllJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=va0Pnudz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6oahllJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="va0Pnudz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QfvL53dE2Amlb8t0pQ4UVtNU6qhDm01tFHkqVVPuo4=;
	b=D6oahllJQDz516puMwl3kkmnGKz/VxJMFJPRMNSHvKxC7KVt+KgwDHGnVOSFV81NIkRVs0
	Vfn8T+xboXp9QM39+PmOHy6O77umAOhcqrCgOTtfFXv7gq/jd+FzprRqLSIwBrISwMnqjR
	Hbgec0CR2Q1356MoT/QmjoTlaS26mHfS3K4M9Y8uEk6h9HWlTCMuIYSeURDRThwLgxbZsI
	mbTYa3tuOVY8/4vFZdu6k5P4jHjnh6ouxy4sMslTwFdBrTxedW3KCH8hesUVxyd71UCW+m
	uLYDLDPo8O1NXCDMQzur6zn41qcBKM6cZCiU5IEeGU6NGj68sFDSWc+gRfZxkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QfvL53dE2Amlb8t0pQ4UVtNU6qhDm01tFHkqVVPuo4=;
	b=va0PnudzrU9oZ5HKh0FQiiw6cnzlcfSnsd5DTtctiCxBdogTGeavnuM2SXhnn/REpYazA9
	U+n49vxmRYDXFgAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 5/5] rv: Remove struct rv_monitor::reacting
Date: Thu, 24 Jul 2025 19:33:30 +0200
Message-Id: <a6c16f845d2f1a09c4d0934ab83f3cb14478a71d.1753378331.git.namcao@linutronix.de>
In-Reply-To: <cover.1753378331.git.namcao@linutronix.de>
References: <cover.1753378331.git.namcao@linutronix.de>
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
 kernel/trace/rv/rv_reactors.c | 19 +++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

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
index a8e849e6cd85..106f2c4740f2 100644
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
@@ -210,7 +208,6 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 	struct rv_reactor *reactor;
 	struct seq_file *seq_f;
 	int retval =3D -EINVAL;
-	bool enable;
 	char *ptr;
 	int len;
=20
@@ -243,12 +240,7 @@ monitor_reactors_write(struct file *file, const char _=
_user *user_buf,
 		if (strcmp(ptr, reactor->name) !=3D 0)
 			continue;
=20
-		if (strcmp(reactor->name, "nop"))
-			enable =3D false;
-		else
-			enable =3D true;
-
-		monitor_swap_reactors(mon, reactor, enable);
+		monitor_swap_reactors(mon, reactor);
=20
 		retval =3D count;
 		break;
@@ -439,7 +431,6 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	 * Configure as the rv_nop reactor.
 	 */
 	mon->reactor =3D get_reactor_rdef_by_name("nop");
-	mon->reacting =3D false;
=20
 	return 0;
 }
--=20
2.39.5

