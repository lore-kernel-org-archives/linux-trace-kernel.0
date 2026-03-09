Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDD41324D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085978; cv=none; b=nnXTA9Ow7kdWJb//mJ5FiXA25J8J51Cm62Gl4RdJs5XbyDhF7cao5nq9Em7k6zce52oLgkPLw3yPxCJl5PyOxtU9eUzAZk7rCWWLi2KmPZRes9w5CuI6+U6G1kuZhaJhqhOD+n3F5Vixwa0nW6Bq7nA9u6xf/YWZlTuqqM1uiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085978; c=relaxed/simple;
	bh=uu1qF51OWMIrP9ZQLA0GZ8rgWwKJRSi10RAcYHwdCZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzQ4NjMVA761PnPpHVYaqFoor0g9MOK3KuFaj5QXbsEDPgRVjqOabcStkXloS915Sc6h4WPW6v9TMM06SToqvd62zyxSZ1fSXnsUsqRlZV/DJq1Gmo2Qs34xN5nQfu/CH4T3Xvp24NbNaz3T+637lR992nqre9J7z2ZdfjwNEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALV3zpR0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALV3zpR0"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4170e916d77so593218fac.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773085976; x=1773690776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umA2OwCk8CCR6ygWt/AhqprCfx79z1WR3ID3hcEWPqQ=;
        b=ALV3zpR09J/TZRrtjK+1zve2eP/1pqw+G9MqjmTL0Sq13zHjYujvwdXmVCHm8FXgrs
         eEORTU38+cQP/zwxfuZ6qIDhPyaGn4r1Z24PXijW76S+60/De3xZiLEVWRO+2F2v/PkV
         VllkeucyTIMPk++D8qr6CKyxamKZS6b7iZVJ33/ldJ6+OuIGon0NTLLlLMlu1jQMiJ3H
         e2qKptMiXwc66CMiWEbt2ttfdNGMFYTKSfr3XWRoCyfB+wQDRBeZUvk1L8RvwJg0LxQz
         1a596LV7p/MaTMR6BNg0nyd+Jp5+xy18tt+otB9156sMBfitdsY1Ik89MI+M9lVM5ELO
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085976; x=1773690776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umA2OwCk8CCR6ygWt/AhqprCfx79z1WR3ID3hcEWPqQ=;
        b=OPuDrewkQSzqehR6e5klDcioNR/Y9zF8rFpvu2xfuTST28FDK+zywPsNofb9KwBRhw
         gHlzqRwpjPT+8mKN1SEXwYfO/Zy88JASlcodhTrNrqZOaAQEkRd8r2ioZm0sU11nltML
         4Hbz+YTvs3cM8LOBKhtXORslY4TZO5O0kRceNxY4ActuB9uMnvAV7HKUYfHlhJva9tWT
         vr5kHROlwFnPOVNlCBgWSDkivmjott+jAMSi6oNHH6vN3tXZuCAxzPIWpuRVO7IVtFVD
         zFa0NhRDUwlpVNZZwMAMVPYHUyM7Lkkzwtu2JvRkP1ukDni1oQnp2/YWbqydAw4VC+P4
         j3jw==
X-Forwarded-Encrypted: i=1; AJvYcCX6HcwvR4TREh54YMuJQU4aQ//pg+rtrtRMJsy2D8lNiTuWWYHtOPKEcGEVJ/v5QXvA80qzsT+mavJaX0DL6pFXCHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhK0ewKXH3r1MyXwtAN2cU6C6FLMFSdWPVhWzJKdLnbE0sqSzC
	/tvb8kkyTzZSx6qEyoufcLxGsXClnWKRY/tcGlbYlZ39YyuJUTl2hQPi
X-Gm-Gg: ATEYQzwVupWmWR8mazoMPJscJEsOx9REJ9Tjvggd3z8hLbcH2MJyztWAebx1xHyRcn7
	r9DPBqYs9N+IKwDVBNVE0LZd/nCDK13oxb17hjzcuiGANksWK/9mYr1t2qw99BkcAuD6MZysw4L
	+EURnaPdDbzYrOa6TdIDL2tpbQvybluXI3gfDXthYSoNpe46kbo855yeUVTHofrh1IaIOxzbbdc
	AgYg2sy1hl18pCiu/zEiN4wixUAI4AxeKJzTzYkBWEmZSf5RB9WNjdOdfzmm3eR+mj2HTPP+Lwz
	X32/C3n0xMnkxy6tyTZopD9M8bCzSj1ChvCz0gWNkTMVhPPg2H2WnXo82OzPb0aDf1TxGWMG8XX
	d9u5mJsnNvqAU2ekYo5dAyoFtWolJGEXDLdtE9aBIb2s5r0V5jkF3bzR7dMaHheUvhkCpb3OF+G
	rD8GhTnQCEXRwPZbRSxtgExehl9EBrDnK0gY56uFOMUB8NLq1oaIgzSzSEAhmgfDcg6IuAeh4mJ
	0F0BMtZSNbpGR9i0I1uyPIlqQnQKreyjFcHvGU1LNn/YzRrOEd9mHeT7f4=
