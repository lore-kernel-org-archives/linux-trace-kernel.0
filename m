Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D7322B7D;
	Wed, 27 May 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890811; cv=none; b=PAENDJ0A0TohbDdbhn+CBGKiXJAMpwVtWudxxF0rpNREiF6xLYKyLwef67j8QpQY7c+0mU2Bk46jEOzCzopN++UM9fEsxpP8XL37dCL74w8bD6xzbmgSohxMM0a9Nz2M9Vch9CyMM58jvfS9wFpPDj5y6Y13wfxigaBtafgkDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890811; c=relaxed/simple;
	bh=PVkQrhhrYvBQD3vyC0lD7FiGrFyJsu0JdQyRsKIR+Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmul74ghnooNrRsEBCIQqDZLGNIynIKpVBUEIek2ZgqNdaQ3+vZtfZLr9VPl7De+Rh0CGDV1zCk59vYlsIM1CxLtxbktGNagd7KVuP3y7ipIhvFvJTfO97s9NmaTi9soCSjx5iuDEzjlz3FD5vqjInfkxbuvJAU/gl0DfvLX1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hXRQFsrh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hXRQFsrh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=WbBaNvEUUV9dHKCwKIk01dAys3/khbUwIgj2MiKwh1k=; b=hXRQFsrhwcO5fbPxJdZLKmAlDC
	/5/Oj8hsdMcdix8mPdYre37lAs2/a0dazRsm78qecUsDQOp5/BlWTs7tgauiYVwHtQJxOrqhIHS3x
	VO5hpMsU9x5mEztCsAvkbxvTs0dJq9GXGctAJgshsRmneMVyolxiNWlwDkJ5h1uwS38n6b9v8EpBX
	mo2oPfoVqD7vv2eF3CVmTGMOiz4UJbv/Pzf1iuEHyZSdoqQQpevj2E7w/UY8w9OBcfd5/wEySNfoh
	i0LCFKR84uFanS5/q6355tzBS2KZpjzexCmeZ3aanuRFV3bRuGjHliUIrJ+CiXKBHe8qAowY90Fg/
	lmpRPmDA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEuG-003DTX-1N;
	Wed, 27 May 2026 14:06:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 May 2026 07:06:17 -0700
Subject: [PATCH v8 4/6] mm/memory-failure: add panic option for
 unrecoverable pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-ecc_panic-v8-4-9ea0cfa16bb0@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=leitao@debian.org;
 h=from:subject:message-id; bh=PVkQrhhrYvBQD3vyC0lD7FiGrFyJsu0JdQyRsKIR+Qo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvpbj7PVLzJ01FRE86nH7X9QE2rSaA3qgOH24
 VsAWQc/ZMOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb6WwAKCRA1o5Of/Hh3
 bXTiEACNvfxka9cCMrQpEcA5UqXBXxS+3NZK9HFqC8QaHpUFJgFpFNNUIv95wyLEnaUW3Iw+ZBC
 19iDONTUFs6ehBZYcThrTuVs9ww0ppdn8HF5f/a61eH+h61cHAzaWPkGDa6Uexo8aiuWhIfwy1I
 hs2DuBJMR1AQBm8nqhHlEvj7DBPAphdbdRvtWW3kYubEdNLPYZ6TFDafxZoV494fSZQcQlPCMRm
 cbTlyAL6OAysiMbSv9h0WCPUGmbF52hmFC8TFBSqqWGMBstelFYKz/glnOurkDpbLdIICoCtQnJ
 kBApBpKqWeyPupsONN6gwGp7In1ZBE9oNyggtC2tISbY4vEm1+/xlvUjpO4l43/OV8xoPZOfsxm
 gVF34Vb7oKz+pFqkvmkKQ3cdVeRC7Tb4Ump+VYQN9KrfwrvQ+Cp5JdeIThG+PVkaokGUL9Z19T+
 SA9Yl4871nAjgcczbO6hH/RQjFWQPmUt39WcevAc1Z1jXuMByn5/GCeXmND1BUq/K2/g1WElrvH
 sUu9teM90CtooOmatjcSN1YB0LVEfXGCURuOCjnzaCvhVupgFkFQWY7/haAy5Y5po2TR5mCptd4
 y0RpDvWdqPsz8Zdt5Ae6sygozIgLRGXR5NOWPE3UY12AT1Qce9YF4hNfAnakE/oTIfHDriu3vHq
 ZzTj3JTFtMHLAUg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a sysctl panic_on_unrecoverable_memory_failure (disabled by
default) that triggers a kernel panic when memory_failure()
encounters pages that cannot be recovered.  This provides a clean
crash with useful debug information rather than allowing silent
data corruption or a delayed crash at an unrelated code path.

Panic eligibility is intentionally narrow: only MF_MSG_KERNEL with
result == MF_IGNORED panics.  After the previous patch, MF_MSG_KERNEL
covers PG_reserved pages and the kernel-owned pages promoted from
get_hwpoison_page() via -ENOTRECOVERABLE (slab, page tables,
large-kmalloc).

All other action types are excluded:

- MF_MSG_GET_HWPOISON and MF_MSG_KERNEL_HIGH_ORDER can be reached by
  transient refcount races with the page allocator (an in-flight buddy
  allocation has refcount 0 and is no longer on the buddy free list,
  briefly), and panicking on them would risk killing the box for what
  is actually a recoverable userspace page.

- MF_MSG_UNKNOWN means identify_page_state() could not classify the
  page; that is precisely the wrong basis for a panic decision.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14c0a958638c..dcd53dbc6aec 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,6 +74,8 @@ static int sysctl_memory_failure_recovery __read_mostly = 1;
 
 static int sysctl_enable_soft_offline __read_mostly = 1;
 
+static int sysctl_panic_on_unrecoverable_mf __read_mostly;
+
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
@@ -155,6 +157,15 @@ static const struct ctl_table memory_failure_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "panic_on_unrecoverable_memory_failure",
+		.data		= &sysctl_panic_on_unrecoverable_mf,
+		.maxlen		= sizeof(sysctl_panic_on_unrecoverable_mf),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	}
 };
 
@@ -1255,6 +1266,15 @@ static void update_per_node_mf_stats(unsigned long pfn,
 	++mf_stats->total;
 }
 
+static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
+				      enum mf_result result)
+{
+	if (!sysctl_panic_on_unrecoverable_mf || result != MF_IGNORED)
+		return false;
+
+	return type == MF_MSG_KERNEL;
+}
+
 /*
  * "Dirty/Clean" indication is not 100% accurate due to the possibility of
  * setting PG_dirty outside page lock. See also comment above set_page_dirty().
@@ -1272,6 +1292,9 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 
+	if (panic_on_unrecoverable_mf(type, result))
+		panic("Memory failure: %#lx: unrecoverable page", pfn);
+
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 

-- 
2.54.0

