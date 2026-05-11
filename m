Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753432E137;
	Mon, 11 May 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513982; cv=none; b=iLT3PKObx5UZnjjs2YvOgQrxwAkaAcsrp3c8sChTIWXl4v59ZTnUHXDV7JpHhNyI0Xp28fNomKJwoYZGE9fpsJ1TnZ4qZVGrfihvO+La0gflaLb/bMTWZFJT4t74m4js5HR3MHc1L/zrBbnSKXEesdDYps28cedAsnIS90g1J0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513982; c=relaxed/simple;
	bh=3WH08KBPaFAFZH+gyAtBCRzaUv1S7Oemd/2clegvfv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISpXcYn9BN9KXQwqpYoP4S/P79nGmhfwZNt35qipHs7S+aVgDEzEYT4tzzqh6LMbQdHhhgiKi4y7W+FRXTIPUKvCP57v6vs+wpEhekZ/xjRElaz0prGp+up9NSV55mwhCpxbpMesS5YNmiRupFUCrMLU3tKgKkvUN82O2ogk6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SoEFslgk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SoEFslgk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=9eczhBxewuo2JvFN1og+M00zMC+sIzResfPi7F2/71E=; b=SoEFslgknWcDSrruLzc6WlAxLC
	3mMn9cFGHBHyFJi/up4p4QPSrz3kdxwOGdJElMDREJSORbSiZvg2hY5Dn9IezBsFyhvvDLguunyCr
	VBsxzu+Ulhl9ZsJAaNe3Nh6e+tFYQnigtazd4YO47qvyw34mUo+Ra2325C++qZv6it22oqvmOOZdY
	s6fwrg6MNbvjKU9p0hMWET1VvNtipiqpPGuphB5Kc6+DU7S5f9jrqt3IofvnC8x3LJ45Ei+RYOL29
	zFO1DCWRfd9iA74ZzmPT1cWZeOGqRfxzIMPWzOuGYzI+PG51bnsffpGwQKA/R71IHqzar9N0nCCcP
	kBvHKLyA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMSjI-001hVR-2i;
	Mon, 11 May 2026 15:39:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 08:38:37 -0700
Subject: [PATCH v6 3/4] mm/memory-failure: add panic option for
 unrecoverable pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-ecc_panic-v6-3-183012ba7d4b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=leitao@debian.org;
 h=from:subject:message-id; bh=3WH08KBPaFAFZH+gyAtBCRzaUv1S7Oemd/2clegvfv0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAfgg6LbRP3E9quuqNfU29bb3SDfqIGPF51mon
 h5IfI1EdvCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagH4IAAKCRA1o5Of/Hh3
 bWJMD/9DaFTTwirbNnP+mpFf7x8UBJ81HYXeu/QS51MfqGkVR5U0eG8Gt8zRRtiJ0/PAHebDQmG
 zgKlONyzGuBhm7oq3WF4pQNUZ5qVKFpkGwvuEA+oGbQKbcGDsxM6FkUAljo3DlLcpjGKthEBzmP
 CZlULeNx4WzgL84wQGxPV2GWJCuBIUkZj9UV6nmy5aHDzY+xXewm3thrlxq4ihM2mB9pIDfz+LP
 6bZnLR4hkkK4un09+UfW7dpzbfJb4Jdpsh8W+qJBh3cMUf3Y0dmyyJ+RoB+2ang38KizQCQgqC1
 2hiCemU76StagplXoRk00IJy9bv/pXiW4y8xKC2KMOFgv7cUysb3TWRDhGA0VRAN68ygySBUI6t
 JNjIdKEcGTcSdZOFlvbYgys/UmvGLIY/pEPqN+WsMOr2Uk1BiJGTSgxvgLGwMFCbhSoXLJaYpYj
 ZICAIAms0EohYnzuWMdlZlveLfSyTdVqhIzK1z9K8J6U5w4IYwiwOWUgAWvfrqPJxeE9AgH6MKi
 7Bvq4oNRKhMIDoogOtNvi5fKX3PD1gaFsRX0qBM0iKt6wQX4c8IyE75wTnkgsVzjptLO7MuV331
 ZQnnr2ONPSZ+u5Kpw7NA9rBp29QxCWT+TpSmmlS6dwKg5aCGTHIhw2mRISNo7thyCu+4/9jHqf/
 a1k53Ji8sW2fbNA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a sysctl panic_on_unrecoverable_memory_failure that triggers a
kernel panic when memory_failure() encounters pages that cannot be
recovered. This provides a clean crash with useful debug information
rather than allowing silent data corruption or a delayed crash at an
unrelated code path.

Panic eligibility is intentionally narrow: only MF_MSG_KERNEL with
result == MF_IGNORED panics. That covers reserved pages (PageReserved)
and the kernel page types that the prior patch promotes from
MF_MSG_GET_HWPOISON via MF_GET_PAGE_UNHANDLABLE — slab, vmalloc, page
tables, kernel stacks, and similar non-LRU/non-buddy kernel-owned pages.

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
 mm/memory-failure.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4210173060aac..e4a9ceacaf36b 100644
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
 
@@ -1281,6 +1292,18 @@ static void update_per_node_mf_stats(unsigned long pfn,
 	++mf_stats->total;
 }
 
+static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
+				      enum mf_result result)
+{
+	if (!sysctl_panic_on_unrecoverable_mf || result != MF_IGNORED)
+		return false;
+
+	if (type == MF_MSG_KERNEL)
+		return true;
+
+	return false;
+}
+
 /*
  * "Dirty/Clean" indication is not 100% accurate due to the possibility of
  * setting PG_dirty outside page lock. See also comment above set_page_dirty().
@@ -1298,6 +1321,9 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 
+	if (panic_on_unrecoverable_mf(type, result))
+		panic("Memory failure: %#lx: unrecoverable page", pfn);
+
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 

-- 
2.53.0-Meta

