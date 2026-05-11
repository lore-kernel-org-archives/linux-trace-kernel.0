Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54140242A;
	Mon, 11 May 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513988; cv=none; b=XMjPwIXU9xRxZdOrUPjl+i4pbWNU1wp+TzaNKakcNDg1myr6Nqa6LIOp8a6xy0GD79ryi4VKrov34ezeYZaqu2PpqncamKYnxrUQlFkOdq/IJC2eUOVxr2bEjV85iiT0Kb3U3Kz8xlzX0qGKQ2otzD8A2CHh0Qz1pBqXRdJfqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513988; c=relaxed/simple;
	bh=Q+ABac2nobHr/s0/5BCHnN9Y3bSYo92z/wSIvYBKopg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNtgp8mGtuQKKWg0MdInh5yTTFM3Ui8d8DHrmWdNbk9TO7XnAyYX3tGGKNcbEjslr51cTLn7QGRQBIuyLU/r76YAhCbC3+l9lBK46bCa3bOM/9PQELdKHrx9Je4KZRCDAJIIUmaUc0MIK58o1nd/VzVTGd04hPQi/7Hfsu6E84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wHpPbeXo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wHpPbeXo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=C+tCS04YBf4yWLUQhQUZajCDPpB2s5wPhqtGUXXQBCg=; b=wHpPbeXoMK5MT1JH7k3UWAIHXT
	YPhq7Iw77BUECX985/6TGJ3de5iiLXQETl29UH4yo9QyzbhHFF3vL75PGK2h5+vNAzZa8dmfx9fro
	/F75vzIx3aP1KX/3AoJJ0mDB8HdZ/Bv5fyu82u6M7NxvBIGURg3ucKJiwiwtMa1j9NWU+9fFvAjEo
	jSi+muMc+aodWrzb84/a4beXBV+F0vGCL6p2NR/0Hp8S497GKSJdAwz3moLL2hR+JsFb17zgKLw0V
	QKhyOUzgJ6F0BBNA6KTPNdSbyr8ULW9j59BLU5MxdLmn8Yq5RcqCCfMXCqr5eYdgLY9EmoMDsPDw6
	mThJA90Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMSjO-001hVi-1k;
	Mon, 11 May 2026 15:39:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 08:38:38 -0700
Subject: [PATCH v6 4/4] Documentation: document
 panic_on_unrecoverable_memory_failure sysctl
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-ecc_panic-v6-4-183012ba7d4b@debian.org>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
In-Reply-To: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4250; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q+ABac2nobHr/s0/5BCHnN9Y3bSYo92z/wSIvYBKopg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAfggExFOzTNiSrshYAhWzivg+fyoMl0UHn1Ol
 k/baPddoo2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagH4IAAKCRA1o5Of/Hh3
 bSYoD/9wpkfhqpU3NW837qbyKkH5PtTXq/mLXGB9M/kyPbi/lbjrhtclHCid5vxa0hjuNNXSWM+
 rjYPOBkE5+yr3G3fvTQ6x0ilNHObfL/mIlrbudRUeyD/AdWO5Py0u3BGlXS7EmgKsUNhNRCydwq
 LLUKeo9F6zk1uaTsdttH0fH0whh1OUIfSYawJwMN3yhybIyoiiPyZM8LpodWjJPgIKE8X37wKMK
 CU0IrV9EqhOo+5Xpdp+TSi1YNJm4WPqt25g1p6GcP8Bv9+JNsKl9nFzfJxJ67nY3Yb8580z5kQy
 FjbsK7ev9NciRGRpptWMCCe3Jct0m8nm6gqTJvNXpHMrh5UfX7woZ3NpkmP4+dIZvVFWGQe7sqo
 RiFoPB7UxxevtzgkBglm6ac8kqQ6dAqfbPWAxSmwJ7U/B72jONwFccgvj/DgSXWWNNES3Avc8IL
 FBGIWQmkD4Yht6YtpDvz5pTgVibcRT0mopLbGxZel8PGK+8ROneMoK0pv+94JcDcYCZkOHj7RHy
 477VvpdIPxBxaj3ew8chVn1yvFb0wApmgnpR2vwwungePtd8UTo5o8jFebr7PrDUGGyiTvcytUz
 TMUHDk09qF+spb7VnVYTx/nEkoOi7NucFih/niGo88XheO1J6daCVgLpFrSBdydI88Y8HJBgw4Y
 d+Rhi92mvN4p4Jw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add documentation for the new vm.panic_on_unrecoverable_memory_failure
sysctl, describing which failures trigger a panic (kernel-owned pages
the handler cannot recover) and which are intentionally left out
(transient allocator races and unclassified pages).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 70 +++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 97e12359775c9..802c51ba8c43b 100644
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
@@ -925,6 +926,75 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
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
+When enabled, this sysctl triggers a panic on kernel-owned pages that
+the memory failure handler cannot recover: reserved pages
+(``PageReserved``) and stable kernel pages that hwpoison cannot handle
+(slab, vmalloc, page tables, kernel stacks, and similar non-LRU,
+non-buddy pages).
+
+Other failure paths are intentionally left out because they can be
+reached by transient races with the page allocator (an in-flight
+buddy allocation has refcount 0 and is no longer on the buddy free
+list, briefly), and panicking on them would risk killing the box for
+a page that was actually destined for userspace where the standard
+SIGBUS recovery path applies. Pages whose state could not be
+classified at all are also not covered, since an unknown state is
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

