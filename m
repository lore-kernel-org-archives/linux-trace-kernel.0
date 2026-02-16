Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B92FB969;
	Mon, 16 Feb 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228807; cv=none; b=Zss6v8XTC56aP8lLziRGePy2Wp1eS7ATzONNB3G/koZL6hFbgnITksbd9CcLw3DkqHkYLGRKIZq00fYsMgPmbVtZ3NeQV2K0brgpcReUFGF0fB3ngRGAWTppaPogOJmfmfYaz83DJPg8lrycrm7hg2qU1c7JLIHCHWxC+UI8T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228807; c=relaxed/simple;
	bh=awGVTKCHiUkewonOwODdZbQc3D1dA6XfSifeCZovq9M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UEplLHFXRlVYbZPKLVrtUHKsu916jJuwiAIGUqf5XHm9kiDop41p9okmge3Q3G2R0mx9h/gSgQe6t3YRXs86yxn/vvbIHkHCYxb89U+9JaLS5MdgGCZyA0c5FBurdOaNUJ9lhF6npjIna9OCDDBpkYszahuZ9D82KdRDUDl1mIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjIxCfwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjIxCfwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967F7C116C6;
	Mon, 16 Feb 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771228806;
	bh=awGVTKCHiUkewonOwODdZbQc3D1dA6XfSifeCZovq9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fjIxCfwIH3eZM5lgA5oIv+ha0/cR/gZ8U234L4t79KsSOkw4F4juY+wOcoxt+bnNZ
	 w0VgNYerXKzvMmIHFzdMkSWKdnWfuMKFS/Q3cYIj/ovr+fkWgPwyFo6nUCmhg1v0s/
	 W9+zRuUwISWmFr3ED9CI9Ewf8F5ahUdwsHQxEvfxdFjLs4AyG+yg1aacB10sn2DVPO
	 vNztG1MjtylXogVBPyX/V39bE3pI42Ca08aZ/Q6pzgLrSl/HriflWde/gDoRFGUKta
	 HacLaHQ2vPB7OdOqq0CYHK8e1nA+5ro19sSFuTgYyTtNSd8pWjVHyiTG+25uLriHDt
	 Z3Cbko10RdMqA==
Date: Mon, 16 Feb 2026 17:00:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "open list:TRACING" <linux-kernel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 "kernel test robot" <lkp@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH] ring-buffer: Fix possible dereference of uninitialized
 pointer
Message-Id: <20260216170001.f6d362ab74f47d2e888b4947@kernel.org>
In-Reply-To: <20260213100130.2013839-1-d.dulov@aladdin.ru>
References: <20260213100130.2013839-1-d.dulov@aladdin.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 13:01:30 +0300
Daniil Dulov <d.dulov@aladdin.ru> wrote:

> There is a pointer head_page in rb_meta_validate_events() which is not
> initialized at the beginning of a function. This pointer can be dereferenced
> if there is a failure during reader page validation. In this case the control
> is passed to "invalid" label where the pointer is dereferenced in a loop.
> 
> To fix the issue initialize orig_head and head_page before calling
> rb_validate_buffer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202406130130.JtTGRf7W-lkp@intel.com/
> Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  kernel/trace/ring_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 630221b00838..ad08430347b0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1918,6 +1918,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	if (!meta || !meta->head_buffer)
>  		return;
>  
> +	orig_head = head_page = cpu_buffer->head_page;
> +
>  	/* Do the reader page first */
>  	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
>  	if (ret < 0) {
> @@ -1928,7 +1930,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
>  	local_set(&cpu_buffer->reader_page->entries, ret);
>  
> -	orig_head = head_page = cpu_buffer->head_page;
>  	ts = head_page->page->time_stamp;
>  
>  	/*
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
