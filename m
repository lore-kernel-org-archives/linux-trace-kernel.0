Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224900;
	b=GScewP4VurXlIgih/chKLwZcG+re/ktQ+ub3UAaWwSah8pBVJ9g1fGy8iwonKT8/3Is8
	 ZI6alLZcLWeYq/nQWhjtGwJCba9INFMzknWc472GReWH84fWgYYWPZoczjOpc3/Ob8CHL
	 mT6N8QzZvbZQrI8D/hBmbYlJlbAWf0ChVmEQTjzLh65DphTyBNrlrg6/KqcblGeQu27On
	 MSLyl8cO8JQ1cWY2VmPKCbrWqJHo9WaffA/Xtv2Dg621WxMgeJyU48NueFMCN93oqlnil
	 ZGXbqvBoNTA/YS0SYpuk3XKsu2gbdye0GMtpiz6IXLTUPrbQjGBZ/ww/+9H9JfTk4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224900;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=fB/vVdtm1ti9+e078MDAaOjyHHssd91+hzP1CWZkiRY=;
	b=AdEABvy/65Jwp/YMhS4zXbK+s+zJnYo4qcNY9V8JbuLlE1AgSor9AQCMK2X54HGZGEyP
	 x4Ul4vxDH4y4NRFLlOAbfC2lVRDp/zc7jveJ0G2SgSSnIhxNRMYVSkxMRv1kVHvjzdfvY
	 wz9MnNy2P5OdUFps+/N6agZBPAEhNSYyMSq6ti5Z3SxR7Wkh7dbivkmPM12GVtoPAufnC
	 uRMMzrXiPllQoW20ZIzKRp6GhotW7JAd8UGa1ciLTAMSIMF2BbzTAbWYyLy+Psr/0h2fm
	 LPNcIkvXaIgOfdE7szF6CcLWxN7H+xJQgod4YlUyy9cM6wyOeIR4mjBThKeY3Rwi2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iaqNg8V+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9069606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9069606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iaqNg8V+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB/vVdtm1ti9+e078MDAaOjyHHssd91+hzP1CWZkiRY=;
	b=iaqNg8V+zt6C5Simttu6R13dA0O5IGK0pgTgFnsjdVujSr5gj3UsikBBtciiUYFSGX8jwz
	glwa5enm9LLt2JvlaBaYRbakPx5HJv+t+NS0pyh/QZVuEpU9U7QmqmVLM8K2TiFb9AGJgZ
	IY+vgtBoKT9jef3pc4oQQCp7KS+311o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-QOHWgguBOYKGdLT0ImWkiQ-1; Wed, 28 Oct 2026 18:01:35 -0400
X-MC-Unique: QOHWgguBOYKGdLT0ImWkiQ-1
X-Mimecast-MFC-AGG-ID: QOHWgguBOYKGdLT0ImWkiQ_1793224895
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53664602c7fso34509381cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224895; x=1793829695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fB/vVdtm1ti9+e078MDAaOjyHHssd91+hzP1CWZkiRY=;
        b=FoQBJpyZcxkWU85ogL81EMY707ETWIsQsj0fqApjk0Cvc+CrFXB/TGsqKbHbFG8gSJ
         FnH84pY8Qt5E2f2niiO34MdI/LwLSWns+NJLJ3KQJdESqsF3BkEkjAsKu5d74dIuUx9T
         FJlFoesmfLNUL02S1m/KKdneyZmmRcapuMR4Sx0w7UNIkiJcet7FosDD2SHLNSFXXUVh
         FcE39G8Wth2Z3+OaGFvnJl4ESiD/v/gG8WZkHza8WyQ4xh74VzkM8PBPfsfNoylHTq3Y
         uM79sruql7FoAPBtFWOyCnAtDkym2ZNG+oSIYoZ20ERKDc7RLmR0aevOuwA2Y7VpUnz3
         33yA==
X-Forwarded-Encrypted: i=1; AKwUvBxNX4KtZ8pPdxrhPu8qGG37M+0aevYoZfQtEzM1AfII4vGEATgtAP4KWbj+YXOmoKX0/OFKqLmtOBgeX1lbd4FAptQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9G6CPoIzmpMzA40nRaN7e8XA3yQppDBDS+MazU962R7OICDHn
	75WOOuIK563LEcys8xfHG92lYaDRNzV13ZKmvRx5g9yTyl8z+fHEvYtHdHwXHl+9yUbsa0dC4Lg
	vD3GJ100Ykjl1F5wTyCeJoPwe7naDA9FpPQgSkTrThACKXXPkutreYP68ypNYm3qUE6jviQi/Lw
	==
