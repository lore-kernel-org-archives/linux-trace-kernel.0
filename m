Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679C1A239A;
	Mon, 29 Sep 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145561; cv=none; b=Y75KZfMsNJvkjfXUeCB3GTFZ5hW8kqgO3tM0nZUqO9ulAWaq9UhwwVYm9OCxrEpwKcZ66iAWpBIDTTiIgG8lhR+pdJJIBLNYRmyLhQXURAYYgB8Zo3CTwIffqGUpWnzpUl9EKx+pj9nBLV8wahhHWFvbRieNHGJ0Nq79JAXIU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145561; c=relaxed/simple;
	bh=g77QlILLHxVB4H6N7j+BSgLkE4s9ILeEklCcbzxdCXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukHSeL0d4GtyBn9sNxZGRGu0SHwMDWtBtEBq5YHi9zhzvZKLGD61R92DpX5gfmN7APHlMu67AtPplpbdBRYJEg+SenPNo+GlGDWNs/Rbo4IJxXlc+CJciQjC+SieU2wRohFfwQZvWDBOS6PwwfcHsh7b6BDsP4jXZcX9X3stIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyNt+cBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyNt+cBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DBDC113D0;
	Mon, 29 Sep 2025 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759145561;
	bh=g77QlILLHxVB4H6N7j+BSgLkE4s9ILeEklCcbzxdCXo=;
	h=From:To:Cc:Subject:Date:From;
	b=PyNt+cBCXzm38zwIkm9Stf8zzlISDPShDruCdy9370J5alm4Bo9FFYs/G/IScvgNu
	 tXqeYZcoLF05cXU0cuR38O4A9p187w+vI0OgDdl+bZQpy0qSVKhfYwpmMe8qLgSgN+
	 o4VQ6R+kcq1Yp062CVEMz5jJV0+kB85vuSwY9RU90jCLYTtMltEqpBijMwKghdJ0mf
	 s1WLUS03g8F06M8SHm9pvrqAviBmoo8wdN/F67LDQ3K+Z7FfO6JT7r/vHHa3iTV9+r
	 x+kBdVppytRgedum0YQGNvzef5iZT8TVQCdkJZrSPctjpx3aFfzgPKm/9HJJHpezRo
	 UkmBKSJxZeTZQ==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Fix lock imbalance in s_start() memory allocation failure path
Date: Mon, 29 Sep 2025 07:32:38 -0400
Message-ID: <20250929113238.3722055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When s_start() fails to allocate memory for set_event_iter, it returns NULL
before acquiring event_mutex. However, the corresponding s_stop() function
always tries to unlock the mutex, causing a lock imbalance warning:

  WARNING: bad unlock balance detected!
  6.17.0-rc7-00175-g2b2e0c04f78c #7 Not tainted
  -------------------------------------
  syz.0.85611/376514 is trying to release lock (event_mutex) at:
  [<ffffffff8dafc7a4>] traverse.part.0.constprop.0+0x2c4/0x650 fs/seq_file.c:131
  but there are no more locks to release!

The issue was introduced by commit b355247df104 ("tracing: Cache ':mod:'
events for modules not loaded yet") which added the kzalloc() allocation before
the mutex lock, creating a path where s_start() could return without locking
the mutex while s_stop() would still try to unlock it.

Fix this by unconditionally acquiring the mutex immediately after allocation,
regardless of whether the allocation succeeded.

Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f3e9537417d5..e00da4182deb7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1629,11 +1629,10 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	loff_t l;
 
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+	mutex_lock(&event_mutex);
 	if (!iter)
 		return NULL;
 
-	mutex_lock(&event_mutex);
-
 	iter->type = SET_EVENT_FILE;
 	iter->file = list_entry(&tr->events, struct trace_event_file, list);
 
-- 
2.51.0

