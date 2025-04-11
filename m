Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02228F952;
	Fri, 11 Apr 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357098; cv=none; b=a0JIku8xuljQUyVBpxckVpJCV8ZHFcNhhhJt1pVn71BKyWvaykHrFDop7eClOoFc6QPFHjFdewkmBYFz0mdT5T8ROu+4b69jIwTi1H8+nFh9XdtelkmJedJTvK1L86Iwm4Y/ISLbr85BgwpP8KILUmqXTkWisWgvgmsVbGOzR48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357098; c=relaxed/simple;
	bh=Pu5qeLP50BYvS1NgIYckvte0gOglKtgy+7dOZ5Tw4oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdPIPbMVjOSB57EOOBQdEi74ywz6AZzwkpUm/vJXGC3inMOzmXdDNH1TbNxWH0UpvTcnfyQyXqrhapgGjFaLB8KRc/6TVtkG1bOwsRf/Us3kfZR/ODuBRIAukzQA7EumPlVUfhxg05GhOOmgS6me86AD6852s+CwTg1F/3oS4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ph50GA5c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uW2JAw34; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ph50GA5c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uW2JAw34"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfEvlueetnDxLMyJc1jJTo3j++2LyYZ3zmJhMLkWgu4=;
	b=Ph50GA5cRKIzSm/m9rkJq2y6KNHZy0fm9ycCtAMWz9fzU/XRFJa82xgCINeNjNm9I7Giij
	T75cxPfPPvocRUJjyLQOUaoSni1RQPUOTeBskbpqJPQQenlcH7t+edR/I9ERhi5TYS8Yeo
	LMoVl7R9w+ZKAEseYBfv9TERG0VOrPkirpIeqM6tjcSqVzkLy9X4GeTjyox3fi9dtn6u3m
	Rsj8WRBqdy9Qpnso9O3DgZQUJGQy3N+TQewOU1M/hYN5T8r/fJv2Db4E04Uqxy7BHW5OvS
	wtXghF3y/IlfbGhtxISQRaqvF4kq//m0jF7fRqOwyKaz3fddcEDyruACbeFbqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfEvlueetnDxLMyJc1jJTo3j++2LyYZ3zmJhMLkWgu4=;
	b=uW2JAw34beWWkx8+GccsvdpdqoNF7+SXd2/lPymaGsXF3nVyoITn+gTQ32d4v2c/Ig/swd
	azNHqKMxOikD8XCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 22/22] rv: Allow to configure the number of per-task monitor
Date: Fri, 11 Apr 2025 09:37:38 +0200
Message-Id: <2591d725ec3dddfa27ad1826e7440fca71671770.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h      | 2 +-
 include/linux/sched.h   | 8 +++-----
 kernel/trace/rv/Kconfig | 9 +++++++++
 kernel/trace/rv/rv.c    | 8 ++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index c8320fa3a94b..204436a73bee 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -75,7 +75,7 @@ static inline bool rv_ltl_all_atoms_known(struct ltl_moni=
tor *mon)
  * these are justified.
  */
 #define RV_PER_TASK_MONITORS		1
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
index d493fddf411f..ebd4b4b228bf 100644
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

