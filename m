Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332F285409;
	Fri, 11 Apr 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357090; cv=none; b=meRSHrwnR4heaVK93Vvqg4uRk4n5aIt+idFubImzpXHGFRsbqwwEe1Zch6AZGnkLS5bbc2X3AyWTSLIlnGKV617D9nq1go5cEJ2ITHr2BNa7XBM5Ar36pnR3l3x4L4viuP9vTIHfiQWlfc3+dyN0MLZBuzGaQkrojqB10sWWvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357090; c=relaxed/simple;
	bh=Xot4b7y9dMyGdGh+ksqRQhszATP5JxZKi5njO+euHFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRjgs3su26xgylF6KgWphx0eej8HnLtofqA1UDIDGOIeml18xc5RvyJ4tvdMvyXklpCNyPuldxsW41UeYoqhTgxz8WC3v/ctBsul4oXzY0VUoIcpOyo/1WK/dueXzfK7EdBjMzj/VK5Sw5Uh2V0D5qsHN9YpHsWxElvn0VN312w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IVX3f98m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCAAPwRp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IVX3f98m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCAAPwRp"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ybyzZafGIWfAqMirTczLUCoz9PienLCmxRVeLV55XU=;
	b=IVX3f98mzrAK9qO+I5N8Jsh+hVBvQACHgQ9icxjhCSmcj+D3QuMAOyMo8XukhtbUbZj843
	94OGrkqZH/c1WWeIoyqEZK8WLzBcmkNWdVbBvNyy9vT2+ZHM1cMMSEn7uWTDBLuz03tG7F
	GT6eEaqADBgL4MligMqYZb5wm6IAkol9Qqxv3AMLQ870MeVfcUoYc2/6hev1dOjICrrMaz
	S9UearO1u2WOidkueTZLiXaFf6UM8zNq4UjU82WVYvwouYJcilWtvOocFzAAXD+1GGLzzQ
	iABi7iylGLbkd17SUV3e1t4dKJ4AwILB03uORM+rPGL9sYtAWeIJEq5p1IMOxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ybyzZafGIWfAqMirTczLUCoz9PienLCmxRVeLV55XU=;
	b=FCAAPwRpXT32lL5RGkh4OrGcoUUDGBhm3xMkFYHeBCBNSM+hiwy7PshBjV+cU4kZJHM78s
	+8wki1Pe13oHMEDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 03/22] rv: Let the reactors take care of buffers
Date: Fri, 11 Apr 2025 09:37:19 +0200
Message-Id: <fb397e38b56f3eab7b7f662fef4860ee4fbda873.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each RV monitor has one static buffer to send to the reactors. If multiple
errors are detected simultaneously, the one buffer could be overwritten.

Instead, leave it to the reactors to handle buffering.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/panic.h            |  3 +++
 include/linux/printk.h           |  5 ++++
 include/linux/rv.h               |  9 +++++--
 include/rv/da_monitor.h          | 45 +++++++-------------------------
 kernel/panic.c                   | 17 ++++++++----
 kernel/printk/internal.h         |  1 -
 kernel/trace/rv/reactor_panic.c  |  8 ++++--
 kernel/trace/rv/reactor_printk.c |  8 ++++--
 kernel/trace/rv/rv_reactors.c    |  2 +-
 9 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 54d90b6c5f47..3522f8c441f4 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -3,6 +3,7 @@
 #define _LINUX_PANIC_H
=20
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
=20
 struct pt_regs;
@@ -10,6 +11,8 @@ struct pt_regs;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
+__printf(1, 0)
+void vpanic(const char *fmt, va_list args) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..1b7eebe13f14 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
=20
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
@@ -213,6 +214,10 @@ int vprintk(const char *s, va_list args)
 {
 	return 0;
 }
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
+{
+	return 0;
+}
 static inline __printf(1, 2) __cold
 int _printk(const char *s, ...)
 {
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 3452b5e4b29e..c7c18c06911b 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -38,7 +38,7 @@ union rv_task_monitor {
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
-	void			(*react)(char *msg);
+	__printf(1, 2) void	(*react)(const char *msg, ...);
 };
 #endif
=20
@@ -50,7 +50,7 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
-	void			(*react)(char *msg);
+	__printf(1, 2) void	(*react)(const char *msg, ...);
 #endif
 };
