Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD1513569
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686178; cv=none; b=lEQ43GJCU+V9hYauAosQMLBhdCLf2dhfYJnWuejRYEGrZdXIRvkIZ0CP+sb38wAQrk0IeD/9720fabjNm8BjQT4hmT5IH4rm0BhVoXYusSYFpyFZi7Bsd8Wd+NOyTEk4MEi7AjWcvwteU2wO5wKzHhEwr+qR5/njfAUBNbGQ3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686178; c=relaxed/simple;
	bh=h1vntD0dUm5YFZVRDlORAyrgjaEwR2iXEp/QOFZOhrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TS94v2JfbNoqp7u93cBfdu1ssDg+vWmudMRrY7vEeKNsxZS70zYg4n5QMImGXpOsrAzV9eESNCyjWzkX/yK6mwRadtsJaVtybceF3qadQKjcO1tJb0pclUJ7cK6JbnNDVePy52rql15gCoyMPC2e80Moopb2sgWxKnNyR7MkMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eh5gMQRA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh5gMQRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFzUvFk/DbwXgA3IS3H0RYPvtLbNIXbGn1aNWF/jVOY=;
	b=Eh5gMQRA8VhXPSQcyHSt6rnt/iMQ4To5LDRvZb32tExFDvdV4ME89qMmWEfH0enuvbSGWF
	ij8wJmcXLFdsTq/mnXeKIbErEbDCc4BeWKkMr4tbX14qqXmsrPKQZ1WWehvqu1+jO0m/qL
	7u4mZLxoFRpxnBuPT6uO6+PtVKbOKcU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-tQ2OtxXHO-idFyVF_kjgfQ-1; Tue,
 29 Sep 2026 08:49:31 -0400
X-MC-Unique: tQ2OtxXHO-idFyVF_kjgfQ-1
X-Mimecast-MFC-AGG-ID: tQ2OtxXHO-idFyVF_kjgfQ_1790686170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E3D0195DE3F;
	Tue, 29 Sep 2026 12:49:30 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 363AF19560AB;
	Tue, 29 Sep 2026 12:49:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 03/10] rv: Cache timer budget when starting HA timers
