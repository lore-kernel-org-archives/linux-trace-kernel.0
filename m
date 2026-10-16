Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79615349B9;
	Fri, 16 Oct 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172806; cv=none; b=sd3BxHtCNIgv5ILcXHE9J+iFvSDpJ/zW0OpMQWbXKftX67PG8zEouSoJLHrPA4Jm3czvmURuWPbg1SWLkV9tkZreAeQwCAcETB4P/cuhLbly/Y3gG7tKzX/cbMnR30bI8HPSIBET7aq1hdblPNxIqJvJ2ADIvWKR7VVEXZtBqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172806; c=relaxed/simple;
	bh=0z7gbRgtBsopxA/ZvBEPCz2t4y69N+IITVEs/sZePXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGIoN7P6WT51Ch8M62OASbMM7E3HthhdidBwgQJadOPFUQG1U423D5oieqr92cosX7kZg8jHiQgyKrcq9emFTjWzja01T8EvPHh+5+jHKis67IAukyLSru57W+tFBmBWTHN6y2MS7sCFKs8RtxduYU5EFh2ARo3rrA3T9qDjqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=D/7AEwIH; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="D/7AEwIH"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 866BC1404D4;
	Fri, 16 Oct 2026 17:46:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 15A9F2002D;
	Fri, 16 Oct 2026 17:46:34 +0000 (UTC)
Date: Fri, 16 Oct 2026 13:46:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: `likely` not applied with Clang and
 `CONFIG_TRACE_BRANCH_PROFILING`
Message-ID: <20261016134632.19a83a57@gandalf.local.home>
In-Reply-To: <20261016171242.125850-1-ojeda@kernel.org>
References: <20261016171242.125850-1-ojeda@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: u5ggbtuphin64xssgmd7y7cgras8y71p
X-Rspamd-Queue-Id: 15A9F2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XzgODTCy+brdlO9f4JxWp9YdQ/TG8BXA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=EvBP1IKRFZ6OUvYy1f1JdTFPpt2YXPTSNCIvlWythdQ=; b=D/7AEwIHdXCiCR8Jdt3/8N7TuG0fsWA9AL9ofnS2wRuhx1wuGnHFdnrsGqlIBhmLZiPI1uJg6sL5KxaUvo8g/C9tBAmhlt76fJ/cWhSHxPcm9xQmFP7MNyh4ngAsBistoFygOxYxa5tQvKg/LsCOjiLM3JxHZj1dIGK7smDod84=
X-HE-Tag: 1792172794-501495
X-HE-Meta: U2FsdGVkX18ws57O0OzVVJspFclHNomxlPALw5Evzc3WfAGkBqwwaocy/4G8lmYFNer9wvqTNm5/XG58WzieJ/OZ8MsSedlLGnNiEeGcrL/4VV3AH8GYEF03CptoL8Dg10A5eon8b1DHxaX4QHPAKwOC/qX7XlOPo2vSRdRQll5Wh03zZpSInWD6XlGbVZkMCdo7v2PWe2khPDEILeL//7MceEq+6pnad5XKZRubMcFqZhyXTyTLF6Sm8RH0ACCvSEybK+MrnGHZH9LxgDJ45rYwb/NWelssAiBilF8oCNMgIi3diulCHDBR/6z1gV8zKhyQUZCdIrjjGKA+/7K07jHPYKIGhD8ieHgq90psnDneG+p51LNn2J18iRckErmkSInba0gM+tsZEmRFw6vA6g==

On Fri, 16 Oct 2026 19:12:42 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> Hi Nathan, Steve, Masami, Arnd, all,

Hi Miguel,

> 
> I was updating my old patch to add `likely()` and friends to the Rust
> side of the kernel [1] and I noticed something odd when comparing with
> the C side with Clang:
> 
>   https://godbolt.org/z/6Kendxzzd
> 
> Under `CONFIG_TRACE_BRANCH_PROFILING`, the way we use `__builtin_expect`
> with a temporary variable makes Clang ignore the hint (GCC is fine).
> 
> So essentially:
> 
>     #define likely(x)   __builtin_expect(!!(x), 1)
>     #define unlikely(x) __builtin_expect(!!(x), 0)
> 
> is fine for both compilers, but:
> 
>     #define __branch_check__(x, expect, is_constant) ({ \
>         long ______r; \
>         ...
>         ______r = __builtin_expect(!!(x), expect); \
>         ...
>         ______r; \
>     })
> 
>     #define likely(x)   (__branch_check__(x, 1, __builtin_constant_p(x)))
>     #define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
> 
> is not. Now, if we do move the `__builtin_expect` outside like:
> 
>     #define __branch_check__(x, expect, is_constant) ({ \
>         long ______r; \
>         ...
>         ______r = !!(x); \
>         ...
>         ______r; \
>     })
> 
>     #define likely(x)   __builtin_expect(__branch_check__(x, 1, __builtin_constant_p(x)), 1)
>     #define unlikely(x) __builtin_expect(__branch_check__(x, 0, __builtin_constant_p(x)), 0)
> 
> then it works with Clang again.
> 
> Asking an LLM to sample a few object files to see the effect, it does
> seem like it works as expected, e.g. `kernel/signal.o` goes from 1 to
> 125 branches carrying weights and 39 of its 355 functions change codegen
> (675 of ~3800 across the dozen objects sampled).
> 
> It doesn't mean it is better of course -- I didn't benchmark it, but it
> means it is passing the information to the compiler that we expected.
> 

If it works, I'm fine with changing it. The branch profile is *not* optimized ;-)

Hmm, which reminds me, I'll be enabling it again on my server to see where
things are wrong soon.

-- Steve
