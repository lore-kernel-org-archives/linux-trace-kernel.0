Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C32749C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606176; cv=none; b=R1mFye0UPJURoy/S7YUX+0e0vIyGWHuj76OZPZpEVIHBPdVbIkFcLSZ/AVBluco9c19nKfnxH6LE0SpXH57h8TxpfgtpUg88PPWx1Wpkts/TF+epifKp8DjEXPkMcGEuQW6VPkiaDQkNiwaqiu6DqJxxy9XpkrGZirE3Jpd12Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606176; c=relaxed/simple;
	bh=VOtlPRz+4X/dPTCxddB2AKQMJH+uPzzcMrsMU/nk/B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VE8V4RvU9a2bl5ggPWtVxUfAHEqppBN+KQy9FylUs65CJDc7GwdrqkrJot3NPVFAs25NmpsKplwGPW6CcWh4c0+bm4+NUpJbR1XeW8vbjGvyRk+DJbNh9Pg3FKOpLVbXm6ipBXhyhjaLk9E8FnU+4sa/zvHshPA2GCyBV91lw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0mGdOrz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0mGdOrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787606173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LW/+TzxygBSC3pdf2UvU1h3rjliFFSTxd7Y/KYnwEvs=;
	b=e0mGdOrzFdrUb5qHuqGRonkpKCgQx9AgAH3s+/Vd5fFgu7piMlwbDNy8tmE+YiKjLT3oWx
	O8c1y1zupLS3xBFE2Yn0ZgxZjigldfPtvqkP02qE9HGEywGsD1VtRYUt6UPNVQCnRQKI0W
	1Mu3a0aji98fGbsTahf4v0c+ydpeyPc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-TS9tUv7pOB2sDJXvatT1jg-1; Mon, 24 Aug 2026 17:16:09 -0400
X-MC-Unique: TS9tUv7pOB2sDJXvatT1jg-1
X-Mimecast-MFC-AGG-ID: TS9tUv7pOB2sDJXvatT1jg_1787606169
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso77022226d6.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606169; x=1788210969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LW/+TzxygBSC3pdf2UvU1h3rjliFFSTxd7Y/KYnwEvs=;
        b=Wnl+V2HzSVldJB9yb3+dTMTqUAM2dE2syFClBMChCpiVHcsqgFOIBuNASsf1BuvwGy
         OwDCHsLva7oAgnuZO5eF69ZeKQXQvvFxmPMnXhjRpYDyymlTPomD8kmAFFYjxx0FZsZr
         6p9tBB1/wycwP/9GM6wj+oHn4WxdJ8BP7TT179HtCv1PEE1Q6QEFCGVR12WOetbNN6Pr
         Rq662Cr2a/G1WXHnDSmpoZl8qyLRt4t6594EljDMQn9hoFGLgJQiO/TfQmhmRK7PMbRB
         4NZ+ZdOxXFsrfKJhjN4ob/tQKSfnzTk2ChYsxv2U+0yWKuC4mNr0dK4Ry4iGADhXGbUp
         Tuzg==
X-Forwarded-Encrypted: i=1; AHgh+RqiledF239lPenDWVZ9JUHhnr1IO6nnf7brUz2GUyVUYIrOZt8LAiqVwh6EQJrob5yQAuvWULo1dgsgGXD+aKNZzqA=@vger.kernel.org
X-Gm-Message-State: AFuF++nfdbIq/D8RyuWCWVxsJKy6xIWbscYQiNaw6yZfOhUNOUUf39Av
	cJMYO60+ko587whevrI8op6KXdzq3znkbNEWkhvakxh4HTqJEEL1JUUHbTBsZnsNOHV1I+7hMgL
	9hBaR2w71qRPyL2RjAr1hS9utMTxdIjJZItvqcLqV6RfNDIfS111sOaWVfZraeySBqnYasb6Rik
	0d02JQwg==
X-Gm-Gg: AR+sD10zvS0BMSC7PvNQkRrTRwpy+TdsK+pu8TyRb8NECuxZNiVj8my7P7VDmJY22tY
	BaBsVTehXCiGyHYlbTeP/IbcwYMmY9T0mjyBVvosqPIWty49twghF9qh7RdmGzMkZgNVHURPCJa
	kBI0Roxa9b4QzxfJ1uCF5nMVRkgFKnJTyqrDyM950dpapHDtz3+bmwmTeThEWaZ0zPzyuAoPpfa
	IltQXr6et7S/nCjSQFH/Q5jslFneIYW94BgM6PBAMxKMAPwrLQzJzD6XujB71mJKLo0bP3VlrFb
	kciRk8ynGO4U2GoMJKwNS3ksJ3cMJo0PQtOZzn6YHPFUwYPQJQqq+gkIWL6excH0yaE2b4eL1X8
	1lRJbvJfZ7eLN5ylI0+qq0oAuJS4nrMCo
X-Received: by 2002:a05:6214:8513:20b0:90c:b635:df18 with SMTP id 6a1803df08f44-90cb635e1c6mr19264396d6.27.1787606169252;
        Mon, 24 Aug 2026 14:16:09 -0700 (PDT)
X-Received: by 2002:a05:6214:8513:20b0:90c:b635:df18 with SMTP id 6a1803df08f44-90cb635e1c6mr19263806d6.27.1787606168682;
        Mon, 24 Aug 2026 14:16:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93931452sm71832556d6.26.2026.08.24.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:16:07 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/4] tracing/osnoise: timerlat_main: Disable migration before per-cpu access
Date: Mon, 24 Aug 2026 16:15:42 -0500
Message-ID: <20260824211544.3984835-3-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824211544.3984835-1-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ifNXCyckIE3E9sj9L4paczrBge8M_JAjKIPxjN47kng_1787606169
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Avoid a preemptible-context splat if we get migrated (e.g. from hotplug
activity) before reaching this_cpu_osn_var(), and verify that we're
on the correct CPU after migrate_disable().

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/trace/trace_osnoise.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e2e1ef3f5a61..a53a07e59197 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -236,6 +236,7 @@ struct osnoise_variables {
 	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
+	int			cpu;
 
 	struct_group(zero,
 		bool			sampling;
@@ -1912,8 +1913,8 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -1933,6 +1934,13 @@ static int timerlat_main(void *data)
 	 * flag.
 	 */
 	migrate_disable();
+	if (osn_var->cpu != smp_processor_id()) {
+		migrate_enable();
+		return 1;
+	}
+
+	tlat = this_cpu_tmr_var();
+
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	current->flags &= ~(PF_NO_SETAFFINITY);
 	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
@@ -2061,7 +2069,7 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_run_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_run_on_cpu(main, cpu_osn_var(cpu), cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -3207,8 +3215,12 @@ __init static int init_osnoise_tracer(void)
 
 	mutex_init(&interface_lock);
 
-	for_each_online_cpu(cpu)
-		mutex_init(&cpu_osn_var(cpu)->lock);
+	for_each_online_cpu(cpu) {
+		struct osnoise_variables *osn = cpu_osn_var(cpu);
+
+		mutex_init(&osn->lock);
+		osn->cpu = cpu;
+	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
 
-- 
2.54.0