Date: Tue, 29 Sep 2026 14:49:01 +0200
Message-ID: <20260929124908.177676-4-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: BAgjQjH8keQ1Cj8x9TorjI3kho9QrReYZH2MfZCy0iE_1790686170
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit ab2900ae252b ("rv: Simplify hybrid automata monitors's clock
variables") simplified storage but introduces the assumption that the
expires value passed to ha_check_invariant() is the same used to arm the
timer, this may not always be true.
The invariant needs to act on a constant value and that needs to be
retrievable somewhere.

Cache the armed budget to ensure invariant checks remain consistent with
the timer's duration. For the timer wheel, add an expire field to the
ha_monitor union, this allows to store ns-granularity values if needed.
For hrtimers, use hrtimer_get_expires() to retrieve the internal
absolute expiration time.

The expire field is used also for jiffy granularity clock to avoid
accessing private fields and hrtimers always use a ns base to avoid
inconsistencies with the jiffies.

Also remove the now superfluous ha_inv_to_guard().

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h                            |  5 +-
 include/rv/ha_monitor.h                       | 53 ++++++++++---------
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +-
 kernel/trace/rv/monitors/stall/stall.c        |  2 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  4 +-
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c  |  4 +-
 .../rvgen/tests/golden/test_ha/test_ha.c      |  4 +-
 .../golden/test_ha_kunit/test_ha_kunit.c      |  4 +-
 8 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..723cc62d11d8 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -109,7 +109,10 @@ struct ha_monitor {
 	u64 env_store[MAX_HA_ENV_LEN];
 	union {
 		struct hrtimer hrtimer;
-		struct timer_list timer;
+		struct {
+			struct timer_list timer;
+			u64 expire;
+		};
 	};
 };
 
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 87cf91abdf67..332671f3ce2c 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -129,9 +129,10 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
  * ktime_get_ns is expensive, since we usually don't require precise accounting
  * of changes within the same event, cache the current time at the beginning of
  * the constraint handler and use the cache for subsequent calls.
- * Monitors without ns clocks automatically skip this.
+ * Monitors without ns clocks automatically skip this, unless they use
+ * hrtimers, which require a ns base.
  */
-#ifdef HA_CLK_NS
+#if defined(HA_CLK_NS) || HA_TIMER_TYPE == HA_TIMER_HRTIMER
 #define ha_get_ns() ktime_get_ns()
 #else
 #define ha_get_ns() 0
@@ -341,9 +342,13 @@ static inline void ha_reset_clk_ns(struct ha_monitor *ha_mon, enum envs env, u64
 	WRITE_ONCE(ha_mon->env_store[env], time_ns);
 }
 static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum envs env,
-					 u64 time_ns, u64 expire_ns)
+					 u64 time_ns)
 {
-	return READ_ONCE(ha_mon->env_store[env]) >= time_ns - expire_ns;
+	if (HA_TIMER_TYPE == HA_TIMER_WHEEL)
+		return time_ns - READ_ONCE(ha_mon->env_store[env]) <= ha_mon->expire;
+	if (HA_TIMER_TYPE == HA_TIMER_HRTIMER)
+		return time_ns <= ktime_to_ns(hrtimer_get_expires(&ha_mon->hrtimer));
+	return true;
 }
 /*
  * ha_invariant_passed_ns - prepare the invariant and return the time since reset
@@ -367,9 +372,14 @@ static inline void ha_reset_clk_jiffy(struct ha_monitor *ha_mon, enum envs env)
 	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64());
 }
 static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, enum envs env,
-					    u64 time_ns, u64 expire_jiffy)
+					    u64 time_ns)
 {
-	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64() - expire_jiffy);
+	if (HA_TIMER_TYPE == HA_TIMER_WHEEL)
+		return time_after64(READ_ONCE(ha_mon->env_store[env]) + ha_mon->expire,
+				    get_jiffies_64());
+	if (HA_TIMER_TYPE == HA_TIMER_HRTIMER)
+		return time_ns <= ktime_to_ns(hrtimer_get_expires(&ha_mon->hrtimer));
+	return true;
 }
 /*
  * ha_invariant_passed_jiffy - prepare the invariant and return the time since reset
@@ -381,23 +391,6 @@ static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enum envs
 	return ha_get_env(ha_mon, env, time_ns);
 }
 
-/*
- * Retrieve the last reset time (guard representation) from the invariant
- * representation (expiration).
- * It the caller's responsibility to make sure the storage was actually in the
- * invariant representation (e.g. the current state has an invariant).
- * The provided value must be the same used when starting the invariant.
- *
- * This function's access to the storage is NOT atomic, due to the rarity when
- * this is used. If a monitor allows writes concurrent to this, likely
- * other things are broken and need rethinking the model or additional locking.
- */
-static inline void ha_inv_to_guard(struct ha_monitor *ha_mon, enum envs env,
-				   u64 value, u64 time_ns)
-{
-	WRITE_ONCE(ha_mon->env_store[env], READ_ONCE(ha_mon->env_store[env]) - value);
-}
-
 #if HA_TIMER_TYPE == HA_TIMER_WHEEL
 /*
  * Helper functions to handle the monitor timer.
@@ -420,22 +413,30 @@ static inline void ha_setup_timer(struct ha_monitor *ha_mon)
 
 	if (RV_MON_TYPE == RV_MON_PER_CPU)
 		mode |= TIMER_PINNED;
+	ha_mon->expire = ENV_INVALID_VALUE;
 	timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
 }
+static inline void _ha_start_timer(struct ha_monitor *ha_mon, u64 expire,
+				   u64 time_ns)
+{
+	mod_timer(&ha_mon->timer, get_jiffies_64() + expire);
+}
 static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
 					u64 expire, u64 time_ns)
 {
 	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, time_ns);
 
-	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
+	ha_mon->expire = expire;
+	_ha_start_timer(ha_mon, expire - passed, time_ns);
 }
 static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
 				     u64 expire, u64 time_ns)
 {
 	u64 passed = ha_invariant_passed_ns(ha_mon, env, time_ns);
 
-	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
-			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
+	ha_mon->expire = expire;
+	_ha_start_timer(ha_mon, nsecs_to_jiffies(expire - passed + TICK_NSEC - 1),
+			      time_ns);
 }
 /*
  * ha_cancel_timer - Cancel the timer
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 6e47d379f777..5e72df87b23a 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -57,9 +57,9 @@ static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state == ready_nomiss)
-		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns, DEADLINE_NS(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
 	else if (curr_state == running_nomiss)
-		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns, DEADLINE_NS(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
 	return true;
 }
 
diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monitors/stall/stall.c
index b265578f845c..3c38fb1a0159 100644
--- a/kernel/trace/rv/monitors/stall/stall.c
+++ b/kernel/trace/rv/monitors/stall/stall.c
@@ -38,7 +38,7 @@ static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state == enqueued_stall)
-		return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns, threshold_jiffies);
+		return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns);
 	return true;
 }
 
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 0b4e19ad9bd5..c8109f3602a6 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -248,9 +248,7 @@ class ha2k(dot2k):
         if inv.unit == "j":
             clock_type = "jiffy"
 
-        value = self.__adjust_value(inv.val, inv.unit)
-
-        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_{self.name}, time_ns, {value})"
+        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_{self.name}, time_ns)"
 
     def __parse_invariant(self, inv):
         # by default assume the timer has ns expiration
diff --git a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
index 7357e182e487..5aa7e64467f5 100644
--- a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
+++ b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
@@ -87,9 +87,9 @@ static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state == S0_ha_percpu)
-		return ha_check_invariant_ns(ha_mon, clk_ha_percpu, time_ns, bar_ns(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_ha_percpu, time_ns);
 	else if (curr_state == S2_ha_percpu)
-		return ha_check_invariant_ns(ha_mon, clk_ha_percpu, time_ns, BAR_NS(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_ha_percpu, time_ns);
 	return true;
 }
 
diff --git a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
index a2bd1eb93b03..3852337dc675 100644
--- a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
+++ b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
@@ -87,9 +87,9 @@ static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state == S0_test_ha)
-		return ha_check_invariant_ns(ha_mon, clk_test_ha, time_ns, bar_ns(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_test_ha, time_ns);
 	else if (curr_state == S2_test_ha)
-		return ha_check_invariant_ns(ha_mon, clk_test_ha, time_ns, BAR_NS(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_test_ha, time_ns);
 	return true;
 }
 
diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
index 61446e7f32c4..1fd524f95c07 100644
--- a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
+++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
@@ -87,9 +87,9 @@ static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state == S0_test_ha_kunit)
-		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns, bar_ns(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns);
 	else if (curr_state == S2_test_ha_kunit)
-		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns, BAR_NS(ha_mon));
+		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns);
 	return true;
 }
 
-- 
2.55.0

