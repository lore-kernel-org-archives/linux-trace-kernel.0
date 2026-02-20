Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704C2EC09B;
	Fri, 20 Feb 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607086; cv=none; b=Q9FrzA17nRe65aT9lT/RqftL2zioOGkI5eHSNMiM1/3bRBjuIY+ushOiSxhlCYl2XXtJa0wcpmFfG95TVbORIp4ot5ihal0VzoGaAl06HZf5g+X8DKOSoJAjFgoPdMFbHmKk1smEtNNGolwXitVrkEbd5MFsUOhsTLkESqNGJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607086; c=relaxed/simple;
	bh=fPMSEQeRlabZXSXcAU+bNMwumrJJylOCCKGBc35KfdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfYLT0/5vdoMgPend1dU0H6XlbNcNI8wAFXQ0/gwMwcGdS6dabDjGwxxuQAANm9/Qfnqq6NIn3Nsud/80CR+htsbEgkg4WVCn/NKmLYkiRm004Mfej0+gWDD8p4qdDfAXgoyPZClQGR3H7UvorqJv1MXwI6bwYejJw9zM56nUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LNYkIvr2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LNYkIvr2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4W61n1XEDT9k+Bz5EhUjcYVj0InlaTnDho/KTMya+T4=; b=LNYkIvr28sSHyabHgz5wgxNTlX
	l+ezrNFpuo75asPcM9XIfqgb8NJISN83HQSvBfkEmMgcex5f+2spBd/IlUYtFlR08bDzTyufUfnVI
	otCyegSHwc3IfH7vPu/fr4qAhQkfr3q/HSrbbRxL7nZ2GZrDw+0MlyCEMdmaeMsHorqtQQGBpURvD
	o5wMyb0tcRrDx98etjHI/bQCF581J34hA8RG4k2sLP/roVYZmImZlgxCo1FWJ0NtETJJ2Ywz5Zm0i
	3N+wxzIgGZpBWr+iJ5v96YuoPEMQ5Zxj1/Kg2UloGRivkzpMa9e7Hw5agyQAUpbq69Xu5clCD2bQv
	w+IubXBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTvj-0000000FLYJ-1uUl;
	Fri, 20 Feb 2026 17:04:39 +0000
Date: Fri, 20 Feb 2026 09:04:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Dave Hansen <dave.hansen@intel.com>,
	"Elly I. Esparza" <ellyesparza8@gmail.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-ID: <aZiUJ--WJygUU6QP@infradead.org>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
 <0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
 <20260218105204.3af7251e@gandalf.local.home>
 <202602191041.4CB9C4AAFD@keescook>
 <20260220114540.fbee78a9a8b8097ec729451c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220114540.fbee78a9a8b8097ec729451c@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 20, 2026 at 11:45:40AM +0900, Masami Hiramatsu wrote:
> On Thu, 19 Feb 2026 10:45:02 -0800
> Kees Cook <kees@kernel.org> wrote:
> 
> > On Wed, Feb 18, 2026 at 10:52:04AM -0500, Steven Rostedt wrote:
> > > Honesty, if you are worried about this, just run LOCKDOWN on tracing, and
> > > prevent *ALL* kprobes. Because yes, there's a 1000 ways to get this
> > > information once you have kprobes enabled and have root access. This patch
> > > is hurting legitimate debugging of running systems more than it is limiting
> > > rootkits from hacking the kernel.
> > 
> > Yeah, I agree. If kprobes is available, there is a lot of harm an
> > attacker can already do. If a bright line between root/ring-0 is
> > desired, a system needs to be configured to be using lockdown or similar
> > things to turn off the interfaces that let root write to kernel state.
> 
> Agreed. The blacklist (or blocklist) of kprobes is designed for preventing
> nesting software breakpoint handling, not for security.

It still can be useful.  As mention in the other thread, we just need
to make it clear.  I.e. add something like "noprobe_for_security".
And if we really, really care it could be conditional on a config
option.

