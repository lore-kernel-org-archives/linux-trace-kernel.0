Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA53DB62D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328366; cv=none; b=aPGV2pog/7U7m638Q7mkSME7P59+waMGxcHebRmzZ6QHKzAjSFCcCew4c4deT24Ge8ecF6SVNmIptDz49b+Z9TpcGVUjkvpx+DONd+uu21VGk9O80zKIDyFlrCRYi3zXyFP7oK4a4hQipfm9gsw0p2iLpSEIQ6ORr3SiBTvhLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328366; c=relaxed/simple;
	bh=g4g8Zam+hSZvn896CrlnvlPR1ryS4eqSi440uwjDUlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ps1NRt+e/3COxX8kTccPUiLFixUjHD0q0IrAkL0JVW/HesHl9aoECMOZLr8jtGa4oaFFP45zSjbZ2seWaY1jubBDKXSb3O1crTNFOOM4aIJVozMR9dJ3cFGD9Mf0eRPXA1No27vJ/AXnfFtDn16CvzIolKkmefpma5gB337IDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BToevUku; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BToevUku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qTDErs0Gx8rY0bmsBZBLWSpPtEJsBrp152kqGKFlZY=;
	b=BToevUkuHRFCm7h/MlMARgIM84JO6lfFNXOTcixm5J628SSY55jWCXhmtNxoKhyDw3SJqn
	BdfdEKxWQUcojAp9yDnlG0rEcuwKBD1afWqh/IcZCSfBUpuYKYut60brPRSGoC9jZPYGQZ
	BF3o5Npt1j1Brm930XuB6790OGVgJdY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-gGF7-PLMOPOyQKNxxr07Sw-1; Mon,
 01 Jun 2026 11:39:18 -0400
X-MC-Unique: gGF7-PLMOPOyQKNxxr07Sw-1
X-Mimecast-MFC-AGG-ID: gGF7-PLMOPOyQKNxxr07Sw_1780328357
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5048195608B;
	Mon,  1 Jun 2026 15:39:16 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C29B180075C;
	Mon,  1 Jun 2026 15:39:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 09/13] rv: Prevent task migration while handling per-CPU events
Date: Mon,  1 Jun 2026 17:38:36 +0200
Message-ID: <20260601153840.124372-10-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: WChI4A3WCrkzxXPJLuNCbvMlxdG6NwgYZ5Zpm4twkrM_1780328357
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
index 1f440c781..34b8fba9e 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -218,6 +218,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_sync_hook();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Functions to define, init and get a per-cpu monitor.
@@ -284,6 +288,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_sync_hook();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard() guard(migrate)()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Functions to define, init and get a per-task monitor.
@@ -756,6 +764,7 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
  */
 static inline void da_handle_event(enum events event)
 {
+	da_implicit_guard();
 	__da_handle_event(da_get_monitor(), event, 0);
 }
 
@@ -771,6 +780,7 @@ static inline void da_handle_event(enum events event)
  */
 static inline bool da_handle_start_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_event(da_get_monitor(), event, 0);
 }
 
@@ -782,6 +792,7 @@ static inline bool da_handle_start_event(enum events event)
  */
 static inline bool da_handle_start_run_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_run_event(da_get_monitor(), event, 0);
 }
 
-- 
2.54.0

