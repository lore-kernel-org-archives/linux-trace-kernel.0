Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C473DC4C9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328354; cv=none; b=YU7VQcI09bdsNNXUGpqef2Otr85WkrhWCEyJw3coZd3wZac2HEOR0b7ajBvE7Y602txSLpjyc7/X20WieKpT/gDKOIWAV/1o+F9ZjuwQCdwJRXDxq8/Gx58mOI4xGe173S0r7ZN1nBH1XviM40dZQnZ0AqFDKdt6UA0Ax6nVj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328354; c=relaxed/simple;
	bh=ILYQxoYncXSHvrIje0mVV0SNGbPlgaCUb0twdOMzYmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rmv7M8srVtCKtmUJo+D55rm/1pitYShhhe1KEetLz9VQolbLEAiX2Aaz9I38pjPNafcqisfNx4yJ/7PWpA1z8PHYzKF3g7qQBEiE4DL40cpCLSpV6wAWVOOu5mq+9g5mQy04sYB4LLp7Hlb60T6TD/SA5MtxVAD8F9HZ7LuUh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGbK/Nyn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGbK/Nyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGM4KiSQXSjNQvu4sU9x9xm/FLK19+v8c0rWHk9XwsY=;
	b=aGbK/Nyn4l3Ou/bIGwwjsFttyyIfP7PJvanXwcDVp4QpCaRVyY2v7dLgCo0kC1nU+49MC9
	V916grkbwWanCuIW5/L5grsFLpOJqxZ801FD+avEA/RTbnc6s7yoBjGBfRVfynCkkuaUV6
	LRCTXxs7fj7pq0aeIEH+WbgUBEJYS/I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-GyDohIjQOnuuzF1wTKhdZA-1; Mon,
 01 Jun 2026 11:39:09 -0400
X-MC-Unique: GyDohIjQOnuuzF1wTKhdZA-1
X-Mimecast-MFC-AGG-ID: GyDohIjQOnuuzF1wTKhdZA_1780328347
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7D4C19560AD;
	Mon,  1 Jun 2026 15:39:06 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E70BC18004A3;
	Mon,  1 Jun 2026 15:39:04 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 06/13] rv: Do not rely on clean monitor when initialising HA
Date: Mon,  1 Jun 2026 17:38:33 +0200
Message-ID: <20260601153840.124372-7-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Taa5b68IcSUS6_ih7-pzH2kGm5PX99hW_BgErOrSi4A_1780328347
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hybrid Automata monitors hook into the DA implementation when doing
da_monitor_reset(). This function is called both on initialisation and
teardown, HA monitors try to cancel a timer only when it's initialised
relying on the da_mon->monitoring flag. This flag could however be
corrupted during initialisation. This happens for instance on per-task
monitors that share the same storage with different type of monitors
like LTL or in case of races during a previous teardown.

Stop relying on the monitoring flag during initialisation, assume that
can have any value, so use a separate da_reset_state() skiping timer
cancellation.
New monitors (e.g. new tasks) are always zero-initialised so it is safe
to rely on the monitoring flag for those.

Reported-by: Wen Yang <wen.yang@linux.dev>
Closes: https://lore.kernel.org/lkml/d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev
Suggested-by: Nam Cao <namcao@linutronix.de>
Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 91 +++++++++++++++++++++++++++++++++--------
 include/rv/ha_monitor.h |  2 +-
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 60dc39f26..ec9bc88bd 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -76,14 +76,22 @@ static void react(enum states curr_state, enum events event)
 		 model_get_state_name(curr_state));
 }
 
+/*
+ * da_monitor_reset_state - reset a monitor and setting it to init state
+ */
+static inline void da_monitor_reset_state(struct da_monitor *da_mon)
+{
+	WRITE_ONCE(da_mon->monitoring, 0);
+	da_mon->curr_state = model_get_initial_state();
+}
+
 /*
  * da_monitor_reset - reset a monitor and setting it to init state
  */
 static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
 	da_monitor_reset_hook(da_mon);
