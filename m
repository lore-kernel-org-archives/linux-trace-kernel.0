Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48C410D3E;
	Tue, 30 Jun 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823619; cv=none; b=qdsTF4VCBf91C1pGNvDNgd/DaO8CeXYHeLqZun7IeQuW+DvInnyHNmmLDK3KfAaGQxGlAcCfnBu6GXtW3ZYQYHDvb8qCjTWkVCAsDrlEMvddFkVTQ2C4o4lNaNkFEVpHebGul0t0FhJfbJzxhcRjzuPOrUKZYNlA7OGUlWfQLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823619; c=relaxed/simple;
	bh=msoDLvFqwsOJsYCzBq/Fp8NcqXTHSLhr0v0oqz9cZZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bntdPJU2UgBIsQg8hbX1za0WvPym00IB0KtsecoCrO3e8dgu477G/7XRuBYr9gS7hT2pX+iFaF6Jk3wxQxct+2syH2QBSvl6R6ZZvtd13wM8TlNLxCBRFEBFOEJ1fDq3ZSAGHa0aEuIpWJ9KkUVbu0p1cXYpS/ubJ0kGAlf3XFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KwMU7BEG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KwMU7BEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=f+riptiA6r5Y/PNxg2RAlIaqa1a8ryBQwwolMCsPfZU=; b=KwMU7BEGKx5LbiKbuR1dZ57CKH
	u8HORcxkOwM5jFm1jTzvEw+4c8pW0/oePV9iRd2zfZ9+4n3wHLURKGNKgY+tMZHBK0i3lq29OLho+
	FqhnT3q5GVza4mW6j6hVFQ5XFuYxqDAp5s2qfEQrEgs+k4Z+wmRdr/lNtwOQn6uzwvjLxcAL9nDU3
	GUE3XwzHJwUxPlaTCCOGjBcq+ts1PCkzc/Sfe/FOxoxwp7x5D1GT1ayG2moU2AEPUX5CzHNcfzoNH
	Uzp4af40NqgtupD/mjt0Nszr/catUCIjXMDkuo/yWxea1xUXae4yAFnyAAeNeFm8Ir4dyseJp3bvC
	XyNGOOkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weXrc-0074c8-2N;
	Tue, 30 Jun 2026 12:46:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 30 Jun 2026 05:46:08 -0700
Subject: [PATCH v10 5/6] Documentation: document
 panic_on_unrecoverable_memory_failure sysctl
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-ecc_panic-v10-5-c6ed5b62eea2@debian.org>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
In-Reply-To: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4818; i=leitao@debian.org;
 h=from:subject:message-id; bh=msoDLvFqwsOJsYCzBq/Fp8NcqXTHSLhr0v0oqz9cZZ0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQ7qdWBb3w3i9zonOzAZvixd8VOV1wwZ/UrYi1
 hP1CKN8MiKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakO6nQAKCRA1o5Of/Hh3
 bQ5MD/950PnBLjKhKhm7aPCbqFUb/DDS/bxhtNwErQfWcj/UkgqV/WR/1YLVbTfHXIR5CLaz3mr
 byD2Vnm6ihXfREfvV/gnQAVRc0mbVkeBCJTwlM5YHKiGOL2NLCUeRf72TbG0+N79u9LGWDgxyKK
 m8uzwA2unIggXCe96m22tMLWwt+2qpKJi2vFIoy8UkyjLK416VYsfZmJz/Fq8HRcXeitbVQrE8c
 wd9EJ/wpG4+8TSvqS7Xj9MPKaQBLrkk93wO+SrvP9MYq/1PtSKzPLYVi5JXievKDQBlsZ3e7Y+z
 LKEwjahzrdiHhlgpmzHfQhRnOlOvlMblHOBkp9otigeF2O66g0Q2FTiZjXncm5K/S16C4KpldiO
 ZNhsfB15QzfPWQOrrTL/S2n5cMEATlS8n4xBerHYn1+JfEZ+sNWcEohbVldotutHwW3cwoHuJsK
 /EelZZUvMc9asX0V7IGKt88idjJ8wEH85q5enPDeKKAJCEE+7+SIfWhLziIOpbiEAtH2joOt0Wu
 V2BjzQhzzRuu4D9UYbLGARfXpcy9g0PQAWyPaspq2fsx1GwMXHRufHjRIyNS1ZGIX3UTADqxmgq
 6AiQ460qgYgIQ8DcTtd0ETJhcTm4/XW6k+DDgue8OrtWbUTFZ2pBLDpc91HvOXKygCT0bBHk7gr
 BvAlyjmCeZnas7w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add documentation for the new vm.panic_on_unrecoverable_memory_failure
