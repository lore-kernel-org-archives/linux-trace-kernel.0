Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297C436BC8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443570; cv=none; b=EX2KszFaXiyZZfAkNDIO2PWevSH45dyALgXvZDAqfmziRaS2bWQyKeOk4vzlfwAyHy2WitG7JCD0LOU0OOFx7i+q6QLZHzauT1YAGTRW5CGPskiZ7cQk7bCXzxyl3YMdhiVz8e6xSD441SiE46fqxRh1j7KIkUp4htFNhzZ4yQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443570; c=relaxed/simple;
	bh=IbzacERZxkdbhBnVGPfmgV70UZfjqVsoR6fFSzWDirM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk9UJ2p0i9rjwDAN9a7VS2cgefr5RtOtPcBNwe5yhubD9ZWuWG47vKKmSeOpYq9BCRuQ93Y+3Wr5b8iBT5VGOXb46ltu6xtvCHQfcRZ4+34vU+73WK04FCDbyFvn9/2ededqaH8eydFAWBj7YNf4ev2VyH8RuQwILGPTd53XRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+tiWQpz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+tiWQpz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e51d3d83cso226970885a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443568; x=1784048368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVxjDIBvMD/d1nBn6wsLhQImx82kCNbQVjkvw4T/T4g=;
        b=W+tiWQpziejfrmmmk3t3KWaUni1s4w/999PZ8keGf/KUDeMrC1tvL/+7DwMRhb5bGu
         FdEXTzqNDalG5t619idmokKb+crdXbJ50pcDlGY0Dbkq36PonLe/7pY/98TuTOOQlJ4B
         afaZtH18PBW02g06Cr1SidQ90y+A1BAcXYtJi5mKiKQAosTItwNidzxIUTZ6SumZQKXR
         lmz4sbw6nQAAi36taITjJccDosN6je52di8AxinwffpJEAb6FVTrKUUQ23bqXaUkaD5L
         9ZJ63n7atGlRIBeD9bt4nXvhDZ8gm2otHAYT5PRFNd/tHngv0ywI2kQa1taYHdrNfdx2
         FtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443568; x=1784048368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NVxjDIBvMD/d1nBn6wsLhQImx82kCNbQVjkvw4T/T4g=;
        b=lRkUP6JrWu+UbC0KOBskd4wGWgYjkJRKrxJ79JNdPdVjueFzAh83H8E3hnuYB24Au2
         RXu/UDNG1EAIaiLNlhh+939cRrEtakcAvI2NUiTEI0AN0Xms0unl9otdWV10Vol7F4xv
         w7l4LQ4nwYrFk7WKAgSdaVyC+InNPdUGaUdfFzROf2kMEwluyY8eyXPo6LTZxbQxMYd7
         ENxO7DbxY4gI9o0I8DWw1cuPWKs21O+PugyzaysYl6YjytbdUkE3p32mtyftYKqh2BLu
         7M4HgK5Fe6TwdUrsho2MyicQWO4vGELH7ZcKH+EdtaAPKkHxkOudlYGiBeSjt7w91+wD
         Vbgg==
X-Forwarded-Encrypted: i=1; AHgh+RqcuRgnmCSFBUw9d0c10VXmXn+9vzfzzRafEJa4k3A/2eUkHWRVfb4RcmLyWvn9SsXG2blaAKNbe5+n0r2h3Rhxh+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGwQ45ocxB4++6n2V2Lw1INg1y3HXyZ3gkp9bERod1iLuZxmj
	qDkvbPI7FmM1jaR9PcHdTKcMaIJNCncdxwf8+omS1LkGbhDnR88iqCtj
X-Gm-Gg: AfdE7cmOjKKUBJ65p8oJUCAmMH+/J2ByRtVzVlqeTEjqx3U+0HEz1V6sd5pS4HN/O+z
	+7yah6Pr6g4x5fDIpZLEbKJRm412gg7KaH6GBjQbiuQU3pjnzMbGe20H8GtNr8a7gN/glyrahdv
	OynsImth8V5tT8NReXX/FV1PxdpOogUxK5KMkrKNnHd0oVMm/Vhqi3GeJJTxNBiFCbBxnTx2+sF
	2PVS+THazAI6hWx3MtxEOfygScXF7MjE+d7/6h6GbgbVljpvJYh1rwol2qs/YjUiu/XwF6B51xS
	UCy6ZHtD1O50d/apv+eVO7Nt0Rl1IWyuI20RUTiadsGECXUtbA8kSCxSxuf90KpnGmTp04AQgN8
	+T+/kYr0g0qYVTFC5nfSS68XFtAZrbrRF/qoOjGi2B0cL3mkrxyMcsOExCx6BQgTFkcebJOapM9
	zPFnBP+HwlFBFDjNWiHRz6Z+8mZfahZnr12oT1SmvHkqytQi4+am6tk9fWxzxxQY7SCE2OFhuII
	JEzcalDh08QIOi8kxMQGPEHUifWkvir
X-Received: by 2002:a05:620a:1982:b0:92b:6805:eae5 with SMTP id af79cd13be357-92ebb710875mr754132885a.66.1783443567666;
        Tue, 07 Jul 2026 09:59:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1209145385a.20.2026.07.07.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] tracing/user_events: fix use-after-free in user_event_mm_dup()
