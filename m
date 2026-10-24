Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806990;
	b=HddpWBn2njHu3mx+q2gpu6yBYVbKPBlrV4DP7fAb0CYcAXJK9SuaztaaJWCkMQyV6cOX
	 ra3xeS7+3FBRy5oGjSz7TIRcMld7JwP0LqH5IF00MMsOUNcg572Agjx1fgaommbZ0T0eL
	 C8VlQfMaS8uk1jwVNxBTdr0pEKJh8SIMTyIzHH4Kp35a50y5A8xvaOIWeLeW35LCu2Rc/
	 nbBr/VE9bkRoBkWK8PmKxEQyghCFogfA8Iakxgw2iLFSjdHbcvu0W18A8C71mU1Mlj9Dt
	 pu4LGnSDyokuZKyVDcZAmJWG+cva71XN6//tC6cnrCEY97u1a0UfcyhVGlxHvMaD17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806990;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=zL/ThqprNW0riwJJHSZnpYF1O3+j6d0hPH6PtM5aJBM=;
	b=XRmxQhkWCeTDL/f7+Xl2J6ey3FTqlKzIPMngQJ32ezgwBcHrEEBbByMBjZegTwr8+DO5
	 ovJ5bmuAQAtjlCeZj0/IWVHvs53PIyFT9aIHvygsosRMg9cGELdGp7HvgEsTIE7E60bLx
	 14Mg84OM/KO1SBlIJxZERrDzBk1Ml2kQk+Nsg2yOjIy++my5THQutumckiYw99+RMlhsV
	 BtXTD2Ch4kYikYPUMuOejAoJyfh95cfRScgRgCnl32ib+w8tAxgX0HW8Twn/Uf8aKPP+i
	 ncE5htOhEVjmbopEtZfyI7/MJhHkQaK0dpT6/jAG1ejo6sHY/1jiCRKuuURPKkIajJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PYhMSU03;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A67606A321
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PYhMSU03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL/ThqprNW0riwJJHSZnpYF1O3+j6d0hPH6PtM5aJBM=;
	b=PYhMSU03AkAFujYOk3SBQ9i6XK2gJtwWO5WYLWcOidvgfCZ41kY/R1lBP4lLT38VXijfv3
	CMAjuBc109D8ZUC2jd87kM+368AW9fn5Gr00jrMmaIB7QChvMOPhkL90NV2XHzqDQTPwUO
	kzQPIKV2K/Cqcdcpeq3Qp12sgfKSUKA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-boU03zlqPJaH8HAKZuf0Cw-1; Fri, 23 Oct 2026 21:56:25 -0400
X-MC-Unique: boU03zlqPJaH8HAKZuf0Cw-1
X-Mimecast-MFC-AGG-ID: boU03zlqPJaH8HAKZuf0Cw_1792806985
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91bc57d4d11so37077546d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806985; x=1793411785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zL/ThqprNW0riwJJHSZnpYF1O3+j6d0hPH6PtM5aJBM=;
        b=Bxn8ZGc7uiGuhxGWc90H4jvou8Rlk6kmz25wo2sWkSfE1sbeBfDyZPCUmIhszkWBKd
         GCVzr1jzSHb973DyX4U1HD8UnSp4F3kk30qO7DWnkipYGRrTFPRYT2Sne7yOo4eGpXuy
         X0gS85vvkUl9itRu6DQ2iRFIE3JkiHW0sfF6ncJpzcmZb7f4oa+R3YCllPNxeU5vViTm
         CHbH1N1VbUtBCcMQtNruobTZATR7CUui8cr2H1xqTgb8MRQvg7l102Hx+CORhDsP2QT+
         6GxPxyBcUxfRootOyrywiAL2OL+BvfFsdaILZ+2LUuAf3nqOlC5Xi1f6Nqvk9pAgUgpN
         q/6w==
X-Forwarded-Encrypted: i=1; AKwUvBzwKy4rhbtUQ5klV1sBFFdN8xYijo5rlMEaTrIBMhYGpuX3Uxxic57vxfCT7YQGA176MdvE92ujjr93PbE8GuU1djE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCCXuVwaB/YSAUN+3a2fwN+AKpU1xL7hxuh+0QQA+DCpkNJnt6
	x6XK7MX4P4LRghaL/idjESwaE2h4H1cYyGFquw3MvNFGCGSSV0XAw3Fg18CmFOV0giGpWHuDAuM
	hU8M/6eWPfVAk7K6JarZuWEHJ4rONanCcPHCbBxkWY780zPPmWdqFJf5IVItOWRILcse3+kw8fw
	==
X-Gm-Gg: AYBFou21dC6W/krwzx/MOQg9RadYNVz7TKNYpWO1YkqLkw+UXP5s+YD7fex8sF6xQIy
	DqqQDqRWi/tncE7tICN88BjTNlOP/x2/5qzO1KwhLWvt7E0rC3+L6a2vEs4EJnBIxFDsSStaa9H
	Y0aYvAZ555H9hS0GJhFt4A38cbzGyS3dgKCOFgO7tUFpycukN1bFCwxlLmpnPT/KkgTf9N8vhIq
	8vVVejgBB5CNQc3+q+23nvavSdGsP0bcAuVom1cQDYwg5Sac6DXMnJq4ocIVH5oHrcILZ3rTDmx
	XdxW6UHwmqGzuVxpsALFJ/87QY+mgFoA3kxicAsR8DYdemNc5Pzg+KOaHwzF/ZcsGPaJMq5o9hc
	LxFTeRfUS5wvlVqDCDAeFKxkQPT+9bQdBdiKqY5Wopx3L/TgRsNdTMQE=
X-Received: by 2002:a05:620a:6088:b0:93e:795c:9d07 with SMTP id af79cd13be357-940ef92b335mr133038185a.35.1792806984871;
        Fri, 23 Oct 2026 18:56:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6088:b0:93e:795c:9d07 with SMTP id af79cd13be357-940ef92b335mr133037285a.35.1792806984430;
        Fri, 23 Oct 2026 18:56:24 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:23 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 5/8] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Fri, 23 Oct 2026 20:56:11 -0500
Message-ID: <20261024015614.3095251-6-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024015614.3095251-1-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: RMnwAiTMbv2J1YEs-b0KYuCJdwVnSGM3pWJ0LqXD4GA_1792806985
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
index 117937d7bf88..9206123ad445 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -236,6 +236,7 @@ struct osnoise_variables {
 	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
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
@@ -2076,7 +2090,7 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, cpu_osn_var(cpu), cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -3251,6 +3265,7 @@ __init static int init_osnoise_tracer(void)
 		struct osnoise_variables *osn = cpu_osn_var(cpu);
 
 		mutex_init(&osn->lock);
+		osn->cpu = cpu;
 	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
-- 
2.54.0

