Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB2307AE6;
	Fri,  4 Jul 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637014; cv=none; b=NUAZ6XuWRUv+F7xF8e+RkRnQlurKUJXir+po7BGWnLAluzTdMC+lApY3ZKh/FdIF4J62+N4RccKHAB3lkggMGF2gzavELTVutuTzf37kEe61Rw2I8cDFy9w+7KOUdWZ96zggD4ZjuBznYgAivHqNiRIJpqV160svrdXf8Hk8rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637014; c=relaxed/simple;
	bh=ekIwqw7pcIPGCmYh23KJrg3hSMMH1+4weybXeR57thU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/AhNr02RmUaHuoAJmWNFb8heOr/8kc1oIib3kyaSlcsA2igHHdgdq9DXhpgMgSyq909Jb/FelBSiJGtrKHQdmjdRPvT9F8Dn5BvIZHTVuTnO2rprg1U/CSCILc7d94b/y+mBKezhQ5G2k3VUVBOj2WB1CqOT2gb4o6yPHCkJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYXunHQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYXunHQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F10C4CEF2;
	Fri,  4 Jul 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637014;
	bh=ekIwqw7pcIPGCmYh23KJrg3hSMMH1+4weybXeR57thU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYXunHQQS4Sf3pr+dPZ9lYeaAI+n4jw/7nwIoOrVZsWb2Q4gaKa1YzTt/ElGU7tN9
	 0qKqmk0pvsTKQDpXaO2TpSmlTRyqa8OAEU/1fHDtYJdUn605+KEBdvoJWI90DqPgpr
	 PTnJ7xu+hMkerN6GeHmTvBARoLGZ9YNptJ6q/jCbF9WxC/UPjVlQ2ApO8io1D1QgYg
	 TC+tfJjIpEyB411e6C9zyOe+6d0hGBwYX7++uarI2XlpcZrDlNAMylymrlYVd4W8kB
	 nj20K765ZTibqLHYV6tuRsCyPhe403p3Ajhnqxgswy37kz0uNU1Tiyud9xOtaoTyRL
	 QficFfSvv8d3w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 4/8] execmem: move execmem_force_rw() and execmem_restore_rox() before use
Date: Fri,  4 Jul 2025 16:49:39 +0300
Message-ID: <20250704134943.3524829-5-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704134943.3524829-1-rppt@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
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
index 1cc781244593..3cb3a9d1c93f 100644
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
@@ -410,27 +429,6 @@ static bool execmem_cache_free(void *ptr)
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

