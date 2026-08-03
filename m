Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF235F179;
	Mon,  3 Aug 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750069; cv=none; b=Nq/AHbcZKUPZJam7O7r+o39+GCb3jHcGrNsRS3NL1AkCei2qBifO7q9omDbhCxPZbpyOGcA2mS874SqgM2Ul4+ta2djhKtYnKlKM8DH1GyPVKUz6fT6UU01CCvqi30Da+ywiwjCH7q0/LNAcn++wl9N1Fi9jGv/SVH7pNda1oUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750069; c=relaxed/simple;
	bh=nAMFZTHCttgJCNHYFXGQb+9h1FTNbn4pBwLZITTZOvg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iGHxIkLC0K89aDjoD8AMjLvFwEZJd4YSz/Y6aM1JBrz5Bxf+Le/z0OWnQGfiY20GoFL6g9VVEDBNoWP8xnShGTzj0BYb3T9CNTUrpmFIX3yBWZjT2fuw2iDXiA+LiWjoUaqPlGwmMk+aLToBrtycDJO1ZC0suJjVfUoW3GMQgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07509217|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0118639-0.030535-0.957601;FP=13175772313018746238|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.icYKc3I_1785750055;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.icYKc3I_1785750055 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 03 Aug 2026 17:40:56 +0800
Message-ID: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
Date: Mon, 3 Aug 2026 17:40:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
From: Michael Wu <michael@allwinnertech.com>
Subject: [PATCH v4] tracing: Fix race between update_event_fields and,
 event_define_fields
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
event_mutex) populates class->fields via list_add(), while
update_event_fields() (called from the pri=0 notifier path via
trace_event_update_all) traverses class->fields protected only by
trace_event_sem.  These are two different locks guarding the same
data structure, so during cross-module loading a reader on one CPU can
observe partially initialized list nodes being concurrently added by a
writer on another CPU.

On arm64 with weak memory ordering, __list_add() writes to two
different cache lines:

        next->prev = new;                // (1) ordinary store
        new->next = next;                // (2) ordinary store
        new->prev = prev;                // (3) ordinary store
        WRITE_ONCE(prev->next, new);    // (4) release store

The store buffer can drain (2) and (4) independently since they target
different cache lines.  A remote CPU may observe (4) before (2): it
sees prev->next pointing to the new node, but the new node's link.next
is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
list_for_each_entry() derives field == NULL from link.next == 0 and
crashes at field->type (offset 0x18):

  Unable to handle kernel access ... at virtual address 0000000000000018
  pc : update_event_fields+0xf8/0x368
  Call trace:
   update_event_fields+0xf8/0x368
   trace_event_update_all+0x7c/0x2b4
   trace_module_notify+0x4c/0x1dc
   notifier_call_chain+0x84/0x168
   blocking_notifier_call_chain_robust+0x64/0xd4
   load_module+0x10c8/0x123c
   __arm64_sys_finit_module+0x230/0x31c

Fix by holding event_mutex in trace_event_update_all() before
down_write(&trace_event_sem).  This serializes the reader against
event_define_fields() which takes event_mutex for the entire
write-side critical section.  The lock ordering event_mutex ->
trace_event_sem is already established at three other sites
(trace_remove_event_call, event_trace_add_tracer,
event_trace_del_tracer), so this introduces no ordering conflict.

An alternative of placing mutex_lock inside update_event_fields() was
considered but rejected -- it would invert the established lock
ordering (trace_event_sem -> event_mutex) and risk ABBA deadlock.

Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 956692856fa8..9632788da5af 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 	int last_i;
 	int i;
 
+	mutex_lock(&event_mutex);
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
 		/* events are usually grouped together with systems */
@@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 		cond_resched();
 	}
 	up_write(&trace_event_sem);
+	mutex_unlock(&event_mutex);
 }
 
 static bool event_in_systems(struct trace_event_call *call,
-- 
2.29.0
