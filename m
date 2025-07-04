Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9230AAC5;
	Fri,  4 Jul 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637021; cv=none; b=FhgajUKFlel/NoCD+dP5wBog5y0h5JZjaqUPD3jPetz/cfXXb92894SA6R2ZlUA+/7dts6sGsbgBiE/XyXaAIiJg2PL3h7RE1BLTzRpvjZmEE2bn2hO71zcOJd2cMNOho3A9qn5dVPzH5Qoh8UUw/cuAeHQXSEgWsPQrKGPAwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637021; c=relaxed/simple;
	bh=GUCCcYH19Ye+ebUGH5iigB3tILGu1YhJq+jW18wLp4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugOyJF9fL5OYo/G/4JnyDjPdQ1IcJHYBvbTVAEUJkHYZJQRRqGvxSr6z03W3E+iVVtVzlL5Wh0OgikUiCoro+36PAgC55L2v/bcFcK8jqpDsd04DzT1dikqUxW+HvqiC2G1xZyF2TO06rd/DXqpxSPfNrfLsl5KLrisvy4Egydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUKnVSBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUKnVSBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067D0C4CEE3;
	Fri,  4 Jul 2025 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637020;
	bh=GUCCcYH19Ye+ebUGH5iigB3tILGu1YhJq+jW18wLp4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUKnVSBmR+9ZHYaZdh6o3tuMFSCpTJv8fsfg5Bsuc7N/GIg6OKPKO1uuobiWUOK40
	 qKsB4BwOXXyzJ2RmLIGqr1ceennVXZB3vvnuYnT0/KnqPRO+XOOfifpRaZD1p++eu/
	 2d+28Rxk7NSh7E+J1Ub6ZE+CSAFXfapwaLLK4FKBPcjydUZIKuyIPz5Bu10FekiXDR
	 JMIqWlgYeg3zzNz+6SEXFTIEeml8W037fwdtjJYFeeS28BS91d3pUelBp0Th0GV47H
	 OAZ0Vvc+KS42TfEbyT1q9ngi/XA2sir8YA+sGcCatYmMzIDQSgATIsxgbXBoIbA2gp
	 cI5ZOxWEyQYoQ==
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
Subject: [PATCH 5/8] execmem: add fallback for failures in vmalloc(VM_ALLOW_HUGE_VMAP)
Date: Fri,  4 Jul 2025 16:49:40 +0300
Message-ID: <20250704134943.3524829-6-rppt@kernel.org>
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
index 3cb3a9d1c93f..ec2a6aab143b 100644
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
 
@@ -457,7 +462,7 @@ void *execmem_alloc(enum execmem_type type, size_t size)
 	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
 	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
-	void *p;
+	void *p = NULL;
 
 	size = PAGE_ALIGN(size);
 
-- 
2.47.2

