Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101120E334;
	Mon, 23 Feb 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832346; cv=none; b=Bobfpxrouf8mQZTLbSVEHIpIuOMYBm0aQQa6idkAIyrJ1c8R6BWlDy4IqB6TONaJ4go7JEZAcmCgqMG/8xWnntrJp0HssRW049ru1MJvJmwpFhh/Zt2c9kLXpr3ZRck/Hskvn1p+jNOTYvcgzHPThZ4ACgxsG/ew5jrDnSoUUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832346; c=relaxed/simple;
	bh=xon9tZeAZO1aMXvaknMSEDPCNVUho772GHePKcQGCOM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NMMcIhEh5gDFV/2PoFTU8PblkUu1hoD7fCURk5AJuX2/pmw2q1UnVzzxjrH7ubot77yHFTT6NtOZ+8sKpcfdtR8qFrEdl1P2ekpKPZ334+Trl9ti9ZWSPKxrGzZz1aVLe1F8UhxYSlwQN1VZDf4LazglYYrWpf4FiPvV0gMdenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlTSnKRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlTSnKRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00639C116C6;
	Mon, 23 Feb 2026 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771832345;
	bh=xon9tZeAZO1aMXvaknMSEDPCNVUho772GHePKcQGCOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlTSnKRU666PMSdlcxON6nx/YPLyvi++6Csn+hg72b/uWdWyu8j4T1GdOUy0CuCxv
	 D6tESCjpfPD6x6Pg0rTrlS7ZJVNysmNkWWCP/pE59aaWNDkBCOLPgeOAVNLPk4rwcC
	 zLZrwGQUsyFV1n6zLUHxfafQK5zhU6SRu/r/kjvDAo0JZWdv9gH336Y0lm7oSzQUMx
	 C/X95Pb/0+fBsYLxPBzRDvmfoGXHfspiOW7Zb5weQHBromSuyaYTn1mT9jdHIMLTk/
	 HX/umBYY/YiVozA7wH7hez4p/cJIaXl5RU3mDxlSnKgyUXRehxBd86i6tykWcNusxE
	 hmtaPs3jJRy9g==
Date: Mon, 23 Feb 2026 16:39:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260223163901.f37e03241282ac4f94d0f033@kernel.org>
In-Reply-To: <20260220145656.7dd289f5@gandalf.local.home>
References: <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
	<177140967567.1537493.7265236420134382381.stgit@mhiramat.tok.corp.google.com>
	<20260220145656.7dd289f5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 14:56:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Feb 2026 19:14:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Skip invalid sub-buffers when validating the persistent ring buffer
> > instead of invalidate all ring buffers.
> 
>   instead of discarding the entire ring buffer.
> 
> 
> > 
> > If the cache data in memory fails to be synchronized during a reboot,
> > the persistent ring buffer may become partially corrupted, but other
> > sub-buffers may still contain readable event data, allowing usersto
> > recover data from the corrupted ring buffer.
> 
>                   ... contain readable event data. Only discard the
>                   subbuffers that are found to be corrupted.
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/ring_buffer.c |   22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index d2b69221a94c..0ae2a5ad8c3e 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2045,17 +2045,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  		if (ret < 0) {
> >  			pr_info("Ring buffer meta [%d] invalid buffer page\n",
> >  				cpu_buffer->cpu);
> > -			goto invalid;
> > -		}
> > -
> > -		/* If the buffer has content, update pages_touched */
> > -		if (ret)
> > -			local_inc(&cpu_buffer->pages_touched);
> > -
> > -		entries += ret;
> > -		entry_bytes += local_read(&head_page->page->commit);
> > -		local_set(&cpu_buffer->head_page->entries, ret);
> > +			/* Instead of invalidate whole ring buffer, just clear this subbuffer. */
> > +			local_set(&head_page->entries, 0);
> > +			local_set(&head_page->page->commit, 0);
> > +			/* TODO: commit an event to mark this is broken. */
> 
> Here's how to fix the TODO:
> 
> 			local_set(&head_page->page->commit, RB_MISSED_EVENTS);

Ah, that's a nice flag!

Thanks!

> 
> -- Steve
> 
> 
> > +		} else {
> > +			/* If the buffer has content, update pages_touched */
> > +			if (ret)
> > +				local_inc(&cpu_buffer->pages_touched);
> >  
> > +			entries += ret;
> > +			entry_bytes += local_read(&head_page->page->commit);
> > +			local_set(&cpu_buffer->head_page->entries, ret);
> > +		}
> >  		if (head_page == cpu_buffer->commit_page)
> >  			break;
> >  	}
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
