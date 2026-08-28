Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6644AB7A;
	Fri, 28 Aug 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926290; cv=none; b=XL+/Hc1iCqpK9KIbm9CHyht8upoRNMKAuNjb1T72CImUiKpitwS8PxiQdITVVPuSMw7idHl7ucR+36VzFzHmOJ4ZeVbD4nG7lzfwfkhqJ/kyVk2hULQ6INNc1spb1uxIaFSIQ+4xFK2xG63qG5BdFRoCP/BRqKE70oo3y/IGFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926290; c=relaxed/simple;
	bh=zrWYftSCGtfnzZIw9FBRwaFuP0lkn+KXDXTp3VXyk30=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=NB4XJtaDUDEGD+zDYTQGxHqoAImse5rgkQaiiZNL1dl9JLeHeXEgDy0epN0ubG5RxoIVUMPwDPcUuVWJ6fEN70okiB+7AVOjirWYAPX7dl7FeGBe+OQhjxnGICWAOkDQmZ+8vCjccAVA9YeWZIodmQxwnHoT9i5kbBM24YGWrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Ycnv+HBq; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pAwUirXl; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Ycnv+HBq";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pAwUirXl"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787926269; bh=iZASGKq02X3MlmO8ig05lys
	xUTvXqLjttI83Y8LZB04=; b=Ycnv+HBqjWQS5U5unDzB96IugCG4zABbml+qs+cqmqoPXqgymN
	G+vRqqgTKjoq8x60DPVW7sOXe0Hsqb5XVKob6OFULWPoJT11vMeGF3D6JUgoiFXpy8emipbSAo6
	IwZ457tXuzzZ7gSK37RTznHw3k8u1/25x4QLcudfso8yHnZrbd3bb+ih/OBHLubdyDLScT66loD
	ikQi4ZPR4efqWGzX5p2Yrzeq4egeTH6Z+oT6Jf1CHeGEwpw0pPrnrAFypM0ywwauY1QphgUu0c7
	SIURc0XASezSaZ5NV9SeEzXFGejC8yS+NYgdAuQWayIoBCn0E1BA9kJwQOGqmRnLmsw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787926269; bh=iZASGKq02X3MlmO8ig05lys
	xUTvXqLjttI83Y8LZB04=; b=pAwUirXl2vj2hacynI1LWN6FYowJY8LNRSofKFRBFio/OCLbR+
	G44FlI0f44HKl1e99r6flMyTrSMraop1b0DA==;
Date: Fri, 28 Aug 2026 15:11:08 +0100
From: Bradley Morgan <brads@mainlining.org>
To: ardb+git@google.com
CC: abarnas@google.com, akpm@linux-foundation.org, ardb@kernel.org,
 atomlin@atomlin.com, catalin.marinas@arm.com, da.gomez@kernel.org,
 kevin.brodsky@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mcgrof@kernel.org, mhiramat@kernel.org,
 petr.pavlu@suse.com, rostedt@goodmis.org, rppt@kernel.org,
 ryan.roberts@arm.com, samitolvanen@google.com, will@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_4/9=5D_module=3A_Allocate_MOD=5F?=
 =?US-ASCII?Q?INIT=5FTEXT_from_the_MOD=5FTEXT_ROX_allocation?=
In-Reply-To: <20260822135323.795946-15-ardb+git@google.com>
Message-ID: <5D55C497-95FF-4603-98E4-8C47CDAB504C@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 August 2026 14:53:26 BST, Ard Biesheuvel <ardb+git@google.com> wrote:
>From: Ard Biesheuvel <ardb@kernel.org>
>
>When execmem ROX caches are used for module text and inittext, place
>them adjacently in memory, by allocating space for both initially, and
>splitting off the space for MOD_INIT_TEXT as needed.
>
>This avoids the corner case on arm64, where .init.text being placed far
>from .text results in a lot of complexity wrt indirect branches and PLTs
>that we'd prefer to avoid.
>

I can't see anything wrong, thanks for the patch

Reviewed-by: Bradley Morgan <brads@mainlining.org> # kernel/

>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
> kernel/module/main.c | 22 ++++++++++++++++----
> 1 file changed, 18 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index 46dd8d25a605..2d6213496359 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -1342,7 +1342,7 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
> {
> 	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
> 	enum execmem_type execmem_type;
>-	void *ptr;
>+	void *ptr = NULL;
> 
> 	mod->mem[type].size = size;
> 
>@@ -1351,11 +1351,25 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
> 	else
> 		execmem_type = EXECMEM_MODULE_TEXT;
> 
>-	ptr = execmem_alloc_rw(execmem_type, size);
>+	bool is_rox = execmem_is_rox(execmem_type);
>+	if (is_rox) {
>+		/*
>+		 * Special case for MOD_TEXT / MOD_INIT_TEXT: allocate the
>+		 * latter by splitting off required space from the former
>+		 * so that they are always placed close together.
>+		 */
>+		if (type == MOD_TEXT)
>+			size += PAGE_ALIGN(mod->mem[MOD_INIT_TEXT].size);
>+		else if (type == MOD_INIT_TEXT)
>+			ptr = execmem_split(mod->mem[MOD_TEXT].base, size);
>+	}
>+
>+	if (!ptr)
>+		ptr = execmem_alloc_rw(execmem_type, size);
> 	if (!ptr)
> 		return -ENOMEM;
> 
>-	mod->mem[type].is_rox = execmem_is_rox(execmem_type);
>+	mod->mem[type].is_rox = is_rox;
> 
> 	/*
> 	 * The pointer to these blocks of memory are stored on the module
>@@ -1368,7 +1382,7 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
> 	 * *do* eventually get freed, but let's just keep things simple
> 	 * and avoid *any* false positives.
> 	 */
>-	if (!mod->mem[type].is_rox)
>+	if (!is_rox)
> 		kmemleak_not_leak(ptr);
> 
> 	memset(ptr, 0, size);
>


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
