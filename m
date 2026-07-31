Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F992EB874
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508035; cv=none; b=bzOiQIZLQIkFiyKdxJatkv6joZwYWtzNQFy5qr1pvUFe+oRfG1EYglHfNbzPFB+B1kO0HsmD+4iJ8R0nV6+uWA0cCoUwbmuKPbEzLV5uqKI2oa8Ayzksct5hUiW8kjcfz9W9xdu/BrRY2FC+2WB5OSdegTUDT1iB28R1Qxvj8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508035; c=relaxed/simple;
	bh=q8I8MZWFhjX7euXez6f4j7D6knYR/kG5TGITk/OF2u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3HA4psOUHtI9x8GzlqfuBMVB8CroKvfM33duJMUd2dS8t9f+NjteOgIPR9tKdWKs5c+NlB1wo50sKt8YflWX/bq0SD8cn8+sh0l91IYZsmENTH8s7b74TqsiGKlQ5gfXSGfdJ6sRrVVkvEvq/e4TaTD+F+4Qh6ItRwD6DTpsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=poh+xbh2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poh+xbh2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso346984f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785508032; x=1786112832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mP7+gGQhSt3U9gtl+FUITqAwQ5hrW23PUFD5XjA3RsI=;
        b=poh+xbh2Z4H1LaipAq0tArumok4lZ2JvMg9r+s2SHfikS/s9gY7YaMzy4WRjiSbgdq
         NZy/YlOzrSyQx7CAF8yDwxXEFk6NTG1N2jsA7glOk6JBNYVQtnASUALuZVtwrdFdBvKT
         fW4rkcRpOqWx4J4VL0DkbdzGPEuxhqmX4m8KIDinR2uSUgpyQ97VJN4cds2/kZ9TGLx5
         CLBOq4jObYFiHoLUriV+MTswTSZNsCll5fsO/QfNmiVErL77ALR2cQU5ropxKMjiiLZx
         ilTaKabYnKG3saCH4QPgs8SZnAnKeJx+n4WZlmvYYjO6SnTq6vXqsvDe3WJlcO/lugy3
         Voig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508032; x=1786112832;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mP7+gGQhSt3U9gtl+FUITqAwQ5hrW23PUFD5XjA3RsI=;
        b=oaeF3/IqyaJn5aqGyIzOt4LU8tQYd2f34rTjmzDTHLULAqV5w34lOIB/RIVSSM9rLF
         E7ZWJ9CzrFMhdbN3axaj/6y0qdhob/IcsMIoM8uD9FIA+6BwlyKuDSfCmnIcGDM1sEGB
         XdOxjja3pFQy63nHZg+GK6UkNXsfEdHQy5jd9WYQVVKR+SU1Bw1ODBo9BSIiNbAuW8vo
         eIpeDCnuo1vr/gYUKdE8lWBWAjuFFTuYe28gYBG3AwRCrV4BRuh8Jc7fWEynbZCz5Tpw
         U14rRrPJ50v2Hxvb0WfqP8JGwzpJz7W/1WMTB9zOCy+3XsaeyEM34Jce2Mf43ysncBe8
         G9UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp48ezS4usXsyt3OACsXDKUM1G7aoKcaHHIqk89qubwQPlKSNLcWJC+C6tC0ekr++LGgEA3rKSkm+EOJWiS4UWnLWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwNhHWbTnf07zzZWG9fQrKtYlL54SJ7W7BKake9/OkPQAvO3Z
	Zi9io/Lxrd+QbjBcxmbTv1XbuSepynV3+FbSdmTjlhtlIFkd/dKahfc7UCd8Whkq0NIyF6GTdl2
	D99125A==
X-Gm-Gg: AR+sD12VbMVmCkUUjsyg7/5TRBp2dxV5eSFQpA8UgaOhoO5hnVjfkdpitmi/3D6Qp8s
	ZaiiDlzLKlRR0dNhWEBkoX5iuR53xiFhZt8MfwWDWpjdKHgTEN+fBXLGVEmsfVmKd0OyAKbZ7Ob
	aHSXNW7DvAxr0U+j+22rl0ihXPAL80OdM/Knihy+24rRyHo05jKE1dobLajvSm+ZxMnA1PSMUIh
	NwbP28v0/YJ1Io687zsbfqRNHyW4WcT4afw0exlNjTU9HVt35RO/QPaI7j4MiKAWRaiOg5jR6c8
	dlpnZ9P5MDYc35QjicsUOtDa9R5S4QCThMlAwh9jCgg8+PBCbM9agESoIJPB3pLt1+ToKpSdF+n
	cea0oaJVk3e54zqmbYN1/kzNpghuGQL0zCDlEjX8l5Peutt50DhsgFyE1liSiAqy3Ee2UX4fvXa
	Bky0rKC/MW4F3zf3L7VMgYUBBpfTpEOVnYISP5A97JTVnr4HZo+S3MvWlPlONI7Z8dKEDbdBErS
	jMQrq5Q++xL4mwx1c0qACkc0FyvRJRZ44JbQtKHWYQ=
X-Received: by 2002:a05:6000:2308:b0:46e:7f72:b6fe with SMTP id ffacd0b85a97d-47fd2adc960mr5202766f8f.19.1785508031404;
        Fri, 31 Jul 2026 07:27:11 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm5798669f8f.27.2026.07.31.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:27:10 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:27:07 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Fix subbuf_ids memory leak in
 rb_allocate_cpu_buffer() error path
Message-ID: <amywuxSt9P2HUE0f@google.com>
References: <178550740672.380917.6067449683620196150.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178550740672.380917.6067449683620196150.stgit@devnote2>

On Fri, Jul 31, 2026 at 11:16:46PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In rb_allocate_cpu_buffer(), cpu_buffer->subbuf_ids is allocated using
> kcalloc() when buffer->remote is non-NULL. If a subsequent page allocation
> fails (e.g., ring_buffer_desc_page() returns NULL or rb_allocate_pages()
> fails), execution jumps to fail_free_reader.
> 
> While __free(kfree) automatically frees the outer cpu_buffer structure
> at scope exit, kfree(cpu_buffer) does not recursively free nested heap
> pointers such as cpu_buffer->subbuf_ids, resulting in a memory leak.
> 
> Fix this by explicitly freeing cpu_buffer->subbuf_ids in the
> fail_free_reader error unwinding path when cpu_buffer->remote is set.
> 
> Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Call kfree(subbuf_ids) unconditionally because it should be NULL
>     if !remote.
> ---
>  kernel/trace/ring_buffer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 78d3875a47a5..8e2485bb3aa8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2599,6 +2599,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	return_ptr(cpu_buffer);
>  
>   fail_free_reader:
> +	kfree(cpu_buffer->subbuf_ids);
>  	free_buffer_page(cpu_buffer->reader_page);
>  
>  	return NULL;
> 

Thanks!

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