sysctl, describing which failures trigger a panic (kernel-owned pages
the handler cannot recover) and which are intentionally left out
(transient allocator races and unclassified pages).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index b9b0c218bfb44..22cc54cac3b21 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -67,6 +67,7 @@ Currently, these files are in /proc/sys/vm:
 - page-cluster
 - page_lock_unfairness
 - panic_on_oom
+- panic_on_unrecoverable_memory_failure
 - percpu_pagelist_high_fraction
 - stat_interval
 - stat_refresh
@@ -925,6 +926,85 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
 why oom happens. You can get snapshot.
 
 
+panic_on_unrecoverable_memory_failure
+======================================
+
+When a hardware memory error (e.g. multi-bit ECC) hits a kernel page
+that cannot be recovered by the memory failure handler, the default
+behaviour is to ignore the error and continue operation.  This is
+dangerous because the corrupted data remains accessible to the kernel,
+risking silent data corruption or a delayed crash when the poisoned
+memory is next accessed.
+
+When enabled, this sysctl triggers a panic on memory failure events
+hitting kernel-owned pages that the handler cannot recover:
+``PageReserved`` (firmware reservations, kernel image, vDSO, zero
+page, and similar memblock-reserved regions), ``PageSlab``,
+``PageTable``, and ``PageLargeKmalloc``.  These are owned by the
+kernel and the memory failure handler cannot reliably evict their
+contents.
+
+Other unrecoverable kernel-owned populations (vmalloc allocations,
+kernel stack pages, ...) are not currently covered because the
+handler has no page-type signal that distinguishes them from a
+userspace folio temporarily off the LRU during migration or
+compaction.  Such pages still go through the standard
+MF_MSG_GET_HWPOISON path: ``PG_hwpoison`` is set on them and a
+delayed crash on the next access remains possible.  Coverage may
+grow as the handler gains stronger kernel-ownership signals.
+
+Recoverable failure paths are also intentionally left out: in-flight
+buddy allocations and other transient races with the page allocator
+can reach the same diagnostic, and panicking on them would risk
+killing the box for a page destined for userspace where the standard
+SIGBUS recovery path applies.  Pages whose state could not be
+classified at all are not covered either, since an unknown state is
+not a sound basis for a panic decision.
+
+For many environments it is preferable to panic immediately with a clean
+crash dump that captures the original error context, rather than to
+continue and face a random crash later whose cause is difficult to
+diagnose.
+
+Use cases
+---------
+
+This option is most useful in environments where unattributed crashes
+are expensive to debug or where data integrity must take precedence
+over availability:
+
+* Large fleets, where multi-bit ECC errors on kernel pages are observed
+  regularly and post-mortem analysis of an unrelated downstream crash
+  (often seconds to minutes after the original error) consumes
+  significant engineering effort.
+
+* Systems configured with kdump, where panicking at the moment of the
+  hardware error produces a vmcore that still contains the faulting
+  address, the affected page state, and the originating MCE/GHES
+  record — context that is typically lost by the time a delayed crash
+  occurs.
+
+* High-availability clusters that rely on fast, deterministic node
+  failure for failover, and prefer an immediate panic over silent data
+  corruption propagating to replicas or persistent storage.
+
+* Kernel and platform developers reproducing hwpoison issues with
+  tools such as ``mce-inject`` or error-injection debugfs interfaces,
+  where panicking on the unrecoverable path makes regressions
+  immediately visible instead of surfacing as later, unrelated
+  failures.
+
+= =====================================================================
+0 Try to continue operation (default).
+1 Panic immediately.  If the ``panic`` sysctl is also non-zero then the
+  machine will be rebooted.
+= =====================================================================
+
+Example::
+
+     echo 1 > /proc/sys/vm/panic_on_unrecoverable_memory_failure
+
+
 percpu_pagelist_high_fraction
 =============================
 

-- 
2.53.0-Meta

