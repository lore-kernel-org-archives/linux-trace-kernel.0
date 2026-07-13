Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA136F8F1;
	Mon, 13 Jul 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927710; cv=none; b=nEUZfJhHgl9tO8KmDD1nngrFB70OUtTlyiDLDiHJXYkdcmP0yndkM9OGIYsCZOu2Nh3e78XmlMBK/IIEEcb7YbFAKEdGajI1QBVzKvDxa7kLSM71mkBCFLqZk9MxsXt5K1xST2sLjHNaKimuSgMX6EJ0ifjc0ePLJZfSfok3yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927710; c=relaxed/simple;
	bh=wxXob9kpWi9dX204UDKpIDHehN4OXK9oqkg2YjGNgkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjJVnAkNHN0mFGpEf9BNF+Fsz+aZ5L+MlWwtJucktT5zmvmoANB/srS5V+ssqfAmHTFAdlZ6fQkX+K+Sq+SPNzoz2GJO8roOzT8SYFnuFi/rm5wTF7NLJ6kBqgd2FkwB1sR/AvabP49CRIlJ8iD6t4SmbH7gbm4aeh65k82YgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mJtgZDzT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJtgZDzT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783927705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nrSswO2tpKX3QYIMHUrXXRtZwbEqGwdT2pVzQKhA3hQ=;
	b=mJtgZDzTLVJKOCFLeNO1lySWyPpxtVXFGHJs1mxhQSfU+EoVzW+sCZcJrqBY/wwO4mHQI8
	zry0cKUzb9Ice4Oqf83GJec8OvIVMkYfVU0lahvHl/BvWxnzzszo8DhigccJtcRcHXOjtk
	dga3hvQ4/kZ/k/ezNN86k74+Gkb819Y=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	will@kernel.org,
	tabba@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tracing/remotes: Fix page_va[] access before counter update in trace_remote_alloc_buffer()
Date: Mon, 13 Jul 2026 08:28:23 +0100
Message-Id: <20260713072823.2668323-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

page_va[] is annotated __counted_by(nr_page_va), so nr_page_va must
cover an index before that element is accessed. The allocation loop
writes page_va[id] while nr_page_va is still id and increments it only
afterwards, so every write is one element past the declared count.

The store is out of bounds with respect to the annotation: a build with
CONFIG_UBSAN_BOUNDS on a toolchain that honours __counted_by
(clang >= 20.1, gcc >= 15.1) flags it as an array-index overflow.

Increment nr_page_va before writing the element it now covers. A failed
allocation then leaves the slot counted but NULL; the error path frees
it with free_page(0), which is a no-op.

Fixes: 96e43537af546 ("tracing: Introduce trace remotes")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
I found this while reviewing Vincent's series [1].

Applies on top of Vincent's "[PATCH v2 0/3] tracing/remotes: Fix leak in
trace_remote_alloc_buffer() error path" [2], which fixes the other
issues in this function.

[1] https://lore.kernel.org/all/20260710114819.2689386-1-vdonnefort@google.com/
[2] https://lore.kernel.org/all/20260709160017.1729517-1-vdonnefort@google.com/

 kernel/trace/trace_remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0f6ef5c36d84e..ef42d9c38b374 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1004,11 +1004,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 		desc->nr_cpus++;
 
 		for (id = 0; id < nr_pages; id++) {
+			rb_desc->nr_page_va++;
 			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
 			if (!rb_desc->page_va[id])
 				goto err;
-
-			rb_desc->nr_page_va++;
 		}
 		rb_desc = __next_ring_buffer_desc(rb_desc);
 	}

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
prerequisite-patch-id: 8bdd7b28f09e97cff4f5995196b83b377c961d8b
prerequisite-patch-id: 6781b7ce5156d229fd21a757ef0cd66dd76130cc
prerequisite-patch-id: 56bcbbdceddf4533770d48d1835d5b7e11f47d56
-- 
2.39.5