X-Gm-Gg: AYBFou1aGAqK3f80B0AnoApXZBm1ChQKimxxyNk0FxOLdqDZDthLTE6j9iDYPQn7m0H
	yDAgLkRaNN2aX28AfwitCGm40hWazGaf0Kbe6rNBuJKOWNZSo4nQxUL+PueSofkwqw+Ky+jngmI
	LPTWug7pA+1Is8ZaQyYkzUJB6AD0lehR+Ih128KvlH4T2xuZ5iKSMOGijc3V4PxbquX7sI+xgxZ
	Ba811NRHUFikhHVJAVDx/Dy98Q3xYlHHbhBCoaYdnSvKQcVW7fZVkW3lZhPJ7AVi4vyrJFh9Lr0
	6D/FNUnqmHDesfFM349FoKmWScmvhKCYllo7760D6iix3wll23D9uWLBxlc0Pf6XZlE1yzA31b5
	Zk/sgfN2ma/r9grYDK7RCjNfkDl6orrfZR3x1lrY0t10ghbKyNvR/z4n6FW5EKadR4WwyrhFnUq
	i0ZguoLiKlafxwwKD1MuWH63Snzj3H
X-Received: by 2002:ac8:5a54:0:b0:536:35e1:b5 with SMTP id d75a77b69052e-53fc8fac376mr65745091cf.1.1793224894734;
        Wed, 28 Oct 2026 15:01:34 -0700 (PDT)
X-Received: by 2002:ac8:5a54:0:b0:536:35e1:b5 with SMTP id d75a77b69052e-53fc8fac376mr65744421cf.1.1793224894054;
        Wed, 28 Oct 2026 15:01:34 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:33 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 07/10] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Wed, 28 Oct 2026 17:01:17 -0500
Message-ID: <20261028220120.4005187-8-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028220120.4005187-1-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LjORbZyx7C-HzjB7eHEoa11IqYE1mQnMmItWH7peO6s_1793224895
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass osn vars as the kthread arg, and make sure it matches where ve're
running in case of (e.g.) hotplug issues.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2:
 - Do it for osnoise too, not just timerlat
 - I haven't been able to reproduce this in a while, and I'm not seeing the
   hole in the hotplug sync that would allow it, but I also don't see what
   would have allowed it in v1 (maybe it was in some pre-v1 iteration? or
   maybe just a tiny race window).

   So we can maybe drop this patch, though it still feels better to explicitly
   splat if problems happen rather than rely on this_cpu_osn_var() blowing up
   due to the affinity being set to multiple cpus.
---
 kernel/trace/trace_osnoise.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f07b62a5ccb8..614adac25a89 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -241,6 +241,7 @@ struct osnoise_variables {
 	struct osn_softirq	softirq;
 	struct osn_thread	thread;
 	local_t			int_counter;
+	int			cpu;
 
 	struct_group(zero,
 		bool			sampling;
@@ -1723,6 +1724,7 @@ static inline int osnoise_migration_pending(void)
  */
 static int osnoise_main(void *data)
 {
+	struct osnoise_variables *osn = data;
 	unsigned long flags;
 
 	/*
@@ -1733,6 +1735,11 @@ static int osnoise_main(void *data)
 	 * flag.
 	 */
 	migrate_disable();
+	if (WARN_ON_ONCE(osn->cpu != smp_processor_id())) {
+		migrate_enable();
+		return 1;
+	}
+
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	current->flags &= ~(PF_NO_SETAFFINITY);
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -1923,8 +1930,8 @@ static int wait_next_period(struct timerlat_variables *tlat)
  */
 static int timerlat_main(void *data)
 {
-	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	struct timerlat_variables *tlat = this_cpu_tmr_var();
+	struct osnoise_variables *osn_var = data;
+	struct timerlat_variables *tlat;
 	struct timerlat_sample s;
 	struct sched_param sp;
 	unsigned long flags;
@@ -1944,6 +1951,13 @@ static int timerlat_main(void *data)
 	 * flag.
 	 */
 	migrate_disable();
+	if (WARN_ON_ONCE(osn_var->cpu != smp_processor_id())) {
+		migrate_enable();
+		return 1;
+	}
+
+	tlat = this_cpu_tmr_var();
+
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	current->flags &= ~(PF_NO_SETAFFINITY);
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -2077,7 +2091,7 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, cpu_osn_var(cpu), cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -3248,6 +3262,7 @@ __init static int init_osnoise_tracer(void)
 		struct osnoise_variables *osn = cpu_osn_var(cpu);
 
 		mutex_init(&osn->lock);
+		osn->cpu = cpu;
 	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
-- 
2.54.0

