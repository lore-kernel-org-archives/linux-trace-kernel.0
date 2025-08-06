Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB71EEA31;
	Wed,  6 Aug 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470020; cv=none; b=E3Mr3fWyjcO6KJPSPg2p2aLhzeJ+dGJ+raI9xI4OVLnftj18yJpmDbpdlGvY52YfsMP41SmL2861qqFutz8kufi//BjIQ0ZUnf0w6/7NzovpqUVje9VRvdCaczk8LbgpwpZAgiYeUvkGexeOFfRBioj+G5iFMAsYSMyFWInJBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470020; c=relaxed/simple;
	bh=hYNqEsP82qdILUOKzEkzPVaFsBgV6sHYuztseoRNoq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA7KsWDyOGdZU1o0Hf2x2Oi6BdAeEPpDCAi0Uz9fNa/4oRC3IAhLccZvQu8HI1gHz3YUPF+Ix/LW32kYnDryhl0NihqHt5Z4R60UQkiKCzx/Vgm+vNRQxCOc7Mba0kYqYzlpeqNHDAVSIRIusFlr9F4HLmZtJIJ7onYw1RZ5txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C1c1mEs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3GD6YB+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C1c1mEs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3GD6YB+"
Date: Wed, 6 Aug 2025 10:46:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754470017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYJrA1BGlXrP0d9RCZmbXBI9p4Rr1CBSrbu3cWfdZJ4=;
	b=C1c1mEs1VQtvuq+dVQKHKwaG+hoKEH+C5HSdx71X83du5/7AhXLgCAzX9Sw/aH2DrFR2Em
	cW+haLzyr2l+HpyCgn6iBHgnLfkpn6PWyCUlsI56pKhyXDOei3A9lrOhwgBxbAohuuqJGl
	X3v/GOop1sVrNAogs3HZhDMptzmib+1cBz2EJ1y6MXqlKjiFxqAdJnWWkMkGpT7ft02ws1
	6IjE5i9iBO7PnHBh60Mv0XgMbEQZFrBhjjCpBuYEtsH0JwDBe6yMnS2vfZs4vln1HSWehm
	g1ctFAgGD64Rcvw74uhhUhcCRNMkOeE/2HQsuuP7yCr6SvFcOl6sMOhfmDgoiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754470017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYJrA1BGlXrP0d9RCZmbXBI9p4Rr1CBSrbu3cWfdZJ4=;
	b=D3GD6YB+kfrVUiUym13eSnrXIpy0o1qG4P9GhGw/7qIT0pBVAfOxCe/akjZalsUqNxrzSS
	2RFYxfpCGFKPH6BQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rv: Add rts monitor
Message-ID: <20250806084652.3TFe1T1W@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
 <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
 <20250805122215.hXbwUchz@linutronix.de>
 <20250805154515.CchJtec3@linutronix.de>
 <1ddbe4c89a12c6282fa6db19c4649b90ab2fcf9d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddbe4c89a12c6282fa6db19c4649b90ab2fcf9d.camel@redhat.com>

On Wed, Aug 06, 2025 at 10:15:48AM +0200, Gabriele Monaco wrote:
> I didn't make it on time before your V2, I assume you solved already so
> you might ignore this.
> 
> You kinda have something like the da_monitor_enabled: the
> rv_ltl_all_atoms_known
> 
> I wonder if you could define LTL_RT_TASK_ENQUEUED only when you
> actually know it (or are reasonably sure based on your internal
> counter). Or at least not set all atoms until the monitor is fully set
> up.

The rv_ltl_all_atoms_known() thingy is for situation where relevant
tracepoints have not been hit yet.

This case is slightly different, the tracepoint has been hit. And it is not
clear how to implement the "reasonably sure based on your internal counter"
part.

> Anyway reordering the tracepoints registration is likely necessary
> whatever you do, but I'm afraid a problem like this can occur pretty
> often with this type of monitors.

What I have in v2 is a workaround only, by reordering the tracepoint
registrations.

The root problem is not specific to this monitor, but all LTL monitors. My
idea for the real fix is the untested patch below. I will send it
separately. It is not urgent, so I can wait for your DA macro removal patch
to be merged first.

As I'm sending the patch to you, I realized that the patch effectively
nullifies ltl_atoms_init(). So I will need to fix that up..

Nam

