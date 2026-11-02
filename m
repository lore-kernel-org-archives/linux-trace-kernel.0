Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646462;
	b=u1G2cNMmOIYi65DBDAA3lhUI8eXWEDOwGzoyKL+i8LTc93M/pdr8khNL3fXEflXlV6DR
	 x7k4tRljd3hydx8RcHzK01TRt2vv+kCBhtRyfqurCdH2H+xMMajCKuRinkPli3zf/+6Y0
	 1w95yeSi2wGBzvi6AbY0HZ9kk25amWgKSMo2piHp/w/1K0mVFDLA6iJSLQJXgFnVsiEYd
	 +o1jV2r0SK0qM04noMFkOymr+jDmpa/VOD+vGwfdU3+KPFIm2jkI5GuiKDl0DxM9ffzCF
	 ZbgYJHEGOekFNolAQBjelLbNaxHaPr8/h2NtOHKky8iV/xvNoaCeMDnqR0kHxHGruBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646462;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gl+xnaBMZeBPaNesQCW4DnR4Om/hR26Eit0GPVIe2gw=;
	b=S5sBmMJHAVwzK514+pge8oc6oUqaq25DTvsD+AcLI9lReLA8REnKWU68x5Rsp4QOroCR
	 wf4z1R4AYycR4WGBaRkYJPozb8ztcbDFDemlUXTY9EGMiH2AVpERTbgPYN5wPWQJISiBw
	 K6VRvnguY1pZykp9F09z6EUQgwQBTvFlOkc0E/20fRPeK40N3j3YZjqHMuGS95sTziw6Y
	 8qVU8k25NaOGyvn7F0lpk1StV0HKHBv5HZOUwtF1iQDfUkx9SH5EHiFRegAUL4U1Jip4y
	 2irpSN+0jnEDHkVkCLBdV2csFsrQHIJTVl+WBb1yj3u/NuwH4dbQ+TtQkKD7qNRGCSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=x8ZWFWyv;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D310606D81E;
	Mon,  2 Nov 2026 19:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D310606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=x8ZWFWyv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793646452;
	bh=gl+xnaBMZeBPaNesQCW4DnR4Om/hR26Eit0GPVIe2gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x8ZWFWyvg7IxuyzujBtZkN7PotpTzTokkgemFKIggco3u1iiD8caRy/Xfxm3z4fnD
	 iH1OHsV49U36dFW1xA2uSlGICrJgY9A6D7nkaBo9o2eIJTQj/UfIO4phT+cQUJeL2z
	 YndnDs/YF3O/sca7+kdR62qmhflEiFdo4mSd3fuBcQrQy5o0nyAmIDcp2kclY97jv+
	 XLbtVqoXpHIYF0K1cPyZrCeHWepAYE4Y2wOlOIu/e8UTGSoV5ohmr86nMtFCgyjD0c
	 Xv9e/1cBmi2zRjXXQBqYHElRiAx/4rvUGT1O1OCedNx8HIzSw9xgz/gbS4TXJ7NmaY
	 /ZDLfxJLkRwqw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jJLn04x95zF1X;
	Mon, 02 Nov 2026 14:07:32 -0500 (EST)
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
	Josh Law <objecting@objecting.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
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
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH v23 05/10] mm: report the approximate RSS in the rss_stat tracepoint
Date: Mon,  2 Nov 2026 14:07:03 -0500
Message-Id: <20261102190708.1287100-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
References: <20261102190708.1287100-1-mathieu.desnoyers@efficios.com>
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
Cc: Josh Law <objecting@objecting.org>
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

