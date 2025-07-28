Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170134CF5;
	Mon, 28 Jul 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718019; cv=none; b=Kuty5s1a6iN53qUmlYUrlFsmp5wFRqO6VWL3p8YSOktC03TjqSiiIq/mwVLfcti9PQ53N5d9tLFyrBcwWm+cJZy93mVdvoNrBxwqciacmgVUqFtCWunT3OSBJfr3Km9cOJOe8I/qxgTvWGgGNtMb+kShsd30TBB36HiwkNK08F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718019; c=relaxed/simple;
	bh=U7j2Lbosm4WLYwZsfrLKzY6YAPlSQt9Q6Zc876hxD3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raKdXVwkdkiJCQPyXV5Jt8aqyLfmBHB2bxi469SiHBve/uu6gyIPS3iRz7PWkKeeUm9aqwXlQFNMkSjsjbuprFVNYOn/ENNXdnUuQoo4S+asbv/uPgTuYr/rwsV3PIeAmBfHS/mf18ETl4Odp2KIaMs8/3IDnc14kTOl8AOkIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4xVgWWN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6keutG0R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4xVgWWN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6keutG0R"
Date: Mon, 28 Jul 2025 17:53:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753718014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CgF4jfxs5+O2wkAzCTn2YihFiw2i9lKZtG7mYjPuQk=;
	b=f4xVgWWNm7IXkoSvOBLeGOenMWbJfO60HAKxQsrhHabxSoAmBk2CumZIUD4B7nMrgoRZXA
	rqjznDqds2XK0eXX/IP+GyJJTicGMJcpXcz6w3AmIAoCrIOXU1s5PR+hWbhrTjJpnsQtzA
	BrtYy2r80pbqubap62Uw3WAfbVaZC0UXGd6wzTQUgRkqDaeF8ag3lFpzRBm4+iXvMwpcrx
	lP+rUXXI0EjrdUkpp1fKA7pFQs5IHACi2DOWkuS0tpPmBHYALt8QZbpbaofZZwyc/VS+FW
	Mko40fot6+CP9ReI5VGIg4WY8c/p2dWXeylSEaVcd5O0TaKqP+N7WD2FAn4Ixg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753718014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CgF4jfxs5+O2wkAzCTn2YihFiw2i9lKZtG7mYjPuQk=;
	b=6keutG0RXxiyWXfQSP9SWfr9+x9fS9jQvt0HnyO4obBGTDBTHD4UNOJ+4BBZB57ldZYk2M
	k6hh+toXUJQNwwAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250728155332.sbkepHj7@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135022.255578-8-gmonaco@redhat.com>

On Mon, Jul 28, 2025 at 03:50:19PM +0200, Gabriele Monaco wrote:
> The tss monitor currently guarantees task switches can happen only while
> scheduling, whereas the sncid monitor enforces scheduling occurs with
> interrupt disabled.
> 
> Replace the monitors with a more comprehensive specification which
> implies both but also ensures that:
> * each scheduler call disable interrupts to switch
> * each task switch happens with interrupts disabled
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I gave this a try on riscv64 and observed some errors:

[  620.696055] rv: monitor sts does not allow event sched_switch on state enable_to_exit
[  621.047705] rv: monitor sts does not allow event sched_switch on state enable_to_exit
[  642.440209] rv: monitor sts does not allow event sched_switch on state enable_to_exit

I tested with two user programs:

    int main() { asm ("unimp"); }
    int main() { asm ("ebreak"); }

The two programs are repeatedly executed:

    #!/bin/bash
    ./test1 &
    ./test2 &
    # ... repeat lots of time

Any idea?

Nam
