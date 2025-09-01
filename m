Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8203596B;
	Mon,  1 Sep 2025 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693960; cv=none; b=IkCbuV6uudGGMrhutMfLcNU15ghfJLjy6XfnmXNjy/9c5rl/UPpJee6pqan0SfhPAIQVb2xKWcGE3gkx0SLBA8l7esqsGOSLierIq3V4/V/eB0LOUx+NHzbUgyucpEtvxaCEtffRYQIIIWwaYIfwIxHsu2jHGIzOekuGIGnbC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693960; c=relaxed/simple;
	bh=lUIiz+7BgfLfPKKsc/cy7IA3TCWa+bBrjQHZdLjKJGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo3I+1trJug8XttB7NszpJi5/YvRrWlbtBvk74dNd8MQoBD+BOCVml8kRE2Fw1bgGRtWFk5u0KBHyfte6LfltnzMDAA9mMOI01pov/M5l8atTQjNtfRwcvvW7H4/J2XeOtEtGVFNuK/LlAiJi7g8MWI6DwW8QQomKFbdrdhTpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acGRxD7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acGRxD7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B646C4CEED;
	Mon,  1 Sep 2025 02:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756693959;
	bh=lUIiz+7BgfLfPKKsc/cy7IA3TCWa+bBrjQHZdLjKJGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acGRxD7vy+HHpjerNNzlp+Vmrl55cy1vhXpVaipscWnR3Gjey9/BbTTIr9XqrI6aG
	 9uc6yepiJ+IqQp9Va9yOfT9empDtZTWAKrjFX2NKtCeuA1wB2gMESeuJwwSixdN97C
	 ByuxejVu/MJma165+RYtcpTq/1+GX7K6FyOEKNtZzey0D9Fo43/xgd4r3cCrKp0ue/
	 4Q1MtGUFy7bXhi1v41OAVLhlIUN6GwuIUPU2CcmsJwJGDwxAEdd8UUwSqKu34H+/FW
	 byiE0tFgIeIZUaIxibXMG2ue+xZOdYzPC6+6Emm6VywLhsn0IyeNAu1VZKs1BTqgqq
	 +MxN9s8mnAJRA==
Date: Mon, 1 Sep 2025 10:32:35 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] cdns3: Remove unused tracepoints
Message-ID: <20250901023235.GB2344733@nchen-desktop>
References: <20250829015552.314865014@kernel.org>
 <20250829015650.053498355@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829015650.053498355@kernel.org>

On 25-08-28 21:55:54, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Tracepoints that are defined take up around 5K each, even if they are not
> used. If they are defined and not used, then they waste memory for unused
> code. Soon unused tracepoints will cause warnings.
> 
> Remove the unused tracepoints of the cdns3 subsystem. They are:
> cdns3_mapped_request
> cdns3_map_request
> cdns3_stream_transfer_split
> cdns3_stream_transfer_split_next_part
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdns3-trace.h | 61 ---------------------------------
>  1 file changed, 61 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
> index c4e542f1b9b7..21a6a2ce7a3d 100644
> --- a/drivers/usb/cdns3/cdns3-trace.h
> +++ b/drivers/usb/cdns3/cdns3-trace.h
> @@ -283,39 +283,6 @@ TRACE_EVENT(cdns3_ep0_queue,
>  		  __entry->length)
>  );
>  
> -DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
> -	TP_PROTO(struct cdns3_request *req),
> -	TP_ARGS(req),
> -	TP_STRUCT__entry(
> -		__string(name, req->priv_ep->name)
> -		__field(struct cdns3_request *, req)
> -		__field(unsigned int, length)
> -		__field(unsigned int, actual)
> -		__field(unsigned int, stream_id)
> -	),
> -	TP_fast_assign(
> -		__assign_str(name);
> -		__entry->req = req;
> -		__entry->actual = req->request.length;
> -		__entry->length = req->request.actual;
> -		__entry->stream_id = req->request.stream_id;
> -	),
> -	TP_printk("%s: req: %p,request length: %u actual length: %u  SID: %u",
> -		  __get_str(name), __entry->req, __entry->length,
> -		  __entry->actual, __entry->stream_id)
> -);
> -
> -DEFINE_EVENT(cdns3_stream_split_transfer_len, cdns3_stream_transfer_split,
> -	     TP_PROTO(struct cdns3_request *req),
> -	     TP_ARGS(req)
> -);
> -
> -DEFINE_EVENT(cdns3_stream_split_transfer_len,
> -	     cdns3_stream_transfer_split_next_part,
> -	     TP_PROTO(struct cdns3_request *req),
> -	     TP_ARGS(req)
> -);
> -
>  DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
>  	TP_PROTO(struct cdns3_request *priv_req),
>  	TP_ARGS(priv_req),
> @@ -354,34 +321,6 @@ DEFINE_EVENT(cdns3_log_aligned_request, cdns3_prepare_aligned_request,
>  	TP_ARGS(req)
>  );
>  
> -DECLARE_EVENT_CLASS(cdns3_log_map_request,
> -	TP_PROTO(struct cdns3_request *priv_req),
> -	TP_ARGS(priv_req),
> -	TP_STRUCT__entry(
> -		__string(name, priv_req->priv_ep->name)
> -		__field(struct usb_request *, req)
> -		__field(void *, buf)
> -		__field(dma_addr_t, dma)
> -	),
> -	TP_fast_assign(
> -		__assign_str(name);
> -		__entry->req = &priv_req->request;
> -		__entry->buf = priv_req->request.buf;
> -		__entry->dma = priv_req->request.dma;
> -	),
> -	TP_printk("%s: req: %p, req buf %p, dma %p",
> -		  __get_str(name), __entry->req, __entry->buf, &__entry->dma
> -	)
> -);
> -DEFINE_EVENT(cdns3_log_map_request, cdns3_map_request,
> -	     TP_PROTO(struct cdns3_request *req),
> -	     TP_ARGS(req)
> -);
> -DEFINE_EVENT(cdns3_log_map_request, cdns3_mapped_request,
> -	     TP_PROTO(struct cdns3_request *req),
> -	     TP_ARGS(req)
> -);
> -
>  DECLARE_EVENT_CLASS(cdns3_log_trb,
>  	TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
>  	TP_ARGS(priv_ep, trb),
> -- 
> 2.50.1
> 
> 

-- 

Best regards,
Peter
