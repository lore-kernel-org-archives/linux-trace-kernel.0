Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429414;
	b=2/pD09w8kEEoiesn1jxvGsqNSQCAW1G3f1NEXyJMbhv4ibzl5NJ0y62R8KzKYTjiP7Wp
	 07Rg4bmuuBcQNRXHFL33BKGm2qIkWtlbKZz/KhAH3I8p4iFBQIorrZn9SalRCaJxk0Psu
	 5LiM/boNVjaR1Tl50h1DpiHDyJYhC7XuuuEBMo1Gr2gEQBZZFzC62hLEqTWWcCaKKioh2
	 tbScrEjArgnxU0tGxSILaoMHZznCCgfvxF+pgjmiRiwaaEQjbuV2zm8IfvyrW/psPQp9n
	 4EZnkbbd3Je8C3VVmS05DAiDWLeqRQ6W+GZ1tOIngfH9FNq11H9DwzhXlX+QJaUsRNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429414;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B2i0ZK07PlEBtX0QbaKuDG+2M0dY7t2yh0/Eybj/INg=;
	b=OuUJ2ue6Fsej8MMHUL8F4+ceA31LgjTGtDsIu/lenXFdM8cv6t+oKzG4alOHWUdbvGW2
	 0L4oLKrIYxGsKplozZ8bOJaiszrGJpiw0AfkB5Rl3YaI2CL1Civ4SWj+hJfWByTfPTRjF
	 GMawQZJQvISAZRsfa6VRWpVrVM5u0tjF0fZV4aJZeBW1BoYvduBxF+WRwAwiBy7sF5vHW
	 7iII98pLCbKFPZPDTD0qOR6IbDvcAk9uQYB1yLkavOVVTADPjxdTXx2CkxOkjfOYKFqy/
	 w906W6Zijei0O9RecxRFK4aeccNgZiSoR/qw2/SbIIi4e3NQ0x1toBxAJml31aylg5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=I0IFPe37;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8460A2618;
	Wed, 11 Nov 2026 20:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF8460A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=I0IFPe37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794429405;
	bh=B2i0ZK07PlEBtX0QbaKuDG+2M0dY7t2yh0/Eybj/INg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0IFPe3793QA4p46Km21OSge2MT6m74ErLWthdauWyBFcKCgvz6DttWw/4eCIHQY/
	 mdg5izB4PvnPNf5qUtNtMGoVy/6PPyD9oHirIbFzBeDzjVHO83NNrjR05FLQ08TeSs
	 Dt1bmUhq0EzPLS93XxNw0m+uinSAg+G8jWaNDD1qRsnkG+hWwdPOsV81w/PwKvs5C8
	 rv7u1AGEx/Iw0vX7i3IYlcE+UaV50fzxYGYsTTJoywWQCt9lWL2CXhDwfcnEXNszst
	 4d07Ugb6iL1umD2lmlj4yg/YpFO1RWXFecmAWbX+dy4HcyjcjH17i/YSmU1znKVZAI
	 nKrALBXfoJfPg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPwKn2bT2zN2y;
	Wed, 11 Nov 2026 15:36:45 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [RFC PATCH v25 05/14] mm: report the approximate RSS in the rss_stat tracepoint
Date: Wed, 11 Nov 2026 15:36:17 -0500
Message-Id: <20261111203626.95838-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rss_stat tracepoint is emitted on every RSS update, including each
page fault.  When it is enabled, it reports the precise sum of the RSS
counter, which iterates over all possible CPUs for each event: 384 per
page fault on a machine with 384 logical CPUs.

Report the approximate sum of the hierarchical per-cpu counter instead,
through get_mm_counter(), which reads the root of the counter tree.  The
size field of the event, the RSS counter after the update, is therefore
within the accuracy bound of the counter from the precise value: within
158.5MB on a machine with 384 logical CPUs and 4kB pages.

The tracepoint reports the precise sum since commit f1a7941243c1 ("mm:
convert mm's rss stats into percpu_counter").  Before that, it reported
an atomic counter which only received the per-task cached updates in
batches.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
Changes since v22:
- Split from "mm: improve RSS counter approximation accuracy for proc
  interfaces", which now keeps reporting the precise sum.
---
 include/trace/events/kmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ac4c96db7638..8ee6d5df5961 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -448,7 +448,7 @@ TRACE_EVENT(rss_stat,
 		 */
 		__entry->curr = current->mm == mm && !(current->flags & PF_KTHREAD);
 		__entry->member = member;
-		__entry->size = get_mm_counter_sum(mm, member) << PAGE_SHIFT;
+		__entry->size = get_mm_counter(mm, member) << PAGE_SHIFT;
 	),
 
 	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
-- 
2.47.3

