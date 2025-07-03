Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93E22258C;
	Thu,  3 Jul 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556046; cv=none; b=f4drJMk6qx5XQYArQDCBwew6gTMZF8gLeh1013RR1XjbGIWNVHcDD3C6cR1pIV78iyEp/wwUsETL3j+VUH2USQSRJQruM5lqdggFBCp3+lT2NPQJOo0okgCglYlviQ4nRL/zHGhN3GrVSR7Du+U3HGIFHP4VKKzDjpJBm1aXauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556046; c=relaxed/simple;
	bh=PB9TNaTNKH+VQLSh3v9KswAy35tz1G3hodK352qbFh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oD5+KZN6P+kpUdOFhSdJYidFnHF/oZgn76BPWCTHoSVQ4ARoOYVnT4azjsCi4NlWSD6AsQSGb6wtf1GU8v12P9CeB9GyN1670WNTCP+3rw3rllJ0r9bKW3y7sP8PHP1NpGf2kPLKh5g/AsagV/qXMpnNnxIJQHI8VWO3QxyZmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hsMjQ1Uj; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hsMjQ1Uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1751556043;
	bh=PB9TNaTNKH+VQLSh3v9KswAy35tz1G3hodK352qbFh0=;
	h=From:To:Cc:Subject:Date:From;
	b=hsMjQ1UjeYUAI6Oe7nSGWF1+Nr/+Sqw2MrVx4+1/0gJQdMTK06RLvaprhIRASGqG9
	 RcZnPQSuyrUPT1OOgJ22ChGvxS63+GAJD5WJ3XPfRLmvetcWBoj4YdBrAcsNW5C/cg
	 XGEJCRfowXtFTXR96pYYqPUqYT+EmhG2bH+ysBilDq1Js3Pyr6WFT5gzLpKlRlFMoB
	 9csxnfdECM8MLwwZPi5XFNh5eOu0II0K7X10WuyvC7YyttI49x7TXcL+87Ryc/atba
	 wgV4UZhxI4jJJVKBfux+rZ8vNAEWviU50/OWQXk+ZhuCHu50ATLyEfm1hdLH1hVXeJ
	 BPGro5PrcCVow==
Received: from thinkos.internal.efficios.com (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bY0p26xl8z1MSc;
	Thu,  3 Jul 2025 11:20:42 -0400 (EDT)
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
Subject: [RFC PATCH v4 0/2] mm: Fix OOM killer inaccuracy on large many-core systems
Date: Thu,  3 Jul 2025 11:20:30 -0400
Message-Id: <20250703152032.10507-1-mathieu.desnoyers@efficios.com>
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

 include/linux/mm.h                  |   8 +-
 include/linux/mm_types.h            |   4 +-
 include/linux/percpu_counter_tree.h | 108 ++++++++
 include/trace/events/kmem.h         |   2 +-
 kernel/fork.c                       |  31 ++-
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 393 ++++++++++++++++++++++++++++
 7 files changed, 530 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
