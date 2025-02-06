Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2622577F;
	Thu,  6 Feb 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852058; cv=none; b=U6/DELhzG6+Bo99i59OkGYnNSvekcMs2BtCNELNls7ZWw8ddKkvrMHCPlbWKvsKTyzRQuLWw+IwGQoCgmQ9Sky4l9BDfoYD4cBL6qH1alHa3DoGcsPvprUBprcYJpbCfNVPwa9HyvWeeYb25Y4gPAc8pBo+j8OQm9GE0g3Z0U70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852058; c=relaxed/simple;
	bh=BezN76/8VPt9jHagI6jVcVKYjsqhc56dWOvbCZY7qQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqyl0dc1eOZDiXc10WyemHCL1LUxAzIO5r7fCmoDrBum30d4fu3QKVtNqGCCWqpZHDf7C1LQyLom1/BRSPLwa6KlaobjkMHICLGrlMK11w4gK49EObeyqUYwuQm0In9/ksghrK6l8z0yuXzIhoP7TJUrMv8yK1YG8yNWstXnTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r/sXPZbY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r/sXPZbY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aHjwizHLsq1lp0fJhwaBPxokex1B77SgmxhHOi1t7L4=; b=r/sXPZbYGcHJakUNZ5H8VPoe8J
	5t+SagAgodvqNeWJRNs61iA7b5jFFhQR6nvR6jI2szVVsvdl17Kt4HNUy/TTbDYQuwLwo9YaeF0Rl
	kXU5rbHE+BjzmQ+zZXrvj4/+tgbxyqeZn3BchWXCTjtFa+5QkSPY3cX/IuT4Cdg9QJ8ZKd/wkRb2L
	RT1S/LWVPiThEL9JUU+fgXykigzgHuuw1yldZBRp0abuKDxXxcwoacNCAuV76ChhVz/txX7RBEJgo
	+Te0w0e0+MNi7kxnqjk/PTt5BFfACddZiyadZed8Tt5l0wY2fiQ2MIbgH5u8V13OEmfQrb1myD/bj
	IjWlru7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2qb-000000067kn-3VUi;
	Thu, 06 Feb 2025 14:27:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6802E30050D; Thu,  6 Feb 2025 15:27:17 +0100 (CET)
Date: Thu, 6 Feb 2025 15:27:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206142717.GS7145@noisy.programming.kicks-ass.net>
References: <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250206134859.GP7145@noisy.programming.kicks-ass.net>
 <20250206135353.i1tp4vDv@linutronix.de>
 <20250206135744.GQ7145@noisy.programming.kicks-ass.net>
 <20250206142234.-kcSg0xr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206142234.-kcSg0xr@linutronix.de>

On Thu, Feb 06, 2025 at 03:22:34PM +0100, Sebastian Andrzej Siewior wrote:
>  Then this feature adds 20us on top?

The point has always been for the number to be < the observable
scheduling latency.

I'm not sure what that number is, and it is always hardware dependent. I
measured it on a random test box when I did the prototype a long while
ago, and ended up at 50us, but for all I know that machine was running a
lockdep enabled kernel at the time (won't be the first and certainly
won't be the last time I try and do a performance measurement on a debug
kernel).

That was not the important part -- but everybody fixates on the number,
instead of the intent.

I'm assuming you have a recent number around -- what's sane? 5us, less?
