Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620D1494A3;
	Tue, 22 Oct 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582015; cv=none; b=J9Qa3ESFYUhTTe+Ev4a+/ihraPjSTfDCg0KjGAz1OmIvLqV5zkXKi8Gytv0Hq8w87mm0MCSM5Lk8B5DnHGbHD1wDkY1kABVLHOuoNJZ4bgvH2jIirbYbn6BiggnzITVWVSkfVPZSe/O2ulLKWUq17cs3Ce0Nrjm3kPqhmVHrxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582015; c=relaxed/simple;
	bh=ibOhkUXvRYMK8jkZzE2HY0TBChY/cc2OecVh8ThPhWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibClg1/jTiLuTS53Uc5Iz6ajTR1ueS3lH98yGygva1w5sFV5BnwyvpT8FZ9h6R+v3xRVWj5e11Th+5nL7mHQfGKaNSD3WW3NXbK7gwaO2tQuVJIO8uV8db+qgpK+3/HOyPp4iWe6dUVHikpUBLX3LmlA5ehE0LubZEaav05MltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPIgL9TI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmDSI1Uw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPIgL9TI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmDSI1Uw"
Date: Tue, 22 Oct 2024 09:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729582006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fSPfzACEXYEYmj8ajCysd204o0hQNSbJqJG3tf/rdtQ=;
	b=oPIgL9TIlmVFMOGmChRdpryNKfi184JhP/yYNuee0+HLn77GrmdygJM6uszNkA8GofupxW
	72XBQOsqwzAOru2LcnK8sqJnRw++lx0J1AafvI+hrdRSDDsOKV18+smC6ABgEGGvw8UeKG
	4PLjsowAcVuUMHU4DwETZCNYFCwo6sNInmIpiQLtHGClmnwPkHuxIzq1fGL7zq5pN/upRd
	vPJGpujVqEWeB2hXIJ1Xo16Ci2I5Asg8rdBP3C8hGobiylyRWP3neObyuJ3rakK3BmaguB
	IW/60TnTYfGOlnZYpbVcoeTmqJvh7/RW6l+38A2r3Zw2cSWd/Q/K7AhSeekrQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729582006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fSPfzACEXYEYmj8ajCysd204o0hQNSbJqJG3tf/rdtQ=;
	b=DmDSI1UwyvYWxeWvwgFsYXjh5msTVid8/6UOeryfDdB9h7VeRc8u7PGD7PyeBbJUW1534/
	8IXDWmMMrs23uLDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241022072644.Tw-k3d95@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
 <20241021151257.102296-3-bigeasy@linutronix.de>
 <20241022031827.21e70b2b@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022031827.21e70b2b@rorschach.local.home>

On 2024-10-22 03:18:27 [-0400], Steven Rostedt wrote:
> On Mon, 21 Oct 2024 17:08:41 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> >  enum trace_flag_type {
> >  	TRACE_FLAG_IRQS_OFF		= 0x01,
> >  	TRACE_FLAG_NEED_RESCHED		= 0x02,
> > +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
> >  	TRACE_FLAG_HARDIRQ		= 0x08,
> >  	TRACE_FLAG_SOFTIRQ		= 0x10,
> >  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> 
> As I stated in the other email, these are user visible. Should probably
> make the LAZY flag 0x100, as the trace_flags are 16 bits worth.

What about struct trace_entry? That flags is stored as 8bit in
tracing_generic_entry_update().

> 
> -- Steve

Sebastian
