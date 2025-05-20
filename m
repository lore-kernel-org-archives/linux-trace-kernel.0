Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B003242D70;
	Tue, 20 May 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749899; cv=none; b=gStbrU55GBH+f0hYeaZhSGAeSX//R5sWhaRUEAHwRnyZjQEcAeK1g+qFmUztlozkDirSDwxvfsl/95gpV+vMNqztMU/fav6ubS7y6/D3aIre8W+cufM9oJu1xifasjpfU54hfI8PND0VCceb9rY9h9cvaBwfqNETohRDMhxa4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749899; c=relaxed/simple;
	bh=FwTN2M9DsTfsj/6tueLnbl1Llxw38v4QaqUMi15NmgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBcdjTNEFMLjDBzhDeVQjZCxkb2PzJYQ9J1peyzFp/DtfGKztMiEyX5iDNrLe2F0IRXAfc/SRPKh3sHewtlha9KhmUlDAizz+RmWY1u3YCeafPlPM8khcYg35l900UPXPZkfi3Nz1AiKrZbo0ubPhJ7HFa8/+CIkbfDht4mg0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES8SmexG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES8SmexG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3917C4CEE9;
	Tue, 20 May 2025 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749899;
	bh=FwTN2M9DsTfsj/6tueLnbl1Llxw38v4QaqUMi15NmgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES8SmexGvRqYBgMtzkBjOvrX8znCoPDidI0UZGzvGoeB4LDg48e4Pbi61iBWLDs+l
	 vRwHMbBZr1dj9zKsF5t4lC+VmR7XYkv8nUYzycpmwY/LPtxMxPFPU5kmSKLGKE+ytf
	 j/JYY/cXGPY2bd1DHz64piyGl6OT5jutJn9/54pWOyvUPGsY7rZ69SbkR+ICbTq9X6
	 YjQ3Ouo8oynmSUZlaTNCgBUIKWPJLzcf74ZCRQYXrlif7xBV0Sw1+17+s+XCdltnw7
	 1j2u3nI01jk9hQr0RxXck0JNmHTvm2RH3fy5aZBp6UwDQ2a6hsFmHL107VvNuyiP6p
	 whQD/WTNnDIcQ==
Date: Tue, 20 May 2025 15:04:54 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250520140453.GA18711@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de>
 <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
 <20250516140449.GB13612@willie-the-truck>
 <3E29A42D-8A6A-4342-8C60-2BEF1EDCD640@goodmis.org>
 <20250519151238.GB17177@willie-the-truck>
 <20250519120837.794f6738@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519120837.794f6738@batman.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, May 19, 2025 at 12:08:37PM -0400, Steven Rostedt wrote:
> On Mon, 19 May 2025 16:12:39 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > > Perf events work for perf only. My question is why isn't this a tracepoint
> > > that perf could hook into?  
> > 
> > Well, the perf event came first in this case, so we're stuck with it :/
> 
> I wonder what effort it will take to convert perf events to tracepoints ;-)
> 
> Note, I'm talking about tracepoints and not trace events, where the
> latter is exposed to tracefs and the former is not.
> 
> > 
> > I was hoping we could settle for a generic helper that could emit both
> > the trace event and the perf event (so that the ordering of the two is
> > portable across architectures) but, judging by Nam's reply, the trace
> > event is needed before kprobes gets a look in.
> 
> Perhaps we could add a helper function that does both (perf and
> tracepoint) and hide the implementation from the code that calls it?

Something like that sounds like a good idea, yes.

> But I'm currently still on PTO so I haven't looked at the details yet.

Enjoy!

Will
