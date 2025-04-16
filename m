Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCA233702;
	Wed, 16 Apr 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786328; cv=none; b=fOt0vXAHx/3gjuWQBmmPDnxIFTHaX3rroMYRQQrGFlyyHT51gYXwNfQ5dK1TkBWIdadKZCixNicxb2rmBPP9gLjvbFv/y/txx6aPhdxtQix8z3oSodeYWr8mynSG52q95sQGGymV3+mYXNdSuVZZ3RuW8IvrOt3eBc/Oxmlcgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786328; c=relaxed/simple;
	bh=DoBeT3pBaDg0HZ0vLJhaXQ1uNpRO0e6zcI01L0ZU38c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWb29QAjSoAnpUdz+HrGqpMlOW/AfDP0MnW3olCYpZOOFyYLy2vqKtOI5q5PuTtDD6agVRrk+TM0D4IfnlTDTwnYKNxGieCjI+eaVCUA57I7CMOd1L47VAYJme1Rg9G5vIRXphKy/sfwmNJWhTEkNC/pnszz2GEOs4we8mHjPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uszUQxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=efZw623S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uszUQxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="efZw623S"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+7bhCgA+oC9ZBDDNwpDBLlIWCbk7xOCScEAcNFKoko=;
	b=1uszUQxhnfEw6v0By6ymDnMSHx2J3bripMHCzQak3X+li1K3TWVHeyx6WZIWlANaITNkKS
	Djf8qEDXI1CBjywV6u9KgIDk50g9+7bdGqeS8/LSYICjysprm7FKBM995yxKxkTJul4I4b
	VnvHb7+m0p5hmBZoxIhF9VReLZO73O45LO5JJPzJMN8twB5A5F33pWix50MbLy+wEak47w
	urZEhS7XCAcYvQRoba4TUCkMkycGZ9pVJloDlwKvL9lFw6OKR9nz0Zdd133F0sNrbxioF0
	1sYUEvCBWCaq7fT+iPEpovjjoa+z9DGu+Ft1O9/7kpGGBKEfUg8ek+LrIQEhwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+7bhCgA+oC9ZBDDNwpDBLlIWCbk7xOCScEAcNFKoko=;
	b=efZw623SBC3ZQxqaEK5ud11pRotSbiEcCheri8Kqk7oojpF8vouUrKR0JoPksqMUy3UQj/
	x8lMbiDbOYyxp6CA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 22/22] rv: Allow to configure the number of per-task monitor
Date: Wed, 16 Apr 2025 08:51:28 +0200
Message-Id: <a77f2b062f7c51e4d194c6846c3b9ed8d7cf2584.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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
 include/linux/rv.h      | 9 +--------
 include/linux/sched.h   | 8 +++-----
 kernel/trace/rv/Kconfig | 9 +++++++++
 kernel/trace/rv/rv.c    | 8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 2897aad16883..099b23c14e54 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -74,14 +74,7 @@ struct ltl_monitor {};
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
index 45be0fa7a5cc..560782493292 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1623,12 +1623,10 @@ struct task_struct {
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
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index dae84deb327d..a1b6b3c39eff 100644
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

