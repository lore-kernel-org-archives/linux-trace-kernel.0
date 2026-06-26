Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E42387361;
	Fri, 26 Jun 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488045; cv=none; b=i58L1QIHsZxqt2hX54dEUhsHLSLf0lH6fDcQ7HTKob7nxjtQbSR4LgVpGUKAC86Qw/biHfHVEW1BkriAjYljtD0qBEDzNeumOJUw2+Ut7lGWDaYrk61wrT7SysiwtA0aQouHPSUIJwGg7iVwmswiHYxaNzaX06dG0IjIIwGD10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488045; c=relaxed/simple;
	bh=qqg1VFQgG3N6sRDY3kMkDgN5t+H1A3GPVMupI+jkNNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsd0sgOgkFwb55vhMSJKyWbV2v6HFIRPBEcwLgAmtJd11ON+4oXkE5N0pQUzMyTwE/xK8XwEd3UGWbHVgrB7gIU5Xi+7QYPFFuYFzB6Nfl1avmif9YJe9LkBZJH/K2CfXFqYzsw0q4MknPxn3HV8M78arwnaKJ0lce6hYOrujxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XpIy72Re; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XpIy72Re"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ZyfgFwlQERVjmxPNgC+88+drKDA3XcfRT7Olyh7E52k=; b=XpIy72Rec580X88Z8TOB/5sFAP
	WTh9Q8Uj7N1g9gKSzMBlz4oR9dA2sq7h2HiykDDnNjurycRXNrTMskJzUY5IREqBaHNYs03VhtMqf
	KsgOha6b1uah94cC+RS6i6iqeWfG8OoxvGgmhNupBj5h/8wmIzWC4liSyk6nAwTx7pYuNYBRhSivQ
	cPsxy4PNEd4aEY34vKGJjx4oWGFWlpgkLp23jPbd/dG9pS2SHCRFBv5TNstGoOMtdsFaDJSJangTT
	uMD1JpXv4yW28aDzWv7GfohtWKcQ+G5yUQQX3EavPzqWd+1DVb4+PhMlOyD7SJnKdnFpZMH5XJs5u
	GDSabWYw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd8Yz-0044E3-2T;
	Fri, 26 Jun 2026 15:33:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 08:33:18 -0700
Subject: [PATCH v10 4/6] mm/memory-failure: add panic option for
 unrecoverable pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-ecc_panic-v10-4-6dacb8ad024d@debian.org>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
In-Reply-To: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=leitao@debian.org;
 h=from:subject:message-id; bh=qqg1VFQgG3N6sRDY3kMkDgN5t+H1A3GPVMupI+jkNNM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPpvFfXSAss0UBGCQbv2RZto5oeldCmxwzsWwI
 cKDQxvqqhCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj6bxQAKCRA1o5Of/Hh3
 bVHzD/4jF0IpI50h7hCvhTrOwq6Hr6ijwDMoT/efaHXUMZQHWKAR3tZYPbzxwcDcyMequxzG2nM
 KL607E6MILB95hmVEAf31A/MZNaZADRYkJwjZOvljFWhYKPuIYrGPB7QS0m0qveGGmf0iV0cHm/
 MYpCfj9D21IMOWqtbzM59bP94NkFzBnadRrjWBECnJpq9D5Qpbf8AoiksVEUOz3MgKyRDV7F/Y0
 UNHXpEPa7wLRnilHctaWaB+oW0+IT2+MEhzqKYbYLvaPcET6ea5FncvAqi4+DdFs//hucxcVRMD
 IsKWm+yrS7CcZu4A+pkQj4vuadOnAo8/RgBa9383SqcH3wo8dQ63cXyH4PamSZfA7gGoICC0s5A
 L247KYNYSYhCconARaRBmCSS1LsbkUKPeFHIchLB7206y5EznWsEtGEjKx/E9JFiTNhsYBhrB64
 lmmOBuBkfWotscwDNx60Cs3cbNWsm8IhTmRrcsELGmf0C3AW1/PRUoTGDOjUm24WhKt2Iw+y4Zu
 GBlkNlLy3aqhvOyyUFYDr9kpMosyOrDGQgrm5bf10VmXpaSPqkHVJ59GyWKqxT0cP+FzQ6vNHMI
 uNAf839LmVWJp81gpQ2QZr3AuslDyjRUtIgNA5WovvgHtJGDJ8zEMhRk8bMAUQFcij/ISGrtH6x
 r1TTGLD8+bv8Sww==
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

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8e2aa2fafc14e..611160c98c6f6 100644
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
+	if (!sysctl_panic_on_unrecoverable_mf)
+		return false;
+
+	return type == MF_MSG_KERNEL && result == MF_IGNORED;
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
2.53.0-Meta

