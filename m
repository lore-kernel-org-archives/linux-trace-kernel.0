Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A33D1CA1;
	Tue,  5 May 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964391; cv=none; b=L4jAf09HuQyj2yC4D+cRkhcfcbARCC8p4SPOP/IyTSNj4E9KoXnzmgJit9Eo2YrAZOIS3eV8LY3JnV2xqxXy+9zLzJEZhNbqLVk0SbxfqkpGbUdjTH8rlO3j4YbXlifs02VXNNJVT0iKa2t2WX03B93t9XDIfiam+Q3wBt1Ku5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964391; c=relaxed/simple;
	bh=JaRoNxBEjNCi23j5JtUMZhFqJMQmn3DMDLRsSwAqaZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzXR+9K7W7HN/EK/i9n9glsoLsE0+Q1VDR2/BISWZEOcYa8aEAvIsOXBfjQG4vwYbM+sILEBPnSZ+HM5KIYkcHVZbjf/9Qjen15Y0fUFle5YCtGkm/kgjFTudvYQecZh2AqLHzTpH8LugHvY3Ii8nSmXoY3GvTrzJ3a1oy9gqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owRB2pbE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Cv7zj+a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owRB2pbE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Cv7zj+a"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySQh632ogP8KARcLB6KPSQVzUCu17DlOdwaSQGNKIbk=;
	b=owRB2pbEUsHBz7ZwiiR1Zj/j/sl4XZeldl1JZlw3kvuKosvTaVwwBmWjTjmLvMnu4mWtGY
	r6XoFruxVndC3M5P3qGSlW2BAFipvM8aiLko/dMVZlLwif69uxFqU65G3LQP7+uicsOm0Y
	ng+NNdGPchemT8j4ZVwljqJUvjbyCnbIbxl67J4pci3FoF15V96gPLboFYILTzUi3zQr4L
	YKQ1s2bQdL/E+hFx4xDaHOtYAatzyMu6aPIgAO1250YRpH7SCyxDvuIqeyOmcQffCy9FmC
	RHwcNbOoaf4k0PbAl2orY9W8wSqTR5Qk7VKJSsbGFVNu9mANFchXvDzl2HuTxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySQh632ogP8KARcLB6KPSQVzUCu17DlOdwaSQGNKIbk=;
	b=3Cv7zj+a4q/PawdZimxSMvfFA6zzEfZVaaEx8HFTA8HpR5FwIZTKxJW2LPALLHnPHrYv9h
	o4CjrOh1mONfgNCQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 07/13] rv: Simply hybrid automata monitors's clock variables
Date: Tue,  5 May 2026 08:59:28 +0200
Message-ID: <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/rv/ha_monitor.h                  | 60 ++++++------------------
 kernel/trace/rv/monitors/nomiss/nomiss.c | 18 +------
 kernel/trace/rv/monitors/stall/stall.c   |  2 +-
 3 files changed, 17 insertions(+), 63 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index d59507e8cb30..1ce3fd324d2c 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -253,19 +253,8 @@ static inline void __ha_monitor_timer_callback(struct =
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
@@ -279,31 +268,21 @@ static inline void ha_reset_clk_ns(struct ha_monitor =
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
+	return time_ns - READ_ONCE(ha_mon->env_store[env]) <=3D expire_ns;
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
@@ -317,32 +296,21 @@ static inline void ha_reset_clk_jiffy(struct ha_monit=
or *ha_mon, enum envs env)
 {
 	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64());
 }
-static inline void ha_set_invariant_jiffy(struct ha_monitor *ha_mon,
-					  enum envs env, u64 value)
-{
-	WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64() + value);
-}
-static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
-					    enum envs env, u64 time_ns)
+static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, enu=
m envs env,
+					    u64 time_ns, u64 expire_jiffy)
 {
-	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64());
-
+	return time_after64(READ_ONCE(ha_mon->env_store[env]) + expire_jiffy, get=
_jiffies_64());
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
@@ -389,14 +357,14 @@ static inline void ha_setup_timer(struct ha_monitor *=
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
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/mon=
itors/nomiss/nomiss.c
index 31f90f3638d8..6b3f93866d56 100644
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
index 9ccfda6b0e73..1aa65d7e690d 100644
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

