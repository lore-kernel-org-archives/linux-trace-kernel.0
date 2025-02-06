Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726221506E;
	Thu,  6 Feb 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842895; cv=none; b=iwqcPFrJr1FZYPuSd9NViVjmD2a0tKDASsmC5O9XEru5sZuQ6Z5NYQtJHUzFuv+LJFKTvPkv/hmYyT7vLgQGaGw9gEJzeSrhrr/10puSwkxiXubIHonC4m6uUhGc6VYtquvCOQFE9TXuslV0XZu+sVy0O2M7nozrs+vWqFRz2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842895; c=relaxed/simple;
	bh=j3wbsZhH071Dq/51XFPsy9CDyT3KcXjm37OtjCYNNTY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FLQQ8y4t895kGOHtfz+2OBGJRscI6cM2nF5XQ1Y6xHM64cLQV8JC/t5bHrv67QAYYvtT9aJJurThsRvs/DwkyBAePK/uLn8NtCYtfJ4+thpQXOsyClN+QjWe1CttGzEcQNPKBsJ7oWLwr4n/ypPHdyKOhY2eOVkFYjZA24xSYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZHpoX1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZHpoX1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F8DC4CEE2;
	Thu,  6 Feb 2025 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842894;
	bh=j3wbsZhH071Dq/51XFPsy9CDyT3KcXjm37OtjCYNNTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZHpoX1NfDM8PGJOMCl+ug6J7wmzjFdzrggV3GhPrdoFM6jgzX35/T4+SS6etxquQ
	 Gv0UsMjcW4hcHCMFXzaidCAvKXtVWgOwphTjlPC6BvmV6rRBmQFrudFdDhFo12qBxN
	 Wvm7mm9EQfFEAN8lzFMsr0z53PSfDlDnTRmAm5zR46b5KHT17yuyfq6G2Hnnc++GMQ
	 ZnuKSAgmEMfCq8Z9o9/gJ2GKbWyAvVAv7c3OsxUtV5cIJX0V9QjK4X7TOgw8Gm0ZxQ
	 tc+6A9yXWu1K2CvsUegoLkwltC2P7l186B7pYoLopFMA73bWmR9iOADJ1+quTTYO1+
	 /KmuErlxI7j2Q==
Date: Thu, 6 Feb 2025 20:54:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Gabriel de Perthuis
 <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>, Sami Tolvanen
 <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-Id: <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
In-Reply-To: <20250206081225.GI7145@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
	<20250206081225.GI7145@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 09:12:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> 
> > +#ifdef CONFIG_HAVE_FENTRY
> > +/* Convert fentry address to the symbol address. */
> > +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> > +{
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +	u32 instr;
> > +
> > +	/* We want to be extra safe in case entry ip is on the page edge,
> > +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > +	 */
> > +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > +			return fentry_ip;
> > +	} else {
> > +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > +	}
> > +	if (is_endbr(instr))
> > +		fentry_ip -= ENDBR_INSN_SIZE;
> > +#endif
> > +	return fentry_ip;
> > +}
> > +#endif
> 
> Urgh, that reminds, me. I have a pile of patches cleaning up this mess.
> Let me go find them.

Thanks for cleaning up! So would it change the location of ENDBR and
symbol address?

Thanks,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
