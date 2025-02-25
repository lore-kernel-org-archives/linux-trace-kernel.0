Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308C267F58;
	Tue, 25 Feb 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486742; cv=none; b=a/R9mLYY0OWTv+pdlJGZFq4UE4I4hyS0yhE8Q95dsySCtLcqPM/XqVK9XosN/zZPu913oClngQNLdCjxSwpM0AWiovf/o0qjAFDAOVBOyUuty6mKERCacXifbgWElw/GugH71c7gJLTv54XHWpbxIj/I57sOk6px2RkhEQew6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486742; c=relaxed/simple;
	bh=h8PDT9P5RGKVlHl1hL6S1sHDxqWxMEzZ0RmWvnH5804=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUGemEcjI0hJY2/eYUDsj1e64rT0MD/BVI4OmbeTK5yrwjORX+jiLtF6VGrTAHtobKh4X9GFF+QNhej96b4GS0NTJeZWb6ijhqVZFX4otf7tb4/IgDQuq/vvEo1Jl5JsjQjRtELbzA9lAMEaRnRiP9PkaK9BYNa3WSlFmoVei0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HU9eGRBy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HU9eGRBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=b/anH
	9Si7AGNeGlSpdEHPfH0OT7WBuTxniqMA05MAeY=; b=HU9eGRByLz8KnTz7ckPK+
	ynj9cETk4kn9VerHd6acIO2UYIv1lWAN+iMDyFKynQ77KRwk+nPXZVpS9I7n0Os4
	ejnIYpqLbaJbQqBBvrtivUEBWxAi8liWDvQUA0OYKYSOsO6urU9+FLYZll2ZdrCN
	7dyqtH1ekojdG4CMWsguZk=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnFlwpuL1nryiDPA--.50629S4;
	Tue, 25 Feb 2025 20:31:39 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	yang.guang5@zte.com.cn,
	Wang Yong <wang.yong12@zte.com.cn>
Subject: [PATCH] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Tue, 25 Feb 2025 12:31:32 +0000
Message-Id: <20250225123132.2583820-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnFlwpuL1nryiDPA--.50629S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWxWFWrCryrZr47ur15Jwb_yoW5XFy8pr
	ZxKFyxJw4UCFyvv3yUZF1rJw10q3yqqF4xt34ktw1rA3Z8uw43Xr1UtFyFq345ury8ZrWa
	v3WDArW7Cw4DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5R6wUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBkBn+TGe9sWSGWgAAso

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Lockdep reports this deadlock log:
============================================
WARNING: possible recursive locking detected
--------------------------------------------
sh/31444 is trying to acquire lock:
ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
stop_per_cpu_kthreads+0x7/0x60

but task is already holding lock:
ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
start_per_cpu_kthreads+0x28/0x140

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(cpu_hotplug_lock);
  lock(cpu_hotplug_lock);

Call Trace:
 <TASK>
 __lock_acquire+0x1612/0x29b0
 lock_acquire+0xd0/0x2e0
 cpus_read_lock+0x49/0x120
 stop_per_cpu_kthreads+0x7/0x60
 start_kthread+0x105/0x120
 start_per_cpu_kthreads+0xdd/0x140
 osnoise_workload_start+0x261/0x2f0
 osnoise_tracer_start+0x18/0x4

In start_kthread(), when kthread_run_on_cpu() fails,
cpus_read_unlock() should be called before stop_per_cpu_kthreads(),
but both start_per_cpu_kthreads() and start_kthread() call the error
handling routine stop_per_cpu_kthreads(),
which is redundant. Only one call is necessary.
To fix this, move stop_per_cpu_kthreads() outside of start_kthread(),
use the return value of start_kthread() to determine kthread creation
error.
The same issue exists in osnoise_hotplug_workfn() too.

Reviewed-by: Yang Guang <yang.guang5@zte.com.cn>
Reviewed-by: Wang Yong <wang.yong12@zte.com.cn>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/trace/trace_osnoise.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 92e16f03fa4e..38fb0c655f5b 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2029,7 +2029,6 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		stop_per_cpu_kthreads();
 		return -ENOMEM;
 	}
 
@@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
work_struct *dummy)
 		return;
 
 	guard(mutex)(&interface_lock);
-	guard(cpus_read_lock)();
+	cpus_read_lock();
 
 	if (!cpu_online(cpu))
 		return;
@@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
work_struct *dummy)
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		return;
 
-	start_kthread(cpu);
+	if (start_kthread(cpu)) {
+		cpus_read_unlock();
+		stop_per_cpu_kthreads();
+		return;
+	}
+	cpus_read_unlock();
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
-- 
2.15.2

