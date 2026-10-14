Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC9363C46;
	Wed, 14 Oct 2026 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014693; cv=none; b=g3u0cM0oc2zT+5uX9YS4vu/gydt3mxHaAlOCBaDRzKFGOv0meLA9WHBL4TtbW25PLnJpOXeyUJL7fR9FS0C/FeZ+HS6YHEEICuV7HE7P0LnmPRwX6H9Crvw6lPOvGZfodOfUCtmsU/6SzCMBisuWBHcj1XFXwk+ljwVYUUY3e+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014693; c=relaxed/simple;
	bh=o8NO7mxoatvBR5rtMtGSMZjkCVLWvk/YEvlmRnRtLwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQuSrDerTOYRjue5zLFCjv5ukmMuAKb3mztDXqRL+PNfvA95tMELpSZX7QdhVnmBHeL5mgO59Ks58yV1P/puFLaRC3hlbV3cDMtMhi5VaX9iTciaU3MQFhPmCDRqsKshC6Oe+mr3qmIbPrWweFbyG1GfO5ON0kFBPBavK0XBth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=lVKCfQiV; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="lVKCfQiV"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 51C151207BA;
	Wed, 14 Oct 2026 21:51:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8A3492F;
	Wed, 14 Oct 2026 21:51:27 +0000 (UTC)
Date: Wed, 14 Oct 2026 17:51:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ring-buffer: Skip si_mem_available() for
 persistent and remote buffers
Message-ID: <20261014175126.49c26f93@gandalf.local.home>
In-Reply-To: <20261013102047.1488347-2-vdonnefort@google.com>
References: <20261013102047.1488347-1-vdonnefort@google.com>
	<20261013102047.1488347-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8A3492F
X-Stat-Signature: bho5aeq755j6rkweomygdjhehjwhjjpk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX190lrxSvdP+7rh265i5vNR+5kWga58Ytq8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=b0vYk7+QCd61Adybm2++cusSeNcBe/uzKUbX4BnPDmk=; b=lVKCfQiVm4Ymk4jax4aKxoUlEwPNb9dKddsd6j6uuCtbj4Q/MNTLNscxvejhmIB0Monz9McBW29i8P7vAW1KkuxdNSSO6yu0VVzVMYs2ddepOFLUw57mVwhxbNZwqrDT4oVidSFVMkRZdGw6L3s3UG4Y0WHe6NXsA0Wn2+4ZVIg=
X-HE-Tag: 1792014687-200780
X-HE-Meta: U2FsdGVkX18EJnHcKWKxl/20Tz0ToP6kXcq4I8DQ6+dmFHEoAXWe8eDCvRDnQZqLntK5iRWq6YdKgV0XJQUP0CVjhxDYOrG17+V4qC2MBFbTB6w0UznFEdmcWeEaduF49BduWVphECHYIZeDp+m4WgL2Ys/5cLjC5xYSfi8bN1ubkTlA54BfbVZ4UCJ6Mm+iL5VZpn7TB9+IiwuTIlceaKTG5BLsOBLSUM/3uaApwi2RtXUeIcCzcD73Yvr2LiNZexTCVKdv7UH3EfpXivCRhHmbCyPAaXD3BhvG7azrNrLO0ICV8f+ZHQ2HToVU6RARER6Tn3UcZXuRy0SotHFqC39/1xfqNKEbJYtprmgWS38RBXxycW/XhG1p3PFeiEZs

On Tue, 13 Oct 2026 11:20:46 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Persistent and remote buffer memory is pre-allocated by the time
> __rb_allocate_pages() is called. Skip si_mem_available() to avoid
> wrongly failing the allocation under memory pressure.
> 
> For the same reason, unset user_thread.
> 
> Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  kernel/trace/ring_buffer.c | 41 +++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..b3a30a0413a5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2442,20 +2442,30 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	struct trace_buffer *buffer = cpu_buffer->buffer;
>  	struct ring_buffer_cpu_meta *meta = NULL;
>  	struct buffer_page *bpage, *tmp;
> -	bool user_thread = current->mm != NULL;
>  	struct ring_buffer_desc *desc = NULL;
> +	bool user_thread = false;
>  	long i;
>  
> -	/*
> -	 * Check if the available memory is there first.
> -	 * Note, si_mem_available() only gives us a rough estimate of available
> -	 * memory. It may not be accurate. But we don't care, we just want
> -	 * to prevent doing any allocation when it is obvious that it is
> -	 * not going to succeed.
> -	 */
> -	i = si_mem_available();
> -	if (i < nr_pages)
> -		return -ENOMEM;
> +	if (buffer->range_addr_start) {
> +		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
> +	} else if (buffer->remote) {
> +		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
> +		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
> +			return -EINVAL;
> +	} else {
> +		/*
> +		 * Check if the available memory is there first.
> +		 * Note, si_mem_available() only gives us a rough estimate of available
> +		 * memory. It may not be accurate. But we don't care, we just want
> +		 * to prevent doing any allocation when it is obvious that it is
> +		 * not going to succeed.
> +		 */
> +		i = si_mem_available();
> +		if (i < nr_pages)
> +			return -ENOMEM;
> +
> +		user_thread = current->mm != NULL;

Not caused by this patch but we need to update this to:

		user_thread = is_user_task(current);

I may add that.

-- Steve

> +	}
>  
>  	/*
>  	 * If a user thread allocates too much, and si_mem_available()
> @@ -2469,15 +2479,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	if (user_thread)
>  		set_current_oom_origin();
>  
> -	if (buffer->range_addr_start)
> -		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
> -
> -	if (buffer->remote) {
> -		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
> -		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
> -			return -EINVAL;
> -	}
> -
>  	for (i = 0; i < nr_pages; i++) {
>  
>  		bpage = alloc_cpu_page(cpu_buffer->cpu);

