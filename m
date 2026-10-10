Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BE386552
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599049; cv=none; b=eqLcWmo2XIuKV+Rczs8xuqnDkY0m6ddpTXVCsupcApXdqlj1TSgIl7c6aioxgWY7/xkMsUb3qvVSUrG0Cr+8ACfShbLbRyCaEOTkiVV6HLayjayfGTUOdguHZRHRyz5++yZlo7Bv03HH/oasQHIJo1dcCZmuoaRHm6POQQBBDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599049; c=relaxed/simple;
	bh=gDQMFySnuvZCyk62IDjvWPgiLF6At0vjaBYzhdQFJ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OmTACMEuzAdyk8zFGCw6ue/nBZRTA3KOVCmELbCx2jBo1mXtNSEPdE3mvP1fkeT3MlUDUIINJE+E6wa0AfrKO8QKF91nXferFh62oDbMdD9BvAYXD4O40adxkriHbkxwdwIMFFmR9z4Q6rLtBetO3SbyxFY1ZjjyqpDwD/FJako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKJVuhFw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKJVuhFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70LAps9VFnCD2CWQp++uXGjMQo2hhbS9VXlXBi9Zs5M=;
	b=aKJVuhFwLQ1jR/rfWGEykn74id9YzxYLshW56ArSbxyGbHPjuwEkiIMC0HVdW81gPTzTtr
	XNVSBGMLGtIRFBY+Y3m/cP7tvNY6uX47bBi8UzhhVi3FkAs/J0TNC6nj7zZ2WOg3HkN/IS
	U6vgV53AwCYY/ZIDQ5H1yMfDJkub3wE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-xoNSYQllNx65DFxK-Qy3ZA-1; Sat, 10 Oct 2026 02:24:06 +0000
X-MC-Unique: xoNSYQllNx65DFxK-Qy3ZA-1
X-Mimecast-MFC-AGG-ID: xoNSYQllNx65DFxK-Qy3ZA_1791599046
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5339732335dso5410211cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599046; x=1792203846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70LAps9VFnCD2CWQp++uXGjMQo2hhbS9VXlXBi9Zs5M=;
        b=l50Evc8Y6BQ78dbZ5lDuwLuiUJPc8WnzXB9IZmseQqkZqvLIoWC20ygWsQdHX8c2TU
         TvzJseMYo4C2QuFuGqhwcUpDVAWIsU3DpdUmziGN8p2k3hMtyvWfrZC/3YUSd1XKXyOj
         OpgJCYseLP8WHqWNBWaSpZKCAyAmcf1leQ3Kw/m5EW2edCUiatRliFdN0hR/Im0aPyV/
         AhhqBzzJrKpxAgO52XmOBUXOcvTx4pBBB/l/d/VhrxCI1S7lW5fKw31qDf+caJ7zeQvr
         s3dRuBSopwMA4GKaYTEl+JATnAjMMCsi9KKEKe/9VcOB/8DypL4fiRVxNU3ILAt7p8u1
         moxw==
X-Forwarded-Encrypted: i=1; AKwUvByOcbHyhWflh5el66KkzmjQOZuBSt00xlwttgcktgS7czrh8vWtxAx5n+bYxzwqYyneirT2dUktH+3dJEJeNQv5BKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVVASGVROtw/rldsH7m8nYmtI/Hp3i4Jb8suRUTuu+MwKHv8Ae
	GJtwJEsa1ZQBKsUO+W8m5ApAqoIzUpVn92tPCqs77TYduYG+g9p4qzDesIhRnPt93yUs9Mdm6qx
	hqfkGcSRcdVbpH5flW3+vqdWn7T7ecE3NRfdM0q/nKM/v+i6XmIdyezh4Lw8gf8QGK+5tmn2pww
	==
X-Gm-Gg: AYBFou0gztP51r8vXi5ttfTaR32pIkqmBJ5C8dQ0Na3BblDxWYF6wMKHbkoTpoRmohh
	MnnUPHn1M3vSLd+kkal2W1Fmswt6iQVkDgOFEAwILbq+1WwJ/HDYsXphI9Utdn6eM1m3kFOe0nv
	tOgC9g0f0AeWLhnWtb89m+jU+2kRCcQGvHnyqST+8oqEK6VmrAleaOgFxHJPAnG1kIwQFSi1rrX
	j2ZCtOtIURqr95Fihkg1T62PKL9gARZDUYiVbFdl9SGhNGglmC5lcaMpEXLjxaP61hbaAquCNOa
	JcyDzHpus9JW/AavEY/U8JF8PpfnTKE3+nyKLZ/gtHvnkPs1uhd0oYIhVbmydBxLqVY1LFClb7J
	Tb+BQh3YbkkXuNdJzyS+/rY73RTk8Kx/aq14a4nty5HvHbvBEf9y3RQk=
X-Received: by 2002:a05:622a:c85:b0:535:15a9:2514 with SMTP id d75a77b69052e-5359fbb9fa7mr61851361cf.43.1791599045590;
        Fri, 09 Oct 2026 19:24:05 -0700 (PDT)
X-Received: by 2002:a05:622a:c85:b0:535:15a9:2514 with SMTP id d75a77b69052e-5359fbb9fa7mr61851131cf.43.1791599045023;
        Fri, 09 Oct 2026 19:24:05 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:04 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 4/9] tracing/osnoise: kthreads: Verify CPU after migrate_disable()
Date: Fri,  9 Oct 2026 21:23:33 -0500
Message-ID: <20261010022338.2507589-5-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010022338.2507589-1-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xk3uPFrzzRzkSW6Rl40V4XXUeHJJrYEY5eZ43cDKypM_1791599046
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass osn vars as the kthread arg, and make sure it matches where ve're
runnning in case of (e.g.) hotplug issues.

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
index 17cd5ea61e41..51e9b8837d20 100644
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
@@ -2076,7 +2090,7 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, cpu_osn_var(cpu), cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -3253,6 +3267,7 @@ __init static int init_osnoise_tracer(void)
 		struct osnoise_variables *osn = cpu_osn_var(cpu);
 
 		mutex_init(&osn->lock);
+		osn->cpu = cpu;
 	}
 
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
-- 
2.54.0

