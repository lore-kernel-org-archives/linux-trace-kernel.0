Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B61367;
	Sun, 13 Jul 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391110; cv=none; b=DxaT3TfhhLtjlvRu3SuWNQd3dw/5seJSXprCpWyk+a/kmo3yB27rgwog/RQDAY15t+e7aCHmA5Kuc3nGbIXOpBehyfLJPnsCqN8IqaS//TPJ206e1lQDdT2TG2ZGsKJk6uCGHJgKMWnfRf7t/Gtv3DlMEacyMFKt9Op+FJYNeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391110; c=relaxed/simple;
	bh=W48KJjyddYpCBONIDAqxZPq1nB/qirB2tcBj7MhxtNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXQUwaTlGj5gJzGhR8BPG/cR7J7w0i4faz8lYbI9zwfPELYi+9EnueXNWqXrvPhjBorBFpT8vEOCXpF7Tz4Cf0/vDXC/Y+wTWdgSIF03S3kmlhmo3tTdHHKt1alO0ebVbJokTSDP3FVknfuB3og7JbnybZlvLYmTuIuSpdY9Zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kko8FVru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kko8FVru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78505C4CEE3;
	Sun, 13 Jul 2025 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391110;
	bh=W48KJjyddYpCBONIDAqxZPq1nB/qirB2tcBj7MhxtNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kko8FVruo1H5ovxkMj8GTy4gtboaPCoaqQovHBDSAmOvEBYVN48O7a941dOPKJgGM
	 o/pEbOGLWOdAkOf0JkG/h6vYJMqOyH9aP6vFVq7uWnz2fdKNq306beYBllZyYUl1tU
	 pv9GbhCHGM4KwAjxTAb7CglQhzWcGdep1RhUMpRWd6OSaMngK2x1EtgaNVHRtiQkk7
	 U09qt1tgwEhsudWasaDujoJxeotNoc0Z9VMPKz959zD73V/xrMz3TLKSJt0KbjDHsL
	 ppyeypK4EkPtO7l9Ht+aK2YdM/PT3j1lZDobitymJTLJQfWHhZrjg3Yy3XVhBsgWX3
	 zDU9+1czJ7zLQ==
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
Subject: [PATCH v3 8/8] x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations
Date: Sun, 13 Jul 2025 10:17:30 +0300
Message-ID: <20250713071730.4117334-9-rppt@kernel.org>
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

For the most part ftrace uses text poking and can handle ROX memory.
The only place that requires writable memory is create_trampoline() that
updates the allocated memory and in the end makes it ROX.

Use execmem_alloc_rw() in x86::ftrace::alloc_tramp() and enable ROX cache
for EXECMEM_FTRACE when configuration and CPU features allow that.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/ftrace.c | 2 +-
 arch/x86/mm/init.c       | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 252e82bcfd2f..4450acec9390 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -263,7 +263,7 @@ void arch_ftrace_update_code(int command)
 
 static inline void *alloc_tramp(unsigned long size)
 {
-	return execmem_alloc(EXECMEM_FTRACE, size);
+	return execmem_alloc_rw(EXECMEM_FTRACE, size);
 }
 static inline void tramp_free(void *tramp)
 {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 442fafd8ff52..bb57e93b4caf 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1105,7 +1105,14 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.pgprot	= PAGE_KERNEL_ROX,
 				.alignment = MODULE_ALIGN,
 			},
-			[EXECMEM_FTRACE ... EXECMEM_BPF] = {
+			[EXECMEM_FTRACE] = {
+				.flags	= flags,
+				.start	= start,
+				.end	= MODULES_END,
+				.pgprot	= pgprot,
+				.alignment = MODULE_ALIGN,
+			},
+			[EXECMEM_BPF] = {
 				.flags	= EXECMEM_KASAN_SHADOW,
 				.start	= start,
 				.end	= MODULES_END,
-- 
2.47.2

