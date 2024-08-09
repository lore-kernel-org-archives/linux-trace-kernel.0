Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A5126F1E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224876; cv=none; b=OD5P/fxNZ7TR1UDcelBR2qcckCyyAUAJpi3gnOJqSdCmPpgEh/5y67YZBXL/H8uXg2tjPrXNud60HMiByYlriuhoZon/jMhrQ2gCCg0ueAMh1TNtO/b7QlRJ39/6si9RFrU+t+4pmwK5zOeQkwCJXzie8ArnXb6b86gzfDIOIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224876; c=relaxed/simple;
	bh=uaFoxvFaWKTcurfNyk9i82RYMbsjWOiWm8JvkajnOEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nVEqcTRR2Zxhzoib9NS5zhv6BcyAolTvZQSYCej2HKCKPC4dLaQjE4/GnAIqoiQctStU7QRNn4/4fJNfhx9kHnXNvgmcvRBDBMI/E+9cIAR3PLu1JPv8NJVJmRWyUGcjhQZmNJsifqcpswnn7uiC8lzZ6QBPGNUeeEfXUpjPkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMQUXBFH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMQUXBFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723224873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qAgqY2+FOr0YdLUk8z8Be8IJe7YHmn8uPB+WVVFagE=;
	b=dMQUXBFHJZ+pAmBSNb8m3tMzK7mO3tUIGa7T77h0F1r8SJvoOYuzlUYjmE+UagYjajxb+3
	DMD+PcylDy6yFk4T+YMIbEo3TQCGBFcTfR+HfzljrWvTp5HMT7kOXBnluhaKBzttSVUPkQ
	NQsyeA3SL0SZsWVZzvvQSPy/r1jkh2Y=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-7Rw4AtZOOrasPhXnDWYWcg-1; Fri, 09 Aug 2024 13:34:32 -0400
X-MC-Unique: 7Rw4AtZOOrasPhXnDWYWcg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-493c73a971cso1099255137.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224872; x=1723829672;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qAgqY2+FOr0YdLUk8z8Be8IJe7YHmn8uPB+WVVFagE=;
        b=oX9uCfSEESrEpI14SFT9sN03I/bg5Tp38oRH+Vmvt3OsbB0fh9uu5okjLvTXRWKjO/
         LtXd6MVeqJCxvOR1RQ6b4SSV+eDbZRlAnk2JP9riDG6ilINyUQbAaTJFXlBn5zkjEIeV
         Tj0hX9tWcc+SEjKZDfFYzrOlGxl8iragAE/YHoKb59hHlZs8YpkxLyB2k+NS5ls7Y6F5
         fI1Q+wV2dUW4av9KWFcye1G8MbqXo9IlwlxNNVLl63l1tdL2jmj5h6Yc6GnMsIl28M0f
         TwUM1xAtDMiyZ37JUnxpBJkbpJNA6VnK+ZnhlqMinqyhTg7cDbVgaeuc6Piu2upVqdwR
         JNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUMxc4LNN43cMC90ajgg+bKEjXtiyIM/U+xGYdF7gN3K07qGlXTXMvbKqw6SaS7ifUgSJFZgAZmRtN6RUNaVOPNBywII7m+417+rYhFM1dr/RGK
X-Gm-Message-State: AOJu0Ywm8NK+5ErYlNgm3D4Z4rOG5U4fhLHmqmWFVV3QPudcbvhU+Ttg
	XcP/EJF6zwg5l5tLfrhsuDa4Gv/mz4nxTRt8d7CAFqXYpXKq/kxUeqitzJkUY74ZcsSTBjfzJWR
	PLFBLkqASL3ptmIJmCl//Zgj3M7t99IFq8zZu8AKq9PWDCChiGKsdF6M/vfy+TIlTl1lI4Q==
X-Received: by 2002:a05:6102:3ecd:b0:48f:a7a6:bacb with SMTP id ada2fe7eead31-495d840a6fcmr3080140137.12.1723224871861;
        Fri, 09 Aug 2024 10:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuWaN08M43DbXCZSgcHg0HBsQZIbgEQVqpCg/mNM2hukMdn00DmL6gxpy8xax+9c89Jl8GZg==
X-Received: by 2002:a05:6102:3ecd:b0:48f:a7a6:bacb with SMTP id ada2fe7eead31-495d840a6fcmr3080116137.12.1723224871501;
        Fri, 09 Aug 2024 10:34:31 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f2452sm278505685a.59.2024.08.09.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:34:30 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:34:28 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Daniel Bristot de Oliveira <bristot@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
In-Reply-To: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Message-ID: <c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Fri, 9 Aug 2024, Dan Carpenter wrote:

> If the "tool->data" allocation fails then there is no need to call
> osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index f594a44df840..2f756628613d 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  		return NULL;
>  
>  	tool->data = osnoise_alloc_top(nr_cpus);
> -	if (!tool->data)
> -		goto out_err;
> +	if (!tool->data) {
> +		osnoise_destroy_tool(tool);
> +		return NULL;
> +	}
>  
>  	tool->params = params;
>  
> @@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  				   osnoise_top_handler, NULL);
>  
>  	return tool;
> -
> -out_err:
> -	osnoise_free_top(tool->data);
> -	osnoise_destroy_tool(tool);
> -	return NULL;
>  }
>  
>  static int stop_tracing;
> -- 

Although your fix appears to be correct, I wonder if it would be better to 
create a second error label, such as out_destroy_tool: as described in 
section 7 of the coding-style.rst

Thanks

John Kacur

