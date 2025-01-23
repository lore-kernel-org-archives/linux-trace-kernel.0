Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621E2F2A;
	Thu, 23 Jan 2025 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600160; cv=none; b=OWBKBh12cBJhF9btiTiqNd6qpPRLW5pJE+weYLbEe71XvdnRw/2UQmyAbiF7I/Wd+AClVEkHY7zkoJowEy+Fj1sFfhXsvgFH3kEtMrAq8OO8Md+FX1e9FP1O3N/JaUYoalIrriTf2MSf5YR5io3WP5DSV2bTU18rFq0FcytMOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600160; c=relaxed/simple;
	bh=jKzh1oMRseLbuqqSqtqj4V6p8s+3jJ1v44mQUF6QnUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH46QeE8oOpp/U+ov0rDQkFxHmetrzp6BBnWX7FjhBnqFlvqZ4E9caBCvsJAnk1RaB1BoIvdXTgB/aqjsfPsmjLEtB3BECcYnvN0EinoglwXp3LLyuIzgIuNZguvt3NliQfdWHXv8Tbed4v8zPwN7YQO8PNx2i2sQICrgYu7Sic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALvGygyh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Erj8JUo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALvGygyh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Erj8JUo"
Date: Thu, 23 Jan 2025 03:42:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737600149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvHwbfk2zgzOjHfHRA0G223BnP/QobptAuu2su6460k=;
	b=ALvGygyhafs0/ZnPHr1TRgbWzZQefmW3aMby9kgVhUlQ651oeYhNeN9X2SzOjRlsewr1tT
	iY59oTc7KObYzcj3I5/mhPYRYiZSXysBGsDkxm4SroXTcmxya8rWARRVr+6ukAHPRQGj3b
	GnT2oEnOy5jPEHTvfGuLdH543J78xASQwUb5Tqai5YqD09Lps2it84Y7iq0ZzWXTK5zjTW
	gKjPYoICkJY5VwLJQIwT8d8RXHu+Nu0cVPhtNHbF/MD4yk6WMXgpp7jo2v3aSGw+yiPypA
	0V9a3P1B3SuGSP7HTsIfWiZeKaiJKyfBZ14BWSKLcCTtMRdeeGgYuqkSAiOH3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737600149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvHwbfk2zgzOjHfHRA0G223BnP/QobptAuu2su6460k=;
	b=+Erj8JUov9BlTq4jsLYjLbpKaK5yMozhxcPa79WR9tSNVXP2egxJqc+JgbY1L2VMLxlx+U
	bSaEFXWM12Ce+1Cg==
From: Nam Cao <namcao@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, naveen@kernel.org,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: kprobe on local function
Message-ID: <20250123024224.d0h8d4HV@linutronix.de>
References: <20250122075939.qw7HsuMd@linutronix.de>
 <20250122172936.09bc8c9a@gandalf.local.home>
 <20250123104842.92336327f898e546c5b67536@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123104842.92336327f898e546c5b67536@kernel.org>

On Thu, Jan 23, 2025 at 10:48:42AM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Jan 2025 17:29:36 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 22 Jan 2025 08:59:39 +0100
> > Nam Cao <namcao@linutronix.de> wrote:
> > > I installed a kretprobe on the function "rt_mutex_slowunlock". Although the
> > > function is called, the probe is never hit.
> > > 
> > 
> > How did you install the kretprobe?

Sorry for being unclear. I install it from within the kernel:

	struct kretprobe mutex_event = {
		.kp.symbol_name = "rt_mutex_slowunlock",
		.entry_handler = entry_handler,
		.handler = return_handler,
	};

	register_kretprobe(&mutex_event);

...
> > Have you tried "perf probe" to install the probes? That uses dwarf info to
> > find all the functions.
> 
> Yes, I recommend you to use `perf probe` (under tools/perf) to put kretprobes
> on those copies. See tools/perf/Documentation/perf-probe.txt for details.

So a similar solution for in-kernel code is kallsyms_on_each_match_symbol().
But I expect register_kretprobe() to do that by itself; or at least report
a failure if caller specifies the symbol name, but multiple symbols of the
same name are found. Because at least to me, my code "looks correct and
should work" but it doesn't.

Thank you both for your replies,
Nam
