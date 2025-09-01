Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCD1E1DE5;
	Mon,  1 Sep 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693803; cv=none; b=q9xSrqM7cQ/mE96R+pglUCgl97EWIUhdqpANpdNqgurIhNTS2QLRxkixG6aupgHydAQSYa3sgffqTRIzWentkJMpb8oXLOiD/ypHyhEKd3rPc8EWxNT8e1z5bXT1kQ2g67GkEPRgLJUJzARuNWpQ+tIitUvpSd+tmUk1LN8bEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693803; c=relaxed/simple;
	bh=EEl7Dl8rmIXPvdQY4z/NjswBXZPLFYOn08q6RmoBUDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okocLPeFM0HQPzaVZCA0Y9DLPBB8X/cLQvEI5gV1TBNOYorsOji7T0kcp6qohhJraUZ/nXxMZW6yUMqF+lSrmAVefAn4eRu4Dgk9FZKNxu6sNUmdkzc4cc9JpfSsh6MM6tNy+wh1ECqwYx11P+49Nd/U29DXhQE9MANEWNwCPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3zfDNya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3zfDNya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605BDC4CEED;
	Mon,  1 Sep 2025 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756693802;
	bh=EEl7Dl8rmIXPvdQY4z/NjswBXZPLFYOn08q6RmoBUDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3zfDNyacOxGyYt/H3jXqjdgEPauZBBV8jA7NF/VNZPsxsMEFuJO0H/k5gSzMbgQ0
	 MxpIX4E6DGgGXvvXcZwbh7hWpGkGPdxWzrX5ilahv1w7WnWZozUYye97HCMEqO52GJ
	 jwMe3Gg8IHDGMsJVHdr2J3f+RWCzZ7zG4RqQuPf39L6007VZvOTKBCPr+1dpaS/OEL
	 Hs0LG8ImuXKM38VFh5QN9s1vP55AjE81vasWJJKY0d7jltRHQPGBbIZXv2uchxZUkl
	 8Tj9lKkc4N4T4Klq7MI8/4gzI/DU1R9osgzo+hjaO2iRUduvaMvoORzZXSrpHps2eK
	 eau9dOYVATLzg==
Date: Mon, 1 Sep 2025 10:29:57 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] cdnsp: Remove unused tracepoints
Message-ID: <20250901022957.GA2344733@nchen-desktop>
References: <20250829015552.314865014@kernel.org>
 <20250829015650.224063821@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829015650.224063821@kernel.org>

On 25-08-28 21:55:55, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Tracepoints that are defined take up around 5K each, even if they are not
> used. If they are defined and not used, then they waste memory for unused
> code. Soon unused tracepoints will cause warnings.
> 
> Remove the unused tracepoints of the cdnsp subsystem. They are:
> 
> cdnsp_defered_event
> cdnsp_ep0_halted
> cdnsp_free_priv_device
> cdnsp_handle_cmd_flush_ep
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-trace.h | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
> index f2bcf77a5d0a..9b33a736c3de 100644
> --- a/drivers/usb/cdns3/cdnsp-trace.h
> +++ b/drivers/usb/cdns3/cdnsp-trace.h
> @@ -178,11 +178,6 @@ DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_set_config,
>  	TP_ARGS(msg)
>  );
>  
> -DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_halted,
> -	TP_PROTO(char *msg),
> -	TP_ARGS(msg)
> -);
> -
>  DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep_halt,
>  	TP_PROTO(char *msg),
>  	TP_ARGS(msg)
> @@ -399,11 +394,6 @@ DEFINE_EVENT(cdnsp_log_trb, cdnsp_cmd_timeout,
>  	TP_ARGS(ring, trb)
>  );
>  
> -DEFINE_EVENT(cdnsp_log_trb, cdnsp_defered_event,
> -	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
> -	TP_ARGS(ring, trb)
> -);
> -
>  DECLARE_EVENT_CLASS(cdnsp_log_pdev,
>  	TP_PROTO(struct cdnsp_device *pdev),
>  	TP_ARGS(pdev),
> @@ -433,16 +423,6 @@ DEFINE_EVENT(cdnsp_log_pdev, cdnsp_alloc_priv_device,
>  	TP_ARGS(vdev)
>  );
>  
> -DEFINE_EVENT(cdnsp_log_pdev, cdnsp_free_priv_device,
> -	TP_PROTO(struct cdnsp_device *vdev),
> -	TP_ARGS(vdev)
> -);
> -
> -DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_device,
> -	TP_PROTO(struct cdnsp_device *vdev),
> -	TP_ARGS(vdev)
> -);
> -
>  DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_addressable_priv_device,
>  	TP_PROTO(struct cdnsp_device *vdev),
>  	TP_ARGS(vdev)
> @@ -575,11 +555,6 @@ DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_stop_ep,
>  	TP_ARGS(ctx)
>  );
>  
> -DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_flush_ep,
> -	TP_PROTO(struct cdnsp_ep_ctx *ctx),
> -	TP_ARGS(ctx)
> -);
> -
>  DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_set_deq_ep,
>  	TP_PROTO(struct cdnsp_ep_ctx *ctx),
>  	TP_ARGS(ctx)
> -- 
> 2.50.1
> 
> 

-- 

Best regards,
Peter
