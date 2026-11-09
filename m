Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216104;
	b=w8UW6eI5+KGmmHbyDEDg+b5pr5axRMlKOgMpdifzHjJuwhGk4/bOcoSTrjf6gDz1S3lj
	 AT1pRvlsfbLp5OnIGLEccJntutS4bm1UFC0Yo0ILlk56fozvJri1Igj6dvn8rnzM7rTM6
	 rihOAdv9flSwVE/4CjsgoicOeT3LtCxr9Ecm6cdaNyTrZnGJSnR7UQmEg3CXmfMYRj8xS
	 iGbjGxuBcs6joqs6JEaWK3t+RdCepqtyPGoSYTFv/IFfX2ND8ay10jEsQs9VA4/L0LWYa
	 dK//3hic8WhGtVNY9Da+Kd0SedWUBxqALBlHnc47LHuQq8rHjywAwCiDw0CW8pSIiNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BP2nz3kgTNIKOGPU8LXmrMB/68D5MLYO7PO06upXzGc=;
	b=FEvuyZj7NnPpcok82QSqarXtz63n9HbPXN7E2CdBN1ejcESHIKBOHWkQTEYrkPKrRxkh
	 3nSclyf2b+MUS/8GwCii3P1EXhZzOeesK6tzvdr3piSEakJSx2nBmvGvtYUAwGLtf4G68
	 aj5lNksaknqwF3iQ21bFDsFcJDr+lFBIuIgSMtbDA8Guhnt+V0vssgNY54dosRLBNVp93
	 /Kv0bHzZUNxxCjxlbOUdwoypej8BMkHPnOsY2EASKnE2jR1N8sFjI6aiCVUzg3cNKThnO
	 1YY+/fXRTiLMCGRWRFDtIBgTkDu/tmWR5ONriR5o674mfe2F2/G289JFaWhUfP7soew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EsFCmFLS;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D303606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 09:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D303606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EsFCmFLS
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b001cd92bso239762f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794216102; x=1794820902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BP2nz3kgTNIKOGPU8LXmrMB/68D5MLYO7PO06upXzGc=;
        b=EsFCmFLS53/z9iximGOpKSrrXAb1ZChn3+Q5On2+uJUibmwhch4tyLyNg824nwwhtx
         GBeGCejsh7Y2Y63iEMp9/VJ5DUyMtzSpzMlwXC0GdollJcK+zxQWposcfpB8zQ/rQwXE
         eHBP3aCIgV0HyigxlTHnc3Uw3H9uKtA4v/pkNTn4XgDNyaZOcmSjNmIoreuKAyoV+Wf7
         s8jSGyBC0irfEuo6NZcVXmc/HIg8FP3qqfVZDzAdDZgHmtZEfSxT9GAL1c6LKswWWapT
         Gv7qpId+xp1Fdl1FXdLvnhzyAhOO7Pzr9wNfU6x8I/9V3HZ4QkFXjq3OpjA+HWakd4De
         BLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216102; x=1794820902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BP2nz3kgTNIKOGPU8LXmrMB/68D5MLYO7PO06upXzGc=;
        b=Y6JFVKrJT6cLtlubeFlFYIMw2ms59R/yn3SKJgHv+M27yP0EMved70ApQMntVEjP92
         NaESUOsbS2on1ixQwt/WGrBTXxKRG4POkQIji2hfXWqjxT4Gw7fSuOLIA8rMD+frn2UB
         YQ4yLc7JwiV+qJSyhQg+fjOPkt4AfYMCYhSCjwuNTm096Zwi14OD/PXxNsI4ZFhf86b8
         S350jU6+tJSf1Qo0FU+LauMresuktHU1cWYq51fTdQ4rRxMQ9gOkpvKmv9iVpYgm8UYR
         2twpP5z5ls7YCFrPaQVi8Y2G7yTZl6hlEOaMYa2krR7Sohh2OxUxeH6HnixSXCoVaImY
         WBzg==
X-Forwarded-Encrypted: i=1; AL+hErFh+VDvsuX6xoDXtNHaoibSbIqGass8oK95jybDHg4R3O7LcPoGQmIbqKmE+PYBBqDAMN+kR8f7hE1J63sG7ewhNHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+savbC8Yvqzc1tR4Z8PVSYfhcMizs9JK0jNRGyf8NBI51MkNQE
	SxjkEd9c/F/VT9NY2ATQOmJtwi2JIScSA9GhtlL3eoNrD4Z67qEH05tyj+ubYSq9V/IxSJycnXl
	kZ+Eiig==
