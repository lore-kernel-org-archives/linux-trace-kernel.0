Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A1EF36C;
	Mon,  8 Sep 2025 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299461; cv=none; b=DJcacGkALnGN3DmzP5D7OtQnMbWaKmO48G0sKQc9/QrUJc/Hrn6ag/c/3w5G+1g+hhsqvHcaTgVkLycimXb0svtevscqkP1kH74J6ea7cY9m0e8E9nUMMTF3ZzV4WVZevFyjXpbptlpWyKjLB0u7NhyUsk1itN6yAt+jbWii0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299461; c=relaxed/simple;
	bh=EI1whyu/GvMcQIxl+6qxm12pxHkQFNMZ57xYopKAUUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clo04aGP24Tuul5psPkSwJycW6i0woVCumUValf8DPj83sfWBbaDfI2+XjGY1t6fxOwgp1WjtSGP/XImecqCNWIZew9WXBdvEIvLp41E7jMxETTeqCDDrdwdpFs0x6UIa+nsISjcFBmSrI+qcnH4P8yYgczq1Xt9WX2AE7Qw4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cKrrG5kFnzYQv89;
	Mon,  8 Sep 2025 10:44:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4BADB1A0B4C;
	Mon,  8 Sep 2025 10:44:13 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgAHnor3Qr5o97YRBw--.44507S2;
	Mon, 08 Sep 2025 10:44:09 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Silence warning when chunk allocation fails in trace_pid_write
Date: Mon,  8 Sep 2025 02:46:58 +0000
Message-Id: <20250908024658.2390398-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHnor3Qr5o97YRBw--.44507S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UtF4rtw45CF4ktFWfGrg_yoWrGFy5pF
	y5Crn3Kr4rJF1jyF48XF18Gry8Jas5AFy7JF17ur1rAF12kr1jgF47XryUXw15Jw4UJFy3
	tw1qyw4rKr4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller trigger a fault injection warning:

WARNING: CPU: 1 PID: 12326 at tracepoint_add_func+0xbfc/0xeb0
Modules linked in:
CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G U 6.14.0-rc5-syzkaller #0
Tainted: [U]=USER
Hardware name: Google Compute Engine/Google Compute Engine
RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff
RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
 register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
 register_pid_events kernel/trace/trace_events.c:2354 [inline]
 event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

We can reproduce the warning by following the steps below:
1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
   and register sched_switch tracepoint.
2. echo ' ' >> set_event_pid, and perform fault injection during chunk
   allocation of trace_pid_list_alloc. Let pid_list with no pid and
assign to tr->filtered_pids.
3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
   tr->filtered_pids.
4. echo 9 >> set_event_pid, will trigger the double register
   sched_switch tracepoint warning.

The reason is that syzkaller injects a fault into the chunk allocation
in trace_pid_list_alloc, causing a failure in trace_pid_list_set, which
may trigger double register of the same tracepoint. This only occurs
when the system is about to crash, but to suppress this warning, let's
add failure handling logic to trace_pid_list_set.

Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1b7db732c0b1..f2a84d1ce4b7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -834,7 +834,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		/* copy the current bits to the new max */
 		ret = trace_pid_list_first(filtered_pids, &pid);
 		while (!ret) {
-			trace_pid_list_set(pid_list, pid);
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
 			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
 			nr_pids++;
 		}
@@ -871,6 +874,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		trace_parser_clear(&parser);
 		ret = 0;
 	}
+ out:
 	trace_parser_put(&parser);
 
 	if (ret < 0) {
-- 
2.34.1

