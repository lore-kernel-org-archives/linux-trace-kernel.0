Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0963AFD16
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150653; cv=none; b=cka2ZJWF6//Wt4dhVseQvVCIYteDRmgMzeHxEycVKKwi5F8Grqf1e/RhR5iXBqYqbsFIbEvrDgqfr4Hnt5fN1Te4Y03QkPF/jibk7KWugnJ6LxgUnLAI1X3dbtF4bufqZkQClU9JxRJgCKPOUO/ftcO7ufLJs6jUQmmEMh2RrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150653; c=relaxed/simple;
	bh=2auu0wUshBdL3euNr84+3mM8Nb18AhruiK26RqQIyJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MWjLZN6KgdfvM5uIRqecSkQ1OzVgOfsjVGDlcs11yhqkp7ilyRfKK1DOBNlDWKLE9nyIM2t1WYkpSNPD8q66rylhVwcnafqDChEhGLeCXKnnJsCaLXxm34tVYqwOcJI2jMXwt2UEuVj1r7h6LdT55abHphwiARfUWLUR79RJZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8mpFPTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8mpFPTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8s8nZxVKOrACxNdZkFQ3oVHcJBxN3VpVUQ3IcWWpAAQ=;
	b=P8mpFPTlu6ntHA9mOCxPykTnFoaca64qRS8Rr7wydDNI1M2Gbw/UUlAbdYY49cN0I6/FBP
	5/5Dcp7iWM+qYOLJNy/qpjTMGFZaPwnafogN6toWC5cBIidAq+vsMUD6fxuLdRfijTsOwT
	NTLBM4TGxLQ63buuzQL4cxjIawI8e9w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-07erGJtsNqGkmUvjPaAPhQ-1; Sat,
 30 May 2026 10:17:27 -0400
X-MC-Unique: 07erGJtsNqGkmUvjPaAPhQ-1
X-Mimecast-MFC-AGG-ID: 07erGJtsNqGkmUvjPaAPhQ_1780150646
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72BAA195608F;
	Sat, 30 May 2026 14:17:26 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2972830001BB;
	Sat, 30 May 2026 14:17:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 09/13] rv: Prevent task migration while handling per-CPU events
Date: Sat, 30 May 2026 16:16:48 +0200
Message-ID: <20260530141652.58084-10-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: RztDrKYFgn1gIysLRCCI0EMrjlT2kc06QJdPGhDoP_0_1780150646
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Tracepoint handlers are fully preemptible after a46023d5616 ("tracing:
Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast"). When
a per-CPU monitor handles an event, it retrieves the monitor state using
a per-CPU pointer. If the event itself doesn't disable preemption, the
task can migrate to a different CPU and we risk updating the wrong
monitor.

Mitigate this by explicitly disabling task migration before acquiring
the monitor pointer. This cannot guarantee the monitor runs on the
correct CPU but reduces the race condition window and prevents warnings.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 03c1150b1..ae8c35fcb 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -194,6 +194,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_sync_hook();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Functions to define, init and get a per-cpu monitor.
@@ -244,6 +248,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_sync_hook();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard() guard(migrate)()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Functions to define, init and get a per-task monitor.
@@ -700,6 +708,7 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
  */
 static inline void da_handle_event(enum events event)
 {
+	da_implicit_guard();
 	__da_handle_event(da_get_monitor(), event, 0);
 }
 
@@ -715,6 +724,7 @@ static inline void da_handle_event(enum events event)
  */
 static inline bool da_handle_start_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_event(da_get_monitor(), event, 0);
 }
 
@@ -726,6 +736,7 @@ static inline bool da_handle_start_event(enum events event)
  */
 static inline bool da_handle_start_run_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_run_event(da_get_monitor(), event, 0);
 }
 
-- 
2.54.0

