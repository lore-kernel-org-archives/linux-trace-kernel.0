Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258936AF5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502721; cv=none; b=Z2yMmwiPoeSaw/dFRrsf7L7H3ZSVAQkiunSrV5MgxdNMfgnsuI0jnGdD9JBo4i6dCfSqaqtzcAWZgOCfmg0TsgMTxpWkEhONk3SLewpW5q89j9w1UB3MHY+JuZ6I9ADoJWeMHrAcEEXjstOHxfVkkaHjjqIpu52943aEhj1Hsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502721; c=relaxed/simple;
	bh=2tV+k+LBk+tVq13k3Y51obWTupsNyQ9CIrTpML8b0kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PONrsjLbDB/s8tL7lqPHb8/gwdlw3rnNnp9e96rEGOTH1eEuzdeTcRXx9RAP0GFQOe1Y07m4jGh2ANmeSYI6EA+2VnGDVu8rdYZK7fQ598J/SqX9piPYYaqdmVifZFTDeqzi/y31XnSDbbrflD/zNdXxHbKwVAujJF5LTpH0+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/966yxx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/966yxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742502718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs78ufWo2bSJSKRY/bRQ3KlIEcRDlnNhDJQo1byueYo=;
	b=U/966yxxe72wcDW0YCVFkjTr5R3LZ/pFFXdOpvTYTbVN33JQUiY2XJR2wqJz4BpxS0cV3a
	AEgHITSwPgbUCTXBxiJSM6dFW8EtMoozT6klOP39PB8rLBKBu2HZivYmj0Evdi8e2J9Awk
	Xt95ORwB5XTFVhk4Fbnw2Dd8DMh4Smw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Q6n2_8BbMUmgKZlAqZZsxg-1; Thu, 20 Mar 2025 16:31:56 -0400
X-MC-Unique: Q6n2_8BbMUmgKZlAqZZsxg-1
X-Mimecast-MFC-AGG-ID: Q6n2_8BbMUmgKZlAqZZsxg_1742502715
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476b2179079so22665911cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502715; x=1743107515;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs78ufWo2bSJSKRY/bRQ3KlIEcRDlnNhDJQo1byueYo=;
        b=KcPOX5sFG5s5Vboy5K12tPt3Obwa9Hle5IQ7Pmj0u6LwLc2UdmgZorIysry7VzhKGu
         oIUzo7TS8ikFt9C9/KZQyvUMOc5xoeB3MNwd+SdvsXFJjSkLKEiq+llnYVkbf2gc+VT+
         fiflwdhf6Y2zRfFypIX94JQNPHo0hO4RFuo+ZHuVhkQJf7DnqLyUC25xagp1wxswmfCM
         WGxCKoanFQKYXERV1TOVOLtFKMmnTVZK5g0jhEjMVeiWGmliL1Ma3bGreVMf7vYWI0JP
         tf8BaHN/lwKus277dlSPPF/xPH5f/b7+cYC+YA1AgDXJ9gTvhuKCQvooXgZTJHp2bhJE
         /fYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjl7A2jctunZLVDvkiD00otnNn+nAI1DSFbTrxLB8nudoM13St70EicGiDZQmfzTnZw2i0FZ6CbLNYAXXAM2ujWc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3bN7zSM7+aCSYdEYypHK/eiij1sq4kTGPKDE5RBqCRN9hT2e
	0vj8l6u+hsS16vVfEy+lC7KZn3TPJLMPMtTYmSEOVaZ7tOcNtapQUM2xIZEBri5ogWmcmnZQf7f
	QI6GtURVujHYJvYnb3FRV1aPVMp39bzT/B3a+6MbnIZtmJy/tdeeg64eZTM0OU7UqlKCWsA==
X-Gm-Gg: ASbGnct+uX41PGYf58bhIG53c31ca8gVnhVur39s1vZgZMKybHcMbWTll8bjPNLWUZz
	xmtgNRh0O7kwitfoC5tgaphuo8cxvjx8MqVfrJzwU6r6hC4MBiGBt2CqZ1M26lufHEIUKeRlS07
	DVJSiws+0pu7HNqC5oRk24uqBHru26AOns85dKJQHuFN/H0GK/Xeitn+if402IPAXP0OGXMJMZd
	YVEt6KTv1t8N+36v4w/ByBdDvvmsDHQYayeZ+QmaSOeyt7G/3MAHOavGpHr/NFneyVwK2IkgKit
X-Received: by 2002:ac8:71ce:0:b0:477:1eec:e355 with SMTP id d75a77b69052e-4771eed082bmr2367141cf.3.1742502715245;
        Thu, 20 Mar 2025 13:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbgJAMPPYKZh9vIiVrvuQuTmRjSYeYhTU4Xkf9NWImKq7CokOQ3ONC+sh5/MiuNZxDyvWfIw==
X-Received: by 2002:ac8:71ce:0:b0:477:1eec:e355 with SMTP id d75a77b69052e-4771eed082bmr2366741cf.3.1742502714704;
        Thu, 20 Mar 2025 13:31:54 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fec4sm2708811cf.52.2025.03.20.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:31:54 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:31:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 4/6] rtla: Always set all tracer options
