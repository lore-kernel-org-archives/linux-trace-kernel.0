Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBD318146
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978337; cv=none; b=HT62h5Bt3amr16Kt8zIl3RpldrrbWaprfsitAoeTNiO2fwqj8lIgrjjVcKmEkc0DxGtp765qS8MMDXANryyFHJ+3YrHLEXFGA6MZ2+WqwIQi6cIKAlbfJXur/1j1D0lSsBSI2jiPNjjEc0QmwPXjbhned2plknGKK3h6lM71P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978337; c=relaxed/simple;
	bh=81sN4Ta0dN01LUppLMSjudvBu+gzjzhGtkGCssIxgO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI4rExSne68TIA/SPcCwLx/sjbrZJ3tNM+YQtCx5vo1EROde99xcx4V6bRz4ixpdrdtZ/05kauCC6F3we5uwWc8981dd1LxhIvJqcAyjtgriAvLlrZ2pnIyv1pX6uV85xDXp1caV3FLd3HaU5d3baJZKoMIq54DqKZkAVIXIVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKdy3u9G; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKdy3u9G"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so13293245e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789978334; x=1790583134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMXYjGcZu2otoIEYefWcT0cnIVDjtKD7spkJocISLVM=;
        b=eKdy3u9G3hKrgX3qtDSEvx2x0pzbY7psv2KyDny0IU9czqCQeV4+JduZ8KlZwk0JU9
         qwumDh8KVmdzLZtEOvwtfIGDBKcHzKJYjIf/f6DoVoHgzdgnLfqf3ZjWFQpJoh+Ti6/N
         aeAI1Y+XES5amwGigFLMhKJFmoY12txcf01UsZKjOq1CaJazL6cXzN7KGwKowXFsmu17
         bH59N9mFwkpCzZoYWapusKMFMHRW8Slru49ehV7GWh8levkg7CTUd35+PizLCmGVGeqs
         H1ooaA+1ksuwf8fvrE8u8Oqsobx+Yl/REccpN5BXWlqij3VUU8WIkdJ2Nv9ZbTIquE+u
         ovTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978334; x=1790583134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMXYjGcZu2otoIEYefWcT0cnIVDjtKD7spkJocISLVM=;
        b=gz0EomzNM8jb9YsyMUAININFIrXIH1/bY5YIara59LIe3HB0h1h1E4Qm8SxvodYBTz
         4GhNB7yqlrUU0PbHCeZ5FSsL1UabXYh7ILUHna9vo00pNQQFzZAVbGj55k6f+zpYV/l4
         0mNwVGzBTmOCgXJDWzbc3ATDIA/HAck9DLYF4z79vEa01Mu6S47KR+taOrWze9miRTaA
         kYEAKnr75F5IgMlIo/ialrH5PETFRFYAFXPfAcdkc8nudx+nQGbrxEhaqbAemf3ib1DW
         L+sFwkMLPK2V2YTx8ABPYDdPS1H3YlPKvA2dDfkYaITu9wCCUNCIXAOk5cPMZroTTU8h
         RJhA==
X-Forwarded-Encrypted: i=1; AKwUvByhcv2N82Q1EnDvoRR77RFgv3CZopZINzwyOws+0QauPKWt8bSaMqj3wg8DQPXq6OZHUVluO//L/5GD1638tmW0ljM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFA7UU3yPBysyy123w94+1lSmZa0JsKrFLa3At9KN9ccOz7EWO
	M/mOp6SmDPN7xVhSujD4dWOQvk85NIglUVMZNXMOukl43Q3Ehfh6CHS+JJgzwr+TNw==
X-Gm-Gg: AYBFou1h1NDkY92xCO8Vh3049OfdxxI7AsMRMxM6STMJj016u5ygfLOzbgacFLXn7Rq
	sBM+yVTEExBVGHdwrjiL2OPb7FKYrfg1TJSPMZURnGphWljKkJB/tmFttAdlJr+Dpx3+8pz9M8z
	b6LrTdmViAGm2HdIrD3XekhMJg3Y9dwdlkbI5GDv94bnYeQpl3CIZzQ2Ukw3TaKaL04dGhqOJ2E
	86YvKyfgUaZP9SOXfJ0SehqfMpZHma2UlyJRJFkI9OEbxPYmF3RIv8TuOYVOLlKlSklYPGGgbsu
	6RvUiWj92PRXJqAM3J5KARMJ3k6TIwgFPQewqsjDeBe0GQOMTGVDO2k/CRidh7o9UnQJDaXUrzK
	I8pfgo9UDb9Gwd5ziUw31NvX596pUKR4FZbG/hszEGRzvBARwaaBdWnolv5U7rGp3pKoVjpM7hj
	Kqo01H+XPtrr6n8+t+a8sQzSzW+JhDlUKu26QoYX+utl4mfL7ZY+oQbgnUTlkJYhhv/MmY18cMJ
	7uFOT7uedBLI9am1og4LzFDXyow4814k4jso32/8lA=
