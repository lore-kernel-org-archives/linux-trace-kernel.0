Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D10306746
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944824; cv=none; b=bt9fTY8gdldKKYzOpPzMuFDihtz2XzjABDux4lLf+aIV4v5rBwTz5yPQi4bad1ronlq62w/gtG666ecB8ls2Y6oyHuGEaSmFVm6H7r7ARqoIRZ1lIfY35/qe3HBUWl2c3dfpDm1jtpWsOfsA61UvP66aqqNntQcz6dyz5QJkEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944824; c=relaxed/simple;
	bh=sHpbWqaRLL2zNw5lN1OUaWMEph34v3Ha7YhDMyFJz6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DAEKYjJF338tfDWQzIi/qoR6pFUU4Zo7igitfdDSlnRVIDTM3jKyPAYGTOrPnC9uXtTEPIJg7A8PIk+h0tPm8pnpVDsgiOIKbv4p8Xkb5T+itMUMlNHNuk4oox7xmPj0OIVcDrxXA6Hzzw8run1pmhYJwBPN2c8CR0SpD5j1EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d25036Mq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d25036Mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMARktDLNbK9lrC+azYNeDahco2ubvm2SHicW270pzk=;
	b=d25036MqLq7S94XltLput7dksMrarSd+xk3jt6sExJeqD8hMvnn73SIN7D06uBymLaTYp7
	ZSmMb+AnIWXrA049kQEqF1R3L6BfOjQA8sUW2nV87PwDIn24qA/eLKmnxXTc82npmSfvJT
	eTUuaYxcJAy1jqN5Lksj1m7Olj4LVOQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-up2z8Qh_M3mkKjWNJq-1Fg-1; Wed, 14 Oct 2026 02:27:00 +0000
X-MC-Unique: up2z8Qh_M3mkKjWNJq-1Fg-1
X-Mimecast-MFC-AGG-ID: up2z8Qh_M3mkKjWNJq-1Fg_1791944820
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535066512b0so104964411cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944820; x=1792549620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMARktDLNbK9lrC+azYNeDahco2ubvm2SHicW270pzk=;
        b=0Mj4OM0hhs2gMuifuvlfBb6pJjqZH6qs+XEHqsgPOwtVqZL+s4brRzAGnHjEXgtYae
         2h7uNCTkOjYsmgkn6NS6teyeH5X3VOblmHP49nyClRx7mdgEVtR7jzx1TkeE2+BqieKe
         /pzwJbxDPihkDqucd2A6FrlrL6Q3drbWm9heN8HQswWrlPOcozRrBXbIhyaPxYADwa28
         vZF8mFukuzoa1foF7WOXs3ExC9mDozLEuI+iVhBEhCElXOVZsZuGioo5g6BgJZ5TRuh6
         jnKXWmcLLeycEj31dzdUTjeKzdDZ2AGlXM3loy9RJVLTgYcevyOJdUnXuvFswhfnWmDa
         iQww==
X-Forwarded-Encrypted: i=1; AKwUvBzYvGl7c1/naKDl2srOab6JB/+SVOksukYuIiowIka/fEv78VExPel029cqdch6QWy8CD9eN45puUxt0e5TxQ81gt0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIa5kepWnviitUkkGL5JMYr5Hb+n6U9KKF6PrhRuy6NcE7hSsZL
	NBvA++GmuTV1gdd+dSryJDC8VBAEABK8fYIc2z4QORS25fYXIH6Su9pR20Rh1j0LbTxwmbCgSD8
	uEdGDixylT4uOizfKhXSCYay/TWRXNNhYTtC6dlBKIq/pPLH9iNtFigGp3/FD5z11943eRaJvCS
	NL0FjWcQ==
X-Gm-Gg: AYBFou05wTJuVz6AKQmHYddBHf/4VKGVQ2ggw8fohbmIZPV8ftvnEwqH6ZJrbzx7wY4
	+7TdwJR2HD8uSw1iNTorDPhpvfYeTNlZCXQZx039vzLgh94zN657pvEyXL5hVfN30aMfIjSuZWL
	pn+oIoMzDtX/r3OPeHT42Mk41XpBpykON3PpTynFr8pXhlu0jhihM37GI5Ix4/QqIUgYf5iLshp
	Lhellh8wwL90+i8BbB+dovIskuo7VkHwoZKFRRrq5RZ7zaqwwYvWrdTVV8Umg9ZRS9Fab0TePZP
	RQs5D/mfWZK2XbqjDnVFgoVDrhj7DNMhWDN2rNaJaHSveFkUxsxUQQH7P7PHbOvKAXvB4q6zX6t
	Cl4xY10dQsxT9Ozk+CNOkRwy47TZmCkRB/zzhkMgco3GkwX2RJYqO2wo=
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id d75a77b69052e-5359fae42c4mr265493611cf.27.1791944819997;
        Tue, 13 Oct 2026 19:26:59 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id d75a77b69052e-5359fae42c4mr265493441cf.27.1791944819417;
        Tue, 13 Oct 2026 19:26:59 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:26:59 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 4/9] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Tue, 13 Oct 2026 21:26:35 -0500
Message-ID: <20261014022640.695786-5-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014022640.695786-1-crwood@redhat.com>
References: <20261014022640.695786-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K7KNkjD8Ri9syyuX8Tm7k9SI6BgTTSClnDaj0lSxXSI_1791944820
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
index 20b0264e5adc..202d7b4254bd 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -236,6 +236,7 @@ struct osnoise_variables {
 	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
+	int			cpu;
 
 	struct_group(zero,
 		bool			sampling;
@@ -1724,6 +1725,7 @@ static inline int osnoise_migration_pending(void)
  */
 static int osnoise_main(void *data)
 {
+	struct osnoise_variables *osn = data;
 	unsigned long flags;
 
 	/*
@@ -1734,6 +1736,11 @@ static int osnoise_main(void *data)
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
@@ -1924,8 +1931,8 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -1945,6 +1952,13 @@ static int timerlat_main(void *data)
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
@@ -3254,6 +3268,7 @@ __init static int init_osnoise_tracer(void)
 		struct osnoise_variables *osn = cpu_osn_var(cpu);
 
 		mutex_init(&osn->lock);
+		osn->cpu = cpu;
 	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
-- 
2.54.0

