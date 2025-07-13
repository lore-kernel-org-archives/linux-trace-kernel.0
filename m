Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BD1EDA2B;
	Sun, 13 Jul 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391091; cv=none; b=nCg2Cr0w6mPQymdvt4WT1Xk88DEHcTlGi2sGNHVDBKuNQ9a73Ox4nf1gPCNr35RCaSxzysNKpmQ6rR1hNsHo+fD9FdVl/7064o/ftE76RlgBvMLhZnCtjjFaC9hiEewoD20ZDUwCEEFGUUOh0vrVrQYE3SepxHRAFXE9XcFZ+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391091; c=relaxed/simple;
	bh=2q/JtK0Q0Ijdxbx3Xk3DGzA5d9fd0T9sey9wBFRhk6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGr9XhmvuzIHsfDFO611mqOIHTFGhHNdDmm0Wi5AYqnbOSGWCzk/9FSNZVg7UDWNjbdMQcvNsl6ZZQJHT85aLAv3WvBs7jdNM1gWT9FEwOSGby3xvdbk+VrCVj5N0RBGuzGlHUueS6igD6Oy4GoqEkarizw3wq89Iky39mRn0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwSDMb+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwSDMb+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F54C4CEF1;
	Sun, 13 Jul 2025 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391091;
	bh=2q/JtK0Q0Ijdxbx3Xk3DGzA5d9fd0T9sey9wBFRhk6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwSDMb+GR3jpqmG1F3gNIPFiP9ubGEaHCEyQ7aMu/Y+Xknb4nxFNImBJJYI51QT6P
	 KgGd/2j6MCWyzEQY3jR902Xj3FabA/SKh3ArnVhr6rflgjyjnJI8uduaLAFVDsm7aR
	 RBz9IXjMkl6u/R4v4J+/kKBKq8au9kpkwKHfkHL3p61+vsi5260EwHVIYx77QZfgQ7
	 IW+D6YNOOT2jpjr2mEWmBuwmXfDSfRVinE+B9zcAHNrPHtnwHt+V+ts8VlGyuklqVN
	 xyS49/X79Ep8paxlLZOmnLZmIxGdhVWVce5JTdmgjIaYq3ncmYRDpPkSx0V+8BGWHa
	 edXw+gArcXUjA==
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
Subject: [PATCH v3 5/8] execmem: add fallback for failures in vmalloc(VM_ALLOW_HUGE_VMAP)
Date: Sun, 13 Jul 2025 10:17:27 +0300
Message-ID: <20250713071730.4117334-6-rppt@kernel.org>
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

When execmem populates ROX cache it uses vmalloc(VM_ALLOW_HUGE_VMAP).
Although vmalloc falls back to allocating base pages if high order
allocation fails, it may happen that it still cannot allocate enough
memory.

Right now ROX cache is only used by modules and in majority of cases the
allocations happen at boot time when there's plenty of free memory, but
upcoming enabling ROX cache for ftrace and kprobes would mean that execmem
allocations can happen when the system is under memory pressure and a
failure to allocate large page worth of memory becomes more likely.

Fallback to regular vmalloc() if vmalloc(VM_ALLOW_HUGE_VMAP) fails.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 056d3caaf4a1..04c35c3a9361 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -291,6 +291,11 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 
 	alloc_size = round_up(size, PMD_SIZE);
 	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
+	if (!p) {
+		alloc_size = size;
+		p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
+	}
+
 	if (!p)
 		return err;
 
@@ -462,7 +467,7 @@ void *execmem_alloc(enum execmem_type type, size_t size)
 	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
 	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
-	void *p;
+	void *p = NULL;
 
 	size = PAGE_ALIGN(size);
 
-- 
2.47.2

