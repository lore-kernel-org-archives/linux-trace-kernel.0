Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52E19F475;
	Thu,  1 Aug 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517813; cv=none; b=DQ9IzqgZFp7890HROb9rtyEgtGUyhlCrJKmO7e/JqAk3u7jvz9+aFTTjcXxXbCELAzDMRySQ6IIZ4SoWR1dRQBpUbn028nePY9ks5nnjFsRAl4zSX0w7Cqpkyq7yFmIvooTHg+drDLsH3m19XuEKisuwcgTwbh+IOaufC7AsTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517813; c=relaxed/simple;
	bh=+O/z8M8RAvAqHMvz0SDEluanJieCobATzsrBgi05j64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed2TKuSHzdQEhUIXF4NpFxUhvcOrkLgFbDZAnvOGKwJ14Q5+WF4e19uJP72hReOduATTZbhYI6UuCG3S64WMcdfk7n7HnDm8gj3JIWAWVYbO+rOmBf73ZO/3DfjtcMvJhqf08S5NQ6T0Q5SyKHC/RJ72c6jp9JVilEGZiM7l5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=muTxNYwy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muTxNYwy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4fKy/jm5Jik4H8N+TVzuXa1JQmbhqU0bdfWs2yRZ7Ks=; b=muTxNYwy9cMOjrpyldBoHhOxMp
	litp+5DKmxxrw4FvPSZJYD7VtiX9XL4uhT1+TTmtvsnHHtjt0wpwBcyc2m5O5ax/jB571JjU06erl
	J5/RUD1rfO6FoOImY7Fxs1oklgRGqFgHk/Xo+37xMyvRhecYImF/q3kFFWheOC1kog2SK4Vphb3pV
	IaMYck6c10elqAm4oR0EMk4Dp83AdBD++aKf5dLWmlRLEjoohaMkkUBUSflKJr/tjxwCBZ4A2qqLB
	Mz+iCpV1/8VU8F2rl2e0nriJcEFF1WNIbzOZrTVDJoqE2JMU2iNzVc2sYT/63wEwXn997wmCLurNO
	1KdgmoYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZVZD-0000000HU67-0izg;
	Thu, 01 Aug 2024 13:10:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1414B30074E; Thu,  1 Aug 2024 15:10:02 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:10:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240801131002.GR33588@noisy.programming.kicks-ass.net>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net>
 <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
 <20240731170551.GK33588@noisy.programming.kicks-ass.net>
 <20240731171732.GA2752@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731171732.GA2752@redhat.com>

On Wed, Jul 31, 2024 at 07:17:33PM +0200, Oleg Nesterov wrote:
> On 07/31, Peter Zijlstra wrote:
> >
> > On Wed, Jul 31, 2024 at 10:01:47AM -0700, Andrii Nakryiko wrote:
> > > > Do I stuff this on top of Oleg's patch or do you want me to fold it in
> > > > one of them?
> > >
> > > Please fold so we have better (potential) bisectability of BPF
> > > selftests, thanks!
> >
> > Fold where, patch 5?
> 
> Yes...
> 
> Or I can resend these 2 series as v3 1-8 with 5/5 updated (thanks Andrii !!!),
> whatever is more convenient for you.

I think I've lost the plot a little, so if you could resent a whole
series that'd probably be easiest.


