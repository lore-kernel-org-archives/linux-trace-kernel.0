Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8E17745;
	Tue, 26 May 2026 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771973; cv=none; b=rLjmnHH9p/h1axf8i/N4dD1KDUK/dNdPoFAaZFnF06vXup8KfA4lo0zZ0YSzJjRVSoehxNAC5GcC1H3J8LzLOva5KQcXeb+o0YnhLs7MyX0ADVtWRpgncKiAA2DxnWEGD005Zh4q6/yXnL4OS3gy8UUIJISrFsn2bfIayh7Uj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771973; c=relaxed/simple;
	bh=9+dvesZqHCez6C4ImG/1xrjdB0ok+iwKeIEfOLvMUVc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J+KVCY/YiEQ7T/eKi9xLwjgGEL4tdSSRQux3PENHbRcZoziFvi5h+FqAdQLBYzHfxwoWBGnWOzFgfBrUy4AfItgIoF45xC5RjqjUbgm+2zSYVUUidw35AtxOQdemRB7v780akKsf2clHmgsB+wWS0FX3Dm7FWdKCGxgkUK3qIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad4avntu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad4avntu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5AF1F00A3A;
	Tue, 26 May 2026 05:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779771972;
	bh=vEPpbuA9hCnZ8dvT8zTkda0SXclRyd3TxRFVCR7xy8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ad4avntuP2ZomCQdCoxLLnnUdiNASJfRvJWe9lTkb/tqCYeDA+mlnJC3uZUXOGG5F
	 CVpidv2qdQSXApd3bxWKHCWp2Z57bLFV4vKMYlXh5tleGSG+m+SPHqZ3dFIOA5YfCD
	 ZDEvGlVRkWVpsJDErZvPiHMMPyp6HzVDTTy17g7mJ0UmXaNJbrBls4KMku7ggsr83+
	 SXKauVdmu1wAfijwBpMSH2zHV7+aEb90Vy8GLLt/E4ALHpaC3bdnYRS3pXLTdmKFO/
	 q7IkyC1Ob6Q2HvokJcu5gLRxsUldjEls5ciza9Gh++l+q/9p7TIzNuTR133u3i5BP6
	 qwU7Fxr8NDi/Q==
Date: Tue, 26 May 2026 14:06:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-Id: <20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
In-Reply-To: <20260522171052.006276604@kernel.org>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 13:09:05 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> @@ -7187,6 +7190,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		local_set(&reader->entries, 0);
>  		reader->read = 0;
>  		data_page->data = dpage;
> +		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
> +			missed_events = -1;
>  
>  		/*
>  		 * Use the real_end for the data size,
> @@ -7204,10 +7209,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Set a flag in the commit field if we lost events
>  	 */
>  	if (missed_events) {
> -		/* If there is room at the end of the page to save the
> +		/*
> +		 * If there is room at the end of the page to save the
>  		 * missed events, then record it there.
>  		 */
> -		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> +		if (missed_events > 0 &&
> +		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
>  			memcpy(&dpage->data[commit], &missed_events,
>  			       sizeof(missed_events));
>  			local_add(RB_MISSED_STORED, &dpage->commit);

After this line, we "add" RB_MISSED_EVENTS instead of set.
In this case, does it clear the RB_MISSED_EVENTS bit because
it already sets RB_MISSED_EVENTS.

			commit += sizeof(missed_events);
		}
		local_add(RB_MISSED_EVENTS, &bpage->commit);
                      ^^^ here.


Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
