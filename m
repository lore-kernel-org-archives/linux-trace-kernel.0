Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799D347FEC;
	Fri, 19 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848358; cv=none; b=WdOHQqkIc3Luq/W9dsLhFFFSDHTX3T75NQ0+kJC4Xhq6bbGPE03uig43peMKIumPHRI5V1s3jCF8KHZfsPDWMxi/1mYTBwIrAIb5TfSeKLJjPgfQdCwV8iE2C4/7NnhupRSzMV3pFDcOqi52iLOIYWrS/IwEpxGvmtowllLFxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848358; c=relaxed/simple;
	bh=ZkGR3RFK4hvJYiauN/Qs1nA2eMQvTkSHTEv1AD32830=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byogmdPhhx6dNx9PVS4PmCzXYf3WA5R3NTZSZ0pCGUQMWL7gr+MibkOlXmIt8HGAcqFEbgUOWuSBFZNsIq6mXzpMCUOEBeIARcC9kDmXmw+/QUZ32CNs2qeDwgF/epK9EqkJbg9wGQ6QVGtRRQJ1Z0VywstYfi0chqSky5NBtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vio1T60M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d95vGU4V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vio1T60M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d95vGU4V"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLuQdn53pO1VED59D4ZX48Gyw19o5NbS1MrwLW8+ThE=;
	b=vio1T60MJrCjBtnnLZSpc4eRN9yniTpOwi+6B3hVKJAsNNRw9UiDvBF28qW85wd7X3swMN
	cHuGAl9E/gULQhQgmnTgxLO2ZXbMjeDP9TwXNpIXXbm36H7XR60N3eddn9XLM5ncpT5/6R
	xeW8EtWayF1uBoPZRgkJP3vLtGh/+HHnfDhQO4pdHr112XyXXNEZpoZtGD4AvQMcKDpIEd
	RFy7DFl5ODrXeQH7jGApI7954RMywXXRgLVbioqCxtXiGe/FnnESNDCtg9wQ8yzbTYfL6D
	XW52zJDbqSWi8GwC/ITeyo8hRqCX/l7ymj1WqTgvZb8QLIfuHsEwsRSIQntx1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLuQdn53pO1VED59D4ZX48Gyw19o5NbS1MrwLW8+ThE=;
	b=d95vGU4VT7EOFAwQWvtNBk6fgPvgx2FRYAOxaQTEq0GhC9QUXZbpaCJTcKyz4Yncv0t9yF
	iBsIUiNuvsOo2pDw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 07/13] rv: Simplify hybrid automata monitors's clock variables
Date: Fri, 19 Jun 2026 07:52:10 +0200
Message-ID: <c0f600dcbf3d8b487c944406851a39146f4d91fa.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hybrid automata monitors's clock variables have two different
representations:

  - The invariant representation, which is the timestamp when the invariant
    expires

  - The guard representation, which is the timestamp when the clock is last
    reset

This dual representation makes the logic quite difficult to follow (well,
at least for me). It also complicates the monitors and the generation tool,
as it requires conversion back and forth between the representation.

Simplify by using the clock variables for a single purpose: storing the
time stamp since the clock is last reset.

This also allows simplifying rvgen, which will be done in a follow-up
commit.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/rv/ha_monitor.h                  | 64 ++++++------------------
 kernel/trace/rv/monitors/nomiss/nomiss.c | 18 +------
 kernel/trace/rv/monitors/stall/stall.c   |  2 +-
 3 files changed, 19 insertions(+), 65 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 28d3c74cabfc..9144b4c06f3f 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -327,19 +327,8 @@ static inline void __ha_monitor_timer_callback(struct =
ha_monitor *ha_mon)
 }
=20
 /*
- * The clock variables have 2 different representations in the env_store:
- * - The guard representation is the timestamp of the last reset
- * - The invariant representation is the timestamp when the invariant expi=
res
- * As the representations are incompatible, care must be taken when switch=
ing
- * between them: the invariant representation can only be used when starti=
ng a
- * timer when the previous representation was guard (e.g. no other invaria=
nt
- * started since the last reset operation).
- * Likewise, switching from invariant to guard representation without a re=
set
- * can be done only by subtracting the exact value used to start the invar=
iant.
- *
- * Reading the environment variable (ha_get_clk) also reflects this differ=
ence
- * any reads in states that have an invariant return the (possibly negativ=
e)
- * time since expiration, other reads return the time since last reset.
+ * The clock variables store the time epoch - the timestamp when the clock=
 was last reset.
+ * They are read by subtracting the time epoch from the current time.
  */
