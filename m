Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364928BABE;
	Tue, 17 Jun 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203625; cv=none; b=BC61ASCR6UzcHF10y9C5d6ZoiJhOp1fpd/dEt86gvmpAm11EUUQkaEgJijh8OHuR+sbnyxzY+ftiOIIDt1wkwqbce5tCs1feFz98uR3xnxh/kwfOaFIRtbxoWq3l6hnGzfJf6kpnyUvbV9NAGr720gQOdv77/ANI2VcL+WXS2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203625; c=relaxed/simple;
	bh=/z3iN1khOpZmUMgnOifZps7TuwKv1jRjOjzM28piwsM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BiCsU0o+N1pFfZAZE6wRZcmki/fRZHjo8x+U1zhc5DvqFPfJF4TZ79EowqTBVFbR4T8BmfnAbn1xEJ7XD89BujVC3U3SpXDpx8Zxq+qt+wE6vhkr0SGylwT4vFOe3iy6/CoAEh2vMZSIIo4m/ekaL1aCVw1jhDhByVSIXWd6nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmT6sTt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmT6sTt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86F1C4CEE3;
	Tue, 17 Jun 2025 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203625;
	bh=/z3iN1khOpZmUMgnOifZps7TuwKv1jRjOjzM28piwsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmT6sTt0UcHk3m8n9ewawyjnp0oCTqUuIe//6DF1GaWp0mH2e1pWnyG/b5oi0pYAv
	 5ZUP/c6YEuKA/UGQj02BX3cJ3tRKI8r3bq4PSjljYFslMib+6w1z2pQM+GJuGLqSK/
	 TfImou9YuKsQVITjAm5JVFYMinTjdCY5vu2o5iiwIgULMdnvABNXsEdwnMDt5PQE4j
	 PjwdQpEPGIqmMKVBJP39Q/QD8oylFAkFjc70xP4sduaw2J0CgqvJBWW2/ilO+g55kL
	 3tx+Gyu5u0JacEOZ8/cbHOIhDGIlosf0asaDWUWrOatOKMZZ+72eoY2O2kix99SnHL
	 OQwFg+BSXPZ3w==
Date: Wed, 18 Jun 2025 08:40:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250618084022.db09168befebc193c5b13a6f@kernel.org>
In-Reply-To: <20250617102951.4e8d936f@gandalf.local.home>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
	<20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
	<20250617102951.4e8d936f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 10:29:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >From e2a49c7cefb4148ea3142c752396d39f103c9f4d Mon Sep 17 00:00:00 2001  
> > From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > Date: Tue, 17 Jun 2025 19:18:37 +0900
> > Subject: [PATCH] x86: alternative: Fix int3 handling failure from broken
> >  text_poke array
> > 
> > Since smp_text_poke_single() does not expect there is another
> > text_poke request is queued, it can make text_poke_array not
> > sorted or cause a buffer overflow on the text_poke_array.vec[].
> > This will cause an Oops in int3, or kernel page fault if it causes
> > a buffer overflow.
> 
> I would add more of what you found above in the change log. And the issue
> that was triggered I don't think was because of a buffer overflow. It was
> because an entry was added to the text_poke_array out of order causing the
> bsearch to fail.

There are two patterns of bugs I saw, one is "Oops: int3" and another is
"#PF in smp_text_poke_batch_finish (or smp_text_poke_int3_handler)".
The latter comes from buffer overflow.

-----
[  164.164215] BUG: unable to handle page fault for address: ffffffff32c00000
[  164.166999] #PF: supervisor read access in kernel mode
[  164.169096] #PF: error_code(0x0000) - not-present page
[  164.171143] PGD 8364b067 P4D 8364b067 PUD 0 
[  164.172954] Oops: Oops: 0000 [#1] SMP PTI
[  164.174581] CPU: 4 UID: 0 PID: 2702 Comm: sh Tainted: G        W           6.15.0-next-20250606-00002-g75b4e49588c2 #239 PREEMPT(voluntary) 
[  164.179193] Tainted: [W]=WARN
[  164.180926] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  164.184696] RIP: 0010:smp_text_poke_batch_finish+0xb9/0x400
[  164.186873] Code: e4 4c 8d 6d c2 85 c9 74 39 48 63 03 b9 01 00 00 00 4c 89 ea 41 83 c4 01 48 c7 c7 d0 f7 f7 b2 48 83 c3 10 48 8d b0 00 00 c0 b2 <0f> b6 80 00 00 c0 b2 88 43 ff e8 68 e3 ff ff 44 3b 25 d1 29 5f 02
-----

This is because smp_text_poke_single() overwrites the
text_poke_array.vec[TEXT_POKE_ARRAY_MAX], which is nr_entries (and
the variables next to text_poke_array.)

-----
static struct smp_text_poke_array {
	struct smp_text_poke_loc vec[TEXT_POKE_ARRAY_MAX];
	int nr_entries;
} text_poke_array;
-----

> 
> Please add to the change log that the issue is that smp_text_poke_single()
> can be called while smp_text_poke_batch*() is being used. The locking is
> around the called functions but nothing prevents them from being intermingled.

OK.

> 
> This means that if we have:
> 
>    CPU 0                           CPU 1                      CPU 2
>    -----                           -----                      -----
> 
>  smp_text_poke_batch_add()
> 
>                                 smp_text_poke_single() <<-- Adds out of order
> 
>                                                             <int3>
>                                                            [Fails o find address in
>                                                             text_poke_array ]
>                                                            OOPS!

Thanks for the chart!

> 
> No overflow. This could possibly happen with just two entries!

Yes, that was actually I observed (by a debug patch)

> 
> > 
> > Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
> > so that it correctly flush the queue if needed.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> > Fixes: 8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by
> > using tp_vec and existing APIs") Signed-off-by: Masami Hiramatsu (Google)
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve
> 
> > <mhiramat@kernel.org> ---
> >  arch/x86/kernel/alternative.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index ecfe7b497cad..8038951650c6 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr,
> > const void *opcode, size_t len, c */
> >  void __ref smp_text_poke_single(void *addr, const void *opcode, size_t
> > len, const void *emulate) {
> > -	__smp_text_poke_batch_add(addr, opcode, len, emulate);
> > +	smp_text_poke_batch_add(addr, opcode, len, emulate);
> >  	smp_text_poke_batch_finish();
> >  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
