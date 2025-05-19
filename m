Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324927511A;
	Mon, 19 May 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667564; cv=none; b=Qjw7SxfOlbCCecujJHOPsNT0VU51f98m7mVc1ZKNtlqQTgWxl0Gnei3FG00yJnVQr3lRBCbKLTzpjgyeLnGndo2C2wj/cYIsmIFKSlc4m6Prb3yvyePmTP/N87yrBjLeq/tYkpOHjtxpaPLSB2Y0KPo7JHNt1QIVdAbSSVwHNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667564; c=relaxed/simple;
	bh=F2x2lSFiD7EPnjwMTLKRMzcQO67IFR8BeGPkqvkIEFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwRJ0P6WkCS9ByNpNOGI32Pl5XtsbAzEz6RaaSgyUomhMSIGpjxLGqzGp00a3DLVHQ4vEKuP9SyfquX9T7J6ponLm20pQu0NdKP6RfmiS5wwzF6JLAFI88D34GA7P+KEIbzgf11hL0zSjur7nQpi/Xo+uItcJrtXz8a5TYdkqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoJIt/or; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoJIt/or"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA3BC4CEE4;
	Mon, 19 May 2025 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747667564;
	bh=F2x2lSFiD7EPnjwMTLKRMzcQO67IFR8BeGPkqvkIEFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoJIt/orUOH+KTd5pUCa8DjVEdBtRwJiAbeEYP+SYuKvB5QUwqE09HTGMS+D5PRak
	 ZodHEfGzeibKjdRlL4M3L5cva2CrFCnJMrfLa/tCLeLAdTQXQVShhGFZpi6Myzpj9F
	 CzXoQgoyRgeHZAENLp3zF96fT95/B7S8JZIsSKO5HriWkO3Aqz/wB8Z89uDUkKi/aD
	 HiBiatMPnDleE/w5FuRCn6fHqomPVt1dJl5RBeQFRRdFll5ojsp4yIAhXHrcXHI09z
	 D8dS91qLMmceVX07SyxP6uw+5cDTIYk0U2n+TEU3rs8KPhgkZotMmbL4duuJVA6vKb
	 XfMtVJ394+Iug==
Date: Mon, 19 May 2025 16:12:39 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250519151238.GB17177@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de>
 <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
 <20250516140449.GB13612@willie-the-truck>
 <3E29A42D-8A6A-4342-8C60-2BEF1EDCD640@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E29A42D-8A6A-4342-8C60-2BEF1EDCD640@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 16, 2025 at 10:42:48AM -0400, Steven Rostedt wrote:
> 
> 
> On May 16, 2025 10:04:50 AM EDT, Will Deacon <will@kernel.org> wrote:
> >
> >> +	if (user_mode(regs))
> >> +		trace_page_fault_user(addr, regs, esr);
> >> +	else
> >> +		trace_page_fault_kernel(addr, regs, esr);
> >
> >Why is this after kprobe_page_fault()?
> >
> >It's also a shame that the RV monitor can't hook into perf, as we
> >already have a sw event for page faults that you could use instead of
> >adding something new.
> >
> 
> Perf events work for perf only. My question is why isn't this a tracepoint
> that perf could hook into?

Well, the perf event came first in this case, so we're stuck with it :/

I was hoping we could settle for a generic helper that could emit both
the trace event and the perf event (so that the ordering of the two is
portable across architectures) but, judging by Nam's reply, the trace
event is needed before kprobes gets a look in.

Will
