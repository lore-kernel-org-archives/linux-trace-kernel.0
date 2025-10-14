Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B4219E8;
	Tue, 14 Oct 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421129; cv=none; b=jftfdqHA1JZoRZrrCXzNl5BEQcA6YviJWBjXkoChUbCr8tGE3AscOUoKeqK/HFpbTx0gce2reFmI9Z1HKHj8bk+nIhNSz4a305eitVecggNdk6MKIvswDAKmnKvmi03ADWBa5rR/Rp1NCk+L4fLm6vwFrMEdvx/n72H/bL1mRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421129; c=relaxed/simple;
	bh=mtCBw7uiiiu4TzTbMBPlmv3xfNJk9wKTRa3d6EHb83M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg17P+71EPZ7CsfUDtzwWnPKVqMfk1XO6xCY2UTgj3IrqEmf0UPjjR9AVV76cvSjth936QhMKldRqlJLwMVB3H5D1lj5C45VmxmFBMVc8iHw4wzUhHrKSzM1btU47ByTu2COc6T0JmjqMWZwxMbTCXbSWIOYQgQY2aiUkrxfxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RRtC2P9B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkeORQ5q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RRtC2P9B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkeORQ5q"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760421125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc3TcaS/AFePFfhZTx3/fRdCh9jq5pr9JbqIIyJOGYk=;
	b=RRtC2P9BczjFc+mpCbqdSlLg9NW/eYeGqHYnSQWWXm4bELs1WfMAUxtLXj9hBvP9ioqZgc
	22BeOUbzjdAz0EuZgsRqLNR5t7TAlsRl/MsEnaWBmRbr27h+LGTUcuKXz0p7G27ciOvRx+
	0yV0GLezfxT1qKyuJbNhoTnscjUwZdcEJw9d3ZCk6IcOZYNxcZ6gGlQwlLHqUwzLFSlGwk
	tQTyd6sxcI6ItEzdPMszVlOdkOIMewEQOikE/T0RE1nrr92jnab1iF1Ey/pWr8+UhovXSo
	s04IFR88NdNE5yloodcXZVV76ktZFecLR/Mw//5NRW6zqNS7Pf3uZ3JGriDvrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760421125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc3TcaS/AFePFfhZTx3/fRdCh9jq5pr9JbqIIyJOGYk=;
	b=nkeORQ5qOF6+1uD5RHhJvwKdNRV2dDvo+xpqdeUAcV6XMHSvKgKRr64RSOUL7h63N3uATG
	4eB4vdu7qfemyeDQ==
Date: Tue, 14 Oct 2025 07:51:56 +0200
Subject: [PATCH 1/3] rv: Pass va_list to reactors
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
In-Reply-To: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760421123; l=8199;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mtCBw7uiiiu4TzTbMBPlmv3xfNJk9wKTRa3d6EHb83M=;
 b=WScipd13e3p8l3rdQULxDqF2flFe978EkWg5RxPHuuxOUa+bFmR+8mhQOHtsPVog3gQWwyR39
 g3t1CVY4Z7qBjq8mh86TaDpB/VHWzVEoNGdta9JY4hdjuv4d774GRfH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The only thing the reactors can do with the passed in varargs is to
convert it into a va_list. Do that in a central helper instead.
It simplifies the reactors, removes some hairy macro-generated code
and introduces a convenient hook point to modify reactor behavior.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/rv.h               | 11 +++++++++--
 include/rv/da_monitor.h          | 35 ++++++++++-------------------------
 include/rv/ltl_monitor.h         | 18 +++++-------------
 kernel/trace/rv/reactor_panic.c  |  6 +-----
 kernel/trace/rv/reactor_printk.c |  6 +-----
 kernel/trace/rv/rv_reactors.c    | 16 +++++++++++++++-
 6 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 9520aab34bcbe36c730bc6ab20bed71c8eee52bf..b567b0191e67f7dfab74e2aad6de3ed63d94058d 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -88,7 +88,7 @@ union rv_task_monitor {
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
-	__printf(1, 2) void	(*react)(const char *msg, ...);
+	__printf(1, 0) void	(*react)(const char *msg, va_list args);
 	struct list_head	list;
 };
 #endif
