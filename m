Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552077;
	b=DsD6zMDedmctMINBaVMpd9G0iAlBN8YaonJMdQjEiEi53En0AwRKrQQ40muw0nLzsOX6
	 dfiG31vnsLbJaoRtZxyD7alXWIMhw7rIqcXezVqMj+0whZB4UCQIvYw2Kslu28+VYN/ji
	 wU+4+2Q3FaWqamEp5V9MR3DAlEiOpOi/TWqMeRYKLjH7vHQPik88KNgIbhUkIm5/S9YN5
	 G4EHCX+kUXZvQA7bh4YppR+AY4Qz+iiq/M1Z6oAFHOmDotr5vtRfOUkhQWuOy3aGR06Hy
	 KrfPE8YfOO6Me/TDY/Nd6S0oNEEyJ7hI0IpZuBjGrZ0aoTym89Cqlk9IHjdYbksk/Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552077;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=D6QmccO6o5MpT3GdJNHtCLmZlfs7Wx/f4W/bIKjhy1Q=;
	b=Rnbsoss6hvqcdhv31lW0a9HN/PzjhzRFbvtc9a4zb+3vWLHEzHPvL3lmVSkZNl049drx
	 YY1XU3mnz77SXSSNCBSZPAE69jXxX/0srCeCb01QA+zgbpnqEvxFYyqUEMuvw3U3lpYqg
	 yMUVyYhOcpx6w9yCkS/gM+WrA9e0FiUVIqoiXUHqmptcflfojnpr4L1/gAGEiQc9QCIiB
	 DwnzAf+hS7OXyCvNDBeXPgVyIxwlr9VhhnPOQoEobVk844EHv6xptmoD0T6T8RY2HsEiq
	 NM9OQRcis52lPcICy3etNmkEqPHkjqqbBnWOsSFey/R2UGO6PfZhz/5FOzNRTFrgErA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGNOMjRs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F0606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75F0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGNOMjRs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6QmccO6o5MpT3GdJNHtCLmZlfs7Wx/f4W/bIKjhy1Q=;
	b=RGNOMjRsnBjK3W7eB2fqriykk+IR630fgZ1W4kwSi/+iZhvpz1k0MyFLEChUEf7FXhb+ei
	BakvOuyOhTCsMwIESXfxmPpoEbBTVpbDA2gUQ67nztgmjQpeFcj1yEzsKYQW5uiIEcBODW
	PLj028gdYu7gqP2EiLhvX1qffUDyLy8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-klYFjK2-NdWHklcslRekgg-1; Fri, 13 Nov 2026 01:41:14 -0500
X-MC-Unique: klYFjK2-NdWHklcslRekgg-1
X-Mimecast-MFC-AGG-ID: klYFjK2-NdWHklcslRekgg_1794552073
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-851f7cdfaefso489361a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552073; x=1795156873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6QmccO6o5MpT3GdJNHtCLmZlfs7Wx/f4W/bIKjhy1Q=;
        b=rGal3RjeDOJfGAKwpYtTEZOrNKZ0XUDc0m1bItvAHHhQTQKLngE7CeJ32sC8PoMUgf
         cxsKJfc+yPzfCMcdC6wybBNAL3pO0Dpe/ykx0sm46NAi01Vaiji+pES2SEwF6koDi6av
         Afng4nLuIRLSbHd90L766Ed9vNkfjvRAC51ac0KOmzNLzoUqCJyUpr4tIaO3rXwRdXRA
         ePbXHHRgGMBYBpEYjkXP5zXnjGacvOrcFkc7OGVYcm2CRsmGpMLSrWu+IO0Y/DOtFjxO
         90BxS6z77wV9qI8faZbjsp6QO7GUfUsKuhxKbO0bNWjjdA+04AJmwXosp+U2G5JVbo7B
         ENLw==
