Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8115747D;
	Thu,  3 Jul 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564303; cv=none; b=kr1844coHebDZ81da8OsUv+0EmmPPXuZGr3vserH7N0GEv9CEIhTDYbNm6olBvhaYMNytc+fhOoJVv/9TsQiRIrocNogXybpHeNdOurNducjAcrSp3YvStpOiy89ELEjfdVficRB0r4OG3WlAx8tZQIeZ9AhrXGqiRpie7L39+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564303; c=relaxed/simple;
	bh=kZci5UJ1oWcZBBjH7Ug8xWdX335Xkrzp7mbkmxZuC84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G8R6WVaAZoKXWez/GUUf5AcSa0L8fPVe9/eTigponQ8wSupUicGsTqsqfythWyDXyD8yOpsJVu8kZdPfwDFTJTNpWs81ECvo0l5s8cYH63+3sKlZWvGYPgijswDyZ3eS8daqAHkxO2vAOaJTpce647jYKU7aF0XgFxUR9uyObgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RrMz7UiZ; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RrMz7UiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1751564300;
	bh=kZci5UJ1oWcZBBjH7Ug8xWdX335Xkrzp7mbkmxZuC84=;
	h=From:To:Cc:Subject:Date:From;
	b=RrMz7UiZ6nPttUwWbcT70Dvzg9lJq9lvBQpKKbkgYtBKVimUvlTibar176dln4Xx0
	 WhyxZ/h5U60qpBp89f0wxnHy7nRhvIp62vTUjhcLq7TwxritdgPG2sfcN9fjOs9l3S
	 lY96TdbEcJ7Fufw918pjx5ty4VrncbmbFWNGlMfJvBy1BKe1hiBcDGgNq4hj1H5c2G
	 s7vBOaExztMBkW6dSKdU0b648NQOaxF5YwwbRm//7OL1fpEIjW1cZTlfywGQnylVgT
	 clLRKtsdz/OSwbJl5UgrEdaKgxc940JdWz6saGco2LZnEdDM4R7WOFDdSoXocL24QV
	 ILW0HR8Dg7o+g==
Received: from thinkos.internal.efficios.com (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bY3rr11w8z1Ndv;
	Thu,  3 Jul 2025 13:38:20 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v5 0/2] mm: Fix OOM killer inaccuracy on large many-core systems
Date: Thu,  3 Jul 2025 13:38:11 -0400
Message-Id: <20250703173813.18432-1-mathieu.desnoyers@efficios.com>
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
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>
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

Mathieu Desnoyers (2):
  lib: Introduce hierarchical per-cpu counters
  mm: Fix OOM killer inaccuracy on large many-core systems

 include/linux/mm.h                  |  10 +-
 include/linux/mm_types.h            |   4 +-
 include/linux/percpu_counter_tree.h | 108 ++++++++
 include/trace/events/kmem.h         |   2 +-
 kernel/fork.c                       |  31 ++-
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 393 ++++++++++++++++++++++++++++
 7 files changed, 532 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
