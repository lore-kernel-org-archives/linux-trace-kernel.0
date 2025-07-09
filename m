Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86422A923;
	Wed,  9 Jul 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069007; cv=none; b=u2agu8iQgvtAaGgAdebC5iywRKuXTeq8rZrlIJo1Pw+tundgVu2use6Jv5+C6fM9nDWKZ8QwlZhHoWmz+kpwm1sqBxpdc0TibwIRZFkUQdgDS8q/d30H3aZRnQcYwQTk2GL20P3cBe/aJ82nva3NwBTDY0j2b22T1QK2eih6X0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069007; c=relaxed/simple;
	bh=Cy9nbTY7/RsVWsT8Lzwrq/nzdX4k1/Ew/ELbVa13ynM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqsv4GkQwWle/cvRoel/t5h4axKFlk2dw69G0hrYxV5LnQFnqG+UJsgiBUfw/56GgHudmu5kQuqBi1BRcasdtVBaVazm4Dfv8OK9MXA9w5ZDtwIHpfP4Agf5AwOptEaHeUba4ncYR5VyVS/TUtio+GI0iXtKWdag8vOHzq9Ch7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqUhi77p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqUhi77p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD24C4CEF8;
	Wed,  9 Jul 2025 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069007;
	bh=Cy9nbTY7/RsVWsT8Lzwrq/nzdX4k1/Ew/ELbVa13ynM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqUhi77pGCtV3tt1XSaEAlSwTSPrlnCtKynuwZKBGvvm2a3hBX1u1HdXX6n2XyZP1
	 PcdOUyXq5A3sEsMlmgy/FUvWYAaQOsFGIVeWQP3ry8aY5muSVr3P7sSxpopbGs75ai
	 1MSce67W63oPqC95WRZXbnlkXWPjbim5rnc0DqcpoJPwrsHcsqgJSq3ONwoSWKxmVd
	 Tv0Qif46FGD3GEQrYtiZznj9oLESU9aaBcTEw6X563qJpzcn6d2aKRT8YM0hESsW+7
	 Yk3RoFidd0OLMIzXn1z5EMdVC54svbGUNEy/q6DzhcxIuQEdSI9J9QRXWbfzIbEDZa
	 +3V8vzpoT6c8g==
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
Subject: [PATCH v2 4/8] execmem: move execmem_force_rw() and execmem_restore_rox() before use
Date: Wed,  9 Jul 2025 16:49:29 +0300
Message-ID: <20250709134933.3848895-5-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

to avoid static declarations.

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

