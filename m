Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806989;
	b=oE/xVQJMWTUHRP1mwkzyYuLMLU6D4Ytma8ywQiVNxGutwmNVyvU2Xln7aESN2i3ZsijT
	 PnGjmAShLbppGx7wtpK60yqI9vK6gEpKhcxB8DkaVHzDoBOR3e6o0AtiD1kRjm0BiwdNC
	 rmDANGsn1++93ZlqMI1MMe2Gg4FvpkrukDGggnyPT1vW+z/kKFQ2WEcaqxmDVFOEV3Xda
	 igmjQId0pWfURgviYptMBPFoS78yLUlh3c6WY7olJUK/MPSvCynbUhZ1HYoweMHyaraC8
	 Jg574HlDTbpRTLDddmRIab2ZaBjIqDtyJIUJqYzLY54+nbHY5OYIkImqyzS0hnzcm+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806989;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=2TEyJRBsXJcLnK2/4SLPefxwt7Ir7ZE03eNQ5Ho1euk=;
	b=KyWcE6WJ+c/n9C5LcSUSw/F/L+5i7DgJtTVHXN3xm00JIOu3rEMbP22DlID7r4DrPZ3z
	 7YsIgEnww9OfuATW1h16uH9JjrxgIJmbN8JTsPWXw+/17avK+TMYMF19oWJaERrI2XdUg
	 wgA0BVfSGTTNLBRSLbTQ4O5tcPlOTR7Bcp2pkURSokbokKIH4wqW/gKBwXlKxegOKG28Y
	 Q2WsRCCPOvWc46UKTdHJfXR1D0vkpVYr45xEcZvufiNUKqcM8hdQZ3VYNCo45SpvXtuIy
	 XLiOSudrgudAsf/ct4Gnm/hStTb/5yXb1Ge0n7wj5rC1MY5VOevKnDUI+tS/yEATLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MtpQu8OZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFA606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MtpQu8OZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TEyJRBsXJcLnK2/4SLPefxwt7Ir7ZE03eNQ5Ho1euk=;
	b=MtpQu8OZ0MyImSZD0y0HA0UBSt6oxn3iC0mz40ynP/MLi23JRkvc6HUYeksbt0f46RvNjd
	HBynfr5+xWAyMLa9/jEtUMgMkRsb5Z8+eA1wBWs3XnbFQX8sKIngdPNpgPQ/5Pt2zd4ZZr
	/tNRXxbO/Up+4fRgxqb5kXCZA3j9P3s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-8bsOyduiN16L9lu65YmTwQ-1; Fri, 23 Oct 2026 21:56:22 -0400
X-MC-Unique: 8bsOyduiN16L9lu65YmTwQ-1
X-Mimecast-MFC-AGG-ID: 8bsOyduiN16L9lu65YmTwQ_1792806982
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9196b477c4cso30350256d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806982; x=1793411782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TEyJRBsXJcLnK2/4SLPefxwt7Ir7ZE03eNQ5Ho1euk=;
        b=jumVs8W6FOgLVHmJLCt7DsH3SiI94dCGteWftPqKABEKvGlLvwkA0BDr7fBC7+LJHK
         dfLLOZBmvT8ObSenGw/fDXD4FNru8+Vssub9TOcFgcKmsckqGr2KL6lqWCoM22HHVbFo
         8Pi3O63HBh20/RoBEOSU5NhpZfEEnIRivfhI8aePlQUaespY2rK4MLQpMqG60QTFi6H9
         VbyVLXp7SBJyN2rB8gJQPjxeh3sKQ2gVAuWQ8PxuTrxrbkcghJQW3zZ52O0Qf/vT66qe
         nogc13ChX8cbWjydTxi/eGIjz95wzbm5CCevBEqEfsehoAFst38WDkGpSMT5ycbxeY2C
         tM0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwI0g6TBSFqDV/BfAKLBnQ2Itehl5jH8vp2pyUj8Npbntv8TrNWm1q1Zo49esMZRg6r9BwHYYuSU+pUQ9eFc95jBaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkdUSAeiCb2BbpTPu3AgY1D+EiXZyVZ8KkgMB4UC42BI8t13/o
	6dW4qN4DlqMEABXz6cmUQm+gxQRB53Jys4Qgmo0GIYz8rC+wkt1cfgQH4BY+/+KnIiTAkDuHxRd
	upMrCXrnGvBBp12xkhNYZMnyRbtNfSeBosCDRkwwa3oxYkwi51tuDXqN6YoJzXwClsu2BN6VqkA
	==
