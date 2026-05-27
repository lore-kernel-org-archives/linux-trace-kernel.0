Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B363164DF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863037; cv=none; b=aT2rl25F2y1FFQh7Ox38ktp3ZJ3Hn2lS8kRJkP8+h28PhtbJ2qsaXAQd1afYkZHN/Z+PLYr+hXtN0HECYnMkUvhJmk5exG4LV3451qEaqAVordrhTTsw4qiZbuf7ZDypNtxS9ibPXQm3DtUOfAXqG8eH3iJQNVsR9bPPlpAmjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863037; c=relaxed/simple;
	bh=8pD24vWsf0Oic32L+LWKN5iw6F9KGR5tawzGI3vksjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pM0Q9u1xvDGXUPJ0i25NB6jFtgedrClrb8QDPgVRvCTL4kPXl5/qs7rDLbMjn4rLq73dOtokO/EoiQMbitzRHKQ465NruBHmSVZYQ7Kil4+B+jpY+SG/VuyrprEFtLXB+5kPW46YDdrOxr42UpP5XPHzKJYDFhWDj7KKlY8utdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5kmt4mf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5kmt4mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVDYJtpxlDAh1CQeGepsebT4DWf9Iwm9B4gpcIcekmM=;
	b=b5kmt4mfggbJ9thI/dCGmUWp0Rcj9ziA/lHOc7+LBgA5UBuz2ABd6Gs/ImG96iD2TFL5yq
	t4DPH4bw8ZMel38ZHh2JtG20YoT9d/cwfn1dTucJK+xBwrVOgnUnvRqPFr/qBTsBkqoGmz
	TtUktJOCUZT3bHBXqsp5dQiiTopP28w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-mtBPWrYCNEaw-_9mjBJZjA-1; Wed,
 27 May 2026 02:23:47 -0400
X-MC-Unique: mtBPWrYCNEaw-_9mjBJZjA-1
X-Mimecast-MFC-AGG-ID: mtBPWrYCNEaw-_9mjBJZjA_1779863026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40B331800603;
	Wed, 27 May 2026 06:23:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 433001800465;
	Wed, 27 May 2026 06:23:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 04/12] rv: Prevent task migration while handling per-CPU events
Date: Wed, 27 May 2026 08:23:04 +0200
Message-ID: <20260527062313.39908-5-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 012ZEYiNwTMpegZcSRbVA85CDNEOHT6TTLJ0mUruN4k_1779863026
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Tracepoint handlers are now fully preemptible. When a per-CPU monitor
handles an event, it retrieves the monitor state using a per-CPU
pointer. If the event itself doesn't disable preemption, the task can
migrate to a different CPU and we risk updating the wrong monitor.

Mitigate this by explicitly disabling task migration before acquiring
the monitor pointer. This cannot guarantee the monitor runs on the
correct CPU but reduces the race condition window and prevents warnings.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 0b7028df08fb..a9fd284195ee 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -181,6 +181,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_reset_all();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_CPU
 /*
  * Functions to define, init and get a per-cpu monitor.
@@ -230,6 +234,10 @@ static inline void da_monitor_destroy(void)
 	da_monitor_reset_all();
 }
 
+#ifndef da_implicit_guard
+#define da_implicit_guard() guard(migrate)()
+#endif
+
 #elif RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Functions to define, init and get a per-task monitor.
@@ -677,6 +685,7 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
  */
 static inline void da_handle_event(enum events event)
 {
+	da_implicit_guard();
 	__da_handle_event(da_get_monitor(), event, 0);
 }
 
@@ -692,6 +701,7 @@ static inline void da_handle_event(enum events event)
  */
 static inline bool da_handle_start_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_event(da_get_monitor(), event, 0);
 }
 
@@ -703,6 +713,7 @@ static inline bool da_handle_start_event(enum events event)
  */
 static inline bool da_handle_start_run_event(enum events event)
 {
+	da_implicit_guard();
 	return __da_handle_start_run_event(da_get_monitor(), event, 0);
 }
 
-- 
2.54.0

