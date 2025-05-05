Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6C191F74;
	Mon,  5 May 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460764; cv=none; b=LJ+vszihqnAqNY4y93B+wLneSEWj6FXq7w4V1nWW/dT3E4QrBA3x1CSLXZAW9PxNpAs1WLJ0dOIONO4vxOKUtGCYMLmGeUHoeIKMR4UoypNRNhZeeKjKRIc3BeruaIxsSnKEbYonaHmb8f2fbPWELP2tmXZnbAsbk9fRvaXKCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460764; c=relaxed/simple;
	bh=RrD7x6fU3Iy2GJmHhBB/95FzxOioR68AN8IEskQgsMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5gw9eX0gOgz2/H4bYsOZhUuA7TC/1s/HRsU0F9eetezRcjWau1q0zkpUFjweUfiBuurUNue6A0kggjyv1bZYOCXE7Rl24FnEPACKWLln1KMXy8DfgwHtAlfgGyaOi+3VHSOgxKI6kRtYcP5axZVPDRUthGPQX8PJIF7R+dh364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74690C4CEE4;
	Mon,  5 May 2025 15:59:22 +0000 (UTC)
Date: Mon, 5 May 2025 11:59:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>
Subject: Re: [PATCH 05/12] tracing: kdb: Use tracer_tracing_on/off() instead
 of setting per CPU disabled
Message-ID: <20250505115928.2fb446b6@gandalf.local.home>
In-Reply-To: <CAD=FV=UEnL7ztSfqAHS1Y=VwwYSyT=rfE7ZiUPLnDnMQNTcPjw@mail.gmail.com>
References: <20250502205147.283272733@goodmis.org>
	<20250502205348.643055437@goodmis.org>
	<CAD=FV=UEnL7ztSfqAHS1Y=VwwYSyT=rfE7ZiUPLnDnMQNTcPjw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 08:42:52 -0700
Doug Anderson <dianders@chromium.org> wrote:

> This new change seems less safe than the old one. Previously you'd

Well, it matters what you your definition of "safe" is ;-)

The new change prevents the ring buffer from having anything written to it,
where as the old change didn't disable everything.

> always increment by one at the start of the function and decrement by
> one at the end. Now at the start of the function you'll set
> "buffer_disabled" to 1 and at the end you'll set it to 0. If
> "buffer_disabled" was already 1 at the start of the function your new
> sequence will end up having the side effect of changing it to 0.

Good point. How about I add a tracer_tracing_disable() and
tracer_tracing_enable() that is not an on off switch and uses:
ring_buffer_disable/enable() that decrements/increments disabling of the
ring buffer?

That way it keeps the same semantics.

-- STeve
