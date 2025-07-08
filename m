Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040601E48A;
	Tue,  8 Jul 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960544; cv=none; b=K25LKYsw/5CSrpBgQE1Z2QG7kXbLNfDeAO3PTUrClZQ/XIbEWa5N1iIyhTrivscflL/cK7kF1LuAJeLBl3mSJQW4tIeqQ1AfuxIVNKlp1WW0XZdyXfBwgrHt7jsLTh7zvXF/DjwZnCUWqLsPKfLoM+ahMnLeZksRCoUULjn+H8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960544; c=relaxed/simple;
	bh=j9Gcl1MR8XonGtAZ9WPFx91cUYqZF+ofU8py5vit9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fygsgs8r1r5PyGOZFOyv+v+c+NRCEWWCoNhaTKWxOBIqWMgmYzX8WlP/eqm1mAVm7AuzHugeiKFUszrDfDMFWIHHgmJzgRfPsej+Od78npe4q5QYn4P0pmx6HbuOrO7BuWgnNfi7TODQ75aaL7N8kvTgwTXWO3Ulmx5SL5yoLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r1arUOkR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwiY0sYJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r1arUOkR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwiY0sYJ"
Date: Tue, 8 Jul 2025 09:42:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751960540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/y+zGBFHtkzuV2I1Uve5PJvHwtJ2rfDUFlcVSxc1/yA=;
	b=r1arUOkR/5qzhcm7UyPVWfoVuYNdSm1wKr/YSAtoUpEmcAhZNPjB3xxDRRX1dVKW8PdcAi
	QY+LjHf8xBw46E8IMcv1wUveWoePKPUHLfNoDuXLilxa9m5hko/0s8UyX9YdbHEjFAtTH2
	bLMelHKYIMgZA8wpFzpY7bG8Ujv6OnejDWLuEY2Ln/16XveX2qbmujevLFoWuWeHCTdlG8
	TcxLHEIDDvAhic4b2J2mY94MuQfFlkr3AXJFxKN+PSVpASxNxoKZWPH1T7fv6qgPI/Gc3L
	9lt4t/NGNoywWgiK6EopH5kBNJy922zaNDYQZhoGZcXZIzmjTFNDVg+yDuqPkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751960540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/y+zGBFHtkzuV2I1Uve5PJvHwtJ2rfDUFlcVSxc1/yA=;
	b=WwiY0sYJLObRNWCl3F0+8+OkcQhtgk7gbiOJAu7dWSL+2p5r6+8FjUm7bt1R4SOJXUOfLb
	MdrXe/luiz9c7XAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250708074219.K7BthlGg@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
 <20250626113520.315db641@gandalf.local.home>
 <20250626160459.soHxOROG@linutronix.de>
 <20250626123445.5b01849d@gandalf.local.home>
 <84o6uatn6i.fsf@jogness.linutronix.de>
 <564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>

On Thu, Jul 03, 2025 at 10:05:59AM +0200, Gabriele Monaco wrote:
> Hi all,
Hi Gabriele,

> these statements made me curious: I always thought of memory barriers as a way
> to order reads and writes to the same address across different CPUs (in other
> words, for visibility).
> 
> For instance I'd do something like:
> 
> CPU 1             CPU2
> 
> write(x)
> smp_mb()
>                   <implicit paired barrier>
>                   READ_ONCE(x)
> 
> Now, I get there isn't much we can do if reader and writer are racing, but, as
> Steve said, I'm expecting the presence of barriers to make the racing window
> smaller.
> 
> Am I misinterpreting the whole thing here? Are those barriers just ordering
> reads with reads and writes with writes (hence useful only with multiple
> variables)?

From "WHAT ARE MEMORY BARRIERS?" section in
https://www.kernel.org/doc/Documentation/memory-barriers.txt

    "Memory barriers [...] impose a perceived partial ordering over the
    memory operations on either side of the barrier."

and also have a look at "WHAT MAY NOT BE ASSUMED ABOUT MEMORY BARRIERS?"
later on:

    "There is no guarantee that any of the memory accesses specified before
    a memory barrier will be _complete_ by the completion of a memory
    barrier instruction"

Or data memory barrier explanation from Arm
(https://developer.arm.com/documentation/den0042/0100/Memory-Ordering/Memory-barriers)

    "This instruction ensures that all memory accesses in program order
    before the barrier are observed in the system before any explicit
    memory accesses that appear in program order after the barrier. It does
    not affect the ordering of any other instructions executing on the
    processor, or of instruction fetches."

So yes, smp_rmb() is only useful inbetween reads, and smp_wmb() is only
userful inbetween writes.

Best regards,
Nam
