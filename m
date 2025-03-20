Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFF1367;
	Thu, 20 Mar 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474150; cv=none; b=kWNXpXZG1+v3ZJ2XQ78NTlWasxITskT2P0S3WabIb0kFLHZuZ4vJ8T/biFxSEGlk6jRomaz2Y5hh5NmxuWJrXvGZVAjdBLDFQfNBSmucxZaclLj7uqpPCLbqyQd7BiTl9zpZwC8W7CmhAO+UT5ncHt4VRokJYqizVO9IV1w8wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474150; c=relaxed/simple;
	bh=HAV/V2MFAPHgXCrIvjSPTQq6I1laaACcflwJnuCB3X0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eT8rk5soazVCwSpx3EN/G8Bd042t9qoF5L/DXhfG6FurwlyozBNX9kBzJvINu/bGcpccKIdU1v0lxwCpGFCVPAqgyBAhoM3AE8clZp74/9SNfyhZkpZ6eQol9bZZe/0TRlS2qqiM1efySSpGxXx+Kp5L5InbqCVojLpe0XNl1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZJQ5k6kYQz4f3jtT;
	Thu, 20 Mar 2025 20:35:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 48FD71A0F24;
	Thu, 20 Mar 2025 20:35:40 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgCXNsGSC9xnS8TNGw--.38998S2;
	Thu, 20 Mar 2025 20:35:38 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kairui Song <kasong@tencent.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] tracing: Fix use-after-free in print_graph_function_flags during tracer switching
Date: Thu, 20 Mar 2025 12:21:37 +0000
Message-Id: <20250320122137.23635-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXNsGSC9xnS8TNGw--.38998S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDuw1rXF18Ar4DXF45trb_yoW5tFyxpa
	y3tFsrKr18JF4rKay8uw4vkF1xJrWfGa47Gw4DAw1fZrZrJr1avrsFqr9xX3W3Gr98Arya
	9a4qvrWUKrsIvF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbco2UUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Kairui reported a UAF issue in print_graph_function_flags() during
ftrace stress testing [1]. This issue can be reproduced if puting a
'mdelay(10)' after 'mutex_unlock(&trace_types_lock)' in s_start(),
and executing the following script:

  $ echo function_graph > current_tracer
  $ cat trace > /dev/null &
  $ sleep 5  # Ensure the 'cat' reaches the 'mdelay(10)' point
  $ echo timerlat > current_tracer

The root cause lies in the two calls to print_graph_function_flags
within print_trace_line during each s_show():

  * One through 'iter->trace->print_line()';
  * Another through 'event->funcs->trace()', which is hidden in
    print_trace_fmt() before print_trace_line returns.

Tracer switching only updates the former, while the latter continues
to use the print_line function of the old tracer, which in the script
above is print_graph_function_flags.

Moreover, when switching from the 'function_graph' tracer to the
'timerlat' tracer, s_start only calls graph_trace_close of the
'function_graph' tracer to free 'iter->private', but does not set
it to NULL. This provides an opportunity for 'event->funcs->trace()'
to use an invalid 'iter->private'.

To fix this issue, set 'iter->private' to NULL immediately after
freeing it in graph_trace_close(), ensuring that an invalid pointer
is not passed to other tracers. Additionally, clean up the unnecessary
'iter->private = NULL' during each 'cat trace' when using wakeup and
irqsoff tracers.

 [1] https://lore.kernel.org/all/20231112150030.84609-1-ryncsn@gmail.com/

Fixes: eecb91b9f98d ("tracing: Fix memleak due to race between current_tracer and trace")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Reported-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/all/CAMgjq7BW79KDSCyp+tZHjShSzHsScSiJxn5ffskp-QzVM06fxw@mail.gmail.com/
Cc: stable@vger.kernel.org # v6.5+
---
 kernel/trace/trace_functions_graph.c | 1 +
 kernel/trace/trace_irqsoff.c         | 2 --
 kernel/trace/trace_sched_wakeup.c    | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 71b2fb068b6b..f995bddf2ab0 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1614,6 +1614,7 @@ void graph_trace_close(struct trace_iterator *iter)
 	if (data) {
 		free_percpu(data->cpu_data);
 		kfree(data);
+		iter->private = NULL;
 	}
 }
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index c8bfa7310a91..40c39e946940 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -250,8 +250,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index c9ba4259e03e..a0db3404f7f7 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -188,8 +188,6 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
-- 
2.34.1

