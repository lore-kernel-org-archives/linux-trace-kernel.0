Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DA31F9A6;
	Wed, 27 May 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890817; cv=none; b=ppZYQ+5yKFPJiw7zOG4rid36Zqs2t7RT3w58xTw1d9N+rh+1wp5vK6MsSNiqrp8KEcTYIlLKIw402KQBGBQGbFauDz9Dotct4B/1Rc7ZGyBTj3y7XL7QFkdiPhn9alBhLWroBIHqN3vZL3qcaXsEZpIjEleDJoTVlmTvbW4RZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890817; c=relaxed/simple;
	bh=B5KdTD7ZhP/7hHR5QHSstU2DTYx/6InnYGWHrgT3KG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPtdwskGiMJ39RwL5reBqEhQXIvx/+kLOjNL1A7zpJBHkGzSUd7OBoMdnjZlX85q9bZouSvJtAbe5+PWEABW+CxV7fkwnaDLV2uVajdPCqm0MMUx+CmEGiY3ZsEMDLTo9bLBT4OU/eLWs4SbRx6a4o0rhJJANZZtjVGPcp9EbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JHUaBSOJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JHUaBSOJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qvNiDGBgEtWh04CKORYdnjbOWGHx4PFQRMc8UbqA0bc=; b=JHUaBSOJnq5vadUYwzmkHoaMjm
	1k53DUwYyVs12ddAPrAOBff7ga+He6A7EGRfQO2BZQn84C6hR3PyatneMWAHX6WBsy2rxzLMhhoT6
	p2+/dn7sshOf9yKbfvNjzmESoK/FaQ9FXOJDZ+GLMu4+4VFrVhfTJkMQNv1hB5lb+VqiFREGTkNLu
	pBYRwsfbX5Wt7d8lMVF3Ua0Obts18Yv8jOXl26BPM+sd5pfLJR+t+DbDtLO9Zq4xMw+m/U/8vM7sx
	bOkKl5OFqZU5bulJTJIeW/JerxVH6cE5xtV3kKxfYPr2laAhbHkId6x8pZ2PLp0A6SoLv8B2DgwEf
	ATUcNy2g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEuM-003DTr-0H;
	Wed, 27 May 2026 14:06:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 May 2026 07:06:18 -0700
Subject: [PATCH v8 5/6] Documentation: document
 panic_on_unrecoverable_memory_failure sysctl
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-ecc_panic-v8-5-9ea0cfa16bb0@debian.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
In-Reply-To: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=5051; i=leitao@debian.org;
 h=from:subject:message-id; bh=B5KdTD7ZhP/7hHR5QHSstU2DTYx/6InnYGWHrgT3KG0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvpbWFZ5tW+B7rNgwndjLhTSZaqZDyApt28GJ
 Z+2hgOzjLKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb6WwAKCRA1o5Of/Hh3
 bcF1D/96nl3pHZvVsIHDOBSzXfwQzAgISt292m7aKGeL5wOoHLfNVNRDP/Qay3Zw8ihSmZ3SKhq
 eCtGDDDFkRK8DyONcMBfMNzcU10qbErfG4WjyHM6o8G0vrPAwDC0PD/7lHc2+JmsEadaFvww+XM
 /a8NP520hvDMj5SFWLtm6SLqzLvIoDLfy5Xuq29WYmniC/kGgBFhZ/AOHulYeBwUD/9rzcvmIwj
 RFNtYgjZ9sFtDVZ4qCM3BWaxuNtoZId2vtOhOK4Uz4q4+D+5kBItasimM6zOdGS5mea++lWcj0f
 baLqPbPYDyM1mV/Ll8+3kqjZSZmh9DyW//0FUVQAGKFkH6lqVXx+C3t88ItZWnc/ULK+PvMqAa8
 qnRQxkc4RXfAjoDeIZrqro8Qk/HgJWt37VUlbMM2rziXTB70YS7yZNWFf1gn5um8U2YPuOqeMVH
 O+UxsbKgQA7K0qX4ZQH9HwI2+MG25WFZMXd0PUj7dEkmnKfTo79y4dsVIgDzuaLD3KLCz2hETY9
 Gdj6pWYpUvRsPFL8trBz7mnqNo3wY05zjlGAGglp3LZG+rJ5igsTHRWRuc6IpfmMSA/RXwxIC74
 k9cAj6ATDQ8kYFXomnrW7iWMIrt5eKqdCs1apuDfCNcqV25ZjgZ6cT5XDp0P/28x8DWsecAWbUn
 GG9y0sD0/WbbUEA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add documentation for the new vm.panic_on_unrecoverable_memory_failure
sysctl, describing which failures trigger a panic (kernel-owned pages
the handler cannot recover) and which are intentionally left out
(transient allocator races and unclassified pages).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 97e12359775c..f71d87039904 100644
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
@@ -925,6 +926,90 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
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
+For soft offline (``madvise(MADV_SOFT_OFFLINE)``,
+``/sys/devices/system/memory/soft_offline_page``), pages owned by
+``movable_ops`` are exempted, since soft offline is allowed to
+migrate them even though they are not on the LRU.
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
2.54.0