X-Received: by 2002:a05:600c:a49:b0:49e:6865:904e with SMTP id 5b1f17b1804b1-49fc500055cmr155390395e9.12.1789978332658;
        Mon, 21 Sep 2026 01:12:12 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcda2140bsm232663265e9.1.2026.09.21.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:12:12 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:12:08 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, syzbot@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Fix false warning in
 ring_buffer_map_get_reader()
Message-ID: <arDm2LvdlWVe9JC1@google.com>
References: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>

On Fri, Sep 18, 2026 at 02:34:25PM +0000, syzbot wrote:
> From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> 
> In ring_buffer_map_get_reader(), an unconditional WARN_ON(!reader) is
> triggered when rb_get_reader_page() returns NULL:
> 
> WARNING: CPU: 1 PID: 5906 at kernel/trace/ring_buffer.c:7998
> ring_buffer_map_get_reader+0x940/0x9d0
> CPU: 1 UID: 0 PID: 5906 Comm: task Not tainted
> RIP: 0010:ring_buffer_map_get_reader+0x940/0x9d0
> kernel/trace/ring_buffer.c:7998
> Call Trace:
>  <TASK>
>  tracing_buffers_ioctl+0x258/0x300 kernel/trace/trace.c:7381
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> This warning is triggered due to a race between a writer committing events
> and a reader mapping the ring buffer via TRACE_MMAP_IOCTL_GET_READER. When
> a writer commits an event in rb_set_commit_to_write(), it advances
> cpu_buffer->commit_page to cpu_buffer->tail_page in its first loop before
> updating the commit counter (commit_page->page->commit) in the second loop.
> If a reader invokes ring_buffer_map_get_reader() at this moment, the
> initial check cpu_buffer->reader_page == cpu_buffer->commit_page is false,
> and it calls rb_get_reader_page(). Inside __rb_get_reader_page(), the
> reader swaps reader_page with the head page (which is the new commit_page).
> Because the writer has not yet updated the commit count on the new page,
> rb_page_size() is zero and reader_page->read < rb_page_size() evaluates to
> false. __rb_get_reader_page() then checks if cpu_buffer->commit_page ==
> cpu_buffer->reader_page. Since both now point to the swapped page, the
> condition evaluates to true and rb_get_reader_page() legitimately returns
> NULL to indicate the reader caught up to the writer.

This seems to make the check above reader_page == commit_page redundant. Doesn't
it?

> 
> Furthermore, rb_get_reader_page() can legitimately return NULL when there
> is no data to read. Re-checking mutable writer state such as

We are checking rb_per_cpu_empty() with the reader_lock held few lines above. I
don't believe we expect NULL here for that reason.

> cpu_buffer->reader_page != cpu_buffer->commit_page is insufficient because
> a writer on another CPU can advance commit_page before the check is
> evaluated without being stopped by reader_lock.
> 
> Because WARN_ON must not be used for conditions that can legitimately
> happen, and pr_err should be used instead if necessary, remove the
> WARN_ON() entirely since returning NULL here is an expected condition.
> 
> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> Assisted-by: Gemini:gemini-3.8-flash syzbot
> Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
> Link: https://syzkaller.appspot.com/ai_job?id=488adc18-a10e-42d2-a205-25327c38837f
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> 
> ---
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a..1a4da3d47 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7995,7 +7995,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
>  		goto out;
>  
>  	reader = rb_get_reader_page(cpu_buffer);
> -	if (WARN_ON(!reader))
> +	if (!reader)
>  		goto out;
>  
>  	/* Check if any events were dropped */
> 
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157
> -- 
> See https://goo.gle/syzbot-ai-patches for information about AI-generated patches.
> The person who has signed off on the patch is responsible for
> addressing comments.
> syzbot engineers can be reached at syzkaller@googlegroups.com.

-- 
Vincent