=20
 /*
@@ -353,31 +342,21 @@ static inline void ha_reset_clk_ns(struct ha_monitor =
*ha_mon, enum envs env, u64
 {
 	WRITE_ONCE(ha_mon->env_store[env], time_ns);
 }
-static inline void ha_set_invariant_ns(struct ha_monitor *ha_mon, enum env=
s env,
-				       u64 value, u64 time_ns)
-{
-	WRITE_ONCE(ha_mon->env_store[env], time_ns + value);
-}
-static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
-					 enum envs env, u64 time_ns)
+static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum e=
nvs env,
+					 u64 time_ns, u64 expire_ns)
 {
-	return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns;
+	return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
 }
 /*
  * ha_invariant_passed_ns - prepare the invariant and return the time sinc=
e reset
  */
-static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum e=
nvs env,
-				   u64 expire, u64 time_ns)
+static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum e=
nvs env, u64 time_ns)
 {
-	u64 passed =3D 0;
-
 	if (env < 0 || env >=3D ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
 		return 0;
-	passed =3D ha_get_env(ha_mon, env, time_ns);
-	ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
-	return passed;
+	return ha_get_env(ha_mon, env, time_ns);
 }
=20
 /*
@@ -391,32 +370,21 @@ static inline void ha_reset_clk_jiffy(struct ha_monit=
or *ha_mon, enum envs env)
 {
 	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64());
 }
-static inline void ha_set_invariant_jiffy(struct ha_monitor *ha_mon,
-					  enum envs env, u64 value)
+static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, enu=
m envs env,
+					    u64 time_ns, u64 expire_jiffy)
 {
-	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64() + value);
-}
-static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
-					    enum envs env, u64 time_ns)
-{
-	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64());
-
+	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64() -=
 expire_jiffy);
 }
 /*
  * ha_invariant_passed_jiffy - prepare the invariant and return the time s=
ince reset
  */
-static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enu=
m envs env,
-				      u64 expire, u64 time_ns)
+static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enu=
m envs env, u64 time_ns)
 {
-	u64 passed =3D 0;
-
 	if (env < 0 || env >=3D ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
 		return 0;
-	passed =3D ha_get_env(ha_mon, env, time_ns);
-	ha_set_invariant_jiffy(ha_mon, env, expire - passed);
-	return passed;
+	return ha_get_env(ha_mon, env, time_ns);
 }
=20
 /*
@@ -463,14 +431,14 @@ static inline void ha_setup_timer(struct ha_monitor *=
ha_mon)
 static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum en=
vs env,
 					u64 expire, u64 time_ns)
 {
-	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, expire, time_ns);
+	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
=20
 	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
 }
 static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs =
env,
 				     u64 expire, u64 time_ns)
 {
-	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
+	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
=20
 	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
 			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
@@ -516,7 +484,7 @@ static inline void ha_start_timer_ns(struct ha_monitor =
*ha_mon, enum envs env,
 				     u64 expire, u64 time_ns)
 {
 	int mode =3D HRTIMER_MODE_REL_HARD;
-	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
+	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
=20
 	if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
 		mode |=3D HRTIMER_MODE_PINNED;
@@ -525,7 +493,7 @@ static inline void ha_start_timer_ns(struct ha_monitor =
*ha_mon, enum envs env,
 static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum en=
vs env,
 					u64 expire, u64 time_ns)
 {
-	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, expire, time_ns);
+	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
=20
 	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
 			  jiffies_to_nsecs(expire - passed), time_ns);
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/mon=
itors/nomiss/nomiss.c
index 8ead8783c29f..515ece5ce0ca 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -57,24 +57,12 @@ static inline bool ha_verify_invariants(struct ha_monit=
or *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state =3D=3D ready_nomiss)
-		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns, DEADLINE_NS(ha=
_mon));
 	else if (curr_state =3D=3D running_nomiss)
-		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
+		return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns, DEADLINE_NS(ha=
_mon));
 	return true;
 }
=20
-static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
-					enum states curr_state, enum events event,
-					enum states next_state, u64 time_ns)
-{
-	if (curr_state =3D=3D next_state)
-		return;
-	if (curr_state =3D=3D ready_nomiss)
-		ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
-	else if (curr_state =3D=3D running_nomiss)
-		ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon), time_ns);
-}
-
 static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 				    enum states curr_state, enum events event,
 				    enum states next_state, u64 time_ns)
@@ -122,8 +110,6 @@ static bool ha_verify_constraint(struct ha_monitor *ha_=
mon,
 	if (!ha_verify_invariants(ha_mon, curr_state, event, next_state, time_ns))
 		return false;
=20
-	ha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);
-
 	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
 		return false;
=20
diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monit=
ors/stall/stall.c
index 3c38fb1a0159..b265578f845c 100644
--- a/kernel/trace/rv/monitors/stall/stall.c
+++ b/kernel/trace/rv/monitors/stall/stall.c
@@ -38,7 +38,7 @@ static inline bool ha_verify_invariants(struct ha_monitor=
 *ha_mon,
 					enum states next_state, u64 time_ns)
 {
 	if (curr_state =3D=3D enqueued_stall)
-		return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns);
+		return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns, threshold_ji=
ffies);
 	return true;
 }
=20
--=20
2.47.3

