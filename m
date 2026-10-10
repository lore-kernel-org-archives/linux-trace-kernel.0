Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C12F7EE7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599047; cv=none; b=l4ovXn8EviLFWoSp3GF26AbHCXSexcQDIPz1nh4Wmb3JGisKPhv3F2PfGE8GXQ7ubyn2uF+hTe/KNVpnkbeYvuCEfWCdWBjvGALUnEjt0eLerL8hehnRHTnrylOscmcMH5xe/0I6dXijhnCAs16Py4RCPhrrxpiFA47TUydCxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599047; c=relaxed/simple;
	bh=L3MyLgmvyOyqJIiJH8jTE90wMKXHv/j0ASDAf5JIVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CnypZZqx0/jskemlhbk1ukTlbcEtPmi+Z+ItboAptPHgCtSFhOSu1PqtP3TJd40pZqWmtgBAQ2EIYGhGmKKB61QNMbke7OXIEKY76YySylro4ztoCxN7Xal13fV6K64C8UaAMxvnWS8kez/6+4Ij8IlBSihCjpRB0waUC+Fp8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctydPDvl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctydPDvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
	b=ctydPDvlcTr2zkiZx1K3cOiUZ8b5Ar3B64CvawzkEPB0Lto/RADXopB2qmzI2sXtVFmHh8
	VZQOc/wdGm6nitwjZTngnVVe1UGNCU5s4dt+u7jnKBq5Nt7YpTMXg2RrKv5bOlXrFbIP1M
	HRo4FbA2ha5BT073MNPjWoce7BHdhSA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-aDr4tvfAOS-qOT5zw3CHNw-1; Sat, 10 Oct 2026 02:24:03 +0000
X-MC-Unique: aDr4tvfAOS-qOT5zw3CHNw-1
X-Mimecast-MFC-AGG-ID: aDr4tvfAOS-qOT5zw3CHNw_1791599043
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338ff2cf14so5318591cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599043; x=1792203843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8FKq30HXmQaNrkB+65uLf8cQ8a8G9k388T8x0MsnN0=;
        b=yD+Ipq07ivkjvNd6TnpRMSFdIbPIMl5svmI5u3v+Xw30/t1U4iMczUNiKsHYBxg62h
         QiC2w8dkgNXr8TWgW7DyuotTZxaQaa6BqX8X9qAy6v1hfQecPWIwNCSDDPvQYwnFpHbK
         uc28qd2qqDcp46nCsoMDnsJgb/8ItKrVOM5j9Sq7tZ4hqShVsbBbCnEBvECApOb1YaLo
         4Rf1zrfee9w/Ys2mtIzTCBYMkJuDm4yOrtpGW9x/aRHsIaPH27exOU8l84InwKuK0Uzb
         yx9mfD5U+F2mgtjtEodGCs8iSvvc6q2lN4oLbKvJKWBdGTQnK0CQQZRdYZwqpZ4UZ/mN
         rREQ==
X-Forwarded-Encrypted: i=1; AKwUvBybybWGHS7BUBpYV0l7hAr+8ySXUc4vz9r0POJluRnpAFNKDAwPCmlxFKeTo3ZUGnI/6VZT7glXuVVuhnjvO5QAcSI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtctCri4WYX4w/AylzVHboUNKSLNnu/7SK3SSipYLEBUojUi78
	+Nb2EbUmEvGffOo/+6u3OQ3dCDweveEn+3B4WYPFqhlcQ9gDB5MDXMWuipcve20Gil/VXyDmbhS
	E5QYD+VN8oJX6UmPbWRG6s8TEzcDpRYDX9ZH1ivPqhNxhAv2qp0e1TimFxodJmzY5V91C8Zy6xg
	==
X-Gm-Gg: AYBFou1iWKQE00zIXqR2nD/9SmBl9jIIzG8vemHtH1+wXYCcTg9sN51y3HfwWoDIOfQ
	LLXeXBVE/StTICODu2yEADiqkxfOvtCcMlZowLvNLHvGCxCeraBVR7f1uLPtGy5Fd8HXIxTmscX
	hKui0KRsddpx9uu9KyKJUf4AgUfu2cjx0hMOF1P9GKSnjJId1aKIXl3WbAHa+Qj8gM3F1Hcecs7
	R7kltYiA2MEYKiws/yqE9IKIu+UiGlSVCoza9XS+FA52cOwlDK4eqb0qs/9w8otkwtMOw125tSb
	70aON7Pu+ZnMuTkjzE51t0gOWpgJHeiGwwtbpVu1lkwvd3GuIdUM8Dla7PMfBbCxktrDyD59SBB
	1e8zFNNcQf3UhQsNbf4P3Alk63avtWjPogj+4rCKhfGzqt58vbRDoN2Q=
X-Received: by 2002:a05:622a:1b12:b0:533:35c1:2da4 with SMTP id d75a77b69052e-5359fb8e8f6mr57137061cf.52.1791599042944;
        Fri, 09 Oct 2026 19:24:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1b12:b0:533:35c1:2da4 with SMTP id d75a77b69052e-5359fb8e8f6mr57136901cf.52.1791599042532;
        Fri, 09 Oct 2026 19:24:02 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:01 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 2/9] tracing/osnoise: Hold a ref on osn->kthread
Date: Fri,  9 Oct 2026 21:23:31 -0500
Message-ID: <20261010022338.2507589-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6D2X2yd9Zvt2BU-tVZftPLAqVcfMMsC5tU7sKwx3TS8_1791599043
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