X-Received: by 2002:a05:6871:378f:b0:3e9:7744:1d4b with SMTP id 586e51a60fabf-416e3f84fb3mr6800926fac.4.1773085975598;
        Mon, 09 Mar 2026 12:52:55 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756d4d342sm525308fac.12.2026.03.09.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:52:55 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH 2/2] tracing: drain deferred trigger frees if kthread startup fails
Date: Mon,  9 Mar 2026 13:52:20 -0600
Message-Id: <20260309195220.2726094-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309195220.2726094-1-atwellwea@gmail.com>
References: <20260309195220.2726094-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boot-time trigger registration can fail before the trigger-data cleanup
kthread exists. Deferring those frees until late init is fine, but the
post-boot fallback must still drain the deferred list if kthread
creation never succeeds.

Otherwise, boot-deferred nodes can accumulate on
trigger_data_free_list, later frees fall back to synchronously freeing
only the current object, and the older queued entries are leaked
forever.

Keep the deferred boot-time behavior, but when kthread creation fails,
drain the whole queued list synchronously. Do the same in the late-init
drain path so queued entries are not stranded there either.

Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 79 ++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d5230b759a2d..3b47a361b867 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -22,6 +22,39 @@ static struct task_struct *trigger_kthread;
 static struct llist_head trigger_data_free_list;
 static DEFINE_MUTEX(trigger_data_kthread_mutex);
 
+static int trigger_kthread_fn(void *ignore);
+
+static void trigger_start_kthread_locked(void)
+{
+	lockdep_assert_held(&trigger_data_kthread_mutex);
+
+	if (!trigger_kthread) {
+		struct task_struct *kthread;
+
+		kthread = kthread_create(trigger_kthread_fn, NULL,
+					 "trigger_data_free");
+		if (!IS_ERR(kthread))
+			WRITE_ONCE(trigger_kthread, kthread);
+	}
+}
+
+static void trigger_data_free_queued_locked(void)
+{
+	struct event_trigger_data *data, *tmp;
+	struct llist_node *llnodes;
+
+	lockdep_assert_held(&trigger_data_kthread_mutex);
+
+	llnodes = llist_del_all(&trigger_data_free_list);
+	if (!llnodes)
+		return;
+
+	tracepoint_synchronize_unregister();
+
+	llist_for_each_entry_safe(data, tmp, llnodes, llist)
+		kfree(data);
+}
+
 /* Bulk garbage collection of event_trigger_data elements */
 static int trigger_kthread_fn(void *ignore)
 {
@@ -56,30 +89,48 @@ void trigger_data_free(struct event_trigger_data *data)
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
+	/*
+	 * Boot-time trigger registration can fail before kthread creation
+	 * works. Keep the deferred-free semantics during boot and let late
+	 * init start the kthread to drain the list.
+	 */
+	if (system_state == SYSTEM_BOOTING && !trigger_kthread) {
+		llist_add(&data->llist, &trigger_data_free_list);
+		return;
+	}
+
 	if (unlikely(!trigger_kthread)) {
 		guard(mutex)(&trigger_data_kthread_mutex);
-		/* Check again after taking mutex */
-		if (!trigger_kthread) {
-			struct task_struct *kthread;
 
-			kthread = kthread_create(trigger_kthread_fn, NULL,
-						 "trigger_data_free");
-			if (!IS_ERR(kthread))
-				WRITE_ONCE(trigger_kthread, kthread);
+		trigger_start_kthread_locked();
+		if (!trigger_kthread) {
+			llist_add(&data->llist, &trigger_data_free_list);
+			trigger_data_free_queued_locked();
+			return;
 		}
 	}
 
-	if (!trigger_kthread) {
-		/* Do it the slow way */
-		tracepoint_synchronize_unregister();
-		kfree(data);
-		return;
-	}
-
 	llist_add(&data->llist, &trigger_data_free_list);
 	wake_up_process(trigger_kthread);
 }
 
+static int __init trigger_data_free_init(void)
+{
+	guard(mutex)(&trigger_data_kthread_mutex);
+
+	if (llist_empty(&trigger_data_free_list))
+		return 0;
+
+	trigger_start_kthread_locked();
+	if (trigger_kthread)
+		wake_up_process(trigger_kthread);
+	else
+		trigger_data_free_queued_locked();
+
+	return 0;
+}
+late_initcall(trigger_data_free_init);
+
 static inline void data_ops_trigger(struct event_trigger_data *data,
 				    struct trace_buffer *buffer,  void *rec,
 				    struct ring_buffer_event *event)
-- 
2.34.1