=20
@@ -64,6 +64,11 @@ void rv_put_task_monitor_slot(int slot);
 bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
+#else
+bool rv_reacting_on(void)
+{
+	return false;
+}
 #endif /* CONFIG_RV_REACTORS */
=20
 #endif /* CONFIG_RV */
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 510c88bfabd4..15f9ed4e4bb6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,45 +19,22 @@
 #ifdef CONFIG_RV_REACTORS
=20
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static char REACT_MSG_##name[1024];								\
-												\
-static inline char *format_react_msg_##name(type curr_state, type event)		=
	\
-{												\
-	snprintf(REACT_MSG_##name, 1024,							\
-		 "rv: monitor %s does not allow event %s on state %s\n",			\
-		 #name,										\
-		 model_get_event_name_##name(event),						\
-		 model_get_state_name_##name(curr_state));					\
-	return REACT_MSG_##name;								\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
-	if (rv_##name.react)									\
-		rv_##name.react(msg);								\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return rv_reacting_on();								\
+	if (!rv_reacting_on() || !rv_##name.react)						\
+		return;										\
+	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",		=
	\
+			#name,									\
+			model_get_event_name_##name(event),					\
+			model_get_state_name_##name(curr_state));				\
 }
=20
 #else /* CONFIG_RV_REACTOR */
=20
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static inline char *format_react_msg_##name(type curr_state, type event)		=
	\
-{												\
-	return NULL;										\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
 	return;											\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return 0;										\
 }
 #endif
=20
@@ -170,8 +147,7 @@ da_event_##name(struct da_monitor *da_mon, enum events_=
##name event)				\
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(model_get_state_name_##name(curr_state),				\
 			   model_get_event_name_##name(event));					\
@@ -202,8 +178,7 @@ static inline bool da_event_##name(struct da_monitor *d=
a_mon, struct task_struct
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(tsk->pid,								\
 			   model_get_state_name_##name(curr_state),				\
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..df799d784b61 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -277,17 +277,16 @@ static void panic_other_cpus_shutdown(bool crash_kexe=
c)
 }
=20
 /**
- *	panic - halt the system
+ *	vpanic - halt the system
  *	@fmt: The text string to print
  *
  *	Display a message, then perform cleanups.
  *
  *	This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next =3D 0, len;
 	int state =3D 0;
 	int old_cpu, this_cpu;
@@ -338,9 +337,7 @@ void panic(const char *fmt, ...)
=20
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
=20
 	if (len && buf[len - 1] =3D=3D '\n')
 		buf[len - 1] =3D '\0';
@@ -477,7 +474,17 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
+EXPORT_SYMBOL(vpanic);
=20
+/* Identical to vpanic(), except it takes variadic arguments instead of va=
_list */
+void panic(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpanic(fmt, args);
+	va_end(args);
+}
 EXPORT_SYMBOL(panic);
=20
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a91bdf802967..28afdeb58412 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -71,7 +71,6 @@ int vprintk_store(int facility, int level,
 		  const char *fmt, va_list args);
=20
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_pani=
c.c
index 0186ff4cbd0b..2587f23db80b 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,9 +13,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
=20
-static void rv_panic_reaction(char *msg)
+static void rv_panic_reaction(const char *msg, ...)
 {
-	panic(msg);
+	va_list args;
+
+	va_start(args, msg);
+	vpanic(msg, args);
+	va_end(args);
 }
=20
 static struct rv_reactor rv_panic =3D {
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_pri=
ntk.c
index 178759dbf89f..a15db3fc8b82 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -12,9 +12,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
=20
-static void rv_printk_reaction(char *msg)
+static void rv_printk_reaction(const char *msg, ...)
 {
-	printk_deferred(msg);
+	va_list args;
+
+	va_start(args, msg);
+	vprintk_deferred(msg, args);
+	va_end(args);
 }
=20
 static struct rv_reactor rv_printk =3D {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 9501ca886d83..4ce6ebb9d095 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -490,7 +490,7 @@ void reactor_cleanup_monitor(struct rv_monitor_def *mde=
f)
 /*
  * Nop reactor register
  */
-static void rv_nop_reaction(char *msg)
+static void rv_nop_reaction(const char *msg, ...)
 {
 }
=20
--=20
2.39.5