@@ -102,7 +102,7 @@ struct rv_monitor {
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor	*reactor;
-	__printf(1, 2) void	(*react)(const char *msg, ...);
+	__printf(1, 0) void	(*react)(const char *msg, va_list args);
 #endif
 	struct list_head	list;
 	struct rv_monitor	*parent;
@@ -119,11 +119,18 @@ void rv_put_task_monitor_slot(int slot);
 bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
+__printf(2, 3)
+void rv_react(struct rv_monitor *monitor, const char *msg, ...);
 #else
 static inline bool rv_reacting_on(void)
 {
 	return false;
 }
+
+__printf(2, 3)
+static inline void rv_react(struct rv_monitor *monitor, const char *msg, ...)
+{
+}
 #endif /* CONFIG_RV_REACTORS */
 
 #endif /* CONFIG_RV */
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 17fa4f6e5ea63fad29fd4349c54720944a179e38..0cef64366538c90dab8f76fbf5d2aaacdd61e2e7 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,34 +16,19 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_RV_REACTORS
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static void cond_react_##name(type curr_state, type event)					\
-{												\
-	if (!rv_reacting_on() || !rv_##name.react)						\
-		return;										\
-	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",			\
-			#name,									\
-			model_get_event_name_##name(event),					\
-			model_get_state_name_##name(curr_state));				\
-}
-
-#else /* CONFIG_RV_REACTOR */
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static void cond_react_##name(type curr_state, type event)					\
-{												\
-	return;											\
-}
-#endif
-
 /*
  * Generic helpers for all types of deterministic automata monitors.
  */
 #define DECLARE_DA_MON_GENERIC_HELPERS(name, type)						\
 												\
-DECLARE_RV_REACTING_HELPERS(name, type)								\
+static void react_##name(type curr_state, type event)						\
+{												\
+	rv_react(&rv_##name,									\
+		 "rv: monitor %s does not allow event %s on state %s\n",			\
+		 #name,										\
+		 model_get_event_name_##name(event),						\
+		 model_get_state_name_##name(curr_state));					\
+}												\
 												\
 /*												\
  * da_monitor_reset_##name - reset a monitor and setting it to init state			\
@@ -126,7 +111,7 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
 		next_state = model_get_next_state_##name(curr_state, event);			\
 		if (next_state == INVALID_STATE) {						\
-			cond_react_##name(curr_state, event);					\
+			react_##name(curr_state, event);					\
 			trace_error_##name(model_get_state_name_##name(curr_state),		\
 					   model_get_event_name_##name(event));			\
 			return false;								\
@@ -165,7 +150,7 @@ static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
 		next_state = model_get_next_state_##name(curr_state, event);			\
 		if (next_state == INVALID_STATE) {						\
-			cond_react_##name(curr_state, event);					\
+			react_##name(curr_state, event);					\
 			trace_error_##name(tsk->pid,						\
 					   model_get_state_name_##name(curr_state),		\
 					   model_get_event_name_##name(event));			\
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 5368cf5fd623e74a5739d2e0b3fc2c27c4bad597..00c42b36f961a00ee473aa58f14b015308523eb0 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -16,21 +16,12 @@
 #error "Please include $(MODEL_NAME).h generated by rvgen"
 #endif
 
-#ifdef CONFIG_RV_REACTORS
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
-static struct rv_monitor RV_MONITOR_NAME;
 
-static void rv_cond_react(struct task_struct *task)
-{
-	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
-		return;
-	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
-			      task->comm, task->pid);
-}
+#ifdef CONFIG_RV_REACTORS
+static struct rv_monitor RV_MONITOR_NAME;
 #else
-static void rv_cond_react(struct task_struct *task)
-{
-}
+extern struct rv_monitor RV_MONITOR_NAME;
 #endif
 
 static int ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
@@ -98,7 +89,8 @@ static void ltl_monitor_destroy(void)
 static void ltl_illegal_state(struct task_struct *task, struct ltl_monitor *mon)
 {
 	CONCATENATE(trace_error_, MONITOR_NAME)(task);
-	rv_cond_react(task);
+	rv_react(&RV_MONITOR_NAME, "rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
+		 task->comm, task->pid);
 }
 
 static void ltl_attempt_start(struct task_struct *task, struct ltl_monitor *mon)
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index 74c6bcc2c7494408770881dda2b0de885c5eb88c..76537b8a4343cbd0d715f60db3cc8868e71c1c0b 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,13 +13,9 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_panic_reaction(const char *msg, va_list args)
 {
-	va_list args;
-
-	va_start(args, msg);
 	vpanic(msg, args);
-	va_end(args);
 }
 
 static struct rv_reactor rv_panic = {
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 2dae2916c05fd17397195e37d9b42d24cea24b9c..48c934e315b31c14d3a5b4fa3ec334ef71f9e390 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -12,13 +12,9 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_printk_reaction(const char *msg, va_list args)
 {
-	va_list args;
-
-	va_start(args, msg);
 	vprintk_deferred(msg, args);
-	va_end(args);
 }
 
 static struct rv_reactor rv_printk = {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index d32859fec238371b5721e08cf6558f0805565f7b..cb1a5968055abb22439a066b4e25dad98f078389 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -438,7 +438,7 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 /*
  * Nop reactor register
  */
-__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_nop_reaction(const char *msg, va_list args)
 {
 }
 
@@ -477,3 +477,17 @@ int init_rv_reactors(struct dentry *root_dir)
 out_err:
 	return -ENOMEM;
 }
+
+void rv_react(struct rv_monitor *monitor, const char *msg, ...)
+{
+	va_list args;
+
+	if (!rv_reacting_on() || !monitor->react)
+		return;
+
+	va_start(args, msg);
+
+	monitor->react(msg, args);
+
+	va_end(args);
+}

-- 
2.51.0

