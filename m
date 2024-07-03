Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A992136660;
	Wed,  3 Jul 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043052; cv=none; b=hJdbzRblR990HnsXAJQdhcBnsgRc3IIjE05dUzpzCzJiuPhgfEQVX/odwdY71opACfiUVR+2cNKmmTLcRSptKZmhr0AQCkVNDNEOU8JMhCq8u5wYDhHXiJ6tvdnlVxhv4ffzYNGFLaX7cmnwbu6VUKQ/ytmKeCWUxL2548qfC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043052; c=relaxed/simple;
	bh=XciLH2BvLZX+43hDP99uSAJVZsp+okYTl4PoGg/jKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se7lzvLjvXbAma7sWljnuoRne7hQgwRwiRqyHt6RzPJC6arcei9TobR378AVeNBft3a6QPXmCKFKLWCmuPlrr7kA8Jwd2xAesRViuta2V+iTH2kImB65FXGPfJMiR/7MSed8R5olO0dwNSoCb3xpwLn2WN3MzffwuAYls/ee29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9B6C2BD10;
	Wed,  3 Jul 2024 21:44:11 +0000 (UTC)
Date: Wed, 3 Jul 2024 17:44:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Message-ID: <20240703174410.099e8784@rorschach.local.home>
In-Reply-To: <20240703075314.23511-1-petr.pavlu@suse.com>
References: <20240703075314.23511-1-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 09:53:14 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The function rb_check_pages() validates the integrity of a specified
> per-CPU tracing ring buffer. It does so by traversing the underlying
> linked list and checking its next and prev links.
> 
> To guarantee that the list isn't modified during the check, a caller
> typically needs to take cpu_buffer->reader_lock. This prevents the check
> from running concurrently, for example, with a potential reader which
> can make the list temporarily inconsistent when swapping its old reader
> page into the buffer.
> 
> A problem with this approach is that the time when interrupts are
> disabled is non-deterministic, dependent on the ring buffer size. This
> particularly affects PREEMPT_RT because the reader_lock is a raw
> spinlock which doesn't become sleepable on PREEMPT_RT kernels.
> 
> Modify the check so it still attempts to traverse the entire list, but
> gives up the reader_lock between checking individual pages. Introduce
> for this purpose a new variable ring_buffer_per_cpu.pages_era which is

I'm dumb. What's an "era"?

-- Steve

> bumped any time the list is modified. The value is used by
> rb_check_pages() to detect such a change and restart the check.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