-	WRITE_ONCE(da_mon->monitoring, 0);
-	da_mon->curr_state = model_get_initial_state();
+	da_monitor_reset_state(da_mon);
 }
 
 /*
@@ -158,12 +166,28 @@ static struct da_monitor *da_get_monitor(void)
 	return &DA_MON_NAME;
 }
 
+/*
+ * __da_monitor_reset_all - reset the single monitor
+ */
+static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
+{
+	reset(da_get_monitor());
+}
+
 /*
  * da_monitor_reset_all - reset the single monitor
  */
 static void da_monitor_reset_all(void)
 {
-	da_monitor_reset(da_get_monitor());
+	__da_monitor_reset_all(da_monitor_reset);
+}
+
+/*
+ * da_monitor_reset_state_all - reset the single monitor
+ */
+static inline void da_monitor_reset_state_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset_state);
 }
 
 /*
@@ -171,7 +195,7 @@ static void da_monitor_reset_all(void)
  */
 static inline int da_monitor_init(void)
 {
-	da_monitor_reset_all();
+	da_monitor_reset_state_all();
 	return 0;
 }
 
@@ -202,25 +226,41 @@ static struct da_monitor *da_get_monitor(void)
 }
 
 /*
- * da_monitor_reset_all - reset all CPUs' monitor
+ * __da_monitor_reset_all - reset all CPUs' monitor
  */
-static void da_monitor_reset_all(void)
+static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
 {
 	struct da_monitor *da_mon;
 	int cpu;
 
 	for_each_cpu(cpu, cpu_online_mask) {
 		da_mon = per_cpu_ptr(&DA_MON_NAME, cpu);
-		da_monitor_reset(da_mon);
+		reset(da_mon);
 	}
 }
 
+/*
+ * da_monitor_reset_all - reset all CPUs' monitor
+ */
+static void da_monitor_reset_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset);
+}
+
+/*
+ * da_monitor_reset_state_all - reset all CPUs' monitor
+ */
+static inline void da_monitor_reset_state_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset_state);
+}
+
 /*
  * da_monitor_init - initialize all CPUs' monitor
  */
 static inline int da_monitor_init(void)
 {
-	da_monitor_reset_all();
+	da_monitor_reset_state_all();
 	return 0;
 }
 
@@ -269,19 +309,29 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
 	return da_get_target(da_mon)->pid;
 }
 
-static void da_monitor_reset_all(void)
+static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
 {
 	struct task_struct *g, *p;
 	int cpu;
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p)
-		da_monitor_reset(da_get_monitor(p));
+		reset(da_get_monitor(p));
 	for_each_present_cpu(cpu)
-		da_monitor_reset(da_get_monitor(idle_task(cpu)));
+		reset(da_get_monitor(idle_task(cpu)));
 	read_unlock(&tasklist_lock);
 }
 
+static void da_monitor_reset_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset);
+}
+
+static inline void da_monitor_reset_state_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset_state);
+}
+
 /*
  * da_monitor_init - initialize the per-task monitor
  *
@@ -298,7 +348,7 @@ static int da_monitor_init(void)
 
 	task_mon_slot = slot;
 
-	da_monitor_reset_all();
+	da_monitor_reset_state_all();
 	return 0;
 }
 
@@ -490,15 +540,24 @@ static inline void da_destroy_storage(da_id_type id)
 	kfree_rcu(mon_storage, rcu);
 }
 
-static void da_monitor_reset_all(void)
+static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
 {
 	struct da_monitor_storage *mon_storage;
 	int bkt;
 
-	rcu_read_lock();
+	guard(rcu)();
 	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
-		da_monitor_reset(&mon_storage->rv.da_mon);
-	rcu_read_unlock();
+		reset(&mon_storage->rv.da_mon);
+}
+
+static void da_monitor_reset_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset);
+}
+
+static inline void da_monitor_reset_state_all(void)
+{
+	__da_monitor_reset_all(da_monitor_reset_state);
 }
 
 static inline int da_monitor_init(void)
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index d59507e8c..bd8705556 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -153,12 +153,12 @@ static inline void ha_monitor_init_env(struct da_monitor *da_mon)
  * Called from a hook in the DA reset functions, it supplies the da_mon
  * corresponding to the current ha_mon.
  * Not all hybrid automata require the timer, still clear it for simplicity.
+ * Monitors that never started have their timer uninitialized, do not stop those.
  */
 static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
 {
 	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
 
-	/* Initialisation resets the monitor before initialising the timer */
 	if (likely(da_monitoring(da_mon)))
 		ha_cancel_timer(ha_mon);
 }
-- 
2.54.0

