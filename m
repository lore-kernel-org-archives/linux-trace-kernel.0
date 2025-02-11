Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA91F3D3F;
	Tue, 11 Feb 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268585; cv=none; b=hvFKdKcY8oT82tjSr6e4A2F+5Y80Awbqeon6nKet4zfEdkRnDqu2UWW6SE4DA4A6W+fLy4EhqxOSM3M7WKpOw9teqpCPAPnJQjKV9N7j+NdIpqe4svG+D7Di3pDK6UumwTjgDwc/RtfC+uYbOXVRbU0dd1KBuuaqnBCXdCfUjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268585; c=relaxed/simple;
	bh=AyKoHq0oQHey+mDAeqZEs1jQgF36tuQkfMMGb89L/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By3eDq2mobmQe66FcShhTWE76FnzsGLAmQzI/SZkpIXYs/aXjqETjLuO3J8kpenKbCSLDN65oHJBvFn+5gOuGFplsXSt3o2QvpM02DzHALVMcgpVNbs8LHbjU9DqLtWZIB5KlRkVhL6z3tO2FZCAnMHAM+NF1fJWWl/z2ev/eHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VwJ75D5G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwJ75D5G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nffVxaAp4SdZQua8XTyH64wt94TC+p4kCdzyytTJXoA=; b=VwJ75D5GAyqtpLn7DTGcRveayh
	/2NiQ/2kpMcOUCLDPrL0KCuAMEYQys4hxXqvLFx50UQKe7/1kzYOvxVTo+yzLN09dDn1PtD8q5zkC
	zHWQle6RsSh9TygrbrAinJcvv3sRebjAEVJ2E7iTH/eH7T3dSFzkJl405zOUr6TUCyUBRQqLk41Iw
	OJz9kOHauxf0Q0QRoiHT6FUWYObZopo8Po0ofk1ceXkZMMVwoKgNSUN4J0BQmKQhyv+ZOSsHAbkpn
	31CyZ3sd+rqlSih6+i5dSmsCI90WGq3a1Oa3SPsjuGvTC0MPTyZsPXOdq46MRGZBewH1y85iTgyeJ
	tGkkY6Ww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thnCe-00000000vYW-0wjz;
	Tue, 11 Feb 2025 10:09:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3D3D30063F; Tue, 11 Feb 2025 11:09:14 +0100 (CET)
Date: Tue, 11 Feb 2025 11:09:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
Message-ID: <20250211100914.GA29593@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210173016.0ce79bc8@gandalf.local.home>

On Mon, Feb 10, 2025 at 05:30:16PM -0500, Steven Rostedt wrote:
> On Fri, 7 Feb 2025 08:59:59 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Ah, this looks good to me except for the removing redundant asm/ibt.h
> > which Haiyue pointed.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Cool, so Peter's going to fix this and I can drop the fixes that are in
> patchwork?

I was aiming my patch for x86/core, but if there's a reason to expedite
them, I can stick it in x86/urgent I suppose.

Just need a reason -- what's this compile error nonsense about, my
kernels build just fine?
