Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB63C6A2C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390425; cv=none; b=PPNFCtH4QmqrxxgQveRlU9qHff10oiVH4lNoeIVYjLJ6UUIwnzRkLc0oOIXbKiNc7oOqbk1mVurERMzsyRYlClxwI/aOW2ARp23uZE+HOk0OCdNByIYa+s+tFNdf1xddiUBymxJJB3jJZ+AsTGM2jj7JKOzU5GcR90NQur62Qm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390425; c=relaxed/simple;
	bh=L09Pdu4jTYMba0vdYDQOwGkhkr4NQ6pKytyHLnC88/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7YbCt1gfHWIK8tpsPaPpMZOW8tyttcNuvG+xni6h7fWoUuvE+TGmA0KYn3rBM/qn4igeNe1g2tmj5mNqnR3bTrLBBBxPSEjixjbBGrU7U4RiIK131fKe8HJGebkmkEfaprZ77PhhV/NuklBVhjywLyX9P/j97zJEDfLjLQ90l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydv3b4SK; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydv3b4SK"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-467e8aaa865so1015335b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390423; x=1774995223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcXL9ds+s1rT9KhDOcENbk0kB+36TweaoEN4bRqaOic=;
        b=Ydv3b4SKBfVRyEpG4VPn9JK2tIvQc01B753ozA9kpg4PQ4TWaXkB6PLuDEYylgmv26
         KW2y4+kfBT58AH1/wS0/LGilyLrlAY2J14SEitQYGQmDGQtLPrqDwHseMSaNnq/pJze7
         FcSZ/KTEU+KeomGYQaeFvIxwcCNgid/a1avTOAuQEuzXWtmVyGJ0+ObosJzwMOJ5FiTo
         Fdgvso43WimQ6fa52uFxIp9Lk2n09UjM2JY2kR9kjriEFSBDbQb/MNYlsYXwQ99qZUQY
         pnsNWQRC9BoJBnu1+ypoCRw+7yOnBQolbCle6//QW/fWQ/PzUyLPem7tQiWVjTaGdW8H
         LjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390423; x=1774995223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcXL9ds+s1rT9KhDOcENbk0kB+36TweaoEN4bRqaOic=;
        b=E5Dxf8knQkQpWA/jCpdZmXM5fHYOmTEEpJl6RN0fQ18x6fJPEze+mB3eko77hSvDXb
         7g99N21NbnFyedsoN9HtM4PnTCemvrbqcMC1DZGMBFntHctBFC0EDKVV7lB4KovnH5Cb
         AF90JSbLJmccyY2vewl5IYvkGye9+exJhEnD2/7sDFXfEc4pbgPC16kbiTGaYZ5OSsHd
         oPxgZfPJhJsqgIiVqNOzhOgewfff1GJ4mh4pkxPw7yU2M1QuEUunNrzE9T8u7EW6SOR/
         2RB1VLkBldyRywMX9bhbCaydWj9duB2qA3fVPMhbBhYw07qF+rAnGFz+9S67oxUtGWzJ
         Aakw==
X-Gm-Message-State: AOJu0YznjxVg9woxlwxHQmxTTvJQNnSlPabFicEC9geIE4On774lt9rj
	Kr9XTvEIhX9Y07oQruwTjUhqbXJnmW5BJ8/FqqF6R9e5EkjOuOzRy+JdyMkvZ5LF
X-Gm-Gg: ATEYQzwr9rG08P/6Xy9NdFPHYXGSynZNSQlyVO4gQPcSJ908ArWEGbCxDMpvyVH4v4i
	ks2zruOt1tqvLVjO1P1VHh2madcGozd/r70KYK6Zw2kiNDs036m2IfCrSLHXiA73RYl5wWzDxBw
	jkmdyQBlbSjfPzl+7FKWn+VN2ENhRxwNXkHYhXxt5cKL0PYfYMBSaAQis/6oZSiQuEIYagr7Abr
	mEgxgZQOxuwXr9oMSYo6KxiDxBrHhd39bJ6AJiBmws+tA5aEwIz4dbFgFB0ZomzUJwzHqu02uWQ
	2XI4622RpH6kBRjtIQD43yQNT5FH8K/9BA24QYlOwN12JBK1kv3KHSX+tL4KHKgBP7LOeCGmHC6
	+xg/1YxglXepMtlvjLNHIVh6kZNqqSPufeGp+bXruJ7L/8h3Qx4OFwxoqhoj3zCDhnVuYmiS3yn
	OdCZf860D6uRtSXhApgNjc4ny3VZngVYcRCwHAGICzvlHp9bHDI/NaeSxVxWMXOJKNB3PnycAhS
	g3IyZUktVLLYwzpBA1xnaxgpX8WQ2A+hCQn+L5D6g==
X-Received: by 2002:a05:6808:d4e:b0:467:2584:870d with SMTP id 5614622812f47-46a5c70e830mr645959b6e.48.1774390422889;
        Tue, 24 Mar 2026 15:13:42 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm8966606fac.7.2026.03.24.15.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:13:42 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v4 2/2] tracing: Drain deferred trigger frees if kthread creation fails
Date: Tue, 24 Mar 2026 16:13:26 -0600
Message-ID: <20260324221326.1395799-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324221326.1395799-1-atwellwea@gmail.com>
References: <20260324221326.1395799-1-atwellwea@gmail.com>
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
index d5230b759a2d..655db2e82513 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -22,6 +22,39 @@ static struct task_struct *trigger_kthread;
 static struct llist_head trigger_data_free_list;
 static DEFINE_MUTEX(trigger_data_kthread_mutex);
 
+static int trigger_kthread_fn(void *ignore);
+
+static void trigger_create_kthread_locked(void)
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
+		trigger_create_kthread_locked();
 		/* Check again after taking mutex */
 		if (!trigger_kthread) {
-			struct task_struct *kthread;
-
-			kthread = kthread_create(trigger_kthread_fn, NULL,
-						 "trigger_data_free");
-			if (!IS_ERR(kthread))
-				WRITE_ONCE(trigger_kthread, kthread);
+			llist_add(&data->llist, &trigger_data_free_list);
+			/* Drain the queued frees synchronously if creation failed. */
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
+	trigger_create_kthread_locked();
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
2.43.0