X-Gm-Gg: AYBFou3lYizpHXasE0m7vfTeNG67LtYQH0KECikZWe9TK9Z4gtb7cDk62135k3oejRY
	PXtXdet29SunFRWmr66G7yaRfHGPR5K7DltuaeycCAs2JN7vqx/okGmHw7a3JskpG9CwwF4Uojs
	DJ0rEAv9lUNJINc2YORIJPseFahi+WOuFuvPk+C/p0PudRgitCkVpqDB8X18+Cl6TmnZxUIkYTz
	y1okphoShL00DVOJvn71M7iw+xBuu/CDysX+t42ufFgV+bKYLg6HLTT3DT7zHFfEZWeX5BE6EEH
	jmZXvSO4wMfdk7Unr0y55lMSb4cj8D9Sg6rH8pjVj3vogNlbjlx3P0f5clWp4uu6nps3M7Yg+/M
	orAIZT/fDvxJ124QY1881MrKlEUvK3TbxshUFo+Vk5rZQQsGoLzqs3jnKjCwTJ+RefM4oEWw5iE
	ITKgjWQPGpR6xGOCks3nzD+mMRWLC6x8uLIEcDaTVLRTfmtMmjvqVVRC99KY4SWkb++dwW3jDjx
	YO/Vui+rEEGjmqRynoNpOl5n3c96S0pblOAxKeX/wTMw7VcpEQaibeM5Q5IzdOiI61areic46t5
	xL0vzyetMhMZoevryXazt9VLqRQtAbyf7cvuj934nAL3sjnNW4moVgAAp3HDXjmi
X-Received: by 2002:a05:6000:40d9:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-4958a01601dmr6811090f8f.13.1794216097055;
        Mon, 09 Nov 2026 01:21:37 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596acf59esm8986229f8f.23.2026.11.09.01.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:21:36 -0800 (PST)
Date: Mon, 9 Nov 2026 09:21:32 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avGQnBjyUMwunknT@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105155729.0f9c7e4d@gandalf.local.home>

