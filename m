Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37C1B532F;
	Sat, 15 Feb 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632679; cv=none; b=JuoWOFxAdJa/lYHE+2EdFqfuiXYb0SsUnDmXSBJGNFP+wba3BxN5wgAZih5F+oj1VfbJqsXstFJKdwOZtmr04aQylrYsqdSS+7bfqEWtH4SXrGM/FG6mi0PdGTLh4zh0L6j8Xm8m97YHx3MT106Y9zxvYh0n+847vKIVXYLfR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632679; c=relaxed/simple;
	bh=0usuO2VVnSrxD/i1f7GJ9yWz1k/gjIV1mloWca/XxQA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VdSrbiNli/KCkQtAMoQmSXm/BDIg6Bvajf0VjY9BFLHvq8jKo0pa4ai9dBmB+EI+a+bqf28J/i3DWWAXHzeHAlTPvlezCOwWmitWS4E0iXWtJAd+VO84+QQ0U5kJ0H5QgkJdfCWq3g0uJnTyzD8sNQoL/XIx9SJ4dPYGh4sexDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIKjwTmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIKjwTmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7193BC4CEDF;
	Sat, 15 Feb 2025 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739632679;
	bh=0usuO2VVnSrxD/i1f7GJ9yWz1k/gjIV1mloWca/XxQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IIKjwTmj+gYTbB/3JjaGEF30QKTAZ7y9cYhD+22Z2kYDTBKdKrMxrDi56sgED9iFr
	 XSOvRK/FHOHQt/wZaULUoFE1VSjZ8UhF8X8RNMqmhq0hUSma4DyxaSUDjWfRpqudOJ
	 zrXCodpcFeuIX72fgTSk6F56a6Q3lYKnu5rUMzauWul0ebA+5FDlT2ZsYHUvdCnp4r
	 31Bp6USLLCNJv8uLqRh80m6KCmIicN7pf8yU+ahzgP/kJOGPha2fedS91/QV0uSMQK
	 wpDx/Vxr4XdfCHwaOpgClZNMiqnmxYGJKtAi6kDCXrXzIHkYyxoGsNR7YHwe8BKXSO
	 A54eH+SQ1lWzQ==
Date: Sun, 16 Feb 2025 00:17:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Update pages_touched to reflect persistent
 buffer content
Message-Id: <20250216001755.b5e1f1ac00bef0b46dec74f4@kernel.org>
In-Reply-To: <20250214123512.0631436e@gandalf.local.home>
References: <20250214123512.0631436e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 12:35:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The pages_touched field represents the number of subbuffers in the ring
> buffer that have content that can be read. This is used in accounting of
> "dirty_pages" and "buffer_percent" to allow the user to wait for the
> buffer to be filled to a certain amount before it reads the buffer in
> blocking mode.
> 
> The persistent buffer never updated this value so it was set to zero, and
> this accounting would take it as it had no content. This would cause user
> space to wait for content even though there's enough content in the ring
> buffer that satisfies the buffer_percent.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Cc: stable@vger.kernel.org
> Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 0419d41a2060..bb6089c2951e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1850,6 +1850,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  				cpu_buffer->cpu);
>  			goto invalid;
>  		}
> +
> +		/* If the buffer has content, update pages_touched */
> +		if (ret)
> +			local_inc(&cpu_buffer->pages_touched);
> +
>  		entries += ret;
>  		entry_bytes += local_read(&head_page->page->commit);
>  		local_set(&cpu_buffer->head_page->entries, ret);
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
