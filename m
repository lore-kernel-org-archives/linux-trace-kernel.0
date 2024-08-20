Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267918E023
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159338; cv=none; b=EOVFEUDvOkNmGWZBhpGB4HB+gyaAgIBJoGDWcBFqD2TydB2LYdjskCMIPeqG9RefOqSoH63hvnSpZUSY/8bCdE36IRInR7WRcYsbKx+pedH5doCJUpjC9XGYtscudgVbnHkjaFSWIvbruJoowtN8LmhtBW19rB40wcf57bur54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159338; c=relaxed/simple;
	bh=xY4wG0jEDIlBuxkTt2WpYkRP670ebohBncjf4GN2ASM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBqrcdZOlXxJsngkdEwu0xZN6wyZCg4f1CAHD7rpoUD1+vyueSbbp/t6+jt/JWnHI4jVzk1nynP6W+SJI0hD7ybt/eD+xP+60JqXTXwh7F5M5tq9O/l43B7tbHg1DYe2xuWnt3bKVqEbMi175BL8sbyDAavHxsjqPNgDSOpijrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cObfdsGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cObfdsGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724159335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WCVrCRGEpid7P4N8fVY0SdNoLiD5BnR70luqDpNkvNY=;
	b=cObfdsGZvue7pqRni1EeOZNHxEHQJlllJDhGjf7WnwMaxzLa+JqPmVsFToDOhfsb1JeunZ
	619WzhxwvCa1k0UQ3Sh2VolOLk6kcYa/7akPJoS8LCs/9iR8miMg5QXJOCFISokN57h7+U
	itANMU0ZHT28ic5D8CuBg0V0Et75jNI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-myvdiKBlNN6RXfgGZ_5rQg-1; Tue,
 20 Aug 2024 09:08:50 -0400
X-MC-Unique: myvdiKBlNN6RXfgGZ_5rQg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E3ED18DB7F3;
	Tue, 20 Aug 2024 13:08:48 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F45819560AA;
	Tue, 20 Aug 2024 13:08:46 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
Date: Tue, 20 Aug 2024 15:00:01 +0200
Message-ID: <20240820130001.124768-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

When running timerlat with a userspace workload (NO_OSNOISE_WORKLOAD),
NULL pointer dereference can be triggered by sending consequent SIGINT
and SIGTERM signals to the workload process. That then causes
timerlat_fd_release to be called twice in a row, and the second time,
hrtimer_cancel is called on a zeroed hrtimer struct, causing the NULL
dereference.

This can be reproduced using rtla:
```
$ while true; do rtla timerlat top -u -q & PID=$!; sleep 5; \
 kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done
[1] 1675
[1]+  Aborted (SIGTERM)      rtla timerlat top -u -q
[1] 1688
client_loop: send disconnect: Broken pipe
```
triggering the bug:
```
BUG: kernel NULL pointer dereference, address: 0000000000000010
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 6 PID: 1679 Comm: timerlatu/6 Kdump: loaded Not tainted
6.10.0-rc2+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
RIP: 0010:hrtimer_active+0xd/0x50
RSP: 0018:ffffa86641567cc0 EFLAGS: 00010286
RAX: 000000000002e2c0 RBX: ffff994c6bf2e2c8 RCX: ffff994b0911ac18
RDX: 0000000000000000 RSI: ffff994b02f10700 RDI: ffff994c6bf2e2c8
RBP: ffff994c6bf2e340 R08: ffff994b158f7400 R09: ffff994b0911ac18
R10: 0000000000000010 R11: ffff994b00d40f00 R12: ffff994c6bf2e2c8
R13: ffff994b02049b20 R14: ffff994b011806c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff994c6bf00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 0000000139020006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x75/0x170
  ? mt_destroy_walk.isra.0+0x2b3/0x320
  ? exc_page_fault+0x70/0x160
  ? asm_exc_page_fault+0x26/0x30
  ? hrtimer_active+0xd/0x50
  hrtimer_cancel+0x15/0x40
  timerlat_fd_release+0x48/0xe0
  __fput+0xed/0x2c0
  task_work_run+0x59/0x90
  do_exit+0x275/0x4b0
  do_group_exit+0x30/0x80
  get_signal+0x917/0x960
  ? vfs_read+0xb7/0x340
  arch_do_signal_or_restart+0x29/0xf0
  ? syscall_exit_to_user_mode+0x70/0x1f0
  ? syscall_exit_work+0xf3/0x120
  syscall_exit_to_user_mode+0x1a0/0x1f0
  do_syscall_64+0x89/0x160
  ? clear_bhb_loop+0x25/0x80
  ? clear_bhb_loop+0x25/0x80
  ? clear_bhb_loop+0x25/0x80
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f75790fd9ec
...
  </TASK>
```

Fix the NULL pointer dereference by checking tlat_var->kthread for zero
first in timerlat_fd_release, before calling hrtimer_cancel.
tlat_var->kthread is always non-zero unless the entire tlat_var is zero,
since it is set to the TID of the userspace workload in timerlat_fd_open
under a mutex.

Cc: stable@vger.kernel.org
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Co-developed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 kernel/trace/trace_osnoise.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..6d2b39da4dce 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2572,6 +2572,7 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	struct osnoise_variables *osn_var;
 	struct timerlat_variables *tlat_var;
 	long cpu = (long) file->private_data;
+	int ret = 0;
 
 	migrate_disable();
 	mutex_lock(&interface_lock);
@@ -2579,6 +2580,12 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
+	if (!tlat_var->kthread) {
+		/* the fd has been closed already */
+		ret = -EBADF;
+		goto out;
+	}
+
 	hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
@@ -2593,9 +2600,10 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 		osn_var->kthread = NULL;
 	}
 
+out:
 	mutex_unlock(&interface_lock);
 	migrate_enable();
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.46.0

