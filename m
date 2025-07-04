Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6975328AF4;
	Fri,  4 Jul 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641354; cv=none; b=LAk2HvJznQ+ZtM96uAOUfRopqkYs6y2xmpMlI5HgYssYJWCNd+13YF7eI3jL96WGUw+6sZfXwZ6I0hWkVr4Cu8pnqO4Ax68lTkCpqYyv7Pd4bXNEag2IOr0SAimlZ0W6tAI1Konn+y4+N4OmOGI+S22soX+M+VipO3XtAUbnve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641354; c=relaxed/simple;
	bh=BwQWVe5CDJayHR4fxHymRQ8jsHENQTbvCVQyO/pDISM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s47xwNhSvckBqBV9+PZN3IIYJQ3jCx4VMoVobt/rBvTuO4MbGb93U+rtwaotWQa7G9n3oZgzll93xJoS5coPJZ2jIF0k10IoERxMwTRdLld8BJ5yRRZmvwgacKEk1rEW0K+vHCY26d7OcmFyoCTuA2uEZMlWZbHFjGcWfiozRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hqZ9YbeN; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hqZ9YbeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1751641351;
	bh=BwQWVe5CDJayHR4fxHymRQ8jsHENQTbvCVQyO/pDISM=;
	h=From:To:Cc:Subject:Date:From;
	b=hqZ9YbeNua+B3QCgnqGNaoMsjEAcyqnDPJ5pNYFVHkYcXGQlS1auKfmaYJobakvAr
	 3pXoQYDu0fTtf9HWdLnJxna9QQ3/k/UFm4Z1PRARabpI+ZLRFQjb6jWggU7XsW9O9Z
	 zn/7GjgxxJSsfy/rRTXZQkITvCqdHrqF5Wc+HiWDr11Fc9m3lR3/dSqot3ZjXW1AUW
	 HMOm0zoBQyjM1ggxlgtqtBPLqFMBdWIUNOISzjYBtUfJ9tHQGvc/E2of5OT0lt1GJ/
	 cwIj6Sd0u45kR2Mx3eBATEScxxkCoQ/O8qvHARRmx5/WIW3+zEJ5Vf65uJ+7gheK7O
	 /iMZiAUDDviAQ==
Received: from thinkos.internal.efficios.com (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bYcLb08nQz72h;
	Fri,  4 Jul 2025 11:02:30 -0400 (EDT)
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
Subject: [RFC PATCH v6 0/2] mm: Fix OOM killer inaccuracy on large many-core systems
Date: Fri,  4 Jul 2025 11:02:24 -0400
Message-Id: <20250704150226.47980-1-mathieu.desnoyers@efficios.com>
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

Relevant delta since v5: introduce !CONFIG_SMP static inlines to
fix UP build and introduce percpu_counter_tree_approximate_sum_positive.

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

 include/linux/mm.h                  |   8 +-
 include/linux/mm_types.h            |   4 +-
 include/linux/percpu_counter_tree.h | 203 ++++++++++++++
 include/trace/events/kmem.h         |   2 +-
 kernel/fork.c                       |  31 ++-
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 394 ++++++++++++++++++++++++++++
 7 files changed, 626 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
