Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD22E424F;
	Wed,  9 Jul 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069020; cv=none; b=kDkWU0NKalQImvEAToSvgX/X3QYvrp08jqRa6hHpMRfMWf3cpsFBwHFCKujoXixAI+jmQ4hNa8aSamLvSqgkfXSxSdimJ+eaUx8ymDwAA3qE7C2YemrGpxPoCCySG2rerAFbNLeGpIS6uzWniLJBIcIyH0qZf+nHPHG39Qwshug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069020; c=relaxed/simple;
	bh=UfdU2NtfT5pyDIDyGKKERIvkXlmii1YDvliXyB4yGWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGrFFftTiHa96x617LiRb+HoqFr+igER4bMIckNoNZr9iDbpGQHuuHfITyTtUNXQFN/7kjoqOYjeEGt8f5q0SUjs/qLyrYvhYhDwusuXAjZiMSvIW+Q9VDuX7yHXC7X/jea7K57LHKtdkRVTelyaAXrXGxdFooFB3+CXjw5DZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYISKbwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYISKbwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F07C4CEF1;
	Wed,  9 Jul 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069019;
	bh=UfdU2NtfT5pyDIDyGKKERIvkXlmii1YDvliXyB4yGWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYISKbwuNhcRxyV4eib/26x4sOL4iiYJhoPQsAjEOC9YExVxanq+lLb26komTBLZG
	 cnB41wXbRuKCHz6C2QkMepppg0/HAHprTz8hplGJU5FEOlV48xUR6gdu67c0YC2i7X
	 XSEhIXis+2pcTnebZIE9RTu6BcQu1CShtCmRvb218F/rTcmotsbHsoNo0YufFV0h5q
	 zVvmNfuIvUHPix7Ht8okjY38iO6O2GjX0f7vhUf6CMK8XS7QKBJe4W/3T1gdn4Lyqf
	 hQ6eWmqDBCz6DNjIamV0urMqjqPvBvaXZ2qbeq/ktYJR2pKNiL3x9BP9y5py2eRQqi
	 gs3wVrRDc1s1w==
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
Subject: [PATCH v2 6/8] execmem: drop writable parameter from execmem_fill_trapping_insns()
Date: Wed,  9 Jul 2025 16:49:31 +0300
Message-ID: <20250709134933.3848895-7-rppt@kernel.org>
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

After update of execmem_cache_free() that made memory writable before
updating it, there is no need to update read only memory, so the writable
parameter to execmem_fill_trapping_insns() is not needed. Drop it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/init.c      | 8 ++------
 include/linux/execmem.h | 3 +--
 mm/execmem.c            | 4 ++--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..dbc63f0d538f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1063,13 +1063,9 @@ unsigned long arch_max_swapfile_size(void)
 static struct execmem_info execmem_info __ro_after_init;
 
 #ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
-void execmem_fill_trapping_insns(void *ptr, size_t size, bool writeable)
+void execmem_fill_trapping_insns(void *ptr, size_t size)
 {
-	/* fill memory with INT3 instructions */
-	if (writeable)
-		memset(ptr, INT3_INSN_OPCODE, size);
-	else
-		text_poke_set(ptr, INT3_INSN_OPCODE, size);
+	memset(ptr, INT3_INSN_OPCODE, size);
 }
 #endif
 
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 4e510d1c609c..fe367bdadc3e 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -60,12 +60,11 @@ enum execmem_range_flags {
  *				 will trap
  * @ptr:	pointer to memory to fill
  * @size:	size of the range to fill
- * @writable:	is the memory poited by @ptr is writable or ROX
  *
  * A hook for architecures to fill execmem ranges with invalid instructions.
  * Architectures that use EXECMEM_ROX_CACHE must implement this.
  */
-void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable);
+void execmem_fill_trapping_insns(void *ptr, size_t size);
 
 /**
  * execmem_restore_rox - restore read-only-execute permissions
diff --git a/mm/execmem.c b/mm/execmem.c
index 04c35c3a9361..0822305413ec 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -304,7 +304,7 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 		goto err_free_mem;
 
 	/* fill memory with instructions that will trap */
-	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
+	execmem_fill_trapping_insns(p, alloc_size);
 
 	err = set_memory_rox((unsigned long)p, vm->nr_pages);
 	if (err)
@@ -363,7 +363,7 @@ static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gfp_mask)
 	if (err)
 		return err;
 
-	execmem_fill_trapping_insns(ptr, size, /* writable = */ true);
+	execmem_fill_trapping_insns(ptr, size);
 	execmem_restore_rox(ptr, size);
 
 	err = execmem_cache_add_locked(ptr, size, gfp_mask);
-- 
2.47.2

