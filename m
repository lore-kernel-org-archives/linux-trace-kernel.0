Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC274204096;
	Tue,  8 Jul 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000432; cv=none; b=TOgxkElCNMkRFYOC8p1mJ941h6pO0QEgLTdxm99RANNbTxwkqnbM5Iwk/bU3xKmLdjpVUnF2qvQO3Qq9vyc33DXTwvPwimxg46cNIhKAs8l/D37/r/8Ko3XdvgtMGu99hA9PRr2I505T35D75QJnvV+SQrHyF2xYfSls0PnHbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000432; c=relaxed/simple;
	bh=4+18+jchT43E/3fu8il7fe0GWHCQbDcpPrVhJA7oKtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKPaL2lMAhhgl1dBDirpVpLeYuPgQsUbS2sZ5dY/3NgUphTxZNWszQXvgXUsdm0rWej8PFF7/iyRzOvTTJNLwWw8fRSk5Ei3f++JVz/7yugVB00dWMNCBUsXsdbJzj+wQPqIPCE0oqGib1GEGhsZkgg+UUdm4WkQtPBauK2WJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hdDt39ro; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hdDt39ro"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZQneKyvkXDsqYAiLGke2KZOCslgy/Tt7BsquQZrhyG4=; b=hdDt39roxDX2oEb+qSiSIGnL0G
	WSGfjWKxmYVVy4gH05igS98k0uNlhPbx1a3fb+JPGM65aUnmoi7ZyjKehLPvz5z4wKxP5bfEBOFam
	6HFrx50yefbNRJ4sCe0+HvDfOPFuDzgYq4Hz1wshAyoxnfSdw22r7wktbOPB3kd9rIILh7ifPO6zG
	XDh5D9p/r74hJOBy3MLxQWjLl3eApAN0yEfIlB0Tt+GLhAH56yBnxp9k64GAE6erCaybHPz+T77+3
	Qo2Htt1ooFB92IzwufPAfor3OYTCGYZew49VhbeUzvwlpMr0fkzlzVPjLC7I9hVSzkxl8B3Yg1oSZ
	YTFIiNpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDLG-00000008mJf-1OYp;
	Tue, 08 Jul 2025 18:46:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 24DCB300125; Tue, 08 Jul 2025 20:46:57 +0200 (CEST)
Date: Tue, 8 Jul 2025 20:46:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20250708184656.GB477119@noisy.programming.kicks-ass.net>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
 <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
 <ppdduzdqnd3kwourcmocfi35i7wcbuagmzqgtgmyr55aps774t@37wucnoii7o3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ppdduzdqnd3kwourcmocfi35i7wcbuagmzqgtgmyr55aps774t@37wucnoii7o3>

On Tue, Jul 08, 2025 at 10:09:45AM -0300, Wander Lairson Costa wrote:
> On Mon, Jul 07, 2025 at 01:26:22PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > > +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
> > > +#define preempt_count_dec_and_test() \
> > > +	({ preempt_count_sub(1); should_resched(0); })
> > > +#endif
> > 
> > Also this is terrible. Surely you can do better.
> > 
> 
> Thank you for pointing this out. I'm not sure I've fully understood the
> concern here. My understanding was that this logic was pre-existing and
> my patch only reorganized it.
> 
> I'm clearly missing something. Could you please elaborate a bit on the
> issue you've spotted?

The normal (!DEBUG) case uses __preempt_count_dec_and_test(), which is
significantly better.
