Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C152390235
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328352; cv=none; b=kVZeiCKr9ryEolf51t01gb7EGl9m8LjNF9/YORPGnqLlP6Mv0u04tgu0QWj0VpWuDz34i0wc2pYb/hQ8x62KRpyPs4N2OKR/Df7l1Iiefv6fQe4PiqJVu4KUUSiY2THn8lcHZt/cqe57pdJ8IUdaaGRJAS8Pr1rtsytRJm6h3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328352; c=relaxed/simple;
	bh=aMI6ETwxmmNMEq4Pf/ssYWo3dsOyX8bUrocvUz48vCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fzk2Ut/MAStNJMZqUEKFDMfG+B1DzqB3KQeAtcHMqOLRi3B8vcVNl/3CxbiZYeTvh2q5abki06oxPKh7Amleakts5ZWBX3E+RfkbiGvSFBuiCAxP3KifOXEv9p9NtBCPxL4ga0UYvl9yhUdZT+b4mGIUXjCaUo3gU2FS5prcyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIOs3b/Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIOs3b/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TbSgf7lkZ2g4yFD6sbp+32F0/NjiAQOgCDqaL4CgCU=;
	b=TIOs3b/YRVWBStaWJsFhDnM6YqprrX1boMNgQVqAdqnynCYuw8xhA28Aes7Abcm/ORVP8r
	kEJ/yPw5kZTzjn6LBOlUvyrt2u+ao2tli+fMG+HcnkOVTGarXlNKL8OzeDwsMYmRpfHvs7
	hp4L++ZKUMCdQEWAQz3a2FrnMaGEEco=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-VwEkJ4wQMs-5OCySIk01Aw-1; Mon,
 01 Jun 2026 11:39:06 -0400
X-MC-Unique: VwEkJ4wQMs-5OCySIk01Aw-1
X-Mimecast-MFC-AGG-ID: VwEkJ4wQMs-5OCySIk01Aw_1780328343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1AEF1955F22;
	Mon,  1 Jun 2026 15:39:03 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0168D18004A3;
	Mon,  1 Jun 2026 15:39:01 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 05/13] rv: Fix monitor start ordering and memory ordering for monitoring flag
Date: Mon,  1 Jun 2026 17:38:32 +0200
Message-ID: <20260601153840.124372-6-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: VIhmDEUh8oU6BEVwVormKaUEOIwPomWdqxuS4ir3S0I_1780328343
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

