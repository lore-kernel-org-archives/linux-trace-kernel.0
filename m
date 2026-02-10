Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2632B9A5;
	Tue, 10 Feb 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732795; cv=none; b=U6YGlSHsgN0NaxsXE3v0wmah+L2vu3FPLZdIzorXoO2PAkgS5Ml64GS48wfWV1yYLl0rDeil/iLszUqeHqH0q+GyjC7mpNq++M5SZM3im3Jb2nU9NE6nrCDDUsIRD23dsC+DKldcTn2XaGojbHl2E7ZJIKNAu8sQ0VTKePbvlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732795; c=relaxed/simple;
	bh=oztty4Zev9BL/kCceekUXQDCsV4y+IwI6P4+2BMKPco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQTNk+PHp+Hnc3DMCWEYqoeED1bBA+thMiwcT/9P+qZvBhoZ8xvRxRuMR0XuJFer0otLZdwwUcOBT4jDyZLRzhxLcMxJteoV43yM9K9W5a5JDVxlKr9b2ExYvsEdeVm335iKBkhVCupbQWFPqKTVN5crc5jB1GEHAC6x5BemsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnOZNnUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnOZNnUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCEBC19424;
	Tue, 10 Feb 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732795;
	bh=oztty4Zev9BL/kCceekUXQDCsV4y+IwI6P4+2BMKPco=;
	h=From:To:Cc:Subject:Date:From;
	b=MnOZNnUNqrZQo8rRN+uBzS/lqD9+bx0iyolXJlTq6zxeRx1LDX1tOeOj2iwx9/DUp
	 hjeVRwt6xd9q2fkBx2dnLkaTwbdM5BIkqJdYPS/+OBxWe/WYvYj/6briWCI1EB/S8c
	 isIJiROdMc5ad7sWkud7XCh1BN2VO9fuAQUarRI4DOD7sVgM0qnUnLhAm7tQLRm8Iv
	 ULTdaPkDjah8ynG3yDvetOCjNxvWhuMJt4oddW8VfNbHP5aA5YlQCqgsK2EZbPmHEp
	 6Ki0ddtfiqJr72Aq1MaUFdnl2EDjYPREYiBSeNyUbP9u0rdc892OaqH8RRs86cVF2M
	 5wgplcwdp7W7Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>,
	Shengming Hu <hu.shengming@zte.com.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: make tr->d_max_latency accessible without CONFIG_FSNOTIFY
Date: Tue, 10 Feb 2026 15:13:06 +0100
Message-Id: <20260210141310.1605322-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent change attempted to make the tracing_max_latency file visible
unconditionally, but this lead to a build failure:

kernel/trace/trace.c: In function 'trace_create_maxlat_file':
kernel/trace/trace.c:1543:13: error: 'struct trace_array' has no member named 'd_max_latency'; did you mean 'max_latency'?
 1543 |         tr->d_max_latency = trace_create_file("tracing_max_latency",
      |             ^~~~~~~~~~~~~

Make the corresponding change in the header file.

Fixes: ba73713da50e ("tracing: Clean up use of trace_create_maxlat_file()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3ebff304fe36..b8f3804586a0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -351,8 +351,8 @@ struct trace_array {
 	unsigned int		snapshot;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
-#ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
+#ifdef CONFIG_FSNOTIFY
 	struct work_struct	fsnotify_work;
 	struct irq_work		fsnotify_irqwork;
 #endif /* CONFIG_FSNOTIFY */
-- 
2.39.5

