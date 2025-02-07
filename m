Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A941DDC20;
	Fri,  7 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922985; cv=none; b=rWWUcxlk/8B/SdCZ80zWDwNwU1mf9INLDU6ra6fJSCjZWBMoUUv5vzp9GRgwG+vhhgsj6GmVb3xI1q/xMESsUveyA25vlDUDI0JaoIXu7q4skwmFtvDLcuxtwhUcA1ieuJa0e8W4cc1J+piBfVGYIupVEX+F8hNiN7Patq4vfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922985; c=relaxed/simple;
	bh=hwhRjJw87qyD4MFy3So0GqSC9UWgvlgvdQdW0ES+O5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcVXL2vVKE7IBnssb2Oi9XbaMOUSC6gZy/6rTMKFsa5cjexP2MNxYJAH0A3p5Z/9TZeXwI7amHMFYMLciZ3ZpteAq31YFTTUGyLIEPypyTtXY+6/nY8LV1lFz9TFZu8HtdNkNxrqXWviOY0TWJiTP/LvJ7ktapDYxWvQUgCS3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HC0m6RRW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HC0m6RRW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dMHfpWwATjyh6xtrvkOKRI4hxnZDh6spdHwQzBFQXGo=; b=HC0m6RRWD3ITB9UfMbsTkUC1Dm
	ZwBKpqRiL6Dup71mNH6ckB8J/W4P6vwvMCd+xthNJtbynkaJhNeqk7DnZTYHNkHsbSFCZQo95wU+N
	+QAUiJLv/02VxuvucxGxCXwUSJ1R3pZ0gbQkpFxIEWcAUhy4azxhvfrfMTwnW7VtHxQU/jOwZv9Jf
	p/ZPF8dRwb6ZF2hbJUXdNpUCRkb0WmhBqFjAihJwMWjsb/FtNNx4KmCR2yOXHvuOAQps4IuuUzlHz
	6t1Jz0fmA6UvgYjQBsQL5fzEoUtoOsUdlGNS50AaeNWn+nZdCSHUQ21FvHpLNX5l/6GH7jool4nCs
	yf6EIPdQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tgLId-0000000H9hJ-2rVX;
	Fri, 07 Feb 2025 10:09:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FC38300310; Fri,  7 Feb 2025 11:09:27 +0100 (CET)
Date: Fri, 7 Feb 2025 11:09:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriel de Perthuis <g2p.code@gmail.com>,
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
Message-ID: <20250207100927.GB7145@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <b4ef10d0-a1eb-4d9c-8ddc-d7815a2bb607@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ef10d0-a1eb-4d9c-8ddc-d7815a2bb607@163.com>

On Thu, Feb 06, 2025 at 09:25:37PM +0800, Haiyue Wang wrote:
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -2,6 +2,7 @@
> >   #ifndef _ASM_X86_FTRACE_H
> >   #define _ASM_X86_FTRACE_H
> > +#include "asm/ibt.h"

Argh yes, I don't know where that came from. /me zaps