Date: Tue,  7 Jul 2026 12:59:11 -0400
Message-ID: <20260707165912.2560537-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707165912.2560537-1-michael.bommarito@gmail.com>
References: <20260707165912.2560537-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

user_event_mm_dup() walks the parent mm's enabler list locklessly under
rcu_read_lock() during fork() (from copy_process()); it does not take
event_mutex:

	rcu_read_lock();
	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link)
		enabler->event = user_event_get(orig->event);

user_event_enabler_destroy() removes an enabler from that list with
list_del_rcu() and then, without waiting for a grace period, drops the
enabler's user_event reference with user_event_put() and frees the enabler
with kfree(). A reader that loaded the enabler before the list_del_rcu()
can still be walking it, which leads to two use-after-frees:

 - kfree(enabler) frees the enabler while that reader dereferences
   enabler->event.

 - user_event_put() may drop the last reference to the user_event, which
   is then freed (via delayed_destroy_user_event() on a work queue), while
   the same reader does user_event_get(orig->event) on it.

Both are reachable by an unprivileged task that can open user_events_data:
one multithreaded process that registers an enabler and then concurrently
unregisters it and calls fork() triggers the race. KASAN reports a
slab-use-after-free in user_event_mm_dup() during clone(), with a
"refcount_t: addition on 0" warning when the user_event is freed.

The enabler use-after-free was found first; the user_event one was reported
by XIAO WU, and the earlier enabler-only fix did not address it.

Defer both the user_event_put() and the kfree(enabler) to a work item
queued with queue_rcu_work(), so they run only after an RCU grace period,
once all readers walking the enabler list have finished. The put must run
in process context because user_event_put() takes event_mutex on the last
reference, so a work queue is used rather than call_rcu(). The now-unlocked
put lets the locked argument of user_event_enabler_destroy() be removed;
all callers are updated.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Reported-by: XIAO WU <xiaowu.417@qq.com>
Closes: https://lore.kernel.org/all/tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com/
Suggested-by: Beau Belgrave <beaub@linux.microsoft.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Since v1 (the enabler-only fix "tracing/user_events: fix use-after-free
of enabler in user_event_mm_dup()", being dropped from for-linus):
 - also fix the user_event-object UAF reported by XIAO WU; defer both the
   put and the free with queue_rcu_work() instead of kfree_rcu().
 - drop the locked argument now that the put runs from the work item.
 - add patch 2 for the selftest teardown timing.

 kernel/trace/trace_events_user.c | 39 ++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38b..8c82ecb735f41 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,9 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+
+	/* Defer the event put and enabler free past an RCU grace period. */
+	struct rcu_work		put_rwork;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -396,17 +399,39 @@ static struct user_event_group *user_event_group_create(void)
 	return NULL;
 };
 
-static void user_event_enabler_destroy(struct user_event_enabler *enabler,
-				       bool locked)
+static void delayed_user_event_enabler_put(struct work_struct *work)
 {
-	list_del_rcu(&enabler->mm_enablers_link);
+	struct user_event_enabler *enabler = container_of(to_rcu_work(work),
+			struct user_event_enabler, put_rwork);
 
 	/* No longer tracking the event via the enabler */
-	user_event_put(enabler->event, locked);
+	user_event_put(enabler->event, false);
 
+	/* Run from queue_rcu_work(), the RCU grace period has elapsed */
 	kfree(enabler);
 }
 
+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
+{
+	list_del_rcu(&enabler->mm_enablers_link);
+
+	/*
+	 * The enabler is removed from an RCU-traversed list
+	 * (user_event_mm_dup() walks mm->enablers under rcu_read_lock() only),
+	 * and readers there dereference enabler->event and take a new ref on
+	 * it. Both the put of that event reference and the free of the enabler
+	 * therefore have to wait for a grace period so no reader can be looking
+	 * at the enabler or racing the last put of its event.
+	 *
+	 * The put itself must not run in RCU context: when it drops the last
+	 * reference user_event_put() takes event_mutex, which cannot be taken
+	 * from a softirq/RCU callback. Defer both to a work item scheduled
+	 * after a grace period via queue_rcu_work().
+	 */
+	INIT_RCU_WORK(&enabler->put_rwork, delayed_user_event_enabler_put);
+	queue_rcu_work(system_percpu_wq, &enabler->put_rwork);
+}
+
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
 				  int attempt)
 {
@@ -464,7 +489,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 
 	/* User asked for enabler to be removed during fault */
 	if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
-		user_event_enabler_destroy(enabler, true);
+		user_event_enabler_destroy(enabler);
 		goto out;
 	}
 
@@ -764,7 +789,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 	struct user_event_enabler *enabler, *next;
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
-		user_event_enabler_destroy(enabler, false);
+		user_event_enabler_destroy(enabler);
 
 	mmdrop(mm->mm);
 	kfree(mm);
@@ -2645,7 +2670,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
-				user_event_enabler_destroy(enabler, true);
+				user_event_enabler_destroy(enabler);
 
 			/* Removed at least one */
 			ret = 0;
-- 
2.53.0

