Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B44457C6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015704; cv=none; b=BuVJN5xWhM81Uy2DZlHX2U0ekmgUQ6gMKc8Z84UpTZhWT4b2jsXbqueIcRzQvruuYBNeRZyrJYzPEjWJcwEdBBrsYW2vip7oaKQ4FJYCRel8FdYZthAhOl7QfuKavqTgiUKynjb3RGlWXmLA9WlkjBHi0+BwGFe2aiGibk/BfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015704; c=relaxed/simple;
	bh=sHpbWqaRLL2zNw5lN1OUaWMEph34v3Ha7YhDMyFJz6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=F6Iflbgk9EILw9rG0oXyUnhK9VUGwL3xKDvqZtOJ+r7PAyJvKhxDPMqz+dlxec9bE/d83jj3bROf+5mAirz59ujHt7GKPWbRXxpCfauYF1huCz4bO1Tzm+dqG4nvrU5IaS157c1kDfQX3W1+jUe33v9MHRVMUlJikQ5VtTMGBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fl60uTyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl60uTyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMARktDLNbK9lrC+azYNeDahco2ubvm2SHicW270pzk=;
	b=fl60uTylVZgdPXk+BwNqYQ5buRx343rly5FK4MMKA8Y1WcgZ2EflWMKTju2Ig88DXACF7x
	0xUCouglkB3WwWz+OTX4+nBqoCCPspZEua0WXfMtD1g2ze4G7mv+uFC5yirM30Vo6Ntz2C
	gerDzTDCgnQRKcFPqRflGNl+wk4q69Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-wgZyyD0MNBmxjHniiJG6yA-1; Wed, 14 Oct 2026 22:08:20 +0000
X-MC-Unique: wgZyyD0MNBmxjHniiJG6yA-1
X-Mimecast-MFC-AGG-ID: wgZyyD0MNBmxjHniiJG6yA_1792015700
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5358515b4easo85844671cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015700; x=1792620500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMARktDLNbK9lrC+azYNeDahco2ubvm2SHicW270pzk=;
        b=M/R/Lp0ucigHwaE4u/6vZLGGJ2gSXRxM08t++GFW3CEfxI8rjpGFk4xlkkGEXya5H5
         jXxembA//Zbn/xzc3YUqHDS0uwLVS6jh07qLtVntCXDRm7aemgSvrLte21M/ajj5cZBA
         SBE8ABXiJ9s10pa8yagnFWnSpyuWhUbGyf/4qMbihry4vgyYRNtJAipmDgix/jR3iqUb
         d5URw21KZGki2Pov+nX0y0MlBwtYwhwgRvc02dO/Xhc/jovVgU/nvAoXT9PiCEDYorkH
         5qi5TEc05/MKRg7mt+JQEXR/EiJZ6NbavZd44iBEns1bmiciC0gjp5xdKPoMumxDGSw0
         /IhA==
X-Forwarded-Encrypted: i=1; AKwUvBylGlG8CTN5sjkCsLANsLgx0dloxylB3R7icsAhRUMMdw2mzWglrjjIW58gLyVVIGNB4rq3Rxp2p0/wQg27Ts4OPu8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvOOK7juoI746q0PjkwDGONCcNArQhu07WkJYFYqirtbkLD6Bi
	ic3eLd1Cw/tVbX6/7m7gynn1GH0Mpm4jWnodl3zO4EWDbnUtnzDuCRhJGmYoViWJTaBWRhSwCFN
	M4szGdmoSUjbwdSBuZrBu9nVJd+68Ib7JUaQHRd/1JReqPvyYoYaei4jiTzJp3KGuNJsVwwpEOZ
	ErXsBVuw==
X-Gm-Gg: AYBFou02klZB6aAjrUDcjAl5QFmZD5Sn6JaE7DpLcfH856i93fWjem8M1nZFr7VjEIG
	ntD7H0r1W3l0rJ38ffY9JquBVjweJ4KUsqcXjyOn/faaDZtOYIuo8L9rPobogTzfHYFHpVawmPp
	+Ndnu20o+NYgRwnCE1W8HjWTvLW4dq4rvtm+7mO2dPUPuxp6XkugNuiKCIMZFwwsGFv6x75nsoy
	y83OsFA38wPRV7W4EYW4CKO43VN687piv48kQgdLvS7NCUsVagGRwWQVqPLOdy0258XTyas22VT
	kGjZ0HKdzuo/YXhlmY5flJgMzmXJxQp7sR54pfsL0Qm/seGsvKTQ1iExpP1nn86ohVWTQNuDjRv
	1zpXuOKj19ESacfcVWxPj5bxoVAha4RBTWkvZzW+B2aRBPX7kBjVz2Bg=
X-Received: by 2002:a05:622a:4c7:b0:535:2e94:ba13 with SMTP id d75a77b69052e-5359faddec8mr291719921cf.23.1792015699782;
        Wed, 14 Oct 2026 15:08:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:535:2e94:ba13 with SMTP id d75a77b69052e-5359faddec8mr291719571cf.23.1792015699332;
        Wed, 14 Oct 2026 15:08:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:16 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 4/9] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Wed, 14 Oct 2026 17:07:54 -0500
Message-ID: <20261014220759.908839-5-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220759.908839-1-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lO6OvlobcegwDjciu8aL0ftIj4hToG7OpEvo29QOWtc_1792015700
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

