Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552081;
	b=d/aRfj8CQO03lwJ1OtV2lXNEce52l/0QBNpYp+igS1+6AmKUDw9vhZsFBlVwnZ6cLDOL
	 Vn1L7I6DmqOCVyqawSgzFaW4dfieDGi34fFu2jEicLhQW0bv8T3YAxSPZ6U8qOyodxX/N
	 ddDqkzAdKVcPoQGL3WI5PmHhE6Tl97t3lIYcx2fv8gGf8xhCbvSnsuBzEcsjHVNbVDhYr
	 fJt0/8cOiAPIelvA3xe/hfymATeUSROufpq7VaWYJdyPnwe2xPOyTzI6Y/DmuwNIDfhzo
	 OPcXUNER7W1g946yoyTFKV1EuNGo+hepMpXuzllEhFIAKhDURKDF460AVeH4A8qa0Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552081;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=UwoxQyG/4Rdsnau0/lO7JxrWr/d79qWON3lk5C7IjXo=;
	b=oJe2bBArTFxZUS6pxCp1FDwpBiAvTkW9tS/1tFylIXamggYyOojdCyT60Yr8gkWu5Ass
	 aYqTQdUSupNNgYfeen7ZUihL0qd6ztj+GluurTva0ctNQQlro7qF/KTHVoYG+W1onARwY
	 xxU1yPxvz8QEAfQLSBl0cqSDJgKrW3I6G9X8HzXeWYnO9Ie6aAzt9ngdatNk8upp8Qq5c
	 cBqYKhwnIApPTbhdqBbncMntdztgNsZwQ8uIExbPgxp3zOGO+loMHLUK8nED9CDvdhjIj
	 LSG7PtpYcgVFDQQwY8CJ6Z/2i+mTtlgZlVvwXsYw6xlQsEy+IhAgl1uaM5+IJ129jyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tp98gJrS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19D606A33A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F19D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tp98gJrS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwoxQyG/4Rdsnau0/lO7JxrWr/d79qWON3lk5C7IjXo=;
	b=Tp98gJrSNFfUUmbR2pTFJFOgt173nDDp+tbXg9iygs20WgzRk40wfKbVIKHRucsowD3hoC
	HconUAdKXF+/yi2GuxzWbvbJ68CZIuic9EGwYaGWtiuGBtVZ/T4vFtnwIGrfIiEyC76Zl/
	5mmsXiaepW2xTiBuLGOeoz/CqCVHKwg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-jE9brRWSMF2SrLX_A4M1cg-1; Fri, 13 Nov 2026 01:41:18 -0500
X-MC-Unique: jE9brRWSMF2SrLX_A4M1cg-1
X-Mimecast-MFC-AGG-ID: jE9brRWSMF2SrLX_A4M1cg_1794552077
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-83edc5c5ae9so357901a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552077; x=1795156877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwoxQyG/4Rdsnau0/lO7JxrWr/d79qWON3lk5C7IjXo=;
        b=IMwWJ4WUd2Fv6wSFBr3Qw+by3g2yhPCPHSjYUMNhjRs15rtpsnaucQre3ipRFrhr32
         bZQ0/vyiB9xqjc37m+dg5J7fJTAHXRkScS3CdSPqEGtls3vsDf3ce0ASOAXtSE/A8K4m
         WJR3EMmYYl7yHRixtiJ8I+rXsbark5ItQ9t57Bs4tL1kC63vyvbAt7EF0jhzw11eDW/l
         GfaYipD9A+XFVPmkWinRkyvk8ypZdqZiyP9PPF6z+9y2oklQginjiCpAQzv5FfWfVqKL
         mYsaVV09uN3Sq/A90Qd5+jQZZWz/kxs3rIdDKRIWd5+44FU+axifm5dXrmlk4qFxL1ut
         Kj0Q==
X-Forwarded-Encrypted: i=1; AL+hErGgT42j8vBdVY+2EQTEnXKfp9WNTSjRiI9argKwdXipIWNZa0bDGUjAR4AAmM6B3IcJeFCRJbvVXiM0wvBa/7+WzTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8svozECXLunAr1qWy1sSIOFlNKmPXGRBH5wU5Pp0YMCsUUzx18
	PGfiV0SjQhvGuXoiyNRiC8lPCdnq8Mi8jhcUqe8u6C6wWAmu8CXaQXN4cBqfr6UlFdRvIxTNqPZ
	N3G6CcZ8ll9M6tU06dt6uGxsvqpE0J2JcPku03vpD03cp0VKeCduKuGsJ2eq9lp1Fe+sgInDCAA
	==
X-Gm-Gg: AYBFou2eH2PhNSKEBLfLEFb246lsZ7QFe2akXr0xOO4dVwK+zuh6vGBlBJkRxqCyQHC
	ejfZtYe3ukXQOC9hKXoew5Qis+ggWewpfB7SSJtgmqINQUB/jt6ToAAhZXP+vUcfgjy5njrceqy
	AuLFFUGEyL9pnGGWEWeeMFRcWHQur7ERX14sH2hrfMjrdSM5s525xK/SkvyqXDK102LRP04cddt
	XaDfNRmJ6v5ygsf/0QB0HnEJc2yhfhsGmCDZXDKwnz4JZiE6A+VLw1pMZjqcPRHGSNthGzzfi6u
	rP9Uc6l0LFpVttZm418841+ucLE/yUHKgjkeQcNTV9CTfPXlJnLSdAjYlVefYvv6ShPd8eq2egr
	7GBiFrT3FVIYrp8WBpFKf/RMEXdgJXp8J06uv0h7UxB4efJpHc9uiyDyt9YsU3SW6jY5qFStD2w
	8pDh3D5GAYASIoaAMIcvtaHo2WWGF2
X-Received: by 2002:a05:6830:2695:b0:83f:f24d:fe19 with SMTP id 46e09a7af769-8628979e65cmr1403848a34.3.1794552077239;
        Thu, 12 Nov 2026 22:41:17 -0800 (PST)
X-Received: by 2002:a05:6830:2695:b0:83f:f24d:fe19 with SMTP id 46e09a7af769-8628979e65cmr1403838a34.3.1794552076729;
        Thu, 12 Nov 2026 22:41:16 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:16 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 07/10] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Fri, 13 Nov 2026 00:41:00 -0600
Message-ID: <20261113064103.3041704-8-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113064103.3041704-1-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9YCyWEAezMC-w8Kp3Qg2JoijJW_6tDK_PrJM4_Am-3s_1794552077
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
index 8db0697b69e4..a81992c937fb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -238,6 +238,7 @@ struct osnoise_variables {
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
 	bool			sampling;
+	int			cpu;
 
 	/* reset only when the entire tracer is restarted */
 	struct_group(zero,
@@ -1729,6 +1730,7 @@ static inline int osnoise_migration_pending(void)
  */
 static int osnoise_main(void *data)
 {
+	struct osnoise_variables *osn = data;
 	unsigned long flags;
 
 	/*
@@ -1739,6 +1741,11 @@ static int osnoise_main(void *data)
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
@@ -1929,8 +1936,8 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -1950,6 +1957,13 @@ static int timerlat_main(void *data)
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
@@ -2083,7 +2097,7 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, cpu_osn_var(cpu), cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -3238,6 +3252,7 @@ __init static int init_osnoise_tracer(void)
 		struct osnoise_variables *osn = cpu_osn_var(cpu);
 
 		mutex_init(&osn->lock);
+		osn->cpu = cpu;
 	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
-- 
2.56.0

