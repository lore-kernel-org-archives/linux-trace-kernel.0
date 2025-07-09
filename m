Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AA2E49BD;
	Wed,  9 Jul 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069013; cv=none; b=tGrYhtSwEFfMSXsPnF1lljQrzjl/nyRFleZphVbMxaWArfCvJ0NNEq3fOViy6VGCOVs3NCgMm4ksAX6lyqVD//2N827cDqHy/kRkeo3S1SUJYHzYhBU0SIpo0iuKEYM7WlWaohTKId4qX4TKm3uQfidhFKQjaH4QSpzKh39tTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069013; c=relaxed/simple;
	bh=3rjfBdytCgPEmue4GcEI2ssOKhgIJ1qlJg3E/xaLrs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZykpO+qYemCCRBpbNUzNv6MbgYfB1OIKKLEHWrAZIDbd2DRBUkV8mPrQCkqODZFf595sSPSpahI963O2bTPQugyWqtaHRm+EAxGmF+3yUxCIIq6LJnPc2R2QddkWLFULWLfkgWyLSkL/AMRrpj5NeRBRoPYaagRF6nExrLizsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6mb4tb/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6mb4tb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F91C4CEEF;
	Wed,  9 Jul 2025 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069013;
	bh=3rjfBdytCgPEmue4GcEI2ssOKhgIJ1qlJg3E/xaLrs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6mb4tb/c5ErumOIPqYDTAF5gBHWVxb1YJiVQFg8YU/ymef36m7/KBWmtp6YhPXD7
	 VhjC36mzromjvGypCvFoZU5WRmUVg5YseVQOBP6/WRSxg+8XYIgFFu0R2/FjRMukz+
	 BTp5uWcXNBH51L7rvo25EghdRCbCkPzeGslyNIBFqyusGbg0rK+UBU9PxZHm/Tgsow
	 k778y1swFYWdZuEUC0CHxiav3CG9aUOi6NWdtstzvWPqV0Ts9oeBzTI0K4+YpQYYD2
	 21K0u/A6g76A6LiiWRLCNgsCl2xEf3YvhB4O7D30F1GQS6t1GvUmGwZlJ1qj/rUTP3
	 +IgOb3QxDYbnQ==
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
Subject: [PATCH v2 5/8] execmem: add fallback for failures in vmalloc(VM_ALLOW_HUGE_VMAP)
Date: Wed,  9 Jul 2025 16:49:30 +0300
Message-ID: <20250709134933.3848895-6-rppt@kernel.org>
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

