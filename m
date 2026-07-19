Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE59175A6D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jul 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487386; cv=pass; b=UXTy3Xi7UzcUVsAu/6aN29MJjy10LXR4HHA3RVGn7Uaix7I6jNFNKPJij3X7DltEBF/wnX5Wdaf5DGSWuabmYAgrNlS+awmWHF2edq20CSjuw2n/+Y3ku5cNWuBG0A4XimdrSauqo8DBaFrDtN4KXe6/RNRwOtNfxqGtjVrmrjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487386; c=relaxed/simple;
	bh=N+21rkpaZHsE/JH8ThNMpu23yT81kMKbJpy7npclSVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ec6cxkUYe4qgNhj4yTOaW4QerTdHnyArN4hgnfHnVlYMJrKC7NZdpq5sBrePPTkuAl9boAiKirQLBzn02jUjHQbiJSjhuvmMm54ATZsP8C+UmRCNbhVZxCTZwhRbckLHxfuu5RLq/xcM4UPgLIQ43Lax7yI6xH4hpHDLzLsJIxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=oSDCqezK; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="oSDCqezK"
ARC-Seal: i=1; a=rsa-sha256; t=1784487289; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=McJqNokg8RJLtID0rDpHo9dZHGTcCImBNyjNUYGUNKx7Hy6zqpz3HtC81y5rc0sfXObKBS4Y+e3lTVp572kZ92nL9WRYPvz//dOHQDIeg+gxOl+WN+PHsSnsz52S5WD4bEC9Z53LbdghM0M9Ze7kQ74LRQEBinvoaEWzn3KnLUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784487289; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XAzpNKpcNCtyrAHnItiN1RWU6bwJlMRMpPXgZD5jnVo=; 
	b=Cj+k8yjMZlLPaVGvfAwb5N7TWBlR2uu0H1Y0tQi/gckdCPxFbiix3Cp0dsDTOk46SEZrU85QatitPy3wLhs10Y95LVTBNhmKcpn50pPxVFVfZJZJSJtjy7hcCFYBaZdsTEQt2QM4cCTszi4dKGTXQw5qoLu+mtPUxiEs+BoIrF4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784487289;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=XAzpNKpcNCtyrAHnItiN1RWU6bwJlMRMpPXgZD5jnVo=;
	b=oSDCqezKKsi/qJYD/MBrcfiWX378g9IN6DcHLRiXs7+RN7K7Vq+gHxkoR4s4DpBV
	L2JKMZvU1ciBmMO3VARq/OG04R6t+GbSS0nZ1/VSTzyqv/lZKKlM6vvNI9KpBKFEJV8
	3guQw0Ax2RZ/tTah8w+9X8Z8wsJJ+ouXl2Xy2unc=
Received: by mx.zoho.in with SMTPS id 178448728809969.40393444362564;
	Mon, 20 Jul 2026 00:24:48 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imbrenda@linux.ibm.com,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [RFC PATCH 7/7] exit: route exit_mm()'s final mmput() through mmput_exit()
Date: Mon, 20 Jul 2026 00:24:09 +0530
Message-Id: <20260719185409.409685-8-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260719185409.409685-1-adi.sharma@zohomail.in>
References: <20260719185409.409685-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This makes the series operative. So far, nothing called mmput_exit().
Switch exit_mm() from mmput() to mmput_exit(), so the exiting task's final
reference drop can defer the address-space teardown to mm_reaper
instead of running exit_mmap() on the exiting CPU.

Only the exit path is routed. Every other mmput() caller (get_task_mm()
users like ptrace and /proc, kthread_unuse_mm(), etc.) still tears down
inline, and if one of those ends up holding the actual last reference,
behavior is unchanged -- the deferral applies only when the exiting
task's own drop is the final one.

The deferral triggers only when all of the following hold, and falls
back to inline __mmput() otherwise:

- vm.async_mm_teardown=1 (static key, default off)
- RSS >= vm.async_mm_teardown_thresh_pages (default 64MB)
- the mm is not an OOM target (MMF_OOM_TARGETED) and has not already
been reaped (MMF_OOM_SKIP)
- charging the RSS to the pending budget stays under
vm.async_mm_teardown_max_pending_pages

Results, bare metal, 32 CPUs / 32GB RAM (31 GiB usable), single
NUMA node, performance governor, medians of 10 reps, THP off unless noted,
vm.async_mm_teardown_max_pending_pages raised to 3/4 of RAM for the
async runs (the RAM/4 default would reject a single 16GB mm on this
box; see the cover letter's open question on the cap default):

reap latency (SIGKILL -> waitpid() returns), async off -> on:
1GB    18.01 ms  ->  0.14 ms
4GB    73.71 ms  ->  0.14 ms
16GB  282.16 ms  ->  0.15 ms
16GB   27.68 ms  ->  0.13 ms   (THP on)

voluntary exit (_exit() -> reap) matches within noise:
16GB  271.27 ms  ->  0.12 ms

redis-server with a 16GB populated dataset (real heap, VmRSS ~16.2GB):
      292.97 ms  ->  0.24 ms

32 simultaneous 0.5GB exits, tail until all reaped:
      157.42 ms  ->  0.32 ms

below-threshold 30MB process with the feature enabled:
        0.56 ms  ->  0.60 ms   (sync path, within noise)

A CONFIG_ASYNC_MM_TEARDOWN=n build of the same tree reproduces the
async-off column within noise (18.01 vs 18.01 ms at 1GB, 282.14 vs
282.16 ms at 16GB), so the config itself costs nothing when dark.

The work is moved, not eliminated: with async on, the 16GB region is
fully back in the buddy allocator ~240 ms after the kill (vs ~283 ms
when torn down inline), and the reaper spends ~1.18x the inline CPU on
the same teardowns (nice-19 kthread, cache-cold on another CPU). The
cover letter carries the full matrix: freeing-latency checks,
backpressure fallback, OOM-killer interaction (an OOM victim is never
queued, tracepoint-verified, including the CLONE_VM-sharer case),
tmpfs inode eviction in reaper context, sysctl toggling under load,
and a freezer cycle with a queued backlog.

Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 1056422bc..6f97d204f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -607,7 +607,7 @@ static void exit_mm(void)
 	task_unlock(current);
 	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
-	mmput(mm);
+	mmput_exit(mm);
 	if (test_thread_flag(TIF_MEMDIE))
 		exit_oom_victim();
 }
-- 
2.34.1

