Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E4315D46
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677363; cv=none; b=PZfE9/rj6hE9sYfQ6YHpO7luin7U8Ge1lfN2v7J6fFMZZMFygMOHZmA4l6rDoiaYAiaaGZBQF0Oulk7dysqKYCYdawWTMWxAp/EZbSjWePrWAuNQwEbB/6NxfHeJ8Y5hNZnrUBfG2sN5dJnbMxGrwg7HfJmYmbnT1GhNuJAnNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677363; c=relaxed/simple;
	bh=JLWetDEEnDWLCbszISn7xyvG1BGVO/TgyXWbrIUzhqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MC5KUnjwU6qvgKiu58BCWS4TDfp38HdNwRbpbQzvKsWUgm1snP3Isvb/tqSFwsK/IF/L/7ACWecmkQeSoT5dVUUULw/OwTTmn0WAbn53F8hnc4eoyh7dvr+fgYzTIhs9nm9feUsqOpd/ezb5Yorx/WTY/4K7rOwMuQIwHYPko2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WtXHHLMl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WtXHHLMl"
Received: from LAPTOP-U3CCR7C6.lan (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A5BE20B6F01;
	Mon, 16 Mar 2026 09:09:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A5BE20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773677361;
	bh=xpxJunxhFMiOAN/pTLJuACoZE7cZJUyX29BGz6UnoVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtXHHLMlguG2HB6kNyZn4VzKnkIghpV7+J0VJCsgagWeDc8yBRvmxmK3G3oBiv5yk
	 hrG7JSbj62yCAvO1RXjbSE6+Ot8Crh5PUqxpSV88Tcmxs46cy3Kice01gBsg5ujut+
	 cco3yLfJZcUlS8D7V43MwYdedNvhF1RkkLIX9UB0=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhiramat@kernel.org,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: [PATCH v8 0/3] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Mon, 16 Mar 2026 09:09:05 -0700
Message-Id: <20260316160908.42727-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223171544.4750-1-tballasi@linux.microsoft.com>
References: <20260223171544.4750-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v8:
- Removed in_task() mention in PID commit message
- Moved __entry->pid to __entry->ent.pid

Link to v7:
https://lore.kernel.org/linux-trace-kernel/20260223171544.4750-1-tballasi@linux.microsoft.com/

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Steven Rostedt (1):
  tracing: Add __event_in_*irq() helpers

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h              | 95 +++++++++++++---------
 include/trace/stages/stage3_trace_output.h |  8 ++
 include/trace/stages/stage7_class_define.h | 19 +++++
 mm/shrinker.c                              |  6 +-
 mm/vmscan.c                                | 17 ++--
 5 files changed, 98 insertions(+), 47 deletions(-)

-- 
2.45.3

