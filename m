Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1A2877C7;
	Fri,  4 Jul 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636998; cv=none; b=l1N4EjK0lDJevVvnQodlAvwyhI9Omk3AKbLRNzoBMJjpvR8E0Vpxjd2S46Do4+ulHDzsH2BB1QNpHDtJyNOidvQ0l2PYL0kRazill2NiiVsFzAZ3bwGT3EiTYyRTTeKrGr3TKI0dFFb3qr5mUUC4PRyKtTlojXVKDfxWTFh93/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636998; c=relaxed/simple;
	bh=vyVIGCtc0jVROOiaoRDc63+XloT/k7Y60usHpVt467Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVN8bQJH6RToQI92JSNKizkQ5QlrnDMYPGNJf/2Yn4KskoJLiTV/cCZseHXFfrLeWC+KMmyF6P5FxYxRTUsxW4Hv6zo41MS0lZJSWHHPkLOubHR1GYVWQXtwxiTYTiRLdVZ4bz0Lyspbr2K/gfG0hGZ2e1yF4KCEgLRqJQ+jycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeBTJcLv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeBTJcLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047A4C4CEEB;
	Fri,  4 Jul 2025 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751636998;
	bh=vyVIGCtc0jVROOiaoRDc63+XloT/k7Y60usHpVt467Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeBTJcLvOcdLQq7prI/RVYQdCGmN/+LTcJOHYLGUX8iY+VcLj1yRa98RNlHOzXWEc
	 ahn08iR5xHokPzlcUIAQ73+776hKf0+qcyFdT/8o5hlTSDaQwAugpnB5JtC3IAobcX
	 +sv9y+8AF034fxCW04J8WnEoYTtST/7KDtzaw5uONIaj515sxtShlw5M70yHDGXuQY
	 o+wESRph61IDDV5a41OwvMIOX8gkyBtSS/wldo76STb0T8DALcWfrKpxx6fy/tDwji
	 KJt6L3V/XNSl5c40uACeUCc3k/fm9uDz3F+fVnpGfPKjRjBJ/DAPUPDKbjSuYnuedr
	 PJBDR6Xylg8Pg==
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
Subject: [PATCH 1/8] execmem: drop unused execmem_update_copy()
Date: Fri,  4 Jul 2025 16:49:36 +0300
Message-ID: <20250704134943.3524829-2-rppt@kernel.org>
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

The execmem_update_copy() that used text poking was required when memory
allocated from ROX cache was always read-only. Since now its permissions
can be switched to read-write there is no need in a function that updates
memory with text poking.

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/execmem.h | 13 -------------
 mm/execmem.c            |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 3be35680a54f..734fbe83d98e 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -185,19 +185,6 @@ DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
 struct vm_struct *execmem_vmap(size_t size);
 #endif
 
-/**
- * execmem_update_copy - copy an update to executable memory
- * @dst:  destination address to update
- * @src:  source address containing the data
- * @size: how many bytes of memory shold be copied
- *
- * Copy @size bytes from @src to @dst using text poking if the memory at
- * @dst is read-only.
- *
- * Return: a pointer to @dst or NULL on error
- */
-void *execmem_update_copy(void *dst, const void *src, size_t size);
-
 /**
  * execmem_is_rox - check if execmem is read-only
  * @type - the execmem type to check
diff --git a/mm/execmem.c b/mm/execmem.c
index 2b683e7d864d..0712ebb4eb77 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -399,11 +399,6 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
-void *execmem_update_copy(void *dst, const void *src, size_t size)
-{
-	return text_poke_copy(dst, src, size);
-}
-
 bool execmem_is_rox(enum execmem_type type)
 {
 	return !!(execmem_info->ranges[type].flags & EXECMEM_ROX_CACHE);
-- 
2.47.2

