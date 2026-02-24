Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1642C21EC;
	Tue, 24 Feb 2026 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914328; cv=none; b=FPxbc75zLVEJ7lI/h3qgExycrO53s7Ys9RZFpf6GXIAwmhJYt3WLh8dOFr2siBhTnG4qeQTJDf89+0gjkLj45fRu+DcBlg/tdUvaGBHrT2JVePDJufRW+ALFffrljv5yb2uRcT6P8s4DuKNqh+Hta8q7EmSyLyARktzz2jaIesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914328; c=relaxed/simple;
	bh=5/Vg+Zu+pZFmxhcW2JP4U1bEhani7oXCNmCw0nx9N2U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TWjt9wCZXCq+NsLEX3J5RQLgfJNfC1Pj+Sf1rZojZPV8SiLSeITUTnnPTpPcViydbsxLUJ1c5A78V7dDNhiuSlkqIlvGxkXFkhiaU1MdEVR7quFzkusPr+l8g8TLsLyeTR8085PlszUjb4jsHoKFNjnjamcDLCGYhEn2JEn9qQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K02LPDPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K02LPDPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACBC116D0;
	Tue, 24 Feb 2026 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771914327;
	bh=5/Vg+Zu+pZFmxhcW2JP4U1bEhani7oXCNmCw0nx9N2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K02LPDPAYHjrcUBABeM+w3eoFwaPrzHO34jL6Itp2EoDPWY8k05UUHjzoNSmRa+ue
	 I9wiS4FlbxBHukYfUO/NknM0dCfGIleGg4qkF37OjK61L9GjxAL41Yw1E6lKTQ3rp2
	 iB4PZRwF2Nc8l000QK0KUwPPt9q17hQuss0Im+oEWWlMRFOpAERxe20SR7StQNJruQ
	 l1Pl5A2SLanmZbVlyYjTlbddWCnxc8LqhO3WPMQc6vRTRHKVridM11ID3iFEXUFuc/
	 WUxElyV3Q0PMNldO6+SUacl2EPbz5RDfOYuvGeiRkeJIEwfameKA0BA8dq2wQO067U
	 Oz1yo94U/xFqw==
Date: Tue, 24 Feb 2026 15:25:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ring-buffer: Handle RB_MISSED_* flags on commit
 field correctly
Message-Id: <20260224152525.0dc71c774e72985e3b67339d@kernel.org>
In-Reply-To: <177186337098.133407.17816322157924593847.stgit@devnote2>
References: <177186335195.133407.907308822749006594.stgit@devnote2>
	<177186337098.133407.17816322157924593847.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 01:16:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the MSBs of rb_data_page::commit are used for storing
> RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
> when it is used for finding the size of data pages.
> 
> Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Newly added.
> ---
>  kernel/trace/ring_buffer.c |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 84a6459ed494..1ef718d21796 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -395,6 +395,18 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
>  	return local_read(&bpage->page->commit);
>  }
>  
> +/* Size is determined by what has been committed */
> +static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
> +{
> +	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
> +}
> +
> +static __always_inline unsigned
> +rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	return rb_page_commit(cpu_buffer->commit_page);
> +}
> +
>  static void free_buffer_page(struct buffer_page *bpage)
>  {
>  	/* Range pages are not to be freed */
> @@ -1907,7 +1919,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
>  	u64 delta;
>  	int tail;
>  
> -	tail = local_read(&dpage->commit);
> +	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
>  	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
>  }
>  
> @@ -1934,7 +1946,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  		goto invalid;
>  	}
>  	entries += ret;
> -	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
> +	entry_bytes += rb_page_size(cpu_buffer->reader_page);
>  	local_set(&cpu_buffer->reader_page->entries, ret);
>  
>  	ts = head_page->page->time_stamp;
> @@ -2054,7 +2066,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  			local_inc(&cpu_buffer->pages_touched);
>  
>  		entries += ret;
> -		entry_bytes += local_read(&head_page->page->commit);
> +		entry_bytes += rb_page_size(head_page);
>  		local_set(&cpu_buffer->head_page->entries, ret);
>  
>  		if (head_page == cpu_buffer->commit_page)
> @@ -3257,18 +3269,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
>  	return NULL;
>  }
>  
> -/* Size is determined by what has been committed */
> -static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
> -{
> -	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
> -}
> -
> -static __always_inline unsigned
> -rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)

Oops, this data structure is defined after this line.
Let me fix it.

> -{
> -	return rb_page_commit(cpu_buffer->commit_page);
> -}
> -
>  static __always_inline unsigned
>  rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event *event)
>  {
> @@ -4433,7 +4433,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
>  
>  	if (tail == CHECK_FULL_PAGE) {
>  		full = true;
> -		tail = local_read(&bpage->commit);
> +		tail = local_read(&bpage->commit) & ~RB_MISSED_MASK;
>  	} else if (info->add_timestamp &
>  		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
>  		/* Ignore events with absolute time stamps */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
