Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F32EAB6B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544238; cv=none; b=VJ74JDMAc7mqT39W/fVoYtjWjUqOiY1BXrYjAFdji/RytGUw2n0vKLMJhfGfsHEnoibIwa/558dLhac8QOMFDMPMiLt/L7VtCwYFVfGDLYQBFiOBADYNkg8NnFgb0glVRjPVNLjE2lQUy2kEK2fRMjWEjIwK+moPrrEnmJnPhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544238; c=relaxed/simple;
	bh=9H/CK9eBVT/+AVbQ22bGCIRSfnchLRGOnFXwVOBU8cA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e5LaKiPykfI3yKNmnadsLJdD/J6Saj1hHCQkLaeWXOmQB+NUYpm3bkYRuGS5Zybs7W2X2xzLMAfWdyi8IQ99xM/eMKUC1swK8i3UOmtLDJC6E4xdr2lWsP8VKFhzPtHyCycx1V/XFx77UdaAk2ECzm7DNfXcUXpQ3qfCOKlFSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQxvcA94; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQxvcA94"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1678498eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771544234; x=1772149034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMf1qxcGK6Wxv/U+V8Of3DjwHpI1qGbRPjrj7xoTTd8=;
        b=WQxvcA94E4zT+6G8yCf0Rb87VMBLPcx9fTGAeihx63siW8n2Lvs2JTneISdUlNrqvP
         gGgJC8Hig8T/iPHdEtpLpIXIDyswM1ddv7bf63zyH/72iZs0VK0lsS7EIXeD6usv5SZo
         tYYbdCmS3exXiHvrXqL51jmB4efcuSE784OLBIMCLzAO8OUQqx+X1Y+T6WgjJFg0dtia
         7NMSsXHTg57jvvUDiaEjLB/fpGYj460I2pOykj9ZVMz2fKYrIwOWVB2YakTAmj0Z6cja
         Y7G8RqWwzLi/tv9jUOaSfaZSNa3c2n0yOBG30M7s2r0kRVYewQrYe6LYMDXIuu0VC+cX
         VdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544234; x=1772149034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMf1qxcGK6Wxv/U+V8Of3DjwHpI1qGbRPjrj7xoTTd8=;
        b=g5aRge0CNP1kkOLenVGUvTLb0CCgfs/6PiMnmzVxv1h4LDSDs+4C/w++2Vxg+eeOYO
         44UOHO4dl2V6AbCLdaIhgSd4RA/vGVV/5goalhvjp2HB3K1czNMerGSXc3Ro1njOMQDC
         eL5M+YmX6IkD42+8u/1FE1vCbP4tvoH016N9OVeb/hgfILOWwjzD4MsybYhtHYz0N87a
         dj2W+X2s46v9e3t+0I6waA1IYL92L0oz6TV6g6SU+twZ4UKP8boMt5c4K40LRryx6mqv
         axX2h7JmERh3x95BW9nxH3X/QwZJTwZT7+p/iSbzVKXV5ekpdf8ueuNqjxih0Uwr83zF
         S3hw==
X-Forwarded-Encrypted: i=1; AJvYcCWLGDKV7le8023vGTaf5YGQrANrrXURrUZdYsghU8wi5EHJCn3YOhnd5n8Cj/HmIZ8MFZ2SzbQKbSNoHGb20F0u3Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEXznxl0YBE3f2AZXAjSDeKXYcOf7FyvN12ez1071uk2+HLWX
	JqZ4b4cznZ7k/c/YcuXKdNqiF63wkpXQQIaGmUYI3fzcsTjkQL+r5Te9BX1IHeJE62KPXhaB0xa
	kVGGeEvQpOSG+EDwHFE9SfhXuIQ==
X-Received: from dybic28.prod.google.com ([2002:a05:7300:c71c:b0:2ba:8e16:e465])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:3108:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2bd501701e4mr3357396eec.20.1771544233484;
 Thu, 19 Feb 2026 15:37:13 -0800 (PST)
Date: Thu, 19 Feb 2026 15:36:56 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219233708.1971199-1-kaleshsingh@google.com>
Subject: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread context
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Minchan Kim <minchan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>, 
	Wander Lairson Costa <wander@redhat.com>, Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rss_stat trace event allows userspace tools, like Perfetto [1],
to inspect per-process RSS metric changes over time.

The curr field was introduced to rss_stat in commit e4dcad204d3a
("rss_stat: add support to detect RSS updates of external mm").
It's intent is to  indicate whether the RSS update is for the
mm_struct of the current execution context; and is set to false
when operating on a remote mm_struct (e.g., via kswapd or a
direct reclaimer).

However, an issue arises when a kernel thread temporarily adopts
a user process's mm_struct. Kernel threads do not have their own
mm_struct and normally have current->mm set to NULL. To operate
on user memory, they can "borrow" a memory context using
kthread_use_mm(), which sets current->mm to the user process's mm.

This can be observed, for example, in the USB Function Filesystem
(FFS) driver. The ffs_user_copy_worker() handles AIO completions
and uses kthread_use_mm() to copy data to a user-space buffer.
If a page fault occurs during this copy, the fault handler executes
in the kthread's context.

At this point, current is the kthread, but current->mm points to the
user process's mm. Since the rss_stat event (from the page fault)
is for that same mm, the condition current->mm == mm becomes true,
causing curr to be incorrectly set to true when the trace event is
emitted.

This is misleading because it suggests the mm belongs to the kthread,
confusing userspace tools that track per-process RSS changes and
corrupting their mm_id-to-process association.

Fix this by ensuring curr is always false when the trace event is
emitted from a kthread context by checking for the PF_KTHREAD flag.

[1] https://perfetto.dev/

Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of external mm")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/trace/events/kmem.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 7f93e754da5c..cd7920c81f85 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -440,7 +440,13 @@ TRACE_EVENT(rss_stat,
 
 	TP_fast_assign(
 		__entry->mm_id = mm_ptr_to_hash(mm);
-		__entry->curr = !!(current->mm == mm);
+		/*
+		 * curr is true if the mm matches the current task's mm_struct.
+		 * Since kthreads (PF_KTHREAD) have no mm_struct of their own
+		 * but can borrow one via kthread_use_mm(), we must filter them
+		 * out to avoid incorrectly attributing the RSS update to them.
+		 */
+		__entry->curr = current->mm == mm && !(current->flags & PF_KTHREAD);
 		__entry->member = member;
 		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
 							    << PAGE_SHIFT);

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.53.0.371.g1d285c8824-goog

