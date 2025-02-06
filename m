Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB612248AC;
	Thu,  6 Feb 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829559; cv=none; b=H477oHwWvXLNCm4tlwxoAwohGg9Tr1vHATg0GDUQ2h0QvzUCGO0DM2Y0YnxehNeq8f0Jky3n3myBujGYgYWcaX/wCbwNlPC0cTpJwM3m+mSZ1Ro/rXwAuDzynQD2gD/QO6+Z1f6LvadqXTL2lqeT3kOn1tkkxFnI4OBL2qaBlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829559; c=relaxed/simple;
	bh=07WLKkgykW9iqLL6s6SeIJsIpe8lPEKSz908LUZRksQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv4YS4CyZNxM4m9ViSPE4YluADRZmR493RrV2mlOPeRZNZkW8vvc/NjkJB+afJthShdBa294neTs9p/9JRtbwtDXNqVXo28A710pThw6MvBX90E/llKbCnnrlD5gPGkx8intzzgHQ26p+SF0MY1LUkc/0j2WjUQYRkwLqPUOhlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uzLcLchG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzLcLchG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bZULsHQIFsH9bgko7wC1dlzvv/Db+p5ftPFYjtmNzZI=; b=uzLcLchGKSIrZiLx2jWDLfsSzc
	ncqAwHhWeDPqizdGIknNXzW7fYaGTCjKaZFc/cpIQzMdmYQVj0VmxXGdrzQFZy0waPzo0ANi2BAoF
	H6eu1GBz3dOSB4kcPcvyRaBjMVN3+2YjiwcNpaPT/2/MnD2IpRUpdUU17RUwTe7V9MelIvugXDV54
	ifbfrz9ebRS8uDlGtSTYHHeoTnTSdKrpz5Rtg9XqPCcgMdqgNC4ti9Rl69omfu8SoyahtEynMKyUP
	BmVKehuEiEElpAOtRUvv5SehLu5/RvgDM+wTlI7P3dJlirLH0fTsfxyHbZIVO42u69as8T5C7EnJM
	TTcw/pVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfwzq-00000005gIq-0aoH;
	Thu, 06 Feb 2025 08:12:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94E2C30031C; Thu,  6 Feb 2025 09:12:25 +0100 (CET)
Date: Thu, 6 Feb 2025 09:12:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriel de Perthuis <g2p.code@gmail.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250206081225.GI7145@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173881156244.211648.1242168038709680511.stgit@devnote2>

On Thu, Feb 06, 2025 at 12:12:42PM +0900, Masami Hiramatsu (Google) wrote:

> +#ifdef CONFIG_HAVE_FENTRY
> +/* Convert fentry address to the symbol address. */
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	u32 instr;
> +
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> +			return fentry_ip;
> +	} else {
> +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> +	}
> +	if (is_endbr(instr))
> +		fentry_ip -= ENDBR_INSN_SIZE;
> +#endif
> +	return fentry_ip;
> +}
> +#endif

Urgh, that reminds, me. I have a pile of patches cleaning up this mess.
Let me go find them.
