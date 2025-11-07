Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFD320385;
	Fri,  7 Nov 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536152; cv=none; b=H76u4TkTP+UAF8cUPpJun49hakrw/mCfBz9RbfAzFb+zYPudUjT02ZBBcU2PDpC2NJuHaSZzeMdyEX5N0Kg89LH4cAEuV/hU+1yVKzsrS6xzq0hOi8POiJttNrytkQ3bjs0o/9Mo5cjU5yYnzn0ckAZx+l87X2FuvrNZH5C0xEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536152; c=relaxed/simple;
	bh=R+lSyLXFW2u75JqNLAnL3NcWWk2deJimJ56WaUWleNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz3tIeH+bl7CP8E4tAMiawFhDFBrbr7WL+5scfnA5TM/XLbQVHpXwjorSiyNmT3Wtp3YViNGqbPJjLpa30tQY1n8CxQWxkz4LFcj24dlGQrMzjjCeoRtpsRBspNwStIXuZTmFOj2aEWgEqYZBxt6uj1mmkRBKTHxrJOXGkyVhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ODiVoDZH; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ODiVoDZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1762536143;
	bh=wcANZRjMX6eDeb9g7LnxYqx3PUgZNlqK6yxyYeMGIZw=;
	h=From:To:Cc:Subject:Date:From;
	b=ODiVoDZHi1ShVyo4MfksyRzqOOGsV+QFDx9HmO2x0gJAku4KgQXSlfV/3bCIm+Rmz
	 w+sAgGUx19M9VBk2S/gib9z9Cs9DTYzAVB7fU3DFMCdSbu/S+ycLP3ddMFq5vvJmgz
	 rlAKyuypbjFbmpxY2+/8ryaNqrIfOV7WczJfRGaSbdaXUhjl/tLW66ulphgWoXzwmJ
	 cJfBJdIEU+DiUV2CmtqgJEa+kaZg10AryGai/xuXrw97OqPzWLf0vFgGPB6cdNm8h+
	 YsTARl4pJ9ZTglFho9wqBxUQ9Khjsz/Imuygqf8Z9q4jo4WsALDv7/VthFOGnrv0Uj
	 6+S4vcLTDwyUw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4d35Tq5MmHzHX4;
	Fri, 07 Nov 2025 12:22:23 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [RFC PATCH v8 0/2] mm: Fix OOM killer inaccuracy on large many-core systems
Date: Fri,  7 Nov 2025 12:22:14 -0500
Message-Id: <20251107172216.515754-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce hierarchical per-cpu counters and use them for rss tracking to
fix the per-mm RSS tracking which has become too inaccurate for OOM
killer purposes on large many-core systems.

The approach proposed here is to replace this by the hierarchical
per-cpu counters, which bounds the inaccuracy based on the system
topology with O(N*logN).

Relevant delta since v7: Initialize the subsystem earlier in
start_kernel() so it is ready before any mm is created. Introduce and
use a precise sum positive API to cover the scenario where an unlucky
precise sum iteration happens concurrently with a sequence of counter
updates that makes it observe a negative sum.

Testing and feedback are welcome!

Thanks,

Mathieu

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>

Mathieu Desnoyers (2):
  lib: Introduce hierarchical per-cpu counters
  mm: Fix OOM killer inaccuracy on large many-core systems

 include/linux/mm.h                  |  10 +-
 include/linux/mm_types.h            |   4 +-
 include/linux/percpu_counter_tree.h | 217 +++++++++++++++
 include/trace/events/kmem.h         |   2 +-
 init/main.c                         |   2 +
 kernel/fork.c                       |  32 ++-
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 392 ++++++++++++++++++++++++++++
 8 files changed, 641 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