On Thu, Nov 05, 2026 at 03:57:29PM -0500, Steven Rostedt wrote:
> On Thu, 05 Nov 2026 03:12:42 -0800
> Breno Leitao <leitao@debian.org> wrote:
> 
> > The following warning occasionally fires on a KASAN-enabled debug
> > kernel in Meta's fleet:
> > 
> >   WARNING: kernel/trace/ring_buffer.c:3793 at rb_move_tail+0xf78/0x1050
> >   Call trace:
> >    rb_move_tail+0xf78/0x1050 (P)
> >    __rb_reserve_next+0x648/0xac0
> >    ring_buffer_lock_reserve+0xd00/0xf00
> >    trace_buffer_lock_reserve+0x28/0x188
> >    trace_graph_return+0x220/0x3e8
> >    ftrace_return_to_handler+0x2bc/0x5a8
> >    return_to_handler+0x20/0x48
> >    __arm64_sys_sched_yield+0x18/0x30 (F)
> > 
> > rb_handle_head_page() moves the head page forward in two steps: it marks
> > the pointer to the old head page UPDATE, then marks the pointer to the
> > page after it (new_head) HEAD. The second cmpxchg is assumed to return
> > only HEAD or NORMAL, but it can also return RB_PAGE_MOVED:
> > 
> >   CPU 0 (writer)                        CPU 1 (reader)
> >   ------------------------------------  --------------------------------
> >   rb_handle_head_page()
> >     old head ptr: HEAD -> UPDATE
> >     new_head = page after old head
> >     <interrupt: nested write>
> >       sees UPDATE, marks new_head
> >       HEAD and moves the tail page
> 
> Wait? The interrupt should never change UPDATE to HEAD.
> 
> Something else is broken here. Because only the one that set HEAD to update
> is allowed to set it back to NORMAL.
> 
> >     </interrupt>
> >                                         rb_get_reader_page()
> >                                           swaps new_head out for the
> >                                           reader page
> 
> 				This should not happen. The entire point of
> 				setting the pointer to UPDATE is to prevent
> 				swaps from happening when any commit is in
> 				progress.
> 
> The rb_handle_head_page() even states this:
> 
> 	/*
> 	 * If this was the outer most commit (the one that
> 	 * changed the original pointer from HEAD to UPDATE),
> 	 * then it is up to us to reset it to NORMAL.
> 	 */
> 	if (type == RB_PAGE_HEAD) {
> 		ret = rb_head_page_set_normal(cpu_buffer, next_page,
> 					      tail_page,
> 					      RB_PAGE_UPDATE);
> 		if (RB_WARN_ON(cpu_buffer,
> 			       ret != RB_PAGE_UPDATE))
> 			return -1;
> 	}
> 
> 
> 
> >     cmpxchg(new_head|NORMAL ->
> >             new_head|HEAD) -> MOVED
> >     RB_WARN_ON()
> > 
> > A nested writer that interrupts the outer one after the second cmpxchg
> > still sees the old head pointer UPDATE and repeats the second step. If
> > the reader swaps new_head out just before that cmpxchg, it returns
> > RB_PAGE_MOVED too.
> > 
> > RB_WARN_ON() permanently disables recording on the whole ring buffer,
> > and the outer writer returns without clearing its UPDATE flag.
> > 
> > In both cases another writer has already moved the head off the old
> > head page, as when the cmpxchg returns HEAD. Treat RB_PAGE_MOVED the
> > same way and fall through: the outer writer still clears its UPDATE
> > flag, and the caller updates the tail page as usual.
> > 
> > Fixes: 77ae365eca89 ("ring-buffer: make lockless")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changes in v2:
> > - Fall through on RB_PAGE_MOVED instead of returning 1, so a nested
> >   writer still moves the tail page (Vincent)
> > - Drop the duplicated UPDATE clear (Vincent)
> > - Document RB_PAGE_MOVED in the "Valid returns" comment (Vincent)
> > - Commit message improvements
> > - Link to v1: https://patch.msgid.link/20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org
> 
> From your v1 comment:
> 
> > A nested writer and a consuming reader can race so that the second
> > cmpxchg of a head page move in rb_handle_head_page() returns
> > RB_PAGE_MOVED. That trips RB_WARN_ON(), which disables the ring buffer
> > and leaves the old head pointer flagged UPDATE. The patch handles the
> > return like the RB_PAGE_MOVED case of the first cmpxchg: clear the
> > UPDATE flag if this writer set it, and retry.
> > 
> > Testing, on arm64 KVM guests under virtme-ng (32 vCPUs, KASAN config,
> > next-20261030; kernel/trace/ring_buffer.c is identical in v7.4-rc1):
> > - Setup: function_graph tracer filtered to "*sched*", buffer_size_kb=7
> >   (two pages per CPU), overwrite on, a trace_pipe_raw reader on every
> >   CPU plus a trace_pipe reader, and stress-ng --yield/--timer/--futex.
> 
> OK, I think I see the issue here. I believe the reader is finding the wrong
> head page. Making the buffer really small can make this scenario happen
> more often.
> 
> The problem is where the reader thinks the "head_page" is. When the reader
> swaps out the page, it first looks for the "head_page". The head page
> always has flags set in the pointer to it, so before the swap, the reader
> will search for the head page.
> 
> It starts with the cpu_buffer->head_page pointer which is where it found it
> last. It then searches for the head page and when it finds it, it tries the
> swap. The swap will only succeed if the pointer is HEAD.
> 
> The issue I think you hit was that we have two HEAD pages, when interrupts
> come in. That is, we can get a state of:
> 
>   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->

How we can end-up in this situation? The cmpxch will only swap HEAD for UPDATE. 

> 
> With the expectation that the reader will never be between those two
> pointers and it will always find the UPDATE before it sees the new HEAD. But
> since only the reader moves the cpu_buffer->head_page around and the writer
> does not, we can have a stale pointer of this:
> 
> 
>   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->
>                                       ^
>                                       |
>                             cpu_buffer->head_page
> 
> And when the reader looks for the new head, it will find this:
> 
> 
>   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->
>                                                        ^
>                                                        |
>                                              cpu_buffer->head_page
> 
> And possibly swap out the head page before it is allowed to.
> 
> To prevent this, I believe having the writer move this pointer will keep it
> from being stale and ending up between the two.
> 
> Can you try this?
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c64e001c3fc0..f0bb2d23d818 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3721,6 +3721,14 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
>  		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
>  		local_inc(&cpu_buffer->pages_lost);
>  
> +		/*
> +		 * To prevent a stale head_page from being between
> +		 * the UPDATE and new HEAD pages, set it here to have
> +		 * the reader check always find the update before
> +		 * finding the HEAD page.
> +		 */
> +		cpu_buffer->head_page = next_page;
> +
>  		if (cpu_buffer->ring_meta)
>  			rb_update_meta_head(cpu_buffer, next_page);
>  		/*
> 
> We may need to add memory barriers here, but for now, I think this could
> fix it. As it should prevent the search from ever starting in between the
> two heads.
> 
> -- Steve
> 

-- 
Vincent
