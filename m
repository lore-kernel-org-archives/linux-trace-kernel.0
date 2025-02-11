Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21724E4B6;
	Tue, 11 Feb 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284633; cv=none; b=SIZeNtJ5+c70b43OvXncG0VpnGOsO+UFN60+fLojr9tnH7fi/UtPF15Hk3EPd1DYPhmR60TkhMfUvPRxDqkxFRG2IFMMgGTBhUCz1hnBbd52aQAv/a4SM1E2P3i9D4jikwWit3Zbwck4SARIXWg3CcjEGP/l0USH2V1vHlVX+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284633; c=relaxed/simple;
	bh=CZIzb9cGr4/AVgH4hhj7syt7mWnqAPJKgrgJZPvCORI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3VXe1UGbWfkekShCSLDogsnj3ubdh2jdD9Dds5kvi9ygqnuqQts4zEIhirNVmmAURA17bLzcKM4sXNwRJejEr1ApAcUKbzIS5XMDPFmVVWOrf7PRkxE/UTRFk+FmvF46ELhVKqUzjHYmUH/BsmQ769+AZaR21YX4eyqRnjiG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dN9lSTek; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dN9lSTek"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pFk5fpEDLWS5KnQvb1kAqi7O5mIQDtL8WY1RZ4xQVrE=; b=dN9lSTekfUpvOIgXLOQfyOH+xw
	VuYQSHTsp1HTBYiyaDFSnKleML4WBXujYlgCRGPzQ82eI1uzmLF9ipUmBusxUAPH1euU0ye9JsMH+
	Eq7JrEPgS8G7Jd7WunIxseMcaqXluXKyY3N8NfOv4rtrkQXjMLlvjCMoSadMmG23pTDLODTK8p6D0
	7pD9cumkoVGRpeOLY2vqtc+ogV7uv9Znr0FuxzYTFXNkK7HxBfSSeL+EZ7SztAhID0/qH5x97m4s8
	ZuaphDGCa8OfOuLBaeBvOjZKS1wyUCMA/4sRPmOpQmbAOADPHotu6bW9b7oGNIiEILc4kxQksULne
	yHhlAyeg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thrNt-00000000bZv-0IcX;
	Tue, 11 Feb 2025 14:37:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18FA73004AF; Tue, 11 Feb 2025 15:37:08 +0100 (CET)
Date: Tue, 11 Feb 2025 15:37:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v1 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250211143707.GH29593@noisy.programming.kicks-ass.net>
References: <20250211074622.58590-1-gmonaco@redhat.com>
 <20250211074622.58590-4-gmonaco@redhat.com>
 <20250211110307.GE29593@noisy.programming.kicks-ass.net>
 <56aad1c92224c624f7404c4ef6076a6ec7299b13.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56aad1c92224c624f7404c4ef6076a6ec7299b13.camel@redhat.com>

On Tue, Feb 11, 2025 at 01:54:44PM +0100, Gabriele Monaco wrote:

> > > +void do_trace_set_current_state(int state_value)
> > > +{
> > > + trace_sched_set_state_tp(current, current->__state, state_value);
> > 
> > Should this be:
> > 
> >  __do_trace_sched_set_state_tp() ?
> > 
> 
> Mmh, you mean avoiding the static_branch_unlikely in the helper
> function, since it's supposed to be used before calling it?

Yep, seems pointless to repeat that.

> > > +}
> > > +EXPORT_SYMBOL(do_trace_set_current_state);
> > 
> > _GPL
> > 
> 
> I'm absolutely not against this change but, out of curiosity, would
> that imply non-GPL modules are not going to be able to sleep going
> forward? At least not using this pattern.

Bah, you're right. Killing non-GPL modules seems like a worthy goal
though, but perhaps another day ;-)
