Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF228D8EA;
	Mon, 21 Jul 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091255; cv=none; b=LiN147ONfB//QowxL640rE/U6jUQQfyOqjg3h4H5Ksf0PdE8OHbZpowYZalLvx357LaCsf1Tw9oasL2B4y6/lkgpB6qt46Bfxutx3v3Cw6eF/YQ74dbD8YPGvV+qq6mTRCvw9kp/7pzwzgmekYKcJgydkYFb2z281HsxNiSNf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091255; c=relaxed/simple;
	bh=tgjRXRS00GhllkORmEzhs2imp7/o6Ruzp26wJv3rIwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zel0G1o2oHJIn2xxC5N9vwLJ8zEotxSQuMTs2GWKvLLAJ+i5Sfa5AQlUMY7L7sAfIn5GUbbUQ+EtZhuNA3u8CDJMEsvBTEcLrSXtrNW6Qr5QLuCpGbnq/OLEbCDWvqGhEo+AE8HzLBY5JCVjZ3HH1rH59cQVCE0jUs1f0sx+0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0IrI4je; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTGWNgmv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0IrI4je";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTGWNgmv"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753091251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIF/45N5CWIDqATsNcmEWzUNyG6OTy6CUlvZXnc+0Y4=;
	b=R0IrI4jefDm14Us1SRk9dv51hoP4kjH4Sug+1PKGJn3mFdD0zuFaQXhBdbigi1Q6DCKT5D
	mjj9HE2wFc9eHJRk6CW7VogBRtSio43ojiMWubqrX7fmwXhW6SnGyJdsza5IqWfuwmCSlN
	9DOmv7PCSDlJn8ZdEcemq6SnH3sVEkyNfrJV2ywG7mqK823BRoVben5mI76sae2aEAo38u
	1CInhAIIicxkpT1kOnFD0Gxb2AJiUUs6T0M3p3ZjAcI9ayIWLepefgT26D/5nVllJrJ9MN
	7v5+U4pkHYkWYPl1SEIVN1/ZPAyrDQTIPuGoVWvm4DKswhn0RMHAV47ypVRU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753091251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIF/45N5CWIDqATsNcmEWzUNyG6OTy6CUlvZXnc+0Y4=;
	b=yTGWNgmvJ3zajVhXfvYJk4uFPeetLaMYLSLs7KO/E6e0cVdnqKny3KebGV7qO3QjKvCt/B
	SpHbYlRWX/ig4QBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 6/6] rv: Remove struct rv_monitor::reacting
Date: Mon, 21 Jul 2025 11:47:13 +0200
Message-Id: <5c18ef23f817fb653bb27f027cc1ffdf53f6e1fd.1753091084.git.namcao@linutronix.de>
In-Reply-To: <cover.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The field 'reacting' in struct rv_monitor is set but never used. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h            |  1 -
 kernel/trace/rv/rv_reactors.c | 14 ++++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

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
index aee622e4b833..6b03f3f6ecc1 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -149,7 +149,7 @@ static const struct seq_operations monitor_reactors_seq=
_ops =3D {
=20
 static void monitor_swap_reactors_single(struct rv_monitor *mon,
 					 struct rv_reactor *reactor,
-					 bool reacting, bool nested)
+					 bool nested)
 {
 	bool monitor_enabled;
=20
@@ -162,7 +162,6 @@ static void monitor_swap_reactors_single(struct rv_moni=
tor *mon,
 		rv_disable_monitor(mon);
=20
 	mon->reactor =3D reactor;
-	mon->reacting =3D reacting;
 	mon->react =3D reactor ? reactor->react : NULL;
=20
 	/* enable only once if iterating through a container */
@@ -170,8 +169,7 @@ static void monitor_swap_reactors_single(struct rv_moni=
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
@@ -179,7 +177,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 		list_for_each_entry_continue(p, &rv_monitors_list, list) {
 			if (p->parent !=3D mon)
 				break;
-			monitor_swap_reactors_single(p, reactor, reacting, true);
+			monitor_swap_reactors_single(p, reactor, true);
 		}
 	/*
 	 * This call enables and disables the monitor if they were active.
@@ -187,7 +185,7 @@ static void monitor_swap_reactors(struct rv_monitor *mo=
n,
 	 * All nested monitors are enabled also if they were off, we may refine
 	 * this logic in the future.
 	 */
-	monitor_swap_reactors_single(mon, reactor, reacting, false);
+	monitor_swap_reactors_single(mon, reactor, false);
 }
=20
 static ssize_t
@@ -221,7 +219,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
=20
 	len =3D strlen(ptr);
 	if (!len) {
-		monitor_swap_reactors(mon, NULL, false);
+		monitor_swap_reactors(mon, NULL);
 		return count;
 	}
=20
@@ -233,7 +231,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 		if (strcmp(ptr, reactor->name) !=3D 0)
 			continue;
=20
-		monitor_swap_reactors(mon, reactor, true);
+		monitor_swap_reactors(mon, reactor);
=20
 		retval =3D count;
 		break;
--=20
2.39.5

