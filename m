Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CE2EBBA8;
	Wed,  8 Oct 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935015; cv=none; b=LUnfkOz0fD5t3uwyupSAVNiyx96Y313nN++iY5eSiii/xr4HTNiw9U6zDl4JC7spf2uIORiwHGzdXHD8l+n0BQ0cqWqQ21vaczwqeHZ5CCpnli/p2ehilBUWjuAwMN7HGXpoFHSw8wkq+paMAhFSv61xjm7HnVNWgufDX3A7mT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935015; c=relaxed/simple;
	bh=I+Ix3/P7afro3v8r060lBJrioBGGye6XHNz8d0HEiqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnz5gflN6WLf3LCv6yEDsHA/0JTpbmULUalm9mOKyJFJ7+DqwnS9MihXKAKMNZU454HbH/IoZpAdjrhC+gu9KLAXd6DscrujACmaI8pHz48v+oPWQBMIYuAD2flZVj3pwvr/1j9y762BUU+OQY7fWr2acEErrpdVURLGvGQrMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D0C3845E42;
	Wed,  8 Oct 2025 14:50:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id DDED020011;
	Wed,  8 Oct 2025 14:50:09 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:52:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: ssrane_b23@ee.vjti.ac.in
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com
Subject: Re: [PATCH] trace/ring_buffer: Fix locking order in
 ring_buffer_map()
Message-ID: <20251008105203.75d521e9@gandalf.local.home>
In-Reply-To: <20251005141636.12405-2-ssranevjti@gmail.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
	<20251005141636.12405-1-ssranevjti@gmail.com>
	<20251005141636.12405-2-ssranevjti@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hji9dkep61ne3emds8qut5smc7xonmgp
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DDED020011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Uv/06XvozQegR7umFXJnsm+hjJFMeQ0=
X-HE-Tag: 1759935009-716078
X-HE-Meta: U2FsdGVkX1+ALtxX8lahlqTALVJHlWK6aNP2TJ203FnP6ghg5xNbuxfz4g5fWhW7XkD0oDTNyK5pjbyZBZdfgwjgAoS3LZeJKU0eL/Ch55o096WGwZNA6DYvPZOczC6FliufJrVLI61ZsZEQOvtNj9fS4Teen8KxJJ7xz57vJM0mYQEg79CCp53bZrzj++v/rXH41DDy8P/n6vkpfYQXosBFaXVXQHOY6zCxfO54AVoVLpZNu0bA6ty11Ts9GhNM1Ii73aFmhzgrXNQ1qA7sNWKJMmo/bHZ75YmfPTetMTAz9WrWM2rV099o6MLkivq3U4kURfsUV4y/82qP8Bbj2Fnq32OY3Of3d48Pz2cZihVj+bpuCN+KDhOH/tZl3X3d

On Sun,  5 Oct 2025 19:46:36 +0530
ssrane_b23@ee.vjti.ac.in wrote:

> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> The kernel's lockdep validator detected a circular locking dependency
> in ring_buffer_map(). The function was acquiring the per-CPU
> 'cpu_buffer->mapping_lock' before the global 'buffer->mutex'.
> 

You should either have a link to the email reporting the lockdep splat, or
post it in the change log. I'd like to know exactly what the race was.

> This violates the established locking hierarchy where 'buffer->mutex'
> should be acquired first, leading to a potential deadlock.
> 
> Fix this by reordering the mutex acquisition to lock 'buffer->mutex'
> before 'cpu_buffer->mapping_lock', satisfying the lockdep requirements
> and preventing the deadlock.
> 
> Reported-by: syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com
> 
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  kernel/trace/ring_buffer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 43460949ad3f..82c3d5d2dcf6 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7222,9 +7222,10 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return -EINVAL;
> -
> +	

Added white space?

>  	cpu_buffer = buffer->buffers[cpu];
> -
> +	

More added white space?

> +	guard(mutex)(&buffer->mutex);
>  	guard(mutex)(&cpu_buffer->mapping_lock);

You state that you are reversing the order here, but all I see is you added
taking the buffer->mutex lock. If there was a reverse order, then I'm
assuming that later on in this function the buffer->mutex is taken again.
That would cause a deadlock.

What exactly are you reversing?

-- Steve


>  
>  	if (cpu_buffer->user_mapped) {

