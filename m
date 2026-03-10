Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F934D3B1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125267; cv=none; b=XAIzf7pHpdmMaxB4a3cWERNrAKe6LhjxunZx9dhiKSfmRkXCytazByVhb7qAeDs8lqqwNuV4lVmgGLqNYI9NILJgsSzOm7ZB0LYh0U3tZestG26cyAqWTC+7JmJmocSFReYMPe2MUog4cltLTLqM3+E224Vl8fxPLdJ/7pDGKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125267; c=relaxed/simple;
	bh=LIXiQ58eevZKhvwQMxvCY7Hx7/LM+Yyz1vh1tUGJRk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwAiL3JqcHUJL70y5dit3fJzrvaUbnVb95WjgSieemLHQABzFPp7kpDKTLAlXCGoAA8RY+AZTpR2bZ09zMcqpPcHtkUtilf0TNs9SV57w+YFz1Nc+r9Lt0jtX4LWCjtHxsAmy4VSaU5XqJwpvlsaTet71VtVC2F00C7hN2DV05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHMDkxcm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHMDkxcm"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c383f2fcso8982220a34.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773125265; x=1773730065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfOj7sKndwZ7txCEcuOMoH8c4ZIJOpSaRVSzXZlYGws=;
        b=CHMDkxcmsIFxBFY+iAIxVRDhHtGiEmiIxzxVLTISC5XO9Yk8VMjRYj3kWPAs+eWs8n
         THkbHWfC4zzGLS8qNw8OoDFcwaqvimqN3ixTgpRrI/V6KjYq7ifWTFjJUwUD9IEyKVBz
         G3JFGMe6WY3oiBsytfxn6MoiRHtLeV55pk4SWHL0X4x62bZHBa1p3FCqmIi5cbl5U28E
         5oQ3wkbTkR7rQAgItoVvgbU1/7egyW5ldIL2fMfjZcP3J0TurljgkTedAn4PL36f3LYG
         PbK5cP+/s6pESUbXCA1jB2qpuoPK1xBALjdY3GPcn7po0Yg3UJPpk8NP/pbqJm/0YXgG
         I8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773125265; x=1773730065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfOj7sKndwZ7txCEcuOMoH8c4ZIJOpSaRVSzXZlYGws=;
        b=Bqm8hqY0yNRt2bnU4tQVGmI5dhGwjQTMFzxDLkEEuXrwXYGa0KgyytSASlXMYOVS5N
         tQ1VnEgq6FqqPaigTjUGWHlF0wQN5oPclHZOxl6BmiJxm1o7H1JLVvAjYudmYwwiftXC
         7V6dq/tN7rx5YMuAA7aU20Q5SOaDcJIfPupKlRyaNzFjHd13qI/kdKFxnidmPLnV7wEh
         THppHgQj5SDd4QB646V6xiSwdNFZbwwdtA2cH2LKiREdaN7l26WVX4+xwTXwkw5pviRN
         1Oxjb6yKz8duyHGq75R+XpAAFigJbPmcgjKeQzYC+TqGDjLLokp35AafKhK35yxpgpVl
         7JuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIeaI+pyz9edaKC8rhAD0pXBgqYa76n0HozJz2Z6FictMS6Xju4dMh9hv3Xe4g8jwx2qSeuzFbRCKc6W5NbxQNVDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r2nUT7tUeXBPV1amA3pdhV/pB88UdzYAOfwkRWvdefNQYWC9
	BkD/Xbz6uQ8WFXKPdh9Oj6g6Z5HmD99uM/2Hp+lFssB/n6Chji19SHz8WbjXQ7Eo
X-Gm-Gg: ATEYQzxIPhYITN7VcWVr6TeiZhMGTHrxLBY+iDgfKRm84aSOLOmBcTjNpMskRsTSGfv
	9yD2sn/Iat/Ev+wRt67EB1gMabYSzp+hO83qsfqkDGb8Uyp1fyN4XN/x3Uyi2Oqe2b13IqJNWA9
	gP7uEU2ohZBjySkJ85xM/396ATIA/2kLqSf999py+BpkD/UDdZWvO3Yk/6YlVd2n74BBqbM7ZtL
	PLi4lYSqCw+LOCk6P60cW60iBb4i1kMaXlvuX6RRJP5K1bIsOCYL8Bt5WD0pcjytYlRlmgFMEph
	bwcuOj6I24nqx2mJpONRmtc68b7QmmHM70OV2hO+OcvvRTNw7VSeJp88JFwEZSVWNJ8wih5Y9DQ
	li9aJ/Er1xUTHQW6O/6KpDntd8mjgnq1z5p04f1dQRhN1Rota2O9lxtzGdnlcS8OIxWWiwYGq3p
	dd/pjtFKqLJkiaXBMSVyIplU7reC3TpBf8x2kAN1hu9htzEIU/Q7RYp8B/faejmnfqXa5ZsaF6e
	A5tjEe+n2+W66g0y4TfTl1FolEhPPpFIMO3RErdVa0CG7T3
X-Received: by 2002:a05:6820:996:b0:67b:b6d2:6d5c with SMTP id 006d021491bc7-67bb6d2731dmr3269623eaf.40.1773125264724;
        Mon, 09 Mar 2026 23:47:44 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb666de5bsm2600618eaf.7.2026.03.09.23.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:47:44 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v3 2/2] tracing: drain deferred trigger frees if kthread startup fails
Date: Tue, 10 Mar 2026 00:47:15 -0600
Message-Id: <20260310064715.527906-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310064715.527906-1-atwellwea@gmail.com>
References: <20260310064715.527906-1-atwellwea@gmail.com>
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
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d5230b759a2d..428b46272ac8 100644
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
@@ -56,30 +89,50 @@ void trigger_data_free(struct event_trigger_data *data)
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
+
+		trigger_start_kthread_locked();
 		/* Check again after taking mutex */
 		if (!trigger_kthread) {
-			struct task_struct *kthread;
-
-			kthread = kthread_create(trigger_kthread_fn, NULL,
-						 "trigger_data_free");
-			if (!IS_ERR(kthread))
-				WRITE_ONCE(trigger_kthread, kthread);
+			llist_add(&data->llist, &trigger_data_free_list);
+			/* Drain the queued frees synchronously if startup failed. */
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

