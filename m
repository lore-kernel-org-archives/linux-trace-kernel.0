Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4B345725;
	Mon, 10 Aug 2026 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343564; cv=none; b=K9l4+UBnTuf1aicOlG5ijlooFdA/BEiuj0cw3rZcQN/te+DZkvRm2WmKaKPoOAcPv34scI6I4CWDwTVjiRtPMYc0SZFVkaxcLq26onIrkIsVixnRADCmowOClO4bVrF8IiT1cw31oKsB2NfX5I1aGfP8JT6eoSqaua4TeSElodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343564; c=relaxed/simple;
	bh=27k1X9vAM1qMy4wwY7ziUz5/u+StbIUNBHGh0LN5BKs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qwEtx5eRjKk01litHgAZwJLenStizBVKFaedQO+fNKQwKmFEKyscgnEYITmsnefiJEV5POsdNJMtSp7lnMoJGkRsXEArfaGDo0QMxJAZnNP4lD9bnXerijb252sX4gZE/VEpM+aGqA4QBoam2NJWfYJw0lA1/5aVSWQE81ksF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1086931|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0119426-0.031275-0.956782;FP=13247847429411803131|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iiCXqdE_1786343550;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.iiCXqdE_1786343550 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 14:32:31 +0800
Message-ID: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
Date: Mon, 10 Aug 2026 14:32:30 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
From: Michael Wu <michael@allwinnertech.com>
Subject: [PATCH v5] tracing: Fix race between update_event_fields and,
 event_define_fields
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following sequence may leads race between event_define_fields()
and update_event_fields():
  CPU0 (module A, pri=1 notifier)        CPU1 (module B, pri=0 notifier)
  ===============================        ===============================
  event_define_fields(call_A)            trace_event_update_all()
    for each f:                            list_for_each_entry(...,
      list_add(&f->link,                                &ftrace_events)
               &class->fields)               -> finds call_A
        f->link.next = next;        (2)
                                           update_event_fields(call_A)
        WRITE_ONCE(class->fields->next,
                   &f->link);       (4)
                                             list_for_each_entry(field,
                                               &class->fields, link)
                                             -> field = class->fields->next
                                                  = &f->link
                                                  = f (offset 0)
                                             -> arm64 weak ordering:
                                                (4) visible before (2)
                                                field->link.next == 0
                                             -> next iteration:
                                                field = (void *)0 = NULL
                                             -> crash at NULL->type (0x18)

This produces the following panic:
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

Fix by taking event_mutex in trace_event_update_all() before
trace_event_sem.

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
