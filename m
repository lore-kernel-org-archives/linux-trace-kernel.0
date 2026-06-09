Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD352E7BD3;
	Tue,  9 Jun 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002663; cv=none; b=ZGmFhUpC2Ah6kEZ7jHOzxlR8avOi2YHYIMw1hM2nKMebjUFcMt1L+UaRQogXGkmgDrzOvQ7xTAioSHdvJQ+B4TPbiJarPx9QDJMwYiEs67SfbP3wxYgdw7q/YzdeziknsHdobcHQuUOra784kE3hqZt9a4MKlJqRfrrDEeoGdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002663; c=relaxed/simple;
	bh=SB9bQGwm6bnhG584f4s6nsshLf8IzQMWwkO39s0ginA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMTghEwm5xWnB8TVFyjJN8U4ipokvb291IXlsIZmmRKmc8sVPjGzg1kwbVgulmydmVpfAfX/TehtB3J3pU8isI7sfSEZ+vaw8BWfzE/eThr/NFcbfAYRfMIwFS43BgVQU/AKtr3+/cMB0qpRnCT8728ydLw30xIualE8J4cC2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=noH0pTtG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="noH0pTtG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=q9kUwYzm1ZRZIOnRUwI8Icw/M3d0mEYD6AM8mlorlt4=; b=noH0pTtGLkGxSnvbe6nc6FcdOl
	FQz/U7cQK21/M/zL9YFmjk81sl5LgUk8acLtfIUCiCU8leH4f0y0pxes3tgNJe9mhOROAgUTDuXON
	JdFPqaunWHGuN8I2ipyKmjESyfHlItL5i/QGPJmvONrApGFovih4pkp0dOW+aLyNi6tQGoTxY79i5
	dooQUs+q80P9xMv9JSExhF1H44b70sgBc0rwBm0jsg6OAlmu0HQwtrZRAOHYRk3u+KSZKZzZNM1hW
	LyxycfEz/92NAHGwlddVMgA80GvcFxvV2Sjs83/eAl1EFZDHr8G8ZMw4257Usi3IIiuWBZfwU/lAE
	cnAJfniA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWu9J-008Lu6-27;
	Tue, 09 Jun 2026 10:57:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:56:59 -0700
Subject: [PATCH v9 5/6] Documentation: document
 panic_on_unrecoverable_memory_failure sysctl
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ecc_panic-v9-5-432a74002e74@debian.org>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
In-Reply-To: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5056; i=leitao@debian.org;
 h=from:subject:message-id; bh=SB9bQGwm6bnhG584f4s6nsshLf8IzQMWwkO39s0ginA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ/F/9OMrId6ol3yxlXgQ2vVelCiaG8GLdcHPK
 78grchQEgCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifxfwAKCRA1o5Of/Hh3
 bZQwD/47vdGYgiYrq5oQdl1keqjiYpozEvjnvZLgHex8ev/dhiUC3NE2MZNkfs9vNx1LLPJ9tNT
 Imf054T26zg5f7GM7RUpHknCbZrCSiW1aWfWDF1MHDKqF7D6JrLVLM0mH5X1qOGxxD22kSBmxOV
 GJDRJUidqBB6gossbpeKaUTYzpCVKelTnP7x10Af9FIDxA/Dw04KVWqUm5PR7b7EJYAFR9sVPD3
 YQsqlEJBNxBpMfQdVtpeI0iSITS6OCZ4dzX/hhgkWO+RxQiKCr7fIGxvY9UtcwLWgxe4DOJIXnL
 nrehAluVN3npEaFZsfy/7/KOGfyVinjf7V0HeqVsba0L3IN8AoHy4PMDd1sljshsd/EvJg7EzlA
 7llj/dawYOQ9vuF3SYAvWa8araUrTcq0BonvXo45Kw7yaWFKA/uY3NQX0dS2643lqGc4ZIjFE5J
 +fLpWxYYoGz0chV6ltjKuTJaW3sASILPTnZ5ghHR2qy/qpmCabhi179I0S1Hd5nX0sLrIovl7/b
 PPtcPMK9ZQySavGAQZfJA5G07SXZbQiaE7cVcIl+JKAzfI7in2GGq3J0nRNKwy2TrAO4rstpdKd
 bJAlH6xAHJsURUnBKR5CphsxjnHFzCrwkjR+wY+lgxcsHYCpS8ujPw5tSagTWrHOzkfhAt4nIVF
 OFiBV5utx0kgmRQ==
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
2.53.0-Meta

