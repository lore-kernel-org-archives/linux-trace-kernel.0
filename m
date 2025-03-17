Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129B79D2;
	Mon, 17 Mar 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176543; cv=none; b=V8pZH44xEUIINa/OZGW6lcAa3MNQFw6T42opBoZSu3WpaHsBHW0oEe2yIQ4eZZsd4M2UQqQqlonbFP8Ukkf3JugfAtxwlSl0LWAarUMsNvEyizSE5gCp0Yb5uRiSVEAUicz/XvmV3MwLQCwOAfd4U/XpIT+uT4JKrC0iQaE7NRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176543; c=relaxed/simple;
	bh=7GlVFROGhQYP4W1Es7a2w1q7aJ6QXK6BRS5zZWU3QQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YXKK/O8Ksgxt8I4irvxblSoj5wzWXcYIEY0WCyx9BGAik3LTKjBelip824MR8dB+I4msUmdMcGrSA7JwGcHdSlZfRPQ8QLiaIwdL/iDqmlRUMWQ+bPYwg37QqzaQMhEusXOG0idjMgc/O62OehjHIa/92gcGQxUuP7E8lGRA9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H0ZXvlJ4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H0ZXvlJ4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742176532; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=uoBZcHvTXH4zImpYvULitH9EJk+5AMCPZ8jdSfBBn3Y=;
	b=H0ZXvlJ4nLA15O8RSaDh3B1fYDg8Q9xjBB9soC776N95v8O6SJISQZgmtOZiPXhQ7OhUhemEf/Wp97l+Pv9oDeu9NwMV42LO7bjAhlRKIlPoBAfcdaaIIYekSdo4fq2MJYvGY60TsbHXDm+vLKMquVq4LuJVta3CqMfsR3lTNmQ=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WRXQteu_1742176525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 09:55:31 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ring-buffer: Remove the unused variable bmeta
Date: Mon, 17 Mar 2025 09:55:24 +0800
Message-Id: <20250317015524.3902-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable bmeta is not effectively used, so delete it.

kernel/trace/ring_buffer.c:1952:27: warning: variable ‘bmeta’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19524
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/ring_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1f9f3fd7e23d..229427fe0c2f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1949,7 +1949,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
-	struct ring_buffer_meta *bmeta;
 	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
@@ -1964,8 +1963,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int sc
 	if (rb_meta_init(buffer, scratch_size))
 		valid = true;
 
-	bmeta = buffer->meta;
-
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
-- 
2.32.0.3.g01195cf9f

