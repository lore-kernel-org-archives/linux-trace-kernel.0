Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B95336E;
	Mon,  3 Feb 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572844; cv=none; b=AHB6qgGB6ksuICXN3D62oesAuh1ZgMoz0hSyvwB0/aCNYUtbQ8gAx9q6l1v5keQcqvUrNJ0y3uxD390NbyUk2B6I/oqkU9bLUJtxDLZeBtVP4uNB1qYHru5L4BtYc8ZjmG0u0joDr9gM+1G2/SxiYPVx7ZOB7iwSTQQgqwEFC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572844; c=relaxed/simple;
	bh=NIx5C9OL/COcxC4emvv1A3zU1bJS2JXGwSDfdqiGEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwHsp8j5dtrhvjptrbD9CJwqD6KGrQy/kjrHFMHNdXc4Q0p2HJSkyljP0sn4Rc01O1pb1QfrHZk2dKCuJBpVZkNBVA+uKtxb9960/tm63CMN7DyYrG+Xono4AroPZszFSHqmVyRoopPrxlpivK7B7fIYg2V9exPuOc7i/GY4Dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dsdFJX7y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsdFJX7y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NIx5C9OL/COcxC4emvv1A3zU1bJS2JXGwSDfdqiGEEQ=; b=dsdFJX7yJY/6M+7mcI96AZhrmD
	r7hiTwdtY6Q8Lf9sortAXjcdjMKF4t2JhsS87MaO5IX93TNABXnGXPkZb4kRufcfmtmsvDt8ygAVw
	0DU+GAk2v/75Wbo13VLxsaOyniKlBO8hl9Cf4QriyNwbtZraw6/3Cn44KYhg0qzdbPErYDnKie5tq
	sgKgWRgefS/NpAgy4SlblIKnP7Il5gFKY1hJpdaJJDgtjYVJ9EDrSoYjIHyBxJv6hNFubuhhm+QS3
	Z2LjXDS3/EGfO8SVOuDIIJaWB8CmDfWk5VYFrfnEehoZJypeWpqeNrbgjs2COs36yJnHYkx6YtUK0
	CKy8A7Gw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tesDE-00000000kwL-1R3q;
	Mon, 03 Feb 2025 08:53:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C1222300310; Mon,  3 Feb 2025 09:53:47 +0100 (CET)
Date: Mon, 3 Feb 2025 09:53:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
	daniel.wagner@suse.com, joseph.salisbury@oracle.com,
	broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250203085347.GL8385@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net>
 <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
 <20250201181129.GA34937@noisy.programming.kicks-ass.net>
 <20250201180617.491ce087@batman.local.home>
 <20250203084306.GC505@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203084306.GC505@noisy.programming.kicks-ass.net>

On Mon, Feb 03, 2025 at 09:43:06AM +0100, Peter Zijlstra wrote:
> Lazy is not the default, nor even the recommended preemption method at
> this time.

Just to clarify this for people reading along; lazy is there for people
to identify performance 'issues' vs voluntary such that those can be
addressed.

I'm not at all sure who is spending time on it, but it will probably
take a while. Once it has been determined lazy is good enough -- as
indicated by the distros having picked it as a default, we can look at
deprecating and removing voluntary (and eventually none).

Also, RT likes it :-)
