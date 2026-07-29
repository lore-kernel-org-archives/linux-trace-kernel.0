Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782D258CE5;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285309; cv=none; b=LVOl406ooIb4y9bo6gxaMYLD34aLKkymV6PEDBFdD2nCH02J0j8wCFDupq9WgATWBfpFTHLvkjM8oGQv349QjmCDDeiTb/8EJ2/uUgNJ111c6F46CCgYuCk7RdRF8/nqt50Hkla+gec25QexynRoEMDdPLAhwHb1K+hmsDaXlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285309; c=relaxed/simple;
	bh=8P2+/T9m6/t7l+sEVyKZYHunwUno4+zhgzh3aLZIyqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIuE6p1CxbYhtIKctcQ+Q4d+w9y9SMayBqQJoYeGh9RS4UrvUXIuN5D1NVT3LzMCaLyUTVWSFcfxUr63+aXC0TSr2i4PTjj/x86I5e5ZhTG1IajJt7pEVzvgmRejEkpvALPHJbUQkwx7me8cWEb5KTZnIpPxdMzuS30FALThDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLKM2SaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLKM2SaM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC0D4C4DDE6;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785285309;
	bh=8P2+/T9m6/t7l+sEVyKZYHunwUno4+zhgzh3aLZIyqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uLKM2SaM4YHqF7GDIZnsMF5pflobvR0FKZyyDy06tLX/TSP3Ir/RAvWE5utou3yd3
	 JNjIYUjdPJoh28psi//w39BHjSz9z1QhZWKJ5A64mPC591AFVFxgw+iVecKbki9iSV
	 zVbUmUjWTbiD1vLi4p+Xo0yjNL5PDYcdZtKSjbZaTSZ9E5pp6gwTVv6wsgijC0q2ca
	 WTF3wCiBku5/H3TcoVyjL0QpY3LeshoEZVvnh2XeL2i75eLYaslXhEj/2PmlrhvqZ7
	 T82Rhif2b39dnxUYCbkhrSttS6gIM8PTiAeCMvlxtMOXpm1rcKJCHoAY0jaEekh3dW
	 PWcmrsz39hTCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B34C54F5B;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Jul 2026 17:35:13 -0700
Subject: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-gmem-inplace-conversion-v9-14-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785285305; l=2983;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=z1k7bYULkqVrzF37fMOsSzxA45ibiL0mHnNKZDzJmd4=;
 b=TM3b/13YyGrFO85K9kaTUS8mgpgnU4Y/aXT5M33Ug87O/Lo9F++1+AEIN2PUps1BAHuyg7UuP
 9q+hhwykKs8C0S2KklFGsxHRwALYYGPR3CNE+OCsczlAkk2peNgz2fe
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Extract the progressive LRU drain retry logic from
collect_longterm_unpinnable_folios() into a reusable helper,
lru_add_drain_progressive().

When attempting to isolate folios that may still reside in per-CPU folio
batches, draining is escalated progressively:

1. State 0: Call lru_add_drain() to flush local CPU batches.
2. State 1: Call lru_add_drain_all() to flush all CPU batches.
3. State >= 2: Return false to stop retrying.

Refactor collect_longterm_unpinnable_folios() to use this new helper.

The helper will be used by KVM's guest_memfd in a later patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/swap.h |  2 ++
 mm/gup.c             | 19 ++++++-------------
 mm/swap.c            | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245baa..cd54f73f34f39 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,6 +344,8 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
+bool lru_add_drain_progressive(int *drain_state);
+
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 extern void swap_setup(void);
diff --git a/mm/gup.c b/mm/gup.c
index 0692119b79043..5f00435e2c635 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2268,7 +2268,7 @@ static unsigned long collect_longterm_unpinnable_folios(
 {
 	unsigned long collected = 0;
 	struct folio *folio;
-	int drained = 0;
+	int drain_state = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2287,18 +2287,11 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drained == 0 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain();
-			drained = 1;
-		}
-		if (drained == 1 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain_all();
-			drained = 2;
-		}
+		while (folio_may_be_lru_cached(folio) &&
+		       folio_ref_count(folio) !=
+		       folio_expected_ref_count(folio) + 1 &&
+		       lru_add_drain_progressive(&drain_state))
+			;
 
 		if (!folio_isolate_lru(folio))
 			continue;
diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8c..0f9465d31fe52 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -950,6 +950,21 @@ void lru_add_drain_all(void)
 }
 #endif /* CONFIG_SMP */
 
+bool lru_add_drain_progressive(int *drain_state)
+{
+	if (*drain_state == 0) {
+		lru_add_drain();
+		*drain_state = 1;
+		return true;
+	}
+	if (*drain_state == 1) {
+		lru_add_drain_all();
+		*drain_state = 2;
+		return true;
+	}
+	return false;
+}
+
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
 /*

-- 
2.55.0.508.g3f0d502094-goog


