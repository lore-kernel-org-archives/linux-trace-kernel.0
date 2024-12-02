Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF333F6;
	Mon,  2 Dec 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121453; cv=none; b=PcfM/rYyGkZ3LqZXrht3s09ST335RITlwTouNYiCj0eJLw1cRdLwHMtp1vmZz0KxejZWFAHIPduT8Db3iRI5K+ckeSoKtxOpc+t03JuFsl3hoAT8NjjTWpTTcqY44A+JWinDFOsZSz9Vc9baZFh/RU1txlPzwecThFxS2a5iEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121453; c=relaxed/simple;
	bh=WBdRcDTx9N7fnkE1blCMm0RztpWS84bc7bxZjpdrF74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNOWx/c/1Z7dTvTi9fL7U/9MwnaRB9Xms1vTH6V8UZSXMv7JvKuCeB/QjNukpU5CinTvHXpIJtAFh+N8Vm3BzLr75Mfto9NODRi7Bg/y+g6Dd2+yrVTzBYXIIlAR9nx9meoyXM9OfGfH8Peg2X+zdqpV0Kt+K1mQO0lwnQATzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3C22hto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3C22hto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4914C4CED2;
	Mon,  2 Dec 2024 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733121452;
	bh=WBdRcDTx9N7fnkE1blCMm0RztpWS84bc7bxZjpdrF74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3C22htoBqNAKys2dY9UdSRMNm+7VGZINvI176HEm7h5HM4DkhVTs0YyJ9vulQMiW
	 Rp4t0ewagmeI34wzXcr3nlwL1b+Hhu/pbG6I8drw0ekgdX0mw2t0hAtlU8eY+0sPRI
	 k+CtYxtF1l/2nqPXndKrOPdpGn6/mq9MnN95Mti5IPV8oAx52KyT2yYW42sWRCa7iO
	 LyyOBLDjKIfjHgjfazW8Ebs/JO055WY7YUZt63VRBN2ksHXkdpCotOqZVsTbVtXTpj
	 jFfdgWJ5yUwQgrXlGrPV21VQRA+fz/teiVtmNdBzjM8OXMNB8R8fKnig7E8wyYltN3
	 Uohdt3CMVjRBQ==
Date: Mon, 2 Dec 2024 08:37:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
Message-ID: <Z01Vn8yZv-AlB-Z4@kernel.org>
References: <20241017113105.1edfa943@gandalf.local.home>
 <6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
 <20241201150406.17f10247@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241201150406.17f10247@rorschach.local.home>

On Sun, Dec 01, 2024 at 03:04:06PM -0500, Steven Rostedt wrote:
> On Sun, 1 Dec 2024 20:37:42 +0100
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> > Hi Steven,
> > 
> > Le 17/10/2024 à 17:31, Steven Rostedt a écrit :
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > Since the beginning of ftrace, the code that did the patching had its
> > > timings saved on how long it took to complete. But this information was
> > > never exposed. It was used for debugging and exposing it was always
> > > something that was on the TODO list. Now it's time to expose it. There's
> > > even a file that is where it should go!
> > > 
> > > Also include how long patching modules took as a separate value.
> > > 
> > >   # cat /sys/kernel/tracing/dyn_ftrace_total_info
> > >   57680 pages:231 groups: 9
> > >   ftrace boot update time = 14024666 (ns)
> > >   ftrace module total update time = 126070 (ns)  
> > 
> > What is this supposed to report / measure ?
> > 
> > On powerpc I get:
> > 
> > 25850 pages:14 groups: 3
> > ftrace boot update time = 0 (ns)
> > ftrace module total update time = 0 (ns)
> 
> Hmm, does powerpc support "trace_clock_local()" at early boot? I
> probably can just switch from using "ftrace_now()" to using
> ktime_get_real_ts64(). Hmm.

The calls to timekeeping_init() and time_init() are after ftrace_init() so
unless an architecture sets up some clock in setup_arch() like x86 does
there won't be a clock to use.
 
> -- Steve

-- 
Sincerely yours,
Mike.
