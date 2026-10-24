Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806986;
	b=nkPYEIFAUeqLWpCTBX9LDPSrHzuUryt0kN3BbbwKf9SLvLArp1onohhTLtofHITDvq34
	 NAMeVTe5ECs4EXsKbvnwFJcHv6wDLT5XK8CT7Iwn8wOyeEDo8ZHZv/xqA8GUpgaZrttRr
	 9tM7GmnyJSVUFnBN1HyOUZB7KvvpjB+jRXT8quXfE+Kh0QUUGAUB8H4kXb4ghM793WCRb
	 vkY27orCFztP0WcXM6hVjBJTVOzRKsDfHI+bzfeYyQMsh3reNIwc/4+lit+6EnSoh35T9
	 +MH9pJEm2HMDqMFzqi69zW3rsoxMbXSI1hEu6KHCeSX+sFVn7FGSPhgWpA5UPrITLDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806986;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=eff9Ipl/p3IuNI+8WZWoBYhmxW4fx7lwPhH0qH4SpDk=;
	b=U1PleZVfwjBOtZY/vLclZYzX3yklXo4EhJjqDU+IBKch9GjWUvtMFgYDOP+Kw8NQlFGu
	 cgmg1m1T67rmuXXr02+nftXWgT4qFeFsixjSkt0CO9TfD7ngbS8QnzvBy2pCnhDBqsYh/
	 gbQSzu0D1MkgG3O0Q/No354CWHxvGw7vWMP1Tgfa//Hc6fLxML4EIjn8E6DQFvTgOttXJ
	 ifhx1qVYatpaQVywvJq+TY5s7gpoQ6j/Cmv+m300vHW0IOZgxwW1JrvGaYEp+Y8wpbE2E
	 q82W4+xRDqdB+CgN3OsA13yizQXbBxQSdS9ZpMuSBtzKNoiCa74XwuNpmv+MD8ZAhMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZT2LygS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B65606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZT2LygS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eff9Ipl/p3IuNI+8WZWoBYhmxW4fx7lwPhH0qH4SpDk=;
	b=IZT2LygSKniR7UmA7jxd06DlmW0HZwV/ADCiNr/3iv2ldIb6AH7mQeXXWBez7llIWolV5L
	1MyR1tjh1s2WmslziqLCWx/LXng1i3kPfbSndMrnnJFhxqdz0SpN9JVLG/MscKnbxkmEIT
	pZIzDNKCq2r8a5BpC7vMTLKMEOVm8fo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-crcxIBN_NtupDmiNoB27pA-1; Fri, 23 Oct 2026 21:56:23 -0400
X-MC-Unique: crcxIBN_NtupDmiNoB27pA-1
X-Mimecast-MFC-AGG-ID: crcxIBN_NtupDmiNoB27pA_1792806983
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5383c05fb2fso5421841cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806982; x=1793411782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eff9Ipl/p3IuNI+8WZWoBYhmxW4fx7lwPhH0qH4SpDk=;
        b=T9chXoapYeBdFD2rYo+4EshYdChUGxINMTAyv1qQagxGeyYIHkYStw16m0YLf2Mj5M
         w1xRnQSrvlVCHU9jsqBvcm3AaIpU8G4HuKhVg6xc4wgLlO5mIPu0rsz+OP5YUApMjVkr
         5WY9PcbTmmK7xuVnocgHRf4ovh6EfxbNs9q1a3RAI2lJm4Ere9RquSjI3VXB+Z2vMxws
         1tZaZSYy8ubc4/s+Jzj52F1R2p0CsS2YKZBJuBD5r9UeEQjoUegPOudlBHmTc3cPujVQ
         VN/9A8TD31HiR7yh4rlrWdT14K59ucnf24nxNcutFxBTU30QY2rtxvmdn6VIMwRzmSpT
         0gbA==
X-Forwarded-Encrypted: i=1; AKwUvBzhG4TwOGbc26Y2XzR1lFuTVAlSJhS5qpVw1cqwEMAIxWLvs5YAiUudeo05LKjPWY/CPmlMU+GGrHcZnXTXHlilG2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZwhzMA0KT5L3vFrHfLstDorZ4Gi3S5izoZYwyT30O4O9b+/IG
	9ZH4CxhwOTAc7K4kAdPRkYH2meZyB1oXPm1lUCGpK9cahFA9RiUXUsaoy+g3nai2IQF8NuEs6sx
	xrGPhAUI5fvdedc97Sb+rpHX9AHhJU0UgoXGnA6cs1Bljnk8rGmyjKCGI/jXXIL1RjNNipiaXDQ
	==
X-Gm-Gg: AYBFou1ovyJrop6r9NxP84mBcEp3TM6tpmKGueGPT3KC0FhUd1UJdFIpKQh4S4sJ4Pd
	KH8F6LxvNgnn005eVELI1GxUTzkM3AzRFhg2lp4JpBTQQOjVNsWDcQnyfaxC5g4MQ6QGB95T4lY
	T7hv6EDFhSyXfJ32QUWv6z/wbDMf8Lk0jmSP/0+sDYwkfKCcvhlqFy5bwpM3cqcnjTx+WXLXhyH
	nDH9bMVTRnslCLbg8o9mTgLXu1SEFa06DssQvQMVxkV4MSQ3aEJOzU3hrj993UDQQQAW/27/ykh
	BMzISITHWpikLuYBy3y/0xY/E5IKXMfBPOcz5GfO+SkSgARH1gBX+VYIN06cwrFLtN0CmbnZWt6
	bwZpBSByXm1ST+Bl1l9gWbGeRMQ8NvpFy+lGFQnG5KSyAUYwiZxnV2Wg=
X-Received: by 2002:ac8:5f4a:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-5383b757aa0mr9874321cf.67.1792806982675;
        Fri, 23 Oct 2026 18:56:22 -0700 (PDT)
X-Received: by 2002:ac8:5f4a:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-5383b757aa0mr9874111cf.67.1792806982224;
        Fri, 23 Oct 2026 18:56:22 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 3/8] tracing/osnoise: Hold a ref on osn->kthread
Date: Fri, 23 Oct 2026 20:56:09 -0500
Message-ID: <20261024015614.3095251-4-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fODVlUOFBHjeJtgt2w8YobTgBTTrCA6aKwrRBe8U2cc_1792806983
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
index 0e744652946c..e710fc26e477 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1691,17 +1691,6 @@ static inline int osnoise_migration_pending(void)
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
 
@@ -2001,8 +1990,8 @@ static void stop_kthread(unsigned int cpu)
 			 * by killing the thread. NOTE: this is a purpose specific file.
 			 */
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
-			put_task_struct(kthread);
 		}
+		put_task_struct(kthread);
 	} else {
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
@@ -2059,15 +2048,17 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_run_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
 		return -ENOMEM;
 	}
 
+	get_task_struct(kthread);
 	cpu_osn_var(cpu)->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
+	wake_up_process(kthread);
 
 	return 0;
 }
-- 
2.54.0

