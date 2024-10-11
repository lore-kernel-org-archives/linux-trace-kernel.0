Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85A19343E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659431; cv=none; b=CilWx1q66suduwRHcvRhfg4yfzCu023ZFWnvCq6cphGVsJhIA8eIg+VUR0px//zB95bHlyLSAolLW8ds47I82nUHpapv8NVj8TgENwQHPPXXFYxLTL572BZd2qE4AD/5KKLN9XXhT30SGsShYHgrxkLWE6l/BWx+itGoEAv27+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659431; c=relaxed/simple;
	bh=lw104qm+G0+JdmIZx7f4XeZ61O0BxitCsy4Oi++bCDU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tHiFiv98rIO7/Ac/CHdew/fu7EvEujF9Bco5exOBt3GA78UwBFUHKRFIGmO4DZXA/7NQuw3Gbz/lKysOC/ECVJ/ak6pieQSdyBcmV+PJyIUCwCqe5mrp8Z3Kron7VsPp4Oj4a6l1BajRfQH9Scku6JwejIo7wrib75KUsnHOD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3VgEMIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3VgEMIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728659429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m24vUpCYQQcbV3XB46UeKIxQNXS2Npg8Axx+7syAJlk=;
	b=H3VgEMISB0Va83xptwD9yucchD8FTZRyDPLa1lJJD3IKqdv4mKECZlPcp940d/EHe4Kq7Y
	AnxK29RN4Nbac3WJh0BxwHt0H43tSaUrcrP95U9c9QTsFMOg5+oXzLx32ye4HXlUnRikPr
	DU7RMb/MY+ZL2j5Spu7w8W7IbZsUWzM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-TBwVjmF9Psqrw8kNuf8C5Q-1; Fri, 11 Oct 2024 11:10:28 -0400
X-MC-Unique: TBwVjmF9Psqrw8kNuf8C5Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b115cfb15aso212674085a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659427; x=1729264227;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m24vUpCYQQcbV3XB46UeKIxQNXS2Npg8Axx+7syAJlk=;
        b=AhCq99Mb1ZizJfgZ1FjLr0nEUcflD7Hih9o3DVpLoInCisKKj0AmflHvP5urrFBLgE
         pyntnP6RxwA0WFI9QBqr2ZebHkoTScvjE/q3ffuGBkKHaxbmg2LITU54PdggshLdhCpa
         h/2XhlkuBak/PxjrWNlMN5zwb/ppfWkWjO4dXlAZQHAKuqbTaevoQjox/F4Hn+V5xCAS
         EfGyPUwzjGHpdAauh1+76SnbkPncupqeYEOskw9ENWuPsrDaP9V9PYDCf1F5UoA60jXP
         5tWfPJvU+jedyo9aZJM+N2OEDFtUE+YRxhPnPBVztiv+DquwbHn5X22UyPY8U275+2R4
         qPcg==
X-Forwarded-Encrypted: i=1; AJvYcCUihIGDg4lifLCboiESxy7V8fTtvlVHtm8WKJWRb0ufkeNMYY9RbYjHVsfMIIxzRCHFqpccikRQaiq16+79AAAB/j4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7P0Bn6bOAhKoBRGUYSp3GwxQLitKCBWUN8ublG5Ua+QZYiY0s
	VgV+4hnXPlPB03/KJN48SfBHRnvF3TzdwgJVN08I+KkSYVS6rPEVML2HXfaadoXXItvN6tGO/W8
	XF21o7TNieLAgDBg5Bnf06jHCbcjjAe8Qb/Q03svogIvZ2vMCtW4gZ3cd7bcrGt2URsgQuA==
X-Received: by 2002:a05:620a:28d1:b0:7af:cd33:33b3 with SMTP id af79cd13be357-7b11a3a9ccbmr480236885a.42.1728659427698;
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNNlcpFHz+ulTVxOY4ANKKzLPBOEsf3PRA5tA3JB3mgtgEjWz+S0wtn4+4mk/xI3zoG884Kw==
X-Received: by 2002:a05:620a:28d1:b0:7af:cd33:33b3 with SMTP id af79cd13be357-7b11a3a9ccbmr480232885a.42.1728659427333;
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497a783sm139724885a.106.2024.10.11.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:10:25 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, lgoncalv@redhat.com, 
    Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 2/2] rtla/timerlat: Make timerlat_hist_cpu->*_count
 unsigned long long
In-Reply-To: <20241011121015.2868751-2-tglozar@redhat.com>
Message-ID: <d016d069-6c89-3798-18c5-b0038a55efe5@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com> <20241011121015.2868751-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Fri, 11 Oct 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Do the same fix as in previous commit also for timerlat-hist.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_hist.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index a3907c390d67..bbeaba8b5183 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -62,9 +62,9 @@ struct timerlat_hist_cpu {
>  	int			*thread;
>  	int			*user;
>  
> -	int			irq_count;
> -	int			thread_count;
> -	int			user_count;
> +	unsigned long long	irq_count;
> +	unsigned long long	thread_count;
> +	unsigned long long	user_count;
>  
>  	unsigned long long	min_irq;
>  	unsigned long long	sum_irq;
> @@ -304,15 +304,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
>  			continue;
>  
>  		if (!params->no_irq)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					data->hist[cpu].irq_count);
>  
>  		if (!params->no_thread)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					data->hist[cpu].thread_count);
>  
>  		if (params->user_hist)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					 data->hist[cpu].user_count);
>  	}
>  	trace_seq_printf(trace->seq, "\n");
> @@ -488,15 +488,15 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
>  		trace_seq_printf(trace->seq, "count:");
>  
>  	if (!params->no_irq)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.irq_count);
>  
>  	if (!params->no_thread)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.thread_count);
>  
>  	if (params->user_hist)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.user_count);
>  
>  	trace_seq_printf(trace->seq, "\n");
> -- 
> 2.47.0
> 
> 
> 
Reviewed by: John Kacur <jkacur@redhat.com>
Tested by: John Kacur <jkacur@redhat.com>

