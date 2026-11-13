Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552075;
	b=Vs38pxNtJ9jII4FeXzVzz2jPdJp2+tCVItfalWCb6LFa+ErOqV1X3bOzC876PPM9NrlL
	 4j8N2XAKLt9c69XNMXHvX/vqPe5y7+WN6BQz+XzN9U1xMXKz+V0cpJaxo4fJM8QRtGudC
	 TVv/Ut8FE8++AZ9dmAHXhIQ9yUcjHcg/jbtMZCBs+DYa/UUAsBXhjLawdXWucL94jymDC
	 webqvEaMKIZZ8IMwlwZddDF+u1xWnSvNpqc7F6lr8j7qvvglZpOhF4qbs7dQe4ouJiTNj
	 aic0Qzd3VSsJAmD87uInE6EduW7SSlJ/lNPlCl8mJDHNqVUeFROXCzQy9jIJ6mAbd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552075;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=TekMeg0S0zTfGCS1adFiO2FSQbbsvfqqOMMBI2NtJtg=;
	b=mT++aSOjyllZM8vC6tuo3Bkcl7RBQ9sL1bZN7F+PZFP+SPgz8A5NtEIY/ushVp7qHcth
	 MlK9xX8Mf02w9LaPDpMsESZ5n1ZBHfqC90sBMklTALld95CD5tJ6SXB7+R+85zWpteLYA
	 Y+wa/Z+kkyl3hipTw14So1gAPeg9+W8e/FF3MkedQIT2DRspQq6TNSB1fZqNGDygq6iHN
	 pUjw1K+4LTgJlWi5cmCuIob/quldQFkXmwTGZfZmqHcrr6T0OWrFBqTjM21auDNppdjb/
	 +Su4AW8FjGvTtGUe6OzOxi7kHDiBrLKDEEkQ004Wh+zz8bYry2pPBBsJzBlqw86hRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZWtSWKMP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECE606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DECE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZWtSWKMP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TekMeg0S0zTfGCS1adFiO2FSQbbsvfqqOMMBI2NtJtg=;
	b=ZWtSWKMPZLHZonql7FEuthERKHnJFZET4WZMmz4K8jsQx75DzTqagMjDVv8DhhUz3fHKWz
	5YxyubaUk/IuiLgoeyGJdOykFEFLA6xTOuHIwEry5TuiVHuZMmOopx/KuD1jqBifGvEcYF
	wrjcE9+TllCbJ8G1KfaDKH2DZ+2R7MQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-HjCZyf2NPH2ZzfOu6At8LA-1; Fri, 13 Nov 2026 01:41:13 -0500
X-MC-Unique: HjCZyf2NPH2ZzfOu6At8LA-1
X-Mimecast-MFC-AGG-ID: HjCZyf2NPH2ZzfOu6At8LA_1794552072
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8490253aeb6so712886a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552072; x=1795156872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TekMeg0S0zTfGCS1adFiO2FSQbbsvfqqOMMBI2NtJtg=;
        b=HV7Ba1+iXqlnxB/1PbY7aeYfZsichjdGVKJJMUgCjUl6t9GIoX90q0vfY52U1V1djQ
         2EhjOvqxPGHfVfzqb/dIVUIverT9N/2s/yEWHaUyc2IPLz09BUDmxkCs7H7BIugqNbaW
         5EdJ8gYhFtYpoi5ReY2UJqtqGM6AyvhUwyVVsg90WP682usmc172TK9rA8OL1fTByB2k
         iw3UMEcl+PvJ6LlLWjUOrpWdcOyLFlmIIUP7IDpb7tfOmPIZUF6Sx+8V2k6r/mFIc3lz
         /3tENPciqUTrMLKwzR4HtRvQ3OJ+AiCEKiAkW6UrPWJ4WZBQU4oUrfO8kDYQqnQPbJYl
         rv3Q==
X-Forwarded-Encrypted: i=1; AL+hErFH7w5m59guh2DBw8AiWMhYZ37MOuAaXXkcIyl0rmkVWQoQ5T0ud8uuG/Vytvw875Y5WYBn3BhA/udKxCpO0tSjwIE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xmw4p6XClSzQjmPyXOWQVJu8IZKD2aS4ljVqXDhLG3xNzLD9M
	8KX7dA+xFho53TWMfsn33rc9axW1Rch/688WkMAYM/9iPS1ylKUJEKuxfpAfkZs04uKbQI7ce33
	Ap0BQV8sqVpgjBnyie3oBjfDyVUQAgHHnmDZX1t2+qzNv33rYPUBPHaPgH4OziyoQGgFxX6Z/FQ
	==
X-Gm-Gg: AYBFou2+EEMsgjlhapyXKe88Lg9d6d3BbbSNu6jc/nTmhi1iup2R8QFpN6iBwKC/SCn
	ZJkF41PeJpionwOaoNI5HJmiibYoSKWEswzm5N0h2uTSzn8EJk7flbTwWRYvTQ2It1Ld3BeF4Pj
	o/EdMY0nao6hL/TIflFaOqtuJ3jbq5bvMuo9DZdiYLr33Mrq/xCVYKQDProRsn5xaoAmZgb7t8A
	Ls3sf46zIFjaBp2ndLxcWA/NbBnGd63DER5t8zlToaaJT7bVC5iL9wMHgUtmgrSzWfNhDDDsyaT
	jc9hTnZ2V7j/7CeFKwKdsje4ktvuN49der1wlKyR7CA/p4oVWJj4KA+fOFZCGCX5ICPY3on1avS
	gafk0p6acwhlrwT+mgsYXuTPkx4YBpUgrm4QiDDk5TgT6KNjwd1vaVYiYE8jHxALdzDf2XyPoCT
	nzLIkBnAiVlvkLKM+hgjlAEV3tQbve
X-Received: by 2002:a05:6830:230a:b0:861:5b79:820b with SMTP id 46e09a7af769-8628990df7dmr1471654a34.30.1794552072113;
        Thu, 12 Nov 2026 22:41:12 -0800 (PST)
X-Received: by 2002:a05:6830:230a:b0:861:5b79:820b with SMTP id 46e09a7af769-8628990df7dmr1471647a34.30.1794552071722;
        Thu, 12 Nov 2026 22:41:11 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:11 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 03/10] tracing/osnoise: Start all eligible cpus from hotplug workfn
Date: Fri, 13 Nov 2026 00:40:56 -0600
Message-ID: <20261113064103.3041704-4-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fRHY7NfeBJX8tBO1wuUf2dyMuI2KshM_25f1B3YUHiY_1794552072
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

v6:

Removed the OSN_WORKLOAD check from this function, and revived the
"Always check OSN_WORKLOAD", so that start_kthread() can set osn->sampling
in the NO_OSN_WORKLOAD osnoise case
---
 kernel/trace/trace_osnoise.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b812a73fa5da..1ddeffbf437d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2125,7 +2125,7 @@ static int start_per_cpu_kthreads(void)
 #ifdef CONFIG_HOTPLUG_CPU
 static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 
 	guard(mutex)(&trace_types_lock);
 
@@ -2135,13 +2135,10 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	guard(cpus_read_lock)();
 	guard(mutex)(&interface_lock);
 
-	if (!cpu_online(cpu))
-		return;
-
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
@@ -2151,7 +2148,7 @@ static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
  */
 static int osnoise_cpu_init(unsigned int cpu)
 {
-	schedule_work_on(cpu, &osnoise_hotplug_work);
+	schedule_work(&osnoise_hotplug_work);
 	return 0;
 }
 
-- 
2.56.0

