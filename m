Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA836A367
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944826; cv=none; b=J/RGtmTLqNc7pfRbXJjy/H0w59u/9IHLJs/qxdtfiGmhJr5N3CwlXHwMTTxNT1yjqX4VhG9uDDx9cZfkPGHFhxW6GzKigg65bhv2Yxbt3UpPDga4uEmIKdqesW5Jlkno5I635qiPL19Cg7FY6NTzr1mNPQKm3LLBnP6xUXthUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944826; c=relaxed/simple;
	bh=L3MyLgmvyOyqJIiJH8jTE90wMKXHv/j0ASDAf5JIVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jn0dbEhWjdRUCn1TtRf5/jmP6jV0KO2dL/ZrCNaqSiIr+9BcL9Z7Ebjw2mN3cI98aF/j7PMxsJ46IHajnz0W6bTKHoY379UPth+kfzHzfRe9TlrglxKIrAmxHSRFCmVwBLxp9myd6GgGETi6RkLnUEEVjRWVZuUjHO0KL6K7jNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6TdyAZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6TdyAZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
	b=F6TdyAZLIYXr6Ic/9OhhGJslQL3YGERQ68cyG+2NL6C8VcMpuvC0gUADOg26AXsZjk63jC
	6ofUvcgdRY4w5190k7vqeY4V7QGm09X5FhL67MJfgM6ZX7q0gWoQvPyXsODgY4F6vLZISB
	cUVElCb78WBab/+QENuRpDqMgAhfMww=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-bgv54foYO5a8JbPrahZSCA-1; Wed, 14 Oct 2026 02:26:59 +0000
X-MC-Unique: bgv54foYO5a8JbPrahZSCA-1
X-Mimecast-MFC-AGG-ID: bgv54foYO5a8JbPrahZSCA_1791944818
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a510b22fso80615586d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944818; x=1792549618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
        b=eKjOGktAh3ouaXS9A/tMOxR5bf0kC8/cGRI/iScwB9bfAjJ4YVgPdJqjG342cAGtcl
         oj0fBSxbH+CA40BfuXOVfJlQWKtdaypLzAOzEOhh5cixJDBkDRmiqFZ/oVHuC2YOl0ef
         fDSMczZCBtzQDoGSHB4WWv11jrZSLlICKCbH2rmYI+wMR82Xyc/6aiJuO9dPyjxzjKT8
         G8gQD8FDXs+FNPfV4MYF/yf7QCRBEHS0qBMtBNi+6zlszo5pJhT2KLpNn5S8jsuHYoBP
         69cQO3rEHz0RUhu1tJEHyn6pMFcP3ySte7ZQt98ac1IiAzCK4OV59aHgyBgTV4dLuAsm
         W4xw==
X-Forwarded-Encrypted: i=1; AKwUvBwmsIMlyfc98k8uEKZ6O26iGGG12CqDiRzrWAwNiIaK4LfOPIsSNiZ4nmRdUAFAWuSPwTqCm8e3T76/ywtpq3la/kU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIteV3Hu/iXMUDJWK8XhIiEHzMTarOtzjxm7q6bXqP6sZdgUwwy
	oZ4nLw3ZEtAs7q8tPn2gthKU5bdt0ld2sAWC205o1FeZkeKbeK7ojs9YyNMXql5lcsFdazjXjWR
	IlyorKJdJbk+0JByy1HNA3NT1E9NTslmF6n1M/ubaaWL9Okmt+Zib6uMG5MSkuT4Fc787pdqYAg
	==
X-Gm-Gg: AYBFou1IUD377yn3Hjvjmq9eKHeZAOHqoKWTDCM+eikwOKIUIIGuP535IHvhWmWrQ0P
	5iKUfBw4X3qrKVfu7e316po+DF8bYizFVymfwl9CRo2SYRPJ+lNjkevJKvbBa+qQNFLQmYJ9DRM
	vP8Mhw1MLV9DrbxuFDJqZJumlD39qwZXbvmm2ttfIzJK5Uk2F+CKJOVaXhe5MrGucdDEsY2Ikiu
	azdFRccn1kke83ZtRgZ5wV9tKz7D7ON7nX58jHPHmnA5LVxBJe2P0dHbcyxYqYc9/m5BRJ/Jcl6
	l490fE0eZ/ltzifYwxR/zdhiB6DQ+6ehxbKZkO3ZZbZGnsSiEGrPg4fxZUJWJs5H3J2SflcZybQ
	n378kwyWGAwD68nJ22u4/5m1TbZYcwY9PxiDKdRsI33ErcvVuHTWMXHw=
X-Received: by 2002:a05:6214:4c42:b0:91b:5d3b:4ac1 with SMTP id 6a1803df08f44-91b5d3b4e3cmr194811836d6.54.1791944818288;
        Tue, 13 Oct 2026 19:26:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4c42:b0:91b:5d3b:4ac1 with SMTP id 6a1803df08f44-91b5d3b4e3cmr194811606d6.54.1791944817754;
        Tue, 13 Oct 2026 19:26:57 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:26:57 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 2/9] tracing/osnoise: Hold a ref on osn->kthread
Date: Tue, 13 Oct 2026 21:26:33 -0500
Message-ID: <20261014022640.695786-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vnsXjOK4GeM5QgJuTlgZiRSVF3LK0FudMdNYCc1YDhs_1791944818
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
index 953936bd5eec..47ede1696c91 100644
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

