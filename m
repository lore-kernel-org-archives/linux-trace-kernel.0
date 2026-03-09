Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6935A93B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091655; cv=none; b=iBtHLEkHjSGUNP9jkidasH6lAvq0cVocx+aai19q60r/WT5nBLj4FjU7J8ig/SN7dJc8DClY16MUouPIqLfFaYEzfiE1CvVf7PaXeifiZIy8+l1on9H62y8c5Ez0ylFlMEplpDMSYnbWl494P6WR42mRF0xUDHhpFguEWU47yKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091655; c=relaxed/simple;
	bh=6uUkqbS1peCg656T6d9eFVBNAReBUwqE9WarCDhm26M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/olGOsV2jXrKDCxDzfKfFxrciE2gekTAWC4bIFWorO50cW9P2BSqK6XsNfEstWZaWMzyA9VwWqtTpCLuzpmX+hlkeyvspD/a7Hkl9NwEY8xPKlkL0Om4sFsVk6/cmNk6a+dChdENzKSK+i5YzCgXcWKGkTCfmaT8zQ49+qNIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhOW/IH8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhOW/IH8"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67bb021cb80so562196eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091653; x=1773696453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ig39XgKJvqjYKJDvVYNDNH+8fk8f4kr1nnRK9rVXmY=;
        b=RhOW/IH8rJlbjiC5bVwGRCpbaoOYCb0zZVStLFN5KVns1CC9n9ZWf3vxZ+92pxiBRa
         QOvG8WSmj9BmRtN+qtdC2pcszZVXli/7v2z/YzWNC0PCaTchARGhVj1b+9PUaH8e2/CT
         HO8sz4z/O/L9FcHn2nK2AqaYQeesXREQSV/ccVwFX0ZLA0cIbQsr5XAONa7i2DjGo/+h
         rRxG5PG9j4dN7pOkj7xVZueXJVJsT9MViBcNL6P6kfZSQXyBskHoCRdAqWl/T3Ev3WNG
         KG0r70NcK3aT2P8j5MtnSSKgyXmSekF0I91BWscPxT+jU6yTt0uChVJO4cYnnHf9xZww
         jPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091653; x=1773696453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ig39XgKJvqjYKJDvVYNDNH+8fk8f4kr1nnRK9rVXmY=;
        b=l5yvLUcyM7pfe6IspiiuTt6QRefo15jP210uvTuImjdFOd/jSaHRxbfVFHQvUqw6NB
         j2dCHD9jl78jyM5W5Zy++h6KSiPoTDMfDeLxNl8bLNCflgFRqr6C+wMBkl9rWyl3V5Mi
         /4zAvnihrC/Oyo4+rMIpcx63qSUOHQXSKVynCwzaPuHqz3+KcgyxTG2ju8mHJCoNmo52
         BxrTklvcw8Upi1c4s9GHQcCIFZPrwXvtDrZgUbhKnNwGtM3oPzpZSO7S50a6wF1qRAqo
         +MC+rw9VNM2ycTPDCLV9rh+LrgPohlDJlnkV00yM34f/5RzyHBAE8xaGyeksAz68KSen
         Qfxw==
X-Forwarded-Encrypted: i=1; AJvYcCXW6GGIborZuzjXzSlQ8rquKbkc88oqBKUyF1Mmz6y92C69/baS4jSfZkZs/bY/X/ZoPUamDPLaSH/vWv0Dhp4r9Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83sxog8bOrhn2SbLY4bvlfrr6CXIf3V6+Nfw5tmO39oGOobwX
	8G15rkh+wXQjhRqP0gWwbVIsVZr+u+SOD/KOZ+MFKqCE28kHBu/X5Oob
X-Gm-Gg: ATEYQzyNTeicKqfJlqd8B6vUnDgX+pIUFsBcLTUKdejlBHD5HJaYPHT4q3b5ebTtmdj
	SUsOR2V6814GjfmRYuLfKghZ6z2flH0vmxdPVPJwLp9tN5lDwp5/BoHVlm1laeg4XFPuz1XePdU
	JxJZG9OG3PZKx/tIMLz65HOCojpPAwRuECt3xEu64mPKIV22r/Ox0HfyQE8s+r+Y6grq58wWlZx
	UozQxmXRaltP85wa9yjZ8OTg4P75knt20rSge9MJ6AiwdIpV2yWZsO7H/6my5k6EYC0YCqJszAn
	VkcAMiWZMchYGNrepC153Y/LS2+zA1XfdjfzCo+sCAsfvRvmoJ1+DL8aKUpwa+0ccC7vLI5H65c
	HTK+d+2nIqwI/7+qaU/VWE+I34lvVAo149NpOFMHQjK4NinWxHv0srB97ihLIVpElWQNj82PZiK
	99C4Jr2HCc35VFebLP4RhKwc5HqyVdzId6ts9l+hDBjed7mgPDyLO52dfrSP+3Dz6cUxPJTrhHm
	5ThhWUAAMb6UdJK2KGtGafpoc2coldzUgXISI1fkHUDrdl0
X-Received: by 2002:a05:6820:229a:b0:67b:b432:5fbe with SMTP id 006d021491bc7-67bb4326165mr2802956eaf.26.1773091653174;
        Mon, 09 Mar 2026 14:27:33 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb3bb67fbsm2639289eaf.15.2026.03.09.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:27:32 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v2 2/2] tracing: drain deferred trigger frees if kthread startup fails
Date: Mon,  9 Mar 2026 15:27:02 -0600
Message-Id: <20260309212702.13622-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309212702.13622-1-atwellwea@gmail.com>
References: <20260309212702.13622-1-atwellwea@gmail.com>
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
v2:
- Restore the dropped mutex recheck comment
- Clarify the synchronous fallback drain path

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
