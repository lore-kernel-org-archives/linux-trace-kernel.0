Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C872DBF45;
	Wed, 18 Jun 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247876; cv=none; b=hAU9q6L4Hfc+ZMNZMyNEqH3NAapu18ZaXZKN70wtiw+3GH2f0qifeOphrjim0ofmPyvExtNrS021foF9pjkB+YoMI++NawpvhvngKjgMdH6e5Azg5mAEzPkE2klLg7m9/7e+zXGJ8/TK+u80repfVogQRHVdDtn9PWMv85jgzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247876; c=relaxed/simple;
	bh=FiT2P8piG5G7J6NznFS5lYOLStWFH61aZl86N7NAMAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+gHGQUYs9YgtxlUxwelluytgQ/sgyIc9LTfIxswCO3CIAHifLXyMQAohcQKc5evpN8iM+rKKdxXeSOq9BWE0DQOsu6xBQYevcCvy/EpwrYwiWYbDJxM5TREJA5kM7jRBhHBpTzAGcrrrzxKaQ/Vp1KQ3GNWKD33UmTwxT3YhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a+pJG/BR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a+pJG/BR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xcNSQOUfcTheQa/3UDDBZL0p6s0dp8xICvhLKA4O2QE=; b=a+pJG/BRWV58leStz/MCjYgzkW
	fTJQY3soUkm3BUHt7AonaJwcAqiPLheMT5ZoOGvrPe1Vvb0Ns/k0SwHUJrkTMupA/m3IvEKdNyqFh
	ZPzKpDyr7hFQpRbFUe4lzYghymRCQI0XzkG7DNHpXLf9tLsVZAS4OKY/HHM1h4VU39y18ZNjytg22
	V9n38jv+9B8zqWn9nG7Edi9CewKUj14qzJ9RoKS0mbJy6vTrux3Z3Hc4Z3da+ZCOhMf5ySLIgPSrU
	0tTmaNByUrPaFVE3qU81CCXlPABzdVBzmLQZh3S+PHdsrcd1wvrV/sTtrNaasV9wA55dzc/mwfzcf
	lel9Yjkg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRrQB-000000041F6-0OCC;
	Wed, 18 Jun 2025 11:57:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E16C7307FB7; Wed, 18 Jun 2025 13:57:37 +0200 (CEST)
Date: Wed, 18 Jun 2025 13:57:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] x86: alternative: Fix int3 handling failure from broken
 text_poke array
Message-ID: <20250618115737.GI1613376@noisy.programming.kicks-ass.net>
References: <175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com>

On Wed, Jun 18, 2025 at 09:05:23AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since smp_text_poke_single() does not expect there is another
> text_poke request is queued, it can make text_poke_array not
> sorted or cause a buffer overflow on the text_poke_array.vec[].
> This will cause an Oops in int3 because of bsearch failing;
> 
> 
>    CPU 0                        CPU 1                      CPU 2
>    -----                        -----                      -----
> 
>  smp_text_poke_batch_add()
> 
> 			    smp_text_poke_single() <<-- Adds out of order
> 
> 							<int3>
>                                                 	[Fails o find address
>                                                         in text_poke_array ]
>                                                         OOPS!
> 
> Or unhandled page fault because of a buffer overflow;
> 
> 
>    CPU 0                        CPU 1
>    -----                        -----
> 
>  smp_text_poke_batch_add() <<+
>  ...                         |
>  smp_text_poke_batch_add() <<-- Adds TEXT_POKE_ARRAY_MAX times.
> 
> 			     smp_text_poke_single() {
> 			     	__smp_text_poke_batch_add() <<-- Adds entry at
> 								TEXT_POKE_ARRAY_MAX + 1
> 
>                 		smp_text_poke_batch_finish()
>                         	  [Unhandled page fault because
> 				   text_poke_array.nr_entries is
> 				   overwritten]
> 				   BUG!
> 			     }
> 
> 
> Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
> so that it correctly flush the queue if needed.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> Fixes: c8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks!
