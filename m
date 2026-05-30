Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7430DD30
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150639; cv=none; b=mrcYpnnUj21aGBT38kX2sMSDato7RcQggE5mlhs+UbNnwPrDXtyL5MpDKf+FLurV4sKtOMXs7q5aBa6rvUDWZFGkZ/3Kw8/IqCVNKkA6IKoRvS2a+iNUyRBxZvk5EffdNURALYZ6AiWpG3HD0UQyJyPAqhYcsjA294ydu1KcdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150639; c=relaxed/simple;
	bh=aMI6ETwxmmNMEq4Pf/ssYWo3dsOyX8bUrocvUz48vCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pxi4VMZ+ecgZohrHi3vZ5Gns2gh4956eaenDdORf5rkvoW9yYLYqaEYjb7vDpYR4uJC8gDYzUiCAD8iJb6x5OTCqKDeEIsoc8iin+Pc9YaSOwy1iNsIpSQ5T4DtXqSo+3gg8lrcm8U9Ux9DHctGqC4OngZZh9Q/If0n2VCfJhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE0Qzs96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE0Qzs96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TbSgf7lkZ2g4yFD6sbp+32F0/NjiAQOgCDqaL4CgCU=;
	b=IE0Qzs96nBDS8bUdRQ+jVq+Vu6btnG/GbXI6I8o8ayEtCZFwoT7s+CP2LUFJpcrHKp0FUz
	P1Q5EEUIpp2lF59uLAK7WoPsYqvAus/KWNPmqAsxxVfFHnAtCDA+WTfJ2DRUAcK87Cc99/
	k8UkXyYTbyiiN6x94N8A2gbuhCg7iFE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Ztj-yjVKNFiifEV6NvOlhQ-1; Sat,
 30 May 2026 10:17:13 -0400
X-MC-Unique: Ztj-yjVKNFiifEV6NvOlhQ-1
X-Mimecast-MFC-AGG-ID: Ztj-yjVKNFiifEV6NvOlhQ_1780150632
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC9361800343;
	Sat, 30 May 2026 14:17:12 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C60E730001BB;
	Sat, 30 May 2026 14:17:10 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 05/13] rv: Fix monitor start ordering and memory ordering for monitoring flag
Date: Sat, 30 May 2026 16:16:44 +0200
Message-ID: <20260530141652.58084-6-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iZkwj9FNxlqMDeXcIp4jz_596azMJngriDEDKpEnQ2M_1780150632
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Wen Yang <wen.yang@linux.dev>

da_monitor_start() set monitoring=1 before calling da_monitor_init_hook(),
may racing with the sched_switch handler:

  da_monitor_start()               sched_switch handler
  -------------------------        ---------------------------------
  da_mon->monitoring = 1;
                                   if (da_monitoring(da_mon))  /* true  */
                                       ha_start_timer_ns(...);
                                       /* hrtimer->base == NULL, crash */
  da_monitor_init_hook(da_mon);
  /* hrtimer_setup() sets base */

Fix the ordering and pair with release/acquire semantics:

  da_monitor_init_hook(da_mon);
  smp_store_release(&da_mon->monitoring, 1);    /* da_monitor_start()  */
  return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()     */

On ARM64 a plain STR + LDR does not form a release-acquire pair, so
the load can observe monitoring=1 while hrtimer->base is still NULL.
The plain accesses are also data races under KCSAN.

Use WRITE_ONCE for the monitoring=0 store in da_monitor_reset() to
cover the reset path.

Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index a7e103654..60dc39f26 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -82,7 +82,7 @@ static void react(enum states curr_state, enum events event)
 static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
 	da_monitor_reset_hook(da_mon);
-	da_mon->monitoring = 0;
+	WRITE_ONCE(da_mon->monitoring, 0);
 	da_mon->curr_state = model_get_initial_state();
 }
 
@@ -95,8 +95,9 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
 	da_mon->curr_state = model_get_initial_state();
-	da_mon->monitoring = 1;
 	da_monitor_init_hook(da_mon);
+	/* Pairs with smp_load_acquire in da_monitoring(). */
+	smp_store_release(&da_mon->monitoring, 1);
 }
 
 /*
@@ -104,7 +105,8 @@ static inline void da_monitor_start(struct da_monitor *da_mon)
  */
 static inline bool da_monitoring(struct da_monitor *da_mon)
 {
-	return da_mon->monitoring;
+	/* Pairs with smp_store_release in da_monitor_start(). */
+	return smp_load_acquire(&da_mon->monitoring);
 }
 
 /*
-- 
2.54.0

