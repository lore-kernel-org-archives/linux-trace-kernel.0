Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1A1D90A5;
	Sun, 13 Jul 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391085; cv=none; b=PQS1HNqUo4Ci42/GokypusnsLewo470gbCL/eoBBev2knJnqV0sU0eH42OGo54laVfB+u5U+d6U07zZX9jFv1DYemXY3kBUuHGIL1HEEyIeiipk4wB3ip1oetBzho/aIglqJWxaPIbKAeTUNYvF50jDsJ9/j6FlQ276e8trgEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391085; c=relaxed/simple;
	bh=3tPQQyB9eXTIb3XNbybVUxCt9L6HRc0Tde1G6CrS+SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn1gizr84Hi1mGkUcsc91vasLY9m48erqcUIGJs+0A/elSqb3Fh2+R1KqIYO/sBQ/mTO0KXkA4nbrxuFeh88sDZ4JCP5jlfB7OWWUmQQyAHnwrzkVtNX914sQeS69gtm7+gatetfbg3En854seJAeXsn2MOYpNT3ipWN2070XFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwCRotWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwCRotWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E472C4CEE3;
	Sun, 13 Jul 2025 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391085;
	bh=3tPQQyB9eXTIb3XNbybVUxCt9L6HRc0Tde1G6CrS+SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwCRotWBhQXhBmXvcSd99JiYdtJb2P07WEbN614ZfrvI6K1Q+ujga1LEyCHX31fku
	 iQsiVQsBNJ6jq5+JEyMu+srF98RKnOpITckdeQRJCN1uOPniDG2nhQ4sybFfUmCqfl
	 xhAtozenT7QZMyXx9IIK9ceeYztE/jSTo08w1nh7lGHoi7ylXkOoU6gEBnfhHl39zb
	 HbPMD4QmunRUuGcD7D41Yy5PQBwwLjgxTspYzU99OEwWzqx1qGrU/LiOI6yhv4WMad
	 oh4CInED6JTNScnbKLZF8ZyJwecbuO1/9IXQf/Fk0H6AoZ612pkaZmNe2W04dWuVAo
	 defDw0ACOFM5Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 4/8] execmem: move execmem_force_rw() and execmem_restore_rox() before use
Date: Sun, 13 Jul 2025 10:17:26 +0300
Message-ID: <20250713071730.4117334-5-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713071730.4117334-1-rppt@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

to avoid static declarations.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 4670e97f8e4e..056d3caaf4a1 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -137,6 +137,27 @@ static int execmem_set_direct_map_valid(struct vm_struct *vm, bool valid)
 	return err;
 }
 
+static int execmem_force_rw(void *ptr, size_t size)
+{
+	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)ptr;
+	int ret;
+
+	ret = set_memory_nx(addr, nr);
+	if (ret)
+		return ret;
+
+	return set_memory_rw(addr, nr);
+}
+
+int execmem_restore_rox(void *ptr, size_t size)
+{
+	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)ptr;
+
+	return set_memory_rox(addr, nr);
+}
+
 static void execmem_cache_clean(struct work_struct *work)
 {
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
@@ -328,8 +349,6 @@ static inline void *pending_free_clear(void *ptr)
 	return (void *)((unsigned long)ptr & ~PENDING_FREE_MASK);
 }
 
-static int execmem_force_rw(void *ptr, size_t size);
-
 static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gfp_mask)
 {
 	size_t size = mas_range_len(mas);
@@ -415,27 +434,6 @@ static bool execmem_cache_free(void *ptr)
 	return true;
 }
 
-static int execmem_force_rw(void *ptr, size_t size)
-{
-	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long addr = (unsigned long)ptr;
-	int ret;
-
-	ret = set_memory_nx(addr, nr);
-	if (ret)
-		return ret;
-
-	return set_memory_rw(addr, nr);
-}
-
-int execmem_restore_rox(void *ptr, size_t size)
-{
-	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long addr = (unsigned long)ptr;
-
-	return set_memory_rox(addr, nr);
-}
-
 #else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 /*
  * when ROX cache is not used the permissions defined by architectures for
-- 
2.47.2

