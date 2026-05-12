Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABA3ABDA4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594609; cv=none; b=ur1v9Uv2koqloc2gywx5gq22tOYuvAVox+KXu2fN2IHfCF8MT4hEDbIuwYYgMEAgpCNcMK8NPs8BGtoEDHMP7njNNfioGM95lU0FE/TM9xoNsoNwBPb0blWi25toQLFQwQlfekXNZyx0pLjSubK0IhqgcOScY3cckZ6DWeSCIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594609; c=relaxed/simple;
	bh=GqmOOXiZ4Sw6hB5sOcbJyLBH+U2OPWqH6Rch/tgYZtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ptkto/7Sn3D4mOdnvuaauR0JPfggE3RDEdcXhYBbcwZaxLnLnBcAIQ00DKdK3954SVlf/Ad3Q2QQ9mhyuCQWBhPRnPi1Avk54aS7aPUOSh0uhvlv0tRXHihOeDUiIENE04TdqYKOIXf0QPy/XFDaFG7vClrE97+66C0Zpmrqams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPYYOCi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPYYOCi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcWlDHY2UKsARXUo4F85F1K8+bqt3pAPESRTfWgsXBk=;
	b=QPYYOCi0/ggipxWk1QFLrLgCZ/mIrR49HWrH4de1gNXK+Y+9hKioladSzOCfnZ8+nzlOOj
	tIWS0SWoRws5129ijybwXeKPsj0nCN1KSONnXBQIB3USv0jDLDYZ+szKHCRIEf8R4zf9hQ
	5juDcIqgXoyFcOR7fE33R0430i3pUMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-mHfxql_GM_i1CJ8HmFjyhQ-1; Tue,
 12 May 2026 10:03:23 -0400
X-MC-Unique: mHfxql_GM_i1CJ8HmFjyhQ-1
X-Mimecast-MFC-AGG-ID: mHfxql_GM_i1CJ8HmFjyhQ_1778594601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 771DF1956089;
	Tue, 12 May 2026 14:03:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2571180034E;
	Tue, 12 May 2026 14:03:18 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 7/9] rv: Do not rely on clean monitor when initialising HA
Date: Tue, 12 May 2026 16:02:48 +0200
Message-ID: <20260512140250.262190-8-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Q_D8a8yZcZuOPt6U4-cwtoPrSCxWTAbFhtaMfotNBoo_1778594601
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
can have any value, so skip timer cancellation in any case when a local
flag is set. New monitors (e.g. new tasks) are always zero-initialised
so they are safe.

Reported-by: Wen Yang <wen.yang@linux.dev>
Closes: https://lore.kernel.org/lkml/d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev
Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ha_monitor.h                       | 31 ++++++++++++++++++-
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +--
 kernel/trace/rv/monitors/opid/opid.c          |  4 +--
 kernel/trace/rv/monitors/stall/stall.c        |  4 +--
 .../rvgen/rvgen/templates/dot2k/main.c        |  4 +--
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 47ff1a41febe..11ae85bad492 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -116,6 +116,35 @@ static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
 #define ha_get_ns() 0
 #endif /* HA_CLK_NS */
 
+static bool ha_mon_initializing;
+
+static int ha_monitor_init(void)
+{
+	int ret;
+
+	ha_mon_initializing = true;
+	ret = da_monitor_init();
+	ha_mon_initializing = false;
+	return ret;
+}
+
+static void ha_monitor_destroy(void)
+{
+	da_monitor_destroy();
+}
+
+/*
+ * ha_monitor_uninitialized - are fields like the timer initialized?
+ *
+ * On a clean monitor, we can assume an active monitor (monitoring) is
+ * initialized, however the monitoring field cannot be trusted during
+ * initialization.
+ */
+static inline bool ha_monitor_uninitialized(struct da_monitor *da_mon)
+{
+	return ha_mon_initializing || !da_monitoring(da_mon);
+}
+
 /* Should be supplied by the monitor */
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
 static bool ha_verify_constraint(struct ha_monitor *ha_mon,
@@ -160,7 +189,7 @@ static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
 	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
 
 	/* Initialisation resets the monitor before initialising the timer */
-	if (likely(da_monitoring(da_mon)))
+	if (likely(!ha_monitor_uninitialized(da_mon)))
 		ha_cancel_timer(ha_mon);
 }
 
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c b/kernel/trace/rv/monitors/nomiss/nomiss.c
index 31f90f3638d8..8ead8783c29f 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
@@ -227,7 +227,7 @@ static int enable_nomiss(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -263,7 +263,7 @@ static void disable_nomiss(void)
 	rv_detach_trace_probe("nomiss", sched_switch, handle_sched_switch);
 	rv_detach_trace_probe("nomiss", sched_wakeup, handle_sched_wakeup);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 static struct rv_monitor rv_this = {
diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 4594c7c46601..2922318c6112 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -73,7 +73,7 @@ static int enable_opid(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -90,7 +90,7 @@ static void disable_opid(void)
 	rv_detach_trace_probe("opid", sched_set_need_resched_tp, handle_sched_need_resched);
 	rv_detach_trace_probe("opid", sched_waking, handle_sched_waking);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 /*
diff --git a/kernel/trace/rv/monitors/stall/stall.c b/kernel/trace/rv/monitors/stall/stall.c
index 9ccfda6b0e73..3c38fb1a0159 100644
--- a/kernel/trace/rv/monitors/stall/stall.c
+++ b/kernel/trace/rv/monitors/stall/stall.c
@@ -103,7 +103,7 @@ static int enable_stall(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -120,7 +120,7 @@ static void disable_stall(void)
 	rv_detach_trace_probe("stall", sched_switch, handle_sched_switch);
 	rv_detach_trace_probe("stall", sched_wakeup, handle_sched_wakeup);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 static struct rv_monitor rv_this = {
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index bf0999f6657a..889446760e3c 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -35,7 +35,7 @@ static int enable_%%MODEL_NAME%%(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = %%MONITOR_CLASS%%_monitor_init();
 	if (retval)
 		return retval;
 
@@ -50,7 +50,7 @@ static void disable_%%MODEL_NAME%%(void)
 
 %%TRACEPOINT_DETACH%%
 
-	da_monitor_destroy();
+	%%MONITOR_CLASS%%_monitor_destroy();
 }
 
 /*
-- 
2.54.0

