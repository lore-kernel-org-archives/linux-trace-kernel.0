Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA7341651
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948407; cv=none; b=YFzXCHQGtehlRQFBYJRKJ6aRBU5pt8c8hkkj8v+91l6sI0HXPF3hSi5EFonb8ifsY/E50jvbpT1LL+n/fVttr+80oVqBjokIqzXVZ2HYTDcv/tUmF7pP45QAFQ2RAKvlInI7Qx0UCNBuY4TyTsJrgk1jrHoKrcTqjSHXBo6j/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948407; c=relaxed/simple;
	bh=K0ElDsTm2ArSyphsFcxUA253o3pMHPe9E9UYvTFwGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXhZKnrbLwObZj4BVcb5GrYxGntINv70P53qQb5ZCTfF6TK1/FP0nXvMPifwPF7GmusxU65kjKaR3ZPSlCA2exVWYQgYQx7ounPJmUt2IZL0R3lQ01DT8uAqPyZ3cZQORDr292o55JXVPQITNUk8s0gZEauMEAdQJFLBEDd1f5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcSMWiCb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcSMWiCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757948404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFkTi56GeHkgOO3HQJUs680Pme7PW2l5lL1fNlMRCTY=;
	b=TcSMWiCb87Y8zuscQZrkM81BJ0M16W1h3cZPCFOEP/++EfxwshsvYHPtCRsssTz06i/jo5
	d1CcpIXPjXLCh6UMbdZrM3dCIG6I80gDgmMSCgfZ+SUxvq8WpJvPME6a1okWNVxc3TMySp
	uB+3GNTMNAPqYwTQfJ+DnJjwtJ4u5cI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-O7BuJkY-NXazP4-dy88Asg-1; Mon,
 15 Sep 2025 11:00:01 -0400
X-MC-Unique: O7BuJkY-NXazP4-dy88Asg-1
X-Mimecast-MFC-AGG-ID: O7BuJkY-NXazP4-dy88Asg_1757948400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 010B819560B0;
	Mon, 15 Sep 2025 15:00:00 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD1B81800446;
	Mon, 15 Sep 2025 14:59:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v12 2/9] timers: Rename tmigr 'online' bit to 'available'
Date: Mon, 15 Sep 2025 16:59:23 +0200
Message-ID: <20250915145920.140180-13-gmonaco@redhat.com>
In-Reply-To: <20250915145920.140180-11-gmonaco@redhat.com>
References: <20250915145920.140180-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The timer migration hierarchy excludes offline CPUs via the
tmigr_is_not_available function, which is essentially checking the
online bit for the CPU.

Rename the online bit to available and all references in function names
and tracepoint to generalise the concept of available CPUs.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 22 +++++++++++-----------
 kernel/time/timer_migration.h          |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
index 47db5eaf2f9a..61171b13c687 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -173,14 +173,14 @@ DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
 	TP_ARGS(tmc)
 );
 
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_available,
 
 	TP_PROTO(struct tmigr_cpu *tmc),
 
 	TP_ARGS(tmc)
 );
 
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_unavailable,
 
 	TP_PROTO(struct tmigr_cpu *tmc),
 
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 891891794b92..55b186fd146c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -427,7 +427,7 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
 {
-	return !(tmc->tmgroup && tmc->online);
+	return !(tmc->tmgroup && tmc->available);
 }
 
 /*
@@ -926,7 +926,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 	 * updated the event takes care when hierarchy is completely
 	 * idle. Otherwise the migrator does it as the event is enqueued.
 	 */
-	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	if (!tmc->available || tmc->remote || tmc->cpuevt.ignore ||
 	    now < tmc->cpuevt.nextevt.expires) {
 		raw_spin_unlock_irq(&tmc->lock);
 		return;
@@ -973,7 +973,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 	 * (See also section "Required event and timerqueue update after a
 	 * remote expiry" in the documentation at the top)
 	 */
-	if (!tmc->online || !tmc->idle) {
+	if (!tmc->available || !tmc->idle) {
 		timer_unlock_remote_bases(cpu);
 		goto unlock;
 	}
@@ -1432,19 +1432,19 @@ static long tmigr_trigger_active(void *unused)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
-	WARN_ON_ONCE(!tmc->online || tmc->idle);
+	WARN_ON_ONCE(!tmc->available || tmc->idle);
 
 	return 0;
 }
 
-static int tmigr_cpu_offline(unsigned int cpu)
+static int tmigr_clear_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 	int migrator;
 	u64 firstexp;
 
 	raw_spin_lock_irq(&tmc->lock);
-	tmc->online = false;
+	tmc->available = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
 	/*
@@ -1452,7 +1452,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
+	trace_tmigr_cpu_unavailable(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
@@ -1463,7 +1463,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static int tmigr_cpu_online(unsigned int cpu)
+static int tmigr_set_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
@@ -1472,11 +1472,11 @@ static int tmigr_cpu_online(unsigned int cpu)
 		return -EINVAL;
 
 	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_online(tmc);
+	trace_tmigr_cpu_available(tmc);
 	tmc->idle = timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
-	tmc->online = true;
+	tmc->available = true;
 	raw_spin_unlock_irq(&tmc->lock);
 	return 0;
 }
@@ -1488,7 +1488,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 static int __init tmigr_late_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				 tmigr_cpu_online, tmigr_cpu_offline);
+				 tmigr_set_cpu_available, tmigr_clear_cpu_available);
 }
 
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index ae19f70f8170..70879cde6fdd 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -97,7 +97,7 @@ struct tmigr_group {
  */
 struct tmigr_cpu {
 	raw_spinlock_t		lock;
-	bool			online;
+	bool			available;
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-- 
2.51.0