commit 7fbb9a99f1a95e5149d476fa3d83a60be1a9a579
Author: Nam Cao <namcao@linutronix.de>
Date:   Tue Aug 5 22:47:49 2025 +0200

    rv: Share the da_monitor_enabled_##name() function with LTL
    
    The LTL monitors also need the functionality that
    da_monitor_enabled_##name() offers.
    
    This is useful to prevent the automaton from being executed before the
    monitor is completely enabled, preventing the situation where the
    monitors run before all tracepoints are registered. This situation can
    cause a false positive error, because the monitors do not see some
    events and do not validate properly.
    
    Pull da_monitor_enabled_##name() to be in the common header, and use
    it for both LTL and DA.
    
    Signed-off-by: Nam Cao <namcao@linutronix.de>

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 1aa01d98e390..8a885b3665a8 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -119,6 +119,14 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent);
 int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
+static inline bool rv_monitor_enabled(struct rv_monitor *monitor)
+{
+	if (unlikely(!rv_monitoring_on()))
+		return 0;
+
+	return likely(monitor->enabled);
+}
+
 #ifdef CONFIG_RV_REACTORS
 bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 17fa4f6e5ea6..92b8a8c0b9b7 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -74,29 +74,12 @@ static inline bool da_monitoring_##name(struct da_monitor *da_mon)				\
 	return da_mon->monitoring;								\
 }												\
 												\
-/*												\
- * da_monitor_enabled_##name - checks if the monitor is enabled					\
- */												\
-static inline bool da_monitor_enabled_##name(void)						\
-{												\
-	/* global switch */									\
-	if (unlikely(!rv_monitoring_on()))							\
-		return 0;									\
-												\
-	/* monitor enabled */									\
-	if (unlikely(!rv_##name.enabled))							\
-		return 0;									\
-												\
-	return 1;										\
-}												\
-												\
 /*												\
  * da_monitor_handling_event_##name - checks if the monitor is ready to handle events		\
  */												\
 static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)			\
 {												\
-												\
-	if (!da_monitor_enabled_##name())							\
+	if (!rv_monitor_enabled(&rv_##name))							\
 		return 0;									\
 												\
 	/* monitor is actually monitoring */							\
@@ -390,7 +373,7 @@ static inline bool da_handle_start_event_##name(enum events_##name event)			\
 {												\
 	struct da_monitor *da_mon;								\
 												\
-	if (!da_monitor_enabled_##name())							\
+	if (!rv_monitor_enabled(&rv_##name))							\
 		return 0;									\
 												\
 	da_mon = da_get_monitor_##name();							\
@@ -415,7 +398,7 @@ static inline bool da_handle_start_run_event_##name(enum events_##name event)
 {												\
 	struct da_monitor *da_mon;								\
 												\
-	if (!da_monitor_enabled_##name())							\
+	if (!rv_monitor_enabled(&rv_##name))				\
 		return 0;									\
 												\
 	da_mon = da_get_monitor_##name();							\
@@ -475,7 +458,7 @@ da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)
 {												\
 	struct da_monitor *da_mon;								\
 												\
-	if (!da_monitor_enabled_##name())							\
+	if (!rv_monitor_enabled(&rv_##name))							\
 		return 0;									\
 												\
 	da_mon = da_get_monitor_##name(tsk);							\
@@ -501,7 +484,7 @@ da_handle_start_run_event_##name(struct task_struct *tsk, enum events_##name eve
 {												\
 	struct da_monitor *da_mon;								\
 												\
-	if (!da_monitor_enabled_##name())							\
+	if (!rv_monitor_enabled(&rv_##name))							\
 		return 0;									\
 												\
 	da_mon = da_get_monitor_##name(tsk);							\
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 29bbf86d1a52..85a3d07a0303 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -16,6 +16,8 @@
 #error "Please include $(MODEL_NAME).h generated by rvgen"
 #endif
 
+#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
+
 #if LTL_MONITOR_TYPE == LTL_TASK_MONITOR
 
 #define TARGET_PRINT_FORMAT "%s[%d]"
@@ -33,7 +35,6 @@ typedef unsigned int monitor_target;
 #endif
 
 #ifdef CONFIG_RV_REACTORS
-#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
 static struct rv_monitor RV_MONITOR_NAME;
 
 static struct ltl_monitor *ltl_get_monitor(monitor_target target);
@@ -156,6 +157,9 @@ static void ltl_attempt_start(monitor_target target, struct ltl_monitor *mon)
 
 static inline void ltl_atom_set(struct ltl_monitor *mon, enum ltl_atom atom, bool value)
 {
+	if (!rv_monitor_enabled(&RV_MONITOR_NAME))
+		return;
+
 	__clear_bit(atom, mon->unknown_atoms);
 	if (value)
 		__set_bit(atom, mon->atoms);
