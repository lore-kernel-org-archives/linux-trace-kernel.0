Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41921244676;
	Wed,  9 Jul 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088911; cv=none; b=eNze0+Ef6yAbsprzgB9TXPqYglV6t7+NWFjiUv/kFLNr3izp9zoPeZLGGTGWXkXVjU4jhyg4qEtIeMkyfb3rvUN8etTsRNhhm/vQKa6EpTXbiG43TD9LO7n6CiVmy7GppNItV8ZWN8XMaZIi7IxfLGODrTN/LragyJG5DpJZPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088911; c=relaxed/simple;
	bh=Wgc5TeCxTSHrIluk/Zchk1qeFdkcI5CAnbfWjST87wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sY4WgdsRq1Pz95nA0uL6Tot2tlqBcMGEGydjUbf5j/ybQxe17kwMKEHzcxqrWpjR2ugKXk4m3THAhTyK8Oh3Tf4DhecOnfw3ZUxm1JUB0V1ZHQE2dPgNBXCuiGva9dF2N5gy/HhFWM4r25PWgy64pDQoVNnS+Rgmicu1NxHAS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7hiEdo0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6sO63G7O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7hiEdo0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6sO63G7O"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752088907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJJiizdaOD7bLY57+4l2vOqWNZK0dHtbValv5ybO8Ck=;
	b=D7hiEdo0UwSYy61UmfwI2smYLX5Xd0ztWTt4Rf//tYAinUlZqYkF3cL7uamYK97Qoy9ctR
	yiKl5QdWjSFtPcYb/n+CXzXL0N2pZh2mG5GNOO9jsxDLrXL2RYuvtn68s1BBrRI+TpmLHv
	HXwiSVXG1IujlFGD97JCUDcDfFviM1diXSraUl9hJr0djvZKN8XV+1bBrV1VHzRagGF548
	z7zgkPfSrRBVDgEQbpwJ05yVtgN59/oEfEavAwyCj4nZTunmkgDaqX1NH4klADVxJWegcM
	9JcKOEp39xmDDWnu9qjQ11QJv0oSJlLRZa2waBO6jUDW2NYFiJ3uf6Ai4ORK4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752088907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJJiizdaOD7bLY57+4l2vOqWNZK0dHtbValv5ybO8Ck=;
	b=6sO63G7OTHQb16XwD+XJDiQ01CQgQ/7tbjljEfXPbWkV+TWk9rBunJwd8oeGYg/toeyDAP
	JzPG/ahplzI6qBCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v13 12/12] rv: Allow to configure the number of per-task monitor
Date: Wed,  9 Jul 2025 21:21:23 +0200
Message-Id: <93e83313fc4ba7f6e66f4abe80ca5f5494d658d0.1752088709.git.namcao@linutronix.de>
In-Reply-To: <cover.1752088709.git.namcao@linutronix.de>
References: <cover.1752088709.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that there are 2 monitors for real-time applications, users may want to
enable both of them simultaneously. Make the number of per-task monitor
configurable. Default it to 2 for now.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h                     | 9 +--------
 include/linux/sched.h                  | 8 +++-----
 kernel/trace/rv/Kconfig                | 9 +++++++++
 kernel/trace/rv/monitors/rtapp/Kconfig | 1 +
 kernel/trace/rv/rv.c                   | 8 ++++----
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 1d5579f9b75a..97baf58d88b2 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -75,14 +75,7 @@ struct ltl_monitor {};
=20
 #endif /* CONFIG_RV_LTL_MONITOR */
=20
-/*
- * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
- * If we find justification for more monitors, we can think about
- * adding more or developing a dynamic method. So far, none of
- * these are justified.
- */
-#define RV_PER_TASK_MONITORS		1
-#define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
+#define RV_PER_TASK_MONITOR_INIT	(CONFIG_RV_PER_TASK_MONITORS)
=20
 union rv_task_monitor {
 	struct da_monitor	da_mon;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..fabd7fe1a07a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1642,12 +1642,10 @@ struct task_struct {
=20
 #ifdef CONFIG_RV
 	/*
-	 * Per-task RV monitor. Nowadays fixed in RV_PER_TASK_MONITORS.
-	 * If we find justification for more monitors, we can think
-	 * about adding more or developing a dynamic method. So far,
-	 * none of these are justified.
+	 * Per-task RV monitor, fixed in CONFIG_RV_PER_TASK_MONITORS.
+	 * If memory becomes a concern, we can think about a dynamic method.
 	 */
-	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
+	union rv_task_monitor		rv[CONFIG_RV_PER_TASK_MONITORS];
 #endif
=20
 #ifdef CONFIG_USER_EVENTS
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 942d57575e67..c11bf7e61ebf 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -32,6 +32,15 @@ menuconfig RV
 	  For further information, see:
 	    Documentation/trace/rv/runtime-verification.rst
=20
+config RV_PER_TASK_MONITORS
+	int "Maximum number of per-task monitor"
+	depends on RV
+	range 1 8
+	default 2
+	help
+	  This option configures the maximum number of per-task RV monitors that =
can run
+	  simultaneously.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monit=
ors/rtapp/Kconfig
index b7415c3570bb..1ce9370a9ba8 100644
--- a/kernel/trace/rv/monitors/rtapp/Kconfig
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -1,5 +1,6 @@
 config RV_MON_RTAPP
 	depends on RV
+	depends on RV_PER_TASK_MONITORS >=3D 2
 	bool "rtapp monitor"
 	help
 	  Collection of monitors to check for common problems with real-time
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e25d65fe432a..108429d16ec1 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -165,7 +165,7 @@ struct dentry *get_monitors_root(void)
 LIST_HEAD(rv_monitors_list);
=20
 static int task_monitor_count;
-static bool task_monitor_slots[RV_PER_TASK_MONITORS];
+static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
=20
 int rv_get_task_monitor_slot(void)
 {
@@ -173,12 +173,12 @@ int rv_get_task_monitor_slot(void)
=20
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (task_monitor_count =3D=3D RV_PER_TASK_MONITORS)
+	if (task_monitor_count =3D=3D CONFIG_RV_PER_TASK_MONITORS)
 		return -EBUSY;
=20
 	task_monitor_count++;
=20
-	for (i =3D 0; i < RV_PER_TASK_MONITORS; i++) {
+	for (i =3D 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
 		if (task_monitor_slots[i] =3D=3D false) {
 			task_monitor_slots[i] =3D true;
 			return i;
@@ -194,7 +194,7 @@ void rv_put_task_monitor_slot(int slot)
 {
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (slot < 0 || slot >=3D RV_PER_TASK_MONITORS) {
+	if (slot < 0 || slot >=3D CONFIG_RV_PER_TASK_MONITORS) {
 		WARN_ONCE(1, "RV releasing an invalid slot!: %d\n", slot);
 		return;
 	}
--=20
2.39.5

