Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6D31E857
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863054; cv=none; b=DRm9MTllJ9qEznSw2ZHhmrMy95FiBHgdS082rWL8gH4Jt0Xm8O45jRxqiBbWAuxTE5iJnL8sQvH0VlZ6ffCRwqDrRv37HYE+5TSzKD704nO4hKOLAfLVmYrtZzWM+rsE0cNOKfXwCYZQU/hxCB8NHQJf9XlkRusVSuqTGj/CvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863054; c=relaxed/simple;
	bh=/zZEHbloB4KIm41CbIFCOsq8dMiIdjmYYvO2/ZvjP2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lriwpgp1WL59gSVW676Kw6QJbvZDJ6KxTGC+HFNjIZyXvOQN2FyoQI4xsA+3XRN0gYmc4kus+zGGgtazCXgaJUL0jAifcI+2eMMjI7enSjGAa28cn+adYzvBC+9Mzcvy3VonD0I2nu+koJbZjNamcVjr3hSJ0ksSPd2hu7bgnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWyxfzEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWyxfzEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ePIHO+8NmGJdHjX2JRgFQZjZfpbWrkjo/nsSfZaWdU=;
	b=jWyxfzEYSj3GWCf6p5kjkR3ySoqZmRSBMZdbaO+00UKwcLmfJkpSMvRmTld0MwAJdaVhLG
	s/mWRegHtvsWTO0/z7jl+5rBf9VRh8UsES8NWn3WiJLBqensVbFGhfDg4xuOokiAsKtq6+
	Wm5/mKIoGeQcqf/AE0Hj1fnr1xrGUPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-Ehw2r_IgPnOKd0xeTn8akw-1; Wed,
 27 May 2026 02:23:58 -0400
X-MC-Unique: Ehw2r_IgPnOKd0xeTn8akw-1
X-Mimecast-MFC-AGG-ID: Ehw2r_IgPnOKd0xeTn8akw_1779863037
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D4D4195608B;
	Wed, 27 May 2026 06:23:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 519F71800465;
	Wed, 27 May 2026 06:23:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 07/12] rv: Fix monitor start ordering and memory ordering for monitoring flag
Date: Wed, 27 May 2026 08:23:07 +0200
Message-ID: <20260527062313.39908-8-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BhZo9yGHfhMmpg3fvYtuA_88aMlKcrJvbYObfWpnaXQ_1779863037
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
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 5f790e1694b4..c1e347f9deaf 100644
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