X-Gm-Gg: AYBFou3KW2cYl7jkSyf0fhArDNe2Q3E+w3UTBBIMMZ5ithiSW62vhvhT1T/2A3kkOR+
	q9/X61N5Lrt3HnIkLPKqA8FqaZOpn+L0EAeA2ftRlFai2pZqhAgr+2cBjLa1wpuobP701gjVsRO
	8uyKGgExBeUIN94so3eya6GFAikOFNlAb+EioYsae91jX/H1Hdvo2ux0nUMy9/FAUzD4lR9RZx7
	eZ3dl/A51MU4y5CbF8Jygoxc5/6VGhHcwKJ6XeTew0or3WGL0miYI/sy+5umWlPvvks5ljeiRVp
	9kd1uTp1zTvyeXQMojAfF9W+4qMni/fG7w7f0zsYS2pq8wRV8G8nJ0SuuqrB4PpiONjAbfiXjCI
	dMB8MXCxI9wTP699dth+/vzEQT1ymud8/Vs4UidgktGwmOn2jm8CvHJc=
X-Received: by 2002:a05:6214:2f8e:b0:91b:dbaa:4f6f with SMTP id 6a1803df08f44-91c48efb050mr10434386d6.18.1792806981931;
        Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
X-Received: by 2002:a05:6214:2f8e:b0:91b:dbaa:4f6f with SMTP id 6a1803df08f44-91c48efb050mr10434306d6.18.1792806981500;
        Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 2/8] tracing/osnoise: Start all eligible cpus from hotplug workfn
Date: Fri, 23 Oct 2026 20:56:08 -0500
Message-ID: <20261024015614.3095251-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LHxelnPaegux9zuTfdFc-RGRFAk-ftH4YUp7m5oKwJQ_1792806982
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Previously, a start could be lost if multiple cpus get onlined
before the workqueue has a chance to run.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v5: new patch

I have this in my notes as being a Sashiko comment, though I can't
find the source now.  I wasn't able to reproduce the race given how
slow and serialized cpu hotplug operations are, but it's possible.

On the other hand, user threads detach on cpu offline with no mechanism
for reattaching (other than userspace figuring it out and reopening the
fd), and you really probably shouldn't be offlining cpus that you're
measuring with tools like this, so you could make an argument for removing
the restart mechanism entirely... it'd certainly shrink the potential bug
surface.

This also eliminates the need for the "Always check OSN_WORKLOAD" patch.
---
 kernel/trace/trace_osnoise.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 953936bd5eec..0e744652946c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2122,7 +2122,7 @@ static int start_per_cpu_kthreads(void)
 #ifdef CONFIG_HOTPLUG_CPU
 static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 
 	guard(mutex)(&trace_types_lock);
 
@@ -2132,13 +2132,13 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	guard(cpus_read_lock)();
 	guard(mutex)(&interface_lock);
 
-	if (!cpu_online(cpu))
+	if (!test_bit(OSN_WORKLOAD, &osnoise_options))
 		return;
 
-	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
-		return;
-
-	start_kthread(cpu);
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, &osnoise_cpumask))
+			start_kthread(cpu);
+	}
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
@@ -2148,7 +2148,7 @@ static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
  */
 static int osnoise_cpu_init(unsigned int cpu)
 {
-	schedule_work_on(cpu, &osnoise_hotplug_work);
+	schedule_work(&osnoise_hotplug_work);
 	return 0;
 }
 
-- 
2.54.0