In-Reply-To: <20250320092500.101385-5-tglozar@redhat.com>
Message-ID: <8e41f0ee-7534-eedb-0a67-184ac195baf4@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-5-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 19KMAWizT_Yp-DIRRwUg_OxA0Nq_AdrWuacX0taNqVc_1742502715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> rtla currently only sets tracer options that are explicitly set by the
> user, with the exception of OSNOISE_WORKLOAD.
> 
> This leads to improper behavior in case rtla is run with those options
> not set to the default value. rtla does reset them to the original
> value upon exiting, but that does not protect it from starting with
> non-default values set either by an improperly exited rtla or by another
> user of the tracers.
> 
> For example, after running this command:
> 
> $ echo 1 > /sys/kernel/tracing/osnoise/stop_tracing_us
> 
> all runs of rtla will stop at the 1us threshold, even if not requested
> by the user:
> 
> $ rtla osnoise hist
> Index   CPU-000   CPU-001
> 1             8         5
> 2             5         9
> 3             1         2
> 4             6         1
> 5             2         1
> 6             0         1
> 8             1         1
> 12            0         1
> 14            1         0
> 15            1         0
> over:         0         0
> count:       25        21
> min:          1         1
> avg:       3.68      3.05
> max:         15        12
> rtla osnoise hit stop tracing
> 
> Fix the problem by setting the default value for all tracer options if
> the user has not provided their own value.
> 
> For most of the options, it's enough to just drop the if clause checking
> for the value being set. For cpus, "all" is used as the default value,
> and for osnoise default period and runtime, default values of
> the osnoise_data variable in trace_osnoise.c are used.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
> Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
> Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c  | 56 ++++++++++++++---------------
>  tools/tracing/rtla/src/timerlat.c | 59 +++++++++++++++----------------
>  2 files changed, 56 insertions(+), 59 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index a71618d876e9..2dc3e4539e99 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -17,6 +17,9 @@
>  
>  #include "osnoise.h"
>  
> +#define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
> +#define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
> +
>  /*
>   * osnoise_get_cpus - return the original "osnoise/cpus" content
>   *
> @@ -1127,46 +1130,43 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  	if (!params->sleep_time)
>  		params->sleep_time = 1;
>  
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
> +	if (retval) {
> +		err_msg("Failed to apply CPUs config\n");
> +		goto out_err;
>  	}
>  
>  	if (params->runtime || params->period) {
>  		retval = osnoise_set_runtime_period(tool->context,
>  						    params->runtime,
>  						    params->period);
> -		if (retval) {
> -			err_msg("Failed to set runtime and/or period\n");
> -			goto out_err;
> -		}
> +	} else {
> +		retval = osnoise_set_runtime_period(tool->context,
> +						    DEFAULT_SAMPLE_PERIOD,
> +						    DEFAULT_SAMPLE_RUNTIME);
>  	}
>  
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> +	if (retval) {
> +		err_msg("Failed to set runtime and/or period\n");
> +		goto out_err;
>  	}
>  
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +	if (retval) {
> +		err_msg("Failed to set stop us\n");
> +		goto out_err;
>  	}
>  
> -	if (params->threshold) {
> -		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> -		if (retval) {
> -			err_msg("Failed to set tracing_thresh\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +	if (retval) {
> +		err_msg("Failed to set stop total us\n");
> +		goto out_err;
> +	}
> +
> +	retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> +	if (retval) {
> +		err_msg("Failed to set tracing_thresh\n");
> +		goto out_err;
>  	}
>  
>  	if (params->hk_cpus) {
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> index 448fb1f7d3a6..c29e2ba2d7d8 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -16,6 +16,8 @@
>  
>  #include "timerlat.h"
>  
> +#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
> +
>  /*
>   * timerlat_apply_config - apply common configs to the initialized tool
>   */
> @@ -27,49 +29,44 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
>  	if (!params->sleep_time)
>  		params->sleep_time = 1;
>  
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	} else {
> +	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
> +	if (retval) {
> +		err_msg("Failed to apply CPUs config\n");
> +		goto out_err;
> +	}
> +
> +	if (!params->cpus) {
>  		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
>  			CPU_SET(i, &params->monitored_cpus);
>  	}
>  
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +	if (retval) {
> +		err_msg("Failed to set stop us\n");
> +		goto out_err;
>  	}
>  
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +	if (retval) {
> +		err_msg("Failed to set stop total us\n");
> +		goto out_err;
>  	}
>  
>  
> -	if (params->timerlat_period_us) {
> -		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
> -		if (retval) {
> -			err_msg("Failed to set timerlat period\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_timerlat_period_us(tool->context,
> +						params->timerlat_period_us ?
> +						params->timerlat_period_us :
> +						DEFAULT_TIMERLAT_PERIOD);
> +	if (retval) {
> +		err_msg("Failed to set timerlat period\n");
> +		goto out_err;
>  	}
>  
>  
> -	if (params->print_stack) {
> -		retval = osnoise_set_print_stack(tool->context, params->print_stack);
> -		if (retval) {
> -			err_msg("Failed to set print stack\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_print_stack(tool->context, params->print_stack);
> +	if (retval) {
> +		err_msg("Failed to set print stack\n");
> +		goto out_err;
>  	}
>  
>  	if (params->hk_cpus) {
> -- 
> 2.48.1
> 
> 
> 
Reviewed-by: John Kacur <jkacur@redhat.com>

