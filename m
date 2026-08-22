Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD63C584F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406851; cv=none; b=GjSuX3gQNARD/guQ02iUGqw5bD0qJpMlR4Li4btrwJrVMu0/sFJL9KXgagIM+fKzOTPotTnbKq8wekBRSalYH172A/14h1rUXHR7jCU3proDcPkicvq2MpePQXRBxXOjwPRTIMCo72f2w4887VXTnz20dG/hjjdsLlo6se6HomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406851; c=relaxed/simple;
	bh=yELrb/Sn4lo7UMYrT7w3YjKzJs20THaExKEmg90KpcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6j2gVbjak6oj/FTaPLt52XTFPXwAQWonN0EbStEWpXzhR8toZRjVYJkdGMoGW7V1vxz+OPDp3JbzqZ8BF1EIrR3DdzNHLxhiJ0V1hxuZPAO6bHarN7DE+Vg8x5dw5KMJqoC3rjmuGWOEwLG1l29rg5pVnkzq7j6eQMs6aIMvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajfLccfz; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajfLccfz"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4601af62so759314f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406848; x=1788011648; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3C1MhcgCYBzARL/+z1ptrjz40O26zol1QO0uE2euMIU=;
        b=ajfLccfzb8aufZ93lpS12KFsEBz1a/lZsL1yqyr0/HMIvDSBamuTL+LGYhOx9pBNbk
         K1pirkT3tQwPO8v1WYsWEm7dw7ZfY/Of5tZkqMsz2YEVFK/rtu+9YE5wZX+17XcrfAMC
         MkhEQub5GCxrKCFSQ5zd/WFT0jrtfbnXOr4WhEUHWlQQ8Ns24kbKRxCxz60zlDrHPM/U
         4TNgyBe12z6G4wNKMy82hpmdtl2KaKIgMWUvjGtdM8DtKYXx6hf/YVf8eQ6NNHwuk0qO
         2Z2/Gv+YvtIdB8q5bVAt3ZK3CGaNbnK5D0j85Y66QKbF16QmmxJ8TcAGeZegjp4Om3YC
         Qd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406848; x=1788011648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3C1MhcgCYBzARL/+z1ptrjz40O26zol1QO0uE2euMIU=;
        b=DCU0wLRhxU/bZu+rqW1zu4/00EaVsVdUjmfw33jQM6QnLPdhSRzF3mDLYYFjm5ZZxW
         RP4VOgL4h8dh1v9Zq1c0M10VZ5S6BN/ipb43HHTWY8drYq1kjFOyhKWOJ1FEHA4VIcx8
         Ox5UM057uy2YVqDrqkvocrSU3uFXxcXV2uEhjYcb46BdNmTMOKrqBGr7/yGBgAQXlnrs
         bMGc5qN8TtgVgSA8nZkLuQQNzMfjLEhcDcfaUG5L/VQWQHB+QsgOHK9sl5QHRtUbvBMc
         nL8IRDFdMmjzOkWnzvpwqMpXW0jk61FlJoxOOtjL3pZ7VXPUpvVElx3rJHdRu/17+DIG
         AHUg==
X-Forwarded-Encrypted: i=1; AHgh+RojGaZAWdT9QM3jyHkZfQdYFHRf+KQ2UGX/5x3avcpQhyCLHy1y9pKmz1HI0FfFSZ5MvF4+6G0afvuPzUJqZuJxf2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lm3tvdHOZ/LkXGCgu4R3zDsps5FcN5lE+rIZ3xQ1rSB2GYsPAU
	TZEuUPc2nug9BRFBKXsP19WhBZp6u4MDNBbUHIPcfOoPuP3NKkct9IC5ZczmsS8yAGbbdwvV0w=
	=
X-Received: from wrnk3.prod.google.com ([2002:adf:e8c3:0:b0:481:5a0f:19b5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:310f:b0:47f:7129:e30
 with SMTP id ffacd0b85a97d-482c0b976f1mr17563678f8f.11.1787406847588; Sat, 22
 Aug 2026 06:54:07 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:26 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=ardb@kernel.org;
 h=from:subject; bh=2CJ7XIW20mRvuSe13JPdhhevFvLjPgwtnqW6fGhR0pc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5c1bi+7sDNh4oOHy8XMHks1ZWx/c9LM5qpAednXj/
 pol76fv6ChlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQAT0dVjZGjsanuobS/bwOzn
 INDJt9ssjUtyEdfbFTGrcj54/RWdJsTw31v4rEPQ3sLVG+ati7dtnpxtEvm4wabQeZJex247NZX 3/AA=
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-15-ardb+git@google.com>
Subject: [RFC PATCH 4/9] module: Allocate MOD_INIT_TEXT from the MOD_TEXT ROX allocation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When execmem ROX caches are used for module text and inittext, place
them adjacently in memory, by allocating space for both initially, and
splitting off the space for MOD_INIT_TEXT as needed.

This avoids the corner case on arm64, where .init.text being placed far
from .text results in a lot of complexity wrt indirect branches and PLTs
that we'd prefer to avoid.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/module/main.c | 22 ++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..2d6213496359 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1342,7 +1342,7 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 {
 	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
 	enum execmem_type execmem_type;
-	void *ptr;
+	void *ptr = NULL;
 
 	mod->mem[type].size = size;
 
@@ -1351,11 +1351,25 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	else
 		execmem_type = EXECMEM_MODULE_TEXT;
 
-	ptr = execmem_alloc_rw(execmem_type, size);
+	bool is_rox = execmem_is_rox(execmem_type);
+	if (is_rox) {
+		/*
+		 * Special case for MOD_TEXT / MOD_INIT_TEXT: allocate the
+		 * latter by splitting off required space from the former
+		 * so that they are always placed close together.
+		 */
+		if (type == MOD_TEXT)
+			size += PAGE_ALIGN(mod->mem[MOD_INIT_TEXT].size);
+		else if (type == MOD_INIT_TEXT)
+			ptr = execmem_split(mod->mem[MOD_TEXT].base, size);
+	}
+
+	if (!ptr)
+		ptr = execmem_alloc_rw(execmem_type, size);
 	if (!ptr)
 		return -ENOMEM;
 
-	mod->mem[type].is_rox = execmem_is_rox(execmem_type);
+	mod->mem[type].is_rox = is_rox;
 
 	/*
 	 * The pointer to these blocks of memory are stored on the module
@@ -1368,7 +1382,7 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 * *do* eventually get freed, but let's just keep things simple
 	 * and avoid *any* false positives.
 	 */
-	if (!mod->mem[type].is_rox)
+	if (!is_rox)
 		kmemleak_not_leak(ptr);
 
 	memset(ptr, 0, size);
-- 
2.55.0.860.g4b6b3295ed-goog

