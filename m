Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1C151992;
	Thu,  6 Feb 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844041; cv=none; b=NxUA/U1czrR+035/rgSh8V5s7Z1ondjMp0wf2PceGgDUkG8CTX2IKecJJWnlLHX45sU56OZLug/FINBMWe16+T480xuiJBETa7zYK6X/IAcU7BPI24tqZF5G1H47iUkxOYDrQPHOzNqPrr9QLJQN6nOFEan5RmVyNerrhpSg9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844041; c=relaxed/simple;
	bh=wxTCmkjY4k9wfr2fZONA+SFblWX9LuSqYnijep5bLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg/sJU+Xcz4dFJzNpIMP0CeYCEsFA4RMhqplogMtLKciblH2cR7QlnpXSxSRmus6Sa2kl+rc4WGRk5Rl/Z98Vl+utBxZ6Stwsw92jIBagO2Me+/E7eqw0wphkhS3nSWtg3eQJqznBwvws0JD2SUv7W+BYfdNeB52tjat6o97khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gW9YDhDS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gW9YDhDS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3B5a6rxdv9Tr08mPBuDoz30MTqmF7tY362uf4ZvrivE=; b=gW9YDhDSq2Mxq2we37wqKCX0YA
	AbNF7dcEc5FolptcfjEwJtbnI8o69XgbNAgsCEJOOyORibQmNGXF3Ikz1uYV0UNqezSTho6ctxLX4
	WTPfejmtCApyCC/xnufGuMWrYJ+LycQKsjmrAcEkap2B2AGdg3KrXz82kUUWe3t/gy80FCxfiUy8L
	ymgUMHMaoRJKB1lFM8UYiq7XaNcQtctRAyw9DZ3+uZUDzpuMvn8/w2X21e1dytvab7lum/chS1ziP
	RP2M+062O4M7RrPv20UfgHHTKQD2Dj1AlFwduHAF1TF7KP2N/2nGE67n0G0Ds1LNEZnBNr5QHVHxZ
	yXVpsEAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tg0l8-0000000Gvar-0Bvo;
	Thu, 06 Feb 2025 12:13:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 49426300318; Thu,  6 Feb 2025 13:13:28 +0100 (CET)
Date: Thu, 6 Feb 2025 13:13:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20250206121328.GN7145@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>

On Thu, Feb 06, 2025 at 08:54:49PM +0900, Masami Hiramatsu wrote:
> On Thu, 6 Feb 2025 09:12:25 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 
> > > +#ifdef CONFIG_HAVE_FENTRY
> > > +/* Convert fentry address to the symbol address. */
> > > +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> > > +{
> > > +#ifdef CONFIG_X86_KERNEL_IBT
> > > +	u32 instr;
> > > +
> > > +	/* We want to be extra safe in case entry ip is on the page edge,
> > > +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > > +	 */
> > > +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > +			return fentry_ip;
> > > +	} else {
> > > +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > +	}
> > > +	if (is_endbr(instr))
> > > +		fentry_ip -= ENDBR_INSN_SIZE;
> > > +#endif
> > > +	return fentry_ip;
> > > +}
> > > +#endif
> > 
> > Urgh, that reminds, me. I have a pile of patches cleaning up this mess.
> > Let me go find them.
> 
> Thanks for cleaning up! So would it change the location of ENDBR and
> symbol address?

No, it just cleans up this utter trainwreck. I also noticed this is a
second (new) copy of this garbage. Clearly I didn't yell loud enough
last time and people didn't think to vomit when doing the copy/paste :/

Function will look something like:

unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
{
	if (is_endbr(fentry_ip - ENDBR_INSN_SIZE))
		fentry_op -= ENDBR_INSN_SIZE;
	return fentry_ip;
}

Let me finish local build test before I push out.
