Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CB323417
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108035; cv=none; b=ek25A5IV0h99HhMhsTfmUw/u6f2i8KtXWPWp0bIpaSXUVfkUpQOoLv901Uh+VPDRJc+WiH/UDcptxIFrR+VxDoN/YfcA9Dx9scxhMGqY0lq1Ri9C7SmkBpJTev+mrqDnSTYYPeSKR1Hc3gYK373o+nCzDBtYb145OhBHFGpR4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108035; c=relaxed/simple;
	bh=DkUd9WMv6Z0/ARAoJlg5ZMyQSsbrBKdwmf/ZiTVF6B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdv9jBM5voPc1WcvuqnKDfjhiVkEHCxjoJBZ5H85IVo8abdDfptKAtDtQV1MwVt4/nrmEeWhIL5S/5/+4quo/VQ07TuiSQthvaBxbiyHZe3Zxvs314pHWqQfkg6v6iXKsem1H65azToZckJtoZpKwQWTv7XvHxtp3o6EwEOQWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7s5VUTb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7s5VUTb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso3221508f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784108030; x=1784712830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dR8FQVRK4e2PYVhniAW9kJV4qFNJvXjE3bHzenXKKAc=;
        b=d7s5VUTbs7bkC5OdlvuCkfJizNOE9SUsgeqa31zOIQx8R3xwohZewWR4VTLtIESHfS
         9ZShroqubMG7rTx3DWk5Kdz3BwZ4TQMMrnoHY+Iw+5Rcd5S5r+pWksZoXyFN7hePSNSl
         +BmXF/H9gE0mQHMdmNI+RCR0LYfavpCo9568YQ0/Rvs596iHNOwHF/6xhPiV5ZKdmKCS
         Bhx3Hj3WvquFKDg0GuDS52BHXhPTGy/mqmr8GjT/EbZ/zmylBm204NbV8rZ7ej1yf9Rd
         9hhKT6Huk7ziKbKS3lzlvsTMpaejUi753t9N9zDO9bnqIOy8UG+uROJHyFqY/QGHyEbb
         T6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108030; x=1784712830;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dR8FQVRK4e2PYVhniAW9kJV4qFNJvXjE3bHzenXKKAc=;
        b=c9kUD+DyySSoZ7BFGldh7VNUO8+mV3DAbvoiaReIaDZRnwLR/feH/vDCTP2s12a+nd
         3aAnL6moKf/P7ST34oqYHS+Sv/YGFt4TYSgaJJ6pbHjPW02TvzCTWf9lZAceXMgvC1l1
         C5QrvP634ITAGM40GsUh5d6xvYDFKuEjpeHqkcp1amgmZoW6V2hUHGqi84Hf2dDxgGCv
         fAg83PBre6ep8dabe2SUr8H4XxiSH2aR+xBUDimFgjjTP3lWrSli2bIkM/PezxIwPBUJ
         KauGwXruVriCsXolTHw6Dn1qkeud5KGruX8fmdGpMnKSChCZ7N2N3t/42lVFzby1IwVj
         qMOA==
X-Forwarded-Encrypted: i=1; AHgh+RqqRuw5yFeK7n6DJs5pxpAGFXomWHD9Hk4TanvRiw0Hi/wHKhkrBIGvsdsqLZodFHGjUMIVlDPLrxl0DSawYPJ4jiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX51J8zg7oKKjfq92/h2clCq4+UCK11kUcNmtJvhI0CSvXjT8l
	UOfYk1gHWr+Dd2qK66Z/5JuXdCzzyjxq90VxH3mFDok0jmDELWPsWQA2e1d9IDSn3g==
X-Gm-Gg: AfdE7cmiJ1dpBdnK79BsAaxEI6Ndulc9uiX5GjGPb9y9Qld4zku7LLB2wsvpXxMbEdj
	DBcM+TCyrBdh7KaaKlKxyf/lXW++DPOBAQ45Zt3TIU1sqr3UKyDE9ImuyYkZmD10Xmns9DyoPXe
	fqA2prqVBUUd36boOmuYqDl4FBqoYAYWDzoMAiqdSYryZQkYTZYEzWc7cUdTiQEvSBpjJT6yMWp
	HPL3JNS2U38TSwvsPPwepW5daK92PTF9fNn6N+UixNWXe3yn++xZGLBdjF2zcPtgZ6ddA2Tqzbq
	hSvnJW8LBbDpTHOT2zufGfQhufei9BFsIv8kOBDRbGr6ZjW+11ZJI6R37WHwiRRvV364AJxJzHz
	zxYYmGD04oYIHrtjyqZD71Nog1cQjFTOs6yj4Y1q3yPY3+XpkVmXQ+FtmM1EWoaLdtQgaYwAIBm
	wDTkCeaPqUxGbTGtN14xaTSqI4ZJ/Yg9FVccQ2+j8zfwxL8j1iQ8Vf20D2JDHz3Q==
X-Received: by 2002:a05:6000:1788:b0:47f:2bce:6f38 with SMTP id ffacd0b85a97d-47f488b281emr7046816f8f.28.1784108029674;
        Wed, 15 Jul 2026 02:33:49 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm15613182f8f.9.2026.07.15.02.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:33:49 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:33:45 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Jackie Liu <liu.yun@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Propagate errors from remote event bulk
 updates
Message-ID: <aldT-RpkeVQI3Uza@google.com>
References: <20260715074455.3897-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715074455.3897-1-liu.yun@linux.dev>

On Wed, Jul 15, 2026 at 03:44:55PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> remote_events_dir_enable_write() ignores the return value from
> trace_remote_enable_event(). If a remote rejects an event state change,
> the write therefore reports success even though the affected event remains
> in its previous state.
> 
> Keep trying all events, but retain and return the first error. This matches
> __ftrace_set_clr_event_nolock(), which permits partial updates while
> notifying userspace when an operation fails.
> 
> Fixes: 775cb093bc50 ("tracing: Add events/ root files to trace remotes")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Thanks!

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  Changes in v2:
> - Move the eret declaration after evt to follow reverse Christmas tree
>   ordering.
> 
>  kernel/trace/trace_remote.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0f6ef5c36d84..daeaf1d3eb1c 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1150,10 +1150,21 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
>  
>  	for (i = 0; i < remote->nr_events; i++) {
>  		struct remote_event *evt = &remote->events[i];
> +		int eret;
>  
> -		trace_remote_enable_event(remote, evt, enable);
> +		eret = trace_remote_enable_event(remote, evt, enable);
> +		/*
> +		 * Save the first error and return that. Some events
> +		 * may still have been enabled, but let the user
> +		 * know that something went wrong.
> +		 */
> +		if (!ret && eret)
> +			ret = eret;
>  	}
>  
> +	if (ret)
> +		return ret;
> +
>  	return count;
>  }
>  
> -- 
> 2.54.0
> 
