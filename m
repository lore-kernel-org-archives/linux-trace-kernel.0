Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BE47D44D;
	Fri,  7 Aug 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117404; cv=none; b=WgO9cdjcq1fk7IppQMOq8RymaGxPPhr6P+TLIZplqhuZgepVZrr5zT/ccolM4PiEInofz0ngsy2Fi5pqGITzA7RqmPIHjkHsgVqEHIx7cHL4YYRs9hSLM9B8pMHxWO8ivqfH+quZqu7RvFuUFQY/UYIXR+Jj3BBhdktM6AifFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117404; c=relaxed/simple;
	bh=5BwIXjNXOqIB3B5MrRmGoSzyplQVb3VXUkGn9Eu6Qcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L27v1I1nZrRtTT+SyeMeUgVJTanBn1uyTphpYUvHUlpf3CZCAETgkIsoubYFot/+nsR5YXGIQ7m1MQGmgRnNh3sI260TiFfBE6MmAZO6igbER/Km7IfF9v2dyvFLSCdZnyTQp+2qPOtENtBGtMdPMdO5gPiWqdfYIIkGdfr6T80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zru8Dznm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zru8Dznm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nh
	su+hO92dsCdty2EoE+vFnRNquHPYHyd8w06LW7iqM=; b=Zru8Dznm0nGuL1Fv1t
	ZTeErClmWwlvhYYNdCZWlC6FgErHeGo5nu/gj5FMOriLZ6XximrIdtrczgmQVyvO
	3QfDkhSQrsm/FrJvX9pA9zot/7n0QgNMF8JKaPvP/hdI8GPLSo/rndVvGFoAkbFh
	wdGubhZpZK2ErwgR6JECKaqK0=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3XrHy_HVqPDDBLA--.8549S2;
	Fri, 07 Aug 2026 23:42:43 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] ring-buffer: Fix crash passing ERR_PTR to kthread_stop()
Date: Fri,  7 Aug 2026 23:41:46 +0800
Message-ID: <20260807154145.2846521-2-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA3XrHy_HVqPDDBLA--.8549S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWrKw4DZr1DZw17Gr13XFb_yoW8AF4xpr
	W5KF4UKr48AF4kZw4Uu3WF9ry7JFs8Z3W7Gr97Aw1rJF1UKw45Xr9xZFyYqrWqk3yrX343
	Kr98XrWvkan8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHCJkUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRNz0mp1-POEBAAA3j

In test_ringbuffer()'s out_free cleanup loop, the check
`!rb_threads[cpu]` only catches NULL entries and misses entries that
hold an ERR_PTR.

rb_threads[] is static, so unassigned slots are NULL. But when
kthread_run_on_cpu() fails for a cpu, it stores ERR_PTR(-ENOMEM) (or
-EINTR) in rb_threads[cpu] before the creation loop jumps to out_free.
That entry is non-NULL, so the old `!ptr` check does not break, and the
cleanup proceeds to call kthread_stop() on the ERR_PTR. kthread_stop()
then dereferences the bogus pointer, crashing the kernel during the
late_initcall self-test.

crash logs:
  BUG: kernel NULL pointer dereference, address: 000000000000001c
  Oops: 0002 [#1] SMP NOPTI
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc6-dirty #7 PREEMPT(lazy)
  RIP: 0010:kthread_stop+0x2e/0x220
  RBX: fffffffffffffff4
  CR2: 000000000000001c
  Call Trace:
   <TASK>
   test_ringbuffer+0x1ec/0x650
   do_one_initcall+0x6c/0x2c0
   kernel_init_freeable+0x21d/0x420
   kernel_init+0x15/0x1c0
   ret_from_fork+0x21b/0x320
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fixes: 64ed3a049e3e ("ring-buffer: make use of the helper function kthread_run_on_cpu()")
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3aa8..6af7e36ca526 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -8214,7 +8214,7 @@ static __init int test_ringbuffer(void)
 
  out_free:
 	for_each_online_cpu(cpu) {
-		if (!rb_threads[cpu])
+		if (IS_ERR_OR_NULL(rb_threads[cpu]))
 			break;
 		kthread_stop(rb_threads[cpu]);
 	}
-- 
2.43.0

