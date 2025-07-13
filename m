Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EE1AC44D;
	Sun, 13 Jul 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391067; cv=none; b=iC+V8+sfnoifdB2GiYH4+F9aFLKQwT5GCMbxXMmbYyQ39u4jmOiC7cUXSBNLjSvLVlKDSeBIHZeUfwGXQDmQP0mlM2hKw53sVz+y88euHkvrqml1dcnkqT4L34zJOMzNU4PepTtxxBWDfKVRXo3ey5C5Cl0cDJGHvnmc/W8eP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391067; c=relaxed/simple;
	bh=P4fHP9UFyAr3Scf7HStnOCqWcHWXOAR5PCL9m8hSZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otzuMcT1cHlh2WZJXVdHMV9cxSPLXXdo0ZG9uZEVAUTchx7AOSCxSISLT95NYeGQOnVvdc23nLaZ6UMYhuUa91OJADx8OnVTUSRuW98FCaoTXsidr/h5jxvkZMzjUfLPMH6ZsbUGzE3yubjZLlGKxxd7qAeQUG1X8pqlSmzAuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffjn4N7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffjn4N7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B10C4CEF5;
	Sun, 13 Jul 2025 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391066;
	bh=P4fHP9UFyAr3Scf7HStnOCqWcHWXOAR5PCL9m8hSZVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffjn4N7LSxiD9F/zVzjTT8+NJhOcazHVy9FHNuKWp5JVdcf2dF29EBCJYEoqX27Jj
	 CVGHuLbuTrj8XmzGaDcaVMFUihPaBebeM7T8yhV9ZItqEf7Fw6JovzMVIoNKL9BxJ5
	 bFL7jtV0VHZgCmZS1WG/HHhQOwp1UBFYngSGfAzMIlEaMqPLJAOPFsZBw19mVFOFQM
	 3TzOT02U5r2/lypPzC287BLucq7AC/bJIncxrGAGbgFnQ04ROTH4bZ+zp9RYJK2OTY
	 2rRZFvZbwfqAnEGaelbjVbn9v95V9YrnNXMqM2u7t8MS4DW1BprMc/pjgBuXbY1vdb
	 JhyVpYKOAy7WA==
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
Subject: [PATCH v3 1/8] execmem: drop unused execmem_update_copy()
Date: Sun, 13 Jul 2025 10:17:23 +0300
Message-ID: <20250713071730.4117334-2-rppt@kernel.org>
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

The execmem_update_copy() that used text poking was required when memory
allocated from ROX cache was always read-only. Since now its permissions
can be switched to read-write there is no need in a function that updates
memory with text poking.

Remove it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

