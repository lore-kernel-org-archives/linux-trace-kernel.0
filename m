Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EE35677D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015699; cv=none; b=EjluiHqvA+U/MeAsikD+1TcFBKnuWb3SuJowb7qssSnF8kUyFPHAel3DIngJ3tkruX7i5bQCRPjE85buXne6NE3mQaV4F4v0wEs0Yy58pAqiwmappmHSMdinSDcaID7G4cuDLrYz2XO+Lmz4nESXU1XftrcHpELqGWpcWRDBdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015699; c=relaxed/simple;
	bh=L3MyLgmvyOyqJIiJH8jTE90wMKXHv/j0ASDAf5JIVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NkIgrd9iHQyZxG745Pj39BIjiM6O91VO8G4G1Eou0lw1FZK5VTsW5/ggjE8XO4d1ddGTEJbkzJtbKE0GnRtGk0EhgdmLzkoMuYxDXsFVz9mLvljLu+1Ux1udqvM952a3klTlt+KroP/ojEOiSVB1RyjSNcTTqRroyNFQRCGbFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0zpyjWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0zpyjWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
	b=G0zpyjWdcCzYSCzb5xaMz6pmXm+oG8LeQbp/YLA5yh8rg7/f5hRBEHqB0xQrwvDCkJHYOT
	L/Ji+FS9e/X2N9DXJECHhOki7fSDSjAJiolvVMfd3fKbAP8NjkOoHc2aXOS1DSq2eAo+Bu
	Q4/hj/QadNeyCA3bi2gyfWc6FtRIdJo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Xr_pF3wXPLydP-kIzxQY_g-1; Wed, 14 Oct 2026 22:08:16 +0000
X-MC-Unique: Xr_pF3wXPLydP-kIzxQY_g-1
X-Mimecast-MFC-AGG-ID: Xr_pF3wXPLydP-kIzxQY_g_1792015696
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53380b67cfdso114445621cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015696; x=1792620496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
        b=z7sevY4jiEWBdNuCMG6n1gkOd/jkQbVLqCUgq96vMkzWdapPVwqa25xr+jNoGsGoQS
         aHUN6BqIUBYVOD5Ta6qSqjZJlxB7UmKzZwAFmH0y9yCV5PMsVjKXkd3BWXw4BC4myOuq
         LV+IEZW5lBH37F0ju4DhmObCN+wQE+ZTRRbaIJn6Zjk38oPX63OUm9AHD62Gbttg32uj
         /qM1NF8PxVSgnuR9c/98ZpuMsvHeOJV78JD/dndZtn68QaW/v2v/JmQo3/FrIIW+BlGh
         kI51Bd0aMbiT6BJAWtFYTjId9C7LzDaBEDCJpFcA7dx06vRYWiPe5AvTKw+amJWgnsGX
         2Lug==
X-Forwarded-Encrypted: i=1; AKwUvByRhf6lzBgTAjNV9kEKpiK58jfmoH5Den7QQsiuCYfB72pTt34Oqhoxmuqkb6C9dgHdA7OKA9vnJdZUwEIEXuZZO3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJV7iCogCGQrXmNFAWAB8+XQp+nfUzan3W8zc7yXwOcZYICVR+F
	QTL/Xu+aKxgfbgrBzQQvQsVNKX4Q14Lr7DpXKbpTXjIyddgspCdmyXuXOthtJ3Cq3It5JvwJgO1
	F8PL97Vr3OYojsZCmlfcokwBtrxhe1R/sZVusdn+zLx/xUKJoUpj60jZlufsw5IBZAjziia6oKA
	==
X-Gm-Gg: AYBFou0qISn4nppAL0AgSJL5FEScpf84cga15gY4IAcmq0utwHVti9tlE8UDn73GLvD
	bKDRiCyYJ7Akg5CYwytuLrl/Z9NLriBgeol2rBrD2TK5dXdwcrS4RbNXPZ1aub0izECEDN8QaMb
	q1lAgkwlc7F6zOh5iNc54KfJQZdOIyq+crYxPQ6yGsCUAVcJYgUiE1KgnKjW6QNAuhRaCSVo9N4
	lKaqACMCisZD61s/uZ7BzVs3j72TAB3SDacyOJZ8xzBbzsob347RjQJvTLXCBVFRRaA7Sv0sOgc
	ICSxqhDxEwHomu7vKUYgM7WGLs3QUy/5AkBBLbx2xeHcyVtdFQUfFXgwlgHdVWF+PwKT0JvbrGQ
	YWjNCA/muE/W8/Zx2qoEXDS2R86Xh1IiuF/iQUpvwPzD9+0PBy4H4JKU=
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id d75a77b69052e-5359f488e55mr300398821cf.5.1792015695949;
        Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id d75a77b69052e-5359f488e55mr300398441cf.5.1792015695463;
        Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 2/9] tracing/osnoise: Hold a ref on osn->kthread
Date: Wed, 14 Oct 2026 17:07:52 -0500
Message-ID: <20261014220759.908839-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -E3rjqPmyXP9Hpq7V28Y6ifWITcQS3pORCl9riZ01WY_1792015696
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

