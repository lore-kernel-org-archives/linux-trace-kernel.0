Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B32C1E0C;
	Tue, 29 Apr 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928097; cv=none; b=Kk2kbii5eDt8uQG2leJ/jkHNE9lgdCFsT6iPaTVXr122yUHmnvMJnvIy+AfJ/2oiLCcIWELrvArRIJQ0lzKdlqbAMcdBDMj5M+qaylRjyvUvUG4NZrihpDq7hEXJ/1Le3J7QYG1fSejSwHq32p7KR+Cbottoq7iCCu3uhKray8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928097; c=relaxed/simple;
	bh=wn2eJuS+zEx8XuEUjHUhCIJA/y0N3h9PIoDYfiC14KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf3QUaGuTZTN7o2oXPbS+pBIjDeXO4HigKQVJqZDD1OsN3yDWn5dEYZlzox//VlJCMA+EGBWaEVP98mOOwQlKCcn6hnVfpfZVEiSBDKM9yP2l5ljMu29DLwlGJROk0ey2fvIyWZE2o7DvRxn7BmI8tK83uWH2hYH0k3Wvn4vzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvrkGWH8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdqT4GgD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvrkGWH8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdqT4GgD"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6K97kNqS9iVwLaZLV56vbzJZXc6QFuHBHlvLvdFEbg=;
	b=jvrkGWH88nekLI1n9GW/ZOkGQ893n8MDV3E6y4UF80j8e1yf+NalOz306JUu+7FNZVQDH0
	OK17Q0UePSPccD5/ot8ASiBWE1g+NFUjenemvdkTUIk/zyyh7N5h9crrKgwI9t2wDnDrKz
	KAMICVZyHuq+vdZSDsWm5tHhRFYu1k8iIa/ekjndBvG5Cd86b0B/pjtH7fqHs5OnVqOZib
	U5G/4iskBRzfHllCzRMjt9TOrxSTyGr7GwevGqHvvWGOQIH2pOTycRs7yE5lU76viJDkTS
	yL1z6u04CO55DGTLHfhbCiy6OxAOGfS4le8I6X3qmT+EfIjffKiL2n0k/LyifA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6K97kNqS9iVwLaZLV56vbzJZXc6QFuHBHlvLvdFEbg=;
	b=tdqT4GgD7h+jm/zEo7LV/CbkkvnMvYi/0hXf9xkypX7YtL/gdMRB8AfEuhqJ6gurHlOXTH
	7kE5E2ex/tAClxDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 04/23] rv: Let the reactors take care of buffers
Date: Tue, 29 Apr 2025 14:00:49 +0200
Message-Id: <833a4176f178d5d8d0acc40237e82b22f4e3c027.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/rv.h               |  9 +++++--
 include/rv/da_monitor.h          | 45 +++++++-------------------------
 kernel/trace/rv/reactor_panic.c  |  8 ++++--
 kernel/trace/rv/reactor_printk.c |  8 ++++--
 kernel/trace/rv/rv_reactors.c    |  2 +-
 5 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 3452b5e4b29e..9428e62eb8e9 100644
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
+static inline bool rv_reacting_on(void)
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
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_pani=
c.c
index 0186ff4cbd0b..74c6bcc2c749 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,9 +13,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
=20
-static void rv_panic_reaction(char *msg)
+__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
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
index 178759dbf89f..2dae2916c05f 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -12,9 +12,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
=20
-static void rv_printk_reaction(char *msg)
+__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
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
index 9501ca886d83..740603670dd1 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -490,7 +490,7 @@ void reactor_cleanup_monitor(struct rv_monitor_def *mde=
f)
 /*
  * Nop reactor register
  */
-static void rv_nop_reaction(char *msg)
+__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
 {
 }
=20
--=20
2.39.5

