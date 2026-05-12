Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961713A599D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594602; cv=none; b=KjlesyL2FS1ORTZFfxOwwVCKEwEDXlscWYSSVT05ciCUVWoTl0I05kDSC4HPHkOuzczjWc/hlWgQEKbER9MPf2DL5hpkus6YldjehkfmqAQdeOClMnbDgvAaKGsQtz84v0Bt5BQAWD7EhI76kCaMMmy/I/9zII0Gvd5Cj82R9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594602; c=relaxed/simple;
	bh=N1apW1tBvb0a/mnB0ObiEYuE3Fuc0xbXMl1UEGlCu8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kNIpG6JIKcoULFmpFYCNSabAmQVIqlJa5+9k9uM/CPlmT2ir8aIuvFRohrSP0qamLPfjicfPHfkPUlqphQ3WN8MRsec95+d3k6FqzzugldfFet7ZXVnowkrdL7L/v1tahFvvG99jtaR477joVtZ2nmsvFyZ13S5Vpk3cRf+Aq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBZni/NJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBZni/NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owPVbqfN1q1NzH+2NJbTR29TZuwOEggaR1L0dz2AxsQ=;
	b=iBZni/NJUMQ5cvLYOhCq5zUPWzqTaRf+p8uLois4HXudkaTAOx0K6ZbOuuyDJtybwwuPf+
	dm7fLMDtWBMvcVkZNI5bse+GzfJHfACWLNvhOhX+E30pyQo8SN8tPIRTeE4a3RaUfMv7UI
	vqF3JXtF0mP8aDpsuGDmPNjwynTiFpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-n4iYhkE4MF65Po6Md3w9rA-1; Tue,
 12 May 2026 10:03:12 -0400
X-MC-Unique: n4iYhkE4MF65Po6Md3w9rA-1
X-Mimecast-MFC-AGG-ID: n4iYhkE4MF65Po6Md3w9rA_1778594590
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F951800367;
	Tue, 12 May 2026 14:03:10 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E62AC180058F;
	Tue, 12 May 2026 14:03:07 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 4/9] rv: Prevent task migration while handling per-CPU events
Date: Tue, 12 May 2026 16:02:45 +0200
Message-ID: <20260512140250.262190-5-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: D5ztaW45W691vfP-ne_RDR_RkCHQ0oGdHcGgxecM6yM_1778594590
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

