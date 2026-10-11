Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10012DCBEC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747596; cv=none; b=KEeMu4Xcpch8xBpn28UxxRM8Wh6Z8TzAbsZ3GSVOUgIkvSmITdGU2eqtL28DvL+hEElIEMh4O1YHh9OQF5xcDiOX0wo48/BPEWRQ3if0bdSGjIEjgHv1djGlWipwqyANrj6Ywfcvct0UHZ8JHHmcvc8QYG8V/xRLqmWWIaQUxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747596; c=relaxed/simple;
	bh=re4zxLJzck5XoBJwDsvFcZnnCV9vSiEHxm9sTlVIdWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsv4QPvDzcJ8jit0T6w0vd714lfk5b6BktD24baU+vUwjhWMxAqRsQLyG035iIs4dRGRzNNdcucTW7BIdndq2wQLD7Nk/QhUUJQIw0pOcIlXl4GpsOpSWsGXwWrFxk6HzKXAL2OmbuyN1W7mqXFCswY0AZuvHU0XysDrkNaTpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kV5rn1qg; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kV5rn1qg"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=re4zxLJzck5XoBJwDsvFcZnnCV9vSiEHxm9sTlVIdWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747592; v=1; x=1792352392;
 b=kV5rn1qg1T1qLW2zM5/BDKH9jOnuu47c+q/ZYSuHoCmoQLGnUMqUxVeFnSvz3suRkciCHeCJ
 ZIPtHclEh05EIoYgsIybS5aKjgvDqzLwFCfCccVs1KfAa+J2MTLyuJf0kyH2xwoTxWHocDFVPnh
 K61n+UB2nKwBDwJMKycX56RI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 42a38e666fdccb58;
	Sun, 11 Oct 2026 19:39:52 +0000
X-Mizu-Trace-ID: 42a38e666fdccb58
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 02/14] rv: Fix ha_monitor timer and invariant underflow
Date: Mon, 12 Oct 2026 03:39:08 +0800
Message-Id: <2ab5a814ce453e282c5d90b7285ee6fea8a674b6.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

ha_start_timer_ns() and ha_start_timer_jiffy() compute the remaining
budget as expire - passed.  Once the elapsed time passed exceeds the
budget expire (e.g. a state transition after the invariant should have
fired, before the timer callback ran), the unsigned subtraction
underflows to a huge value and the timer is scheduled far into the
future instead of expiring immediately.

ha_check_invariant_ns() computes store >= time_ns - expire_ns, which
underflows when the system uptime is still below expire_ns (a monitor
armed early in boot with a large budget), reporting a false violation.

Clamp the timer remainder to 0 (fire immediately) when passed >= expire,
and replace the invariant check as store + expire_ns >= time_ns so
neither side can underflow.

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Fixes: ab2900ae252b ("rv: Simplify hybrid automata monitors's clock variables")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 93ac99ff7f1d..499ce60779f9 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -351,7 +351,7 @@ static inline void ha_reset_clk_ns(struct ha_monitor *ha_mon, enum envs env, u64
 static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum envs env,
 					 u64 time_ns, u64 expire_ns)
 {
-	return READ_ONCE(ha_mon->env_store[env]) >= time_ns - expire_ns;
+	return READ_ONCE(ha_mon->env_store[env]) + expire_ns >= time_ns;
 }
 /*
  * ha_invariant_passed_ns - prepare the invariant and return the time since reset
@@ -410,6 +410,11 @@ static inline void ha_inv_to_guard(struct ha_monitor *ha_mon, enum envs env,
 	WRITE_ONCE(ha_mon->env_store[env], READ_ONCE(ha_mon->env_store[env]) - value);
 }
 
+static inline u64 ha_time_left(u64 passed, u64 expire)
+{
+	return passed < expire ? expire - passed : 0;
+}
+
 #if HA_TIMER_TYPE == HA_TIMER_WHEEL
 /*
  * Helper functions to handle the monitor timer.
@@ -439,15 +444,17 @@ static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env
 {
 	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, time_ns);
 
-	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
+	mod_timer(&ha_mon->timer,
+		  get_jiffies_64() + ha_time_left(passed, expire));
 }
 static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
 				     u64 expire, u64 time_ns)
 {
 	u64 passed = ha_invariant_passed_ns(ha_mon, env, time_ns);
+	u64 delay = ha_time_left(passed, expire);
 
 	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
-			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
+			     nsecs_to_jiffies(delay + TICK_NSEC - 1), time_ns);
 }
 /*
  * ha_cancel_timer - Cancel the timer
@@ -494,7 +501,8 @@ static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
 
 	if (RV_MON_TYPE == RV_MON_PER_CPU)
 		mode |= HRTIMER_MODE_PINNED;
-	hrtimer_start(&ha_mon->hrtimer, ns_to_ktime(expire - passed), mode);
+	hrtimer_start(&ha_mon->hrtimer,
+		      ns_to_ktime(ha_time_left(passed, expire)), mode);
 }
 static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
 					u64 expire, u64 time_ns)
@@ -502,7 +510,8 @@ static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env
 	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, time_ns);
 
 	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
-			  jiffies_to_nsecs(expire - passed), time_ns);
+			  jiffies_to_nsecs(ha_time_left(passed, expire)),
+			  time_ns);
 }
 /*
  * ha_cancel_timer - Cancel the timer
-- 
2.25.1

