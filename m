Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D5377A91;
	Wed, 15 Jul 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784158812; cv=none; b=lDWLokrB+3xBMMQlgwySvqPo7bQm7Z1K/fN8P7OtCti5Pz7POo1o9nTGoLdkYTmCfphtz3CyyhrNQRdVZ1a5C2Afq8HEDsN5QtBI8MZTdFRkK6oCD8kv0EnHwahBrOoi2JVYY6jz3/HEeNEK+rRy34steJ4u7G26OX8RQ8u4eiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784158812; c=relaxed/simple;
	bh=Dxpqj/8dKgrWFkpgccpFkentl0kmdJsj6682or5SiHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRMs2A7+DrYvSVHQlOJeykokYS4fb7rqvNwz5UMlXiFhcQyR0xxvJw2MsPGKJBKzdOUNAH1Hn1Ummtirb0pSFiEIrvRZncFK1OU3iyLIl97+xLrOWcMW1wkW8f7HS25JH8U2omobH3Ngp59+h51Njxa+nOdC+q7tfYpKsM2UPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAN1zj0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAN1zj0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2941F000E9;
	Wed, 15 Jul 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784158810;
	bh=+h/jDmZfTpzINdBC677m6zUdXppV6mEd0tUSUbjimu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mAN1zj0GBNk9ttnLGDXv7p0eGbtYs6/yuTPLXZOU6yianhwzSYFIsZsGVioZpB/Ag
	 hX8BYlH00DoViJpPiQA71vKICH8r9F61ULtB5z17IEq8exP+Bn44qRc5FI79f4jWMv
	 ci0CByyS4KdsWArDayHVQJkMw+ELOoVROhn5CfXw6XIU8SzDUeIduuuZbFWtLZle3i
	 7bAIbko4VZgJEKA0xQXGJyiArVYJSWkhCWKyUxdns4d+BV7LkZAOjfwsSY4sF/OaDP
	 mdunccaTEXVhuhZzm0m2jTARlncIr7qPNkJdGcFRxcyJmtONGf06C+6F4MJzR4yhme
	 7sWxF12dWZQgA==
Date: Wed, 15 Jul 2026 19:40:05 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: ring-buffer: allowlist clang-generated symbols
Message-ID: <20260715234005.GB3672352@ax162>
References: <20260616164211.3733326-1-arnd@kernel.org>
 <ajKgjNuHUlteSziZ@google.com>
 <20260714175617.319a6ec7@gandalf.local.home>
 <cc1232f7-fa15-4e1b-ba24-3d77dcb813c9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1232f7-fa15-4e1b-ba24-3d77dcb813c9@app.fastmail.com>

On Wed, Jul 15, 2026 at 09:38:21AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 14, 2026, at 23:56, Steven Rostedt wrote:
> > On Wed, 17 Jun 2026 14:26:36 +0100 Vincent Donnefort <vdonnefort@google.com> wrote:
> >
> >> On Tue, Jun 16, 2026 at 06:42:03PM +0200, Arnd Bergmann wrote:
> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> > 
> >> > In randconfig build testing using clang-22, I came across two
> >> > sets of extra symbols in the ring buffer code that may get
> >> > inserted by the compiler:
> >> > 
> >> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >> >          U memset
> >> > 
> >> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >> >                  U llvm_gcda_emit_arcs
> >> >                  U llvm_gcda_emit_function
> >> >                  U llvm_gcda_end_file
> >> >                  U llvm_gcda_start_file
> >> >                  U llvm_gcda_summary_info
> >> >                  U llvm_gcov_init
> >> > 
> >> > Add all of these to the allowlist.
> >> > 
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> > ---
> >> >  kernel/trace/Makefile | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> > 
> >> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> >> > index f934ff586bd4..aa8564fb8ff4 100644
> >> > --- a/kernel/trace/Makefile
> >> > +++ b/kernel/trace/Makefile
> >> > @@ -146,6 +146,7 @@ KASAN_SANITIZE_undefsyms_base.o := y  
> >> 
> >> Would "GCOV_PROFILE_undefsyms_base.o := y" work?
> >
> > Arnd?
> 
> Yes, turning off gcov for this file should avoid the llvm_gcda and
> llvm_gcov symbols, but not the memset() symbol.

This would actually turn on GCOV for this translation unit and cause the
llvm_gcda and llvm_gcov symbols to be included in UNDEFINED_ALLOWLIST
via the $(NM) call.

> All the other features that leave annotations are handled by
> listing the symbol names (__asan __gcov __kasan __kcsan __hwasan
> __sancov __sanitizer __tsan __ubsan __msan), so I think for
> consistency it makes sense to treat llvm gcov the same way
> we handle gcc gcov and the rest.

I do tend to agree with this though, as opposed to using
GCOV_PROFILE_... or ..._SANTIZE variables.

-- 
Cheers,
Nathan
