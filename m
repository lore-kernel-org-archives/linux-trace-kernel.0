Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CA386421
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455823; cv=none; b=oCnrBppZpzxxE9fYJXHavgfVajDPicNJGWGThgQgYpmaguV4ddTHTIitvONT1FSSepHXmP1SXc+waOVzi8orM6oOLgA7EQH5ij4LdRUoYZn1JDje/hA/gLPt0U8p3r9548qplGcdk3CW4qKH9ieT+MnbNta3g5SI47dlTzXKZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455823; c=relaxed/simple;
	bh=PG+hm5bvITiRbAcd5VWl0Xp5NRJOOvRk7Y+1Dymc1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=BaLtSMHs5fwBFXWE9c/zK92LkDnruQa2VQz/KiPnWQOAx6a909seWxu89C7A6oiSc5Xo/allsWmnlclo8MxI1wsKsuy5CKKYylhv0fEL2xA0VicuRDahnBos8qLCUwuhZksM6bUnZgOiWVRtl8TjW1HIrAIkra1Drttqs8l9XPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bc07xAdv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bc07xAdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777455820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qjxg9Na+AQRO2MtnqRP3E16mQmGKTVMIu8Emcbi7O5g=;
	b=Bc07xAdvM7rJDQLWzIyGTaKi8h1CUYR0rJHxfStZSirYoDVkS9g+Y+QoF9xlIEm6DBuVf2
	YBjIKsp6JciZjZlEFhGz4bq1gzjKFkHKwzs66DhtKL/GzfvdJC2S399bPIlnr6v3qE+DSR
	qoeJP8vr+GLoJ5/73VKAUByfsZEQneo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-lPRN9uijMSCXHyXh55MRCw-1; Wed,
 29 Apr 2026 05:43:37 -0400
X-MC-Unique: lPRN9uijMSCXHyXh55MRCw-1
X-Mimecast-MFC-AGG-ID: lPRN9uijMSCXHyXh55MRCw_1777455816
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2FBB1800350;
	Wed, 29 Apr 2026 09:43:35 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A17D6195608E;
	Wed, 29 Apr 2026 09:43:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] sched: Use trace_call__<tp>() to save a static branch
Date: Wed, 29 Apr 2026 11:41:37 +0200
Message-ID: <20260429094227.34087-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: AHRJ-ONed59nRd7v8xkKE1n2q2tGibVv-0uedBPCFMk_1777455816
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The wrapper functions __trace_set_current_state() and
__trace_set_need_resched() allow the tracepoints to be called from code
outside sched/core.c, those calls are already guarded by a
tracepoint_enabled(<tp>) so there is no need to repeat this check once
again inside the call using trace_<tp>().

Use the new trace_call__<tp>() API to directly call the tracepoint
without check. Those helper functions must be called after the
appropriate check.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da20fb6ea25a..c37562b02e24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -537,10 +537,14 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 /* need a wrapper since we may need to trace from modules */
 EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
 
-/* Call via the helper macro trace_set_current_state. */
+/*
+ * Call via the helper macro trace_set_current_state.
+ * Calls to this function MUST be guarded by a
+ * tracepoint_enabled(sched_set_state_tp)
+ */
 void __trace_set_current_state(int state_value)
 {
-	trace_sched_set_state_tp(current, state_value);
+	trace_call__sched_set_state_tp(current, state_value);
 }
 EXPORT_SYMBOL(__trace_set_current_state);
 
@@ -1203,9 +1207,13 @@ static void __resched_curr(struct rq *rq, int tif)
 	}
 }
 
+/*
+ * Calls to this function MUST be guarded by a
+ * tracepoint_enabled(sched_set_need_resched_tp)
+ */
 void __trace_set_need_resched(struct task_struct *curr, int tif)
 {
-	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
+	trace_call__sched_set_need_resched_tp(curr, smp_processor_id(), tif);
 }
 EXPORT_SYMBOL_GPL(__trace_set_need_resched);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0

