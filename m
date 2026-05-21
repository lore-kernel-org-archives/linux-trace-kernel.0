Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B439282B;
	Thu, 21 May 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345004; cv=none; b=tgySgjzGce0DCHWNl/ZA0MPN+PhFjSmv6x16HQN/+Bf+erEY6eSjzBPii4qZWyv18BxwyRGmMQnD+pxaW5lYhH5ar4lsQDvyhmyZtMFFHXZR/d00G7sxs3YlwvqnEvO9e7WBD/2XDL5QGrICU7pA9RlO4AQ5hkkZqunuEk+iTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345004; c=relaxed/simple;
	bh=RwYba/5ezoaUQK61L2y8oY8wiiWUttxQw5r6B4Ubtpg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j2iGAH4yLpBGCaKS2+jDf7PpCHb1FigWLYSQ5EUoQ21xjeceK2cOBA5pFSlNuuPUGr3Lzn9CDxLm0aC6RJAJp79TiZCLEZ/rCg8B/tzb8OaoFMdaAr+T+26959z88gxKL+YPQE74xtoz3ctOz4m6+YYSUF9VXaimEQ5Q2SzmfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5EVv4T1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5EVv4T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6D31F000E9;
	Thu, 21 May 2026 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779345003;
	bh=3w7SRg7I6MI1f+FAyfs5Zh+zsKP0ydgH+i1hdszpP8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d5EVv4T1ESWX8BAQZ9e9N2wN6jXOhqyASkiexGDITybdM3WgJm71qOki6b7oNVg9K
	 DyRWct1Ls8/BJFsDwvN5lNFAenPHXcZ3wUiN4BrmTe5RYa70yFo2bSRwF618eo7Iy8
	 5Clc/i0ADsLI1Zo0ZtQK1eKHRbuceurqJzGFTjkMQeHSIbCEolgwC8bc+Gz0asuFOf
	 MEUxzzAOgDd43Jac0rTzVsZOhImM5rOEaBBwupk55xTAT+OErnIw4j6DaSPBMfFOgu
	 W5NvrZaBLqL0hBstbX68W5i01It/gDePMFzOWJnQPDx3tgKl8KfilI1RLpKqUZ2XDL
	 3frY/OJ6OoXcg==
Date: Thu, 21 May 2026 15:29:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 08/10] ring-buffer: Have dropped subbuffers be
 persistent across reboots
Message-Id: <20260521152959.d4ceae680571ed4adea03adf@kernel.org>
In-Reply-To: <20260520185018.193087991@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.193087991@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:49:46 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the persistent ring buffer detects a corrupted subbuffer, it will
> zero its size and report dropped pages in the dmesg, then it continues
> normally.
> 
> But if a reboot happens without clearing or restarting tracing on the
> persistent ring buffer, the next boot will show no pages are dropped.
> 
> If the persistent ring buffer is still the same, then it should still
> report dropped pages so the user knows that the buffer has missing events.
> 
> Add the RB_MISSED_EVENTS flag to the commit value of the subbuffer so that
> the next boot will still show that pages were dropped.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index bda53a2d2159..ae5c645b59c9 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1915,7 +1915,7 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
>  	 * Even after clearing these bits, a commit value greater than the
>  	 * subbuf_size is considered invalid.
>  	 */
> -	tail = rb_data_page_size(dpage);
> +	tail = rb_data_page_commit(dpage);
>  	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
>  		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
>  	else
> @@ -1929,7 +1929,7 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
>  	 */
>  	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
>  		local_set(&bpage->entries, 0);
> -		local_set(&dpage->commit, 0);
> +		local_set(&dpage->commit, RB_MISSED_EVENTS);
>  		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
>  		ret = -1;
>  	} else {
> @@ -3444,7 +3444,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
>  	 * is a mb(), which will synchronize with the rmb here.
>  	 * (see rb_tail_page_update() and __rb_reserve_next())
>  	 */
> -	commit = rb_page_commit(iter_head_page);
> +	commit = rb_page_size(iter_head_page);
>  	smp_rmb();
>  
>  	/* An event needs to be at least 8 bytes in size */
> @@ -3473,7 +3473,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
>  
>  	/* Make sure the page didn't change since we read this */
>  	if (iter->page_stamp != iter_head_page->page->time_stamp ||
> -	    commit > rb_page_commit(iter_head_page))
> +	    commit > rb_page_size(iter_head_page))
>  		goto reset;
>  
>  	iter->next_event = iter->head + length;
> @@ -5643,7 +5643,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
>  	 * (see rb_tail_page_update())
>  	 */
>  	smp_rmb();
> -	commit = rb_page_commit(commit_page);
> +	commit = rb_page_size(commit_page);
>  	/* We want to make sure that the commit page doesn't change */
>  	smp_rmb();
>  
> @@ -5836,6 +5836,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	 */
>  	local_set(&cpu_buffer->reader_page->write, 0);
>  	local_set(&cpu_buffer->reader_page->entries, 0);
> +	rb_init_data_page(cpu_buffer->reader_page->page);
>  	cpu_buffer->reader_page->real_end = 0;
>  
>   spin:
> -- 
> 2.53.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
