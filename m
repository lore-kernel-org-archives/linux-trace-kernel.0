Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116B2DA756;
	Thu, 26 Feb 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110716; cv=none; b=ZHkRiMOn/JppAHxEkxNcRopeJOIv3Smdf6j52ljiPbVtjKt+N0ZwSqsXokzC/xhWDcR9VFETBnxy57B+rXu2PKFu5V34ifRenNGaWZMM0otfnB3XcCt8lq2ErqUFWMWTkkhJ6eV/+TD9BNegNs4LN3gEaToy1ANb44Y2FV4LOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110716; c=relaxed/simple;
	bh=HvzxYOzGKIZ3lyECHLnPZgMC+8aPZEt3LvpABU8A46k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bsHnERYvzW6lVLj2E3VM55iIXTV9KzLRDvo6ZrAKf3ljLI3LB0rlpdT1dd6Lqb4dgvJ2Gvbu0mTmACm42cbASDGanLiAbCrOtzv5xYncjKMR6WYW7ot8froOIbWy0cLrjybrBQ2aQuSRM2VXRPMk+TsREkH+DEN/Ovz8rcB0inU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFoWBVDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFoWBVDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A85C116C6;
	Thu, 26 Feb 2026 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772110715;
	bh=HvzxYOzGKIZ3lyECHLnPZgMC+8aPZEt3LvpABU8A46k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hFoWBVDisPNFjFk0weJ0PejOf/YgJ+zYSramRREmWaxS7lrWz1xAasHjtARRK/Xml
	 DPnViascBPSRNVA7+I6pL944OnlIo8tFKyc+IxbQal21WPnQWjOcqhhHBixFvxRw10
	 a1Nts6oMo4/K6EdVln/pQXE5XS+O6G3XqUXqI/oUJANueUYS3bOtP/oaW6RLFV+zUg
	 2Xyfdd3wsqJYVy32SWof92suWAa629mxBGSaOczzmNLUUB6fUSRzgrfGJVnVUuLYhk
	 8JOUKlAjREO13AQPYOPDSgmttErNwityHtRAjz2Pb566OVnqzUSVvSkPBHJTU0YY0C
	 bsxry4vDIWGbw==
Date: Thu, 26 Feb 2026 21:58:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260226215833.4ad4f07f2cd06c9ccf5c1afa@kernel.org>
In-Reply-To: <177191597760.435720.2484229987964512451.stgit@mhiramat.tok.corp.google.com>
References: <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
	<177191597760.435720.2484229987964512451.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 15:52:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Skip invalid sub-buffers when validating the persistent ring buffer
> instead of discarding the entire ring buffer. Also, mark there are
> missed events on the discarded buffer.
> 
> If the cache data in memory fails to be synchronized during a reboot,
> the persistent ring buffer may become partially corrupted, but other
> sub-buffers may still contain readable event data. Only discard the
> subbuffersa that ar found to be corrupted.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v3:
>   - Record missed data event on commit.
> ---
>  kernel/trace/ring_buffer.c |   21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 67bc652ba02a..72f82e2e6740 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2058,17 +2058,18 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  		if (ret < 0) {
>  			pr_info("Ring buffer meta [%d] invalid buffer page\n",
>  				cpu_buffer->cpu);

This pr_info() should be removed too, because multiple pages
can be discarded.

Thanks,

> -			goto invalid;
> -		}
> -
> -		/* If the buffer has content, update pages_touched */
> -		if (ret)
> -			local_inc(&cpu_buffer->pages_touched);
> -
> -		entries += ret;
> -		entry_bytes += rb_page_size(head_page);
> -		local_set(&cpu_buffer->head_page->entries, ret);
> +			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
> +			local_set(&head_page->entries, 0);
> +			local_set(&head_page->page->commit, RB_MISSED_EVENTS);
> +		} else {
> +			/* If the buffer has content, update pages_touched */
> +			if (ret)
> +				local_inc(&cpu_buffer->pages_touched);
>  
> +			entries += ret;
> +			entry_bytes += rb_page_size(head_page);
> +			local_set(&cpu_buffer->head_page->entries, ret);
> +		}
>  		if (head_page == cpu_buffer->commit_page)
>  			break;
>  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