X-Forwarded-Encrypted: i=1; AL+hErH7gxhTsNWBFhgjuVCsxs1ic7JXpyeFajxIspbJc4y+nlLYkjzGVQx3gKZRWiDE1eg7B0JR1ROoAfDeUXP2UduUWKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J2p1k5rSVyCbHtzuvKUhaYkZa0JdqrFGNhOHutaJsoppFEOBG
	mLIFjUOvLddUgO2FMpF+80eO0Zk/0eSvjXtkVUTYg/0K2XlWvCN4Fhc74to7tBO9nTDa08CxPSO
	7yoz9eVxZmGYV0+TEOWDu/d6jw08gGEEdma4JaZZppDTfH54y6ooCn3eYi/+G/WsDUNSSp0ugow
	==
X-Gm-Gg: AYBFou1rS0EwdPTTed9nRW4+vmTX+7uUW7f+jS/JOvuVBaUlNnuNwsfP1dlDknX14zt
	rLlDdXa0p9TlXlxRjneu2mOg/xplGqPoLbcT/qrOH83WZIfQv2/kGsX0AAC8ScSXCupps+VppWK
	4zp7fRoUXWg5D1EtqPx7idOmuR40Y/WzqfDvMvSitNEPJ6rKOu8HofnYDMVxmyZP0cYrgrCUmgR
	HtJdoycmwkD8yNaPgmFVy/qmJxiVtAbT5LHgFWhio29UThqtRykb1PEUjT3Ze5WOH248bJ7TCS+
	ZuhyLkCqC3tlukLKLYbLGEWCJlpezTXDy8UFNBHkGmZFSiGPkmSa0bA1muGAB5L9/5TgfkexfNI
	u1e/l8JTb3kZ6WfeMw139K8PfSSIYOqrnuWsFYjsMevEmqxs+QRtWgciwWBGz7u7jlkDsxMkq9S
	a4EhEk7PV2QXutzpFWlCacnktW7GGg
X-Received: by 2002:a05:6830:71a0:b0:861:5cbb:8603 with SMTP id 46e09a7af769-8628989b4c0mr1290704a34.20.1794552073238;
        Thu, 12 Nov 2026 22:41:13 -0800 (PST)
X-Received: by 2002:a05:6830:71a0:b0:861:5cbb:8603 with SMTP id 46e09a7af769-8628989b4c0mr1290687a34.20.1794552072756;
        Thu, 12 Nov 2026 22:41:12 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:12 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 04/10] tracing/osnoise: Hold a ref on osn->kthread
Date: Fri, 13 Nov 2026 00:40:57 -0600
Message-ID: <20261113064103.3041704-5-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: oFfxbIe8pfhnJ7eVeloF1vDyZvp8u8uB674YBWhpwSE_1794552073
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Deal with early kthread termination by holding a reference to the
task_struct and always running the cleanup code in stop_kthread(), rather
than with hacks like osnoise_migration_pending().

This avoids a potential deadlock when a later patch switches from xchg
to using a lock to protect osn->kthread updates, and also deals with
any other situations where a kthread might exit early.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: New patch.  I did this in response to Sashiko pointing out a deadlock
in v1 with the use of osn->lock in osnoise_migration_pending.  That might
no longer be an issue now that detach_lock is split out, but this is still
the cleaner and more robust approach.
---
 kernel/trace/trace_osnoise.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1ddeffbf437d..7b343f47cf2f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1692,17 +1692,6 @@ static inline int osnoise_migration_pending(void)
 	 * thus: taint and leave to unblock the blocked thread.
 	 */
 	osnoise_taint("migration requested to osnoise threads, leaving.");
-
-	/*
-	 * Unset this thread from the threads managed by the interface.
-	 * The tracers are responsible for cleaning their env before
-	 * exiting.
-	 */
-	mutex_lock(&interface_lock);
-	this_cpu_osn_var()->kthread = NULL;
-	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
-	mutex_unlock(&interface_lock);
-
 	return 1;
 }
 
@@ -2002,8 +1991,8 @@ static void stop_kthread(unsigned int cpu)
 			 * by killing the thread. NOTE: this is a purpose specific file.
 			 */
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
-			put_task_struct(kthread);
 		}
+		put_task_struct(kthread);
 	} else {
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
@@ -2062,15 +2051,17 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_run_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
 		return -ENOMEM;
 	}
 
+	get_task_struct(kthread);
 	osn->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
+	wake_up_process(kthread);
 
 	return 0;
 }
-- 
2.56.0

