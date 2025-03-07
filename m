Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775363CF;
	Fri,  7 Mar 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313670; cv=none; b=KcqU2Anm1WrwccfSLYlQe1F0fivvDeM00TFTI5Ji1f1FG/Acpgw1IBBcYywgxeRmkrkfj2ZF8x5ByjaIfvqRuq70xCYtCytnXmDJWT7rYIFyjVdvqbajqlKqbFeWBIKKR0OXg2UaMo11GV5wAtAtgTEbxstzpxGMsZskjJ1cPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313670; c=relaxed/simple;
	bh=hIU/jHW6i2n1bLd+ULKkpNa1KSq3r0IHNrwHxnEvsMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jzNQx0QYh5QveQu53CP2cT4mt6cdmYcQCSGM3LisbEyjov6OJ7SIcTw29FOilbpThEy5sGylA5GqtZr8bbSgMFWguMOT2nCrn88vA0kvXvw2HNX1eVghlUriN26E3js+OoCZFL9nW3xSFAFCmVKH7SlaJ5cFOSIy4BYN/IHvpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aZhvs2gg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aZhvs2gg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741313658; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=OEsZ722+T9luhvFcjJl5RrcLF6JNMZ9rh4LTTolbXl4=;
	b=aZhvs2ggFIOZzVNXkqT9dtVzxSgUP/ObOmWnGLft4XtE9jJdycbDVvX3FlZGnnVZVVHRa369BVGhovsjAWckmM69QqMrK5x+Ce5k2pq6goK9YBrmY8c8A2eo5nHMu0XcG1ysCuZZkfV/dxKQSpk9dT+guID/qqm9IFlNrxXpnOg=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQqVTne_1741313652 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 10:14:17 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] function_graph: Remove the unused variable func
Date: Fri,  7 Mar 2025 10:14:12 +0800
Message-Id: <20250307021412.119107-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable func is not effectively used, so delete it.

kernel/trace/trace_functions_graph.c:925:16: warning: variable ‘func’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19250
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/trace_functions_graph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 71b2fb068b6b..ed61ff719aa4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -922,7 +922,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
 	unsigned long ret_func;
-	unsigned long func;
 	int args_size;
 	int cpu = iter->cpu;
 	int i;
@@ -933,8 +932,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	call = &entry->graph_ent;
 	duration = ret_entry->rettime - ret_entry->calltime;
 
-	func = call->func + iter->tr->text_delta;
-
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
 
-- 
2.32.0.3.g01195cf9f

