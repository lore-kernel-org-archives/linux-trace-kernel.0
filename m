Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E9261587;
	Tue, 11 Mar 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712729; cv=none; b=LwMxJbNNSMPCaG9J8K9Ld7tMtR4ykaHkLMrOlWKWdsEYlWoxxlbZi/XqPisAISAanGiki/m3F6geAIKXJL2YLGIJ/pWjujcJFsPidAVcg+eHf1XAAzYESiJOCaH0kUqEGnR1B+/BXegZ/ksDkDkiGrPpbSxx8NRDtxcpBHPblQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712729; c=relaxed/simple;
	bh=gXWb1QVtURyPC1c9pNNAyYZImcQzG0Oan0pvcJgKnA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCFXDS3tKKPE6pVI0XhcrWQ9pprBnJVPuS1Osa5z3f+JSDwsRJOHTuaHafuRTlA8W2pxCy19efeebz+6oZ8M5Irgxtnj5BLzZQLGRTCSyLkLtjavf/RN9dtnYBlV8TsRIO+MdMGWNgyIDSHnaZggPLzK+OYDpw0nPl41uJgG8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Li3G+6mh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OsEuz6Uk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Li3G+6mh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OsEuz6Uk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/WlMggTTNfgC7f8VGbRswXvvuNe8BA6cQ5BXr81Npo=;
	b=Li3G+6mh8GCwBxt2uT5KZp8k1I9V3VLssXEKRiO68qpFCXAbfCgfl67cgcAO+RDqw2M3qd
	uvz6e4CovFsrFGPmlwz2ipq4AfAiZFlNWIs3itc2uIHBu3Kb2YEHEcC8lstSxQGkoW2JD3
	jVxkcUbl/HLztlioVNp1JADbdCT+rAR435EqHraEGFzE5PhR1aT8tsQDM3oBZ1qKLmGNqu
	fMvj8xEi/nmStV4T36borp1sr70UeDwhotJO8lAkqhCbvgmSlNysGoprzfItlK8uGuziJo
	j8I5uVx7C5hkJANxabskxQYzcXhUCcIU3d0N9QsauOvuVYzACLoGVqfb3Y5ziA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/WlMggTTNfgC7f8VGbRswXvvuNe8BA6cQ5BXr81Npo=;
	b=OsEuz6Uk/3Pi7mEcBBYHQyPayWA1apW87E0eqYGyfQdLPpj+vFsx4aPfCnbumBRVAOEvlw
	wyKgGNx381bNSsCw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 02/10] rv: Let the reactors take care of buffers
Date: Tue, 11 Mar 2025 18:05:03 +0100
Message-Id: <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each RV monitor has one static buffer to send to the reactors. If multiple
errors are detected at the same time, the one buffer could be overwritten.

Instead, leave it to the reactors to handle buffering.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h           |  1 +
 include/linux/rv.h               | 11 +++---
 include/rv/da_monitor.h          | 61 ++++++--------------------------
 kernel/printk/internal.h         |  1 -
 kernel/trace/rv/reactor_panic.c  |  7 +---
 kernel/trace/rv/reactor_printk.c |  8 +++--
 kernel/trace/rv/rv_reactors.c    |  2 +-
 7 files changed, 26 insertions(+), 65 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..11e49b299312 100644
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
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 8883b41d88ec..5482651ed020 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -38,7 +38,7 @@ union rv_task_monitor {
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
-	void			(*react)(char *msg);
+	void			(*react)(const char *msg, ...);
 };
 #endif
=20
@@ -49,9 +49,7 @@ struct rv_monitor {
 	int			(*enable)(void);
 	void			(*disable)(void);
 	void			(*reset)(void);
-#ifdef CONFIG_RV_REACTORS
-	void			(*react)(char *msg);
-#endif
+	void			(*react)(const char *msg, ...);
 };
=20
 bool rv_monitoring_on(void);
@@ -64,6 +62,11 @@ void rv_put_task_monitor_slot(int slot);
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
index 510c88bfabd4..c55d45544a16 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,58 +16,11 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
=20
-#ifdef CONFIG_RV_REACTORS
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
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
-{												\
-	if (rv_##name.react)									\
-		rv_##name.react(msg);								\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return rv_reacting_on();								\
-}
-
-#else /* CONFIG_RV_REACTOR */
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static inline char *format_react_msg_##name(type curr_state, type event)		=
	\
-{												\
-	return NULL;										\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
-{												\
-	return;											\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return 0;										\
-}
-#endif
-
 /*
  * Generic helpers for all types of deterministic automata monitors.
  */
 #define DECLARE_DA_MON_GENERIC_HELPERS(name, type)						\
 												\
-DECLARE_RV_REACTING_HELPERS(name, type)								\
-												\
 /*												\
  * da_monitor_reset_##name - reset a monitor and setting it to init state	=
		\
  */												\
@@ -170,8 +123,11 @@ da_event_##name(struct da_monitor *da_mon, enum events=
_##name event)				\
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	if (rv_reacting_on() && rv_##name.react)						\
+		rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",	=
	\
+				#name,								\
+				model_get_event_name_##name(event),				\
+				model_get_state_name_##name(curr_state));			\
 												\
 	trace_error_##name(model_get_state_name_##name(curr_state),				\
 			   model_get_event_name_##name(event));					\
@@ -202,8 +158,11 @@ static inline bool da_event_##name(struct da_monitor *=
da_mon, struct task_struct
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	if (rv_reacting_on() && rv_##name.react)						\
+		rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",	=
	\
+				#name,								\
+				model_get_event_name_##name(event),				\
+				model_get_state_name_##name(curr_state));			\
 												\
 	trace_error_##name(tsk->pid,								\
 			   model_get_state_name_##name(curr_state),				\
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
index 0186ff4cbd0b..4addabc9bcf1 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,15 +13,10 @@
 #include <linux/init.h>
 #include <linux/rv.h>
=20
-static void rv_panic_reaction(char *msg)
-{
-	panic(msg);
-}
-
 static struct rv_reactor rv_panic =3D {
 	.name =3D "panic",
 	.description =3D "panic the system if an exception is found.",
-	.react =3D rv_panic_reaction
+	.react =3D panic
 };
=20
 static int __init register_react_panic(void)
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
index 7b49cbe388d4..885661fe2b6e 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -468,7 +468,7 @@ void reactor_cleanup_monitor(struct rv_monitor_def *mde=
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

