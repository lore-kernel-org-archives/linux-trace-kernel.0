Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A83CEBA0;
	Wed, 11 Mar 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224187; cv=none; b=lSpVlt2OWXz/n0ngHfapxdame6SDskw4W4Eb2lQ2/RaSiqqQlMmb6B3QxRwb1gxivsjhO7nMi6N3zU+f6Gh3lUzuoPxd311Ps0kWww0JpIUDl2koidg2u4EmTVPiaCADR460jR9aoVDS8Wgu/Z3kOgo5OR4z13alEgNu/Hlc70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224187; c=relaxed/simple;
	bh=YvXyV7CVpcm/llatxBdUGnPwoonKvKmSxfG6LXdq7ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfNiCTjErdnNrcv698FQ0Y42xRjOVrMGx88fkM7Cj9Z2Yw9NubH3efPEjsvnVwVi9yraP7E5Ue4YEyDgMRAC9/cbdGNsicx5GITvqp593VbPVlYOG3Isl/2twhwwu2DnClYkr40sdr/w5AW4vb9l62HFRggWzGIQWpaq/p2u+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pt8ftYDb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6csCQMBI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pt8ftYDb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6csCQMBI"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1lqbPdWo5M7xyMGcnFdCdyd/ndaVXfMuzeCyaV6maY=;
	b=pt8ftYDbhWrhCXfKA4Oa/xg4dtora3Y0ynchr4jNqrUpr30g5GPdeQ/EPSFLdsgTlDBVYm
	RwH4fISwPDwqHEBZeyZFkInPex6QqUWi1Pwetu8+DB+ob1U5q9oadS8zR8grY0Ns1nbsbR
	NE5PKFtPfbF3a88/0bV0I1EHE+wKZ1bsqxDld+l9hBx+UrQr/xmAK9spv0a+S7HLD8wLUQ
	N/pACctXVZUzVqquTGNDlQN4JmjM8TF4Fn8eleu5zIvgXlISDmrs7tSsHu6pIbpCOla4gZ
	PRfH0f9/6F6RjG4iiXz4s4YwUqETZTnSzEUdgtbU46UXS+uYisVfzkwFRqGb3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1lqbPdWo5M7xyMGcnFdCdyd/ndaVXfMuzeCyaV6maY=;
	b=6csCQMBIt93U9Or22QexmVXQUytv8Gj5Q7HnbDrHDliXDFwF6UJ1/tZd5aF8/m+6WC1IRK
	1yWNdMLmGhXcXFCQ==
Date: Wed, 11 Mar 2026 11:15:21 +0100
Subject: [PATCH 12/12] hrtimer: Add a helper to retrieve a hrtimer from its
 timerqueue node
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-12-095357392669@linutronix.de>
References: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
In-Reply-To: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=2056;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YvXyV7CVpcm/llatxBdUGnPwoonKvKmSxfG6LXdq7ZI=;
 b=7txLjQFs4i7aNne4I+4t3O4R9sFRfvSuT1zH4pQNorAGf5+/yedPlMont6LSa2uBEF4/JwSVM
 vhSApJt1MocBnvl9wgsX/FxKqcXLxkHjAwocVOEoDpQT5El8XeUDRwA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The container_of() call is open-coded multiple times.

Add a helper macro.

Use container_of_const() to preserve constness.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/hrtimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d350bceb3c95..94955f967207 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -534,6 +534,8 @@ static inline void debug_activate(struct hrtimer *timer, enum hrtimer_mode mode,
 		for (bool done = false; !done; active &= ~(1U << idx))			\
 			for (base = &cpu_base->clock_base[idx]; !done; done = true)
 
+#define hrtimer_from_timerqueue_node(_n) container_of_const(_n, struct hrtimer, node)
+
 #if defined(CONFIG_NO_HZ_COMMON)
 /*
  * Same as hrtimer_bases_next_event() below, but skips the excluded timer and
@@ -578,7 +580,7 @@ static __always_inline struct hrtimer *clock_base_next_timer(struct hrtimer_cloc
 {
 	struct timerqueue_linked_node *next = timerqueue_linked_first(&base->active);
 
-	return container_of(next, struct hrtimer, node);
+	return hrtimer_from_timerqueue_node(next);
 }
 
 /* Find the base with the earliest expiry */
@@ -1960,7 +1962,7 @@ static __always_inline struct hrtimer *clock_base_next_timer_safe(struct hrtimer
 {
 	struct timerqueue_linked_node *next = timerqueue_linked_first(&base->active);
 
-	return next ? container_of(next, struct hrtimer, node) : NULL;
+	return next ? hrtimer_from_timerqueue_node(next) : NULL;
 }
 
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
@@ -2438,7 +2440,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	struct hrtimer *timer;
 
 	while ((node = timerqueue_linked_first(&old_base->active))) {
-		timer = container_of(node, struct hrtimer, node);
+		timer = hrtimer_from_timerqueue_node(node);
 		BUG_ON(hrtimer_callback_running(timer));
 		debug_hrtimer_deactivate(timer);
 

-- 
2.53.0

