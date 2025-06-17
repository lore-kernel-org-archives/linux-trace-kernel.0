Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149D2EF65D;
	Tue, 17 Jun 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170592; cv=none; b=WzBYRBW3YkwPx00PF8IrWR6TC94gd1erE1WVdVFJCOkQKtoUkuY0tVGZo3Ale74R3tRbYEWOswszaoGGC7s3hoZLO4n5WM9fSX+aFWmpSTS6KCPjWTwjoz2O1UJRC8jw+vK6xLA83DnKOZGm6ZyACHI+gy7uMx2h41oNDDVuCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170592; c=relaxed/simple;
	bh=LIyLij0wTrWveyj9tsMjCsf5lcrhmmEGp8cSiEvEkjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYlMiAn/8ZLAZAWTqJR0G2/1ElvN0dySAo8LoUKM2xSLb/WGoHeQD1aljD4JXEsj4HyxF5h7QWX0gN0PR4806W1Kug68IHmRY6ujJOe+57o1aTWGYCyvcaGS8ILCU+/gX3vS9OELAG66lMrXAnln4ZC9vXKLVBrl2mPdZqkE1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DED2FC0357;
	Tue, 17 Jun 2025 14:29:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id BEC171C;
	Tue, 17 Jun 2025 14:29:46 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:29:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250617102951.4e8d936f@gandalf.local.home>
In-Reply-To: <20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
	<20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BEC171C
X-Stat-Signature: phn44jc8oeu4do411zfki11fm9dphr3m
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yTFeuBs9lHHWznNjtDmuS+6PxVmjY/vM=
X-HE-Tag: 1750170586-255323
X-HE-Meta: U2FsdGVkX1/7IqGp0o9oUi3gbK1vBv60r+hV6TbMJeDGYzIvLNNN4kiDFtCACNoL7Xj8ltqX8u6AZ0h+5iU3Yl5FY73M76BXl92rKcsho7yMb3ncQxX294SjhWKi30LFHmQWSybbyHDXrULwsElTBPugxWQ7rC3pw9H+52QmuxPmmFghSUjvkBbydM/MqFcSU1n3KQrGSJM1Lc+vCLF4D5wKXg7VBleBs48L6ezTQnxxLEqXHcYNAfDV6Te5AzgsTYI5hd1qw/xcUHrhiC5mVxeVNUbCbgNhzRxzg9XcqUqZUnmp1A0dEgwX8Cu/qi8QIeOBquRrQp+3VXT9NhxZ7kv6ZNzFcdo5HD11vyNPUbgn3ZpJF4Ny4vNCuk+RmzIGlfsxt4E2awoXnDVnVcX0bNAZMqt3AX/xEj1b3I9OH+B1a8hGNVqCwQWkus7EOe+CAc+TmxgkLVw/7K04ExeyS4GBHYS8s+URNMoe7kCftKU=

On Tue, 17 Jun 2025 19:41:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Eventually, I found a bug in text_poke, and jump_label
> (tracepoint) hit the bug.
> 
> The jump_label uses 2 different APIs (single and batch)
> which independently takes text_mutex lock. 
> 
> smp_text_poke_single()
>   __jump_label_transform()
>     jump_label_transform() --> lock text_mutex
> 
> smp_text_poke_batch_add()
>   arch_jump_label_transform_queue() -> lock text_mutex
> 
> smp_text_poke_batch_finish()
>   arch_jump_label_transform_apply() -> lock text_mutex
> 
> This is allowed by commit 8a6a1b4e0ef1 ("x86/alternatives:
> Remove the mixed-patching restriction on smp_text_poke_single()"),
> but smp_text_poke_single() still expects that the batched
> APIs are run in the same text_mutex lock region.
> Thus if user calls those APIs in the below order;
> 
> arch_jump_label_transform_queue(addr1)
> jump_label_transform(addr2)
> arch_jump_label_transform_apply()
> 
> And if the addr1 > addr2, the bsearch on the array
> does not work, and failed to handle int3!
> 

Nice catch!

> This can explain the disappeared int3 case. If it happens
> right before int3 is overwritten, that int3 will be 
> overwritten when the int3 handler dumps the code, but
> text_poke_array_refs is still 1.
> 
> It seems that commit c8976ade0c1b ("x86/alternatives: 
> Simplify smp_text_poke_single() by using tp_vec and existing APIs")
> introduced this problem, because it shares the global array in
> the text_poke_batch and text_poke_single. Before that commit,
> text_poke_single (text_poke_bp) uses its local variable.
> 
> To fix this issue, Use smp_text_poke_batch_add() in
> smp_text_poke_single(), which checks whether the array
> sorted and the array index does not overflow.
> 
> Please test below;
> 
> 
> >From e2a49c7cefb4148ea3142c752396d39f103c9f4d Mon Sep 17 00:00:00 2001  
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Tue, 17 Jun 2025 19:18:37 +0900
> Subject: [PATCH] x86: alternative: Fix int3 handling failure from broken
>  text_poke array
> 
> Since smp_text_poke_single() does not expect there is another
> text_poke request is queued, it can make text_poke_array not
> sorted or cause a buffer overflow on the text_poke_array.vec[].
> This will cause an Oops in int3, or kernel page fault if it causes
> a buffer overflow.

I would add more of what you found above in the change log. And the issue
that was triggered I don't think was because of a buffer overflow. It was
because an entry was added to the text_poke_array out of order causing the
bsearch to fail.

Please add to the change log that the issue is that smp_text_poke_single()
can be called while smp_text_poke_batch*() is being used. The locking is
around the called functions but nothing prevents them from being intermingled.

This means that if we have:

   CPU 0                           CPU 1                      CPU 2
   -----                           -----                      -----

 smp_text_poke_batch_add()

                                smp_text_poke_single() <<-- Adds out of order

                                                            <int3>
                                                           [Fails o find address in
                                                            text_poke_array ]
                                                           OOPS!

No overflow. This could possibly happen with just two entries!

> 
> Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
> so that it correctly flush the queue if needed.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> Fixes: 8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by
> using tp_vec and existing APIs") Signed-off-by: Masami Hiramatsu (Google)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> <mhiramat@kernel.org> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..8038951650c6 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr,
> const void *opcode, size_t len, c */
>  void __ref smp_text_poke_single(void *addr, const void *opcode, size_t
> len, const void *emulate) {
> -	__smp_text_poke_batch_add(addr, opcode, len, emulate);
> +	smp_text_poke_batch_add(addr, opcode, len, emulate);
>  	smp_text_poke_batch_finish();
>  }

