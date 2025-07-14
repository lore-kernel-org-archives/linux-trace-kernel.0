Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB4221727
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493329; cv=none; b=jxoW5JwIGqivM4gL5bZiUV/LgHEHsCD8RwRh3dp1WtP1mYpwMC6989IHnkI1FvYowKJ8PKleQdavnlySwPfItuMAg8la6d6BjtvMRrl5HF0g1QRjmcv42tfi6cKywHOzILPtl5yPO+omxlboa47VYwrO/adE4C6uhEjjQhmai8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493329; c=relaxed/simple;
	bh=FYgST6pQFD9uW71/0fSwDSrVyJfCLOXNbI+aU9yF7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SRu3yAnVqvznuoRKfkYDx5mrnEFzz7nCfc8KIDibP/cDzHQgtskaXMibyF0NlMx1FiOtw0NJnpbBpkI7s/JRE/27ONcgwSSGQqqOaJwg+vWAQRts+KQo2LR3qGn7ktE077Bru63LkkHJUDVyzWAoE0YiYt5gj1mVnFmsmePyGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+E9HQRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+E9HQRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752493326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y731NRnwNIgogYJawkSk0h9B9WtguA4mG+59dmJ2OSE=;
	b=b+E9HQRFFIjyo47Rhu0999CxVI0ZaHkXx8WJnuzGpXypQob5d8whqz6TWgkoYJtVIiyTRC
	8ZMMbNPP+giE3f0N2WoV/AYQFsDSDuBt2sn7v4sp7TvOMOV4OiydWIYGSrJH/IWAWK14Dt
	Pw+mgVWrCZuY3egSwXomLyXN4rPBnCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-P9CIJfP5OWmvYhFY3zjvzA-1; Mon, 14 Jul 2025 07:42:05 -0400
X-MC-Unique: P9CIJfP5OWmvYhFY3zjvzA-1
X-Mimecast-MFC-AGG-ID: P9CIJfP5OWmvYhFY3zjvzA_1752493324
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b39cc43f15so2323874f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493324; x=1753098124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y731NRnwNIgogYJawkSk0h9B9WtguA4mG+59dmJ2OSE=;
        b=Y5y+0AGs573s+wPLMQD9gAYDu3X3RjtPhgsRpoi3yHKdyWFa58qR/AcSKd+VRhZuIv
         kjNK9jqt4FLfeyfm1mcUrOgv/3IXrqFxt7gkaeJes2qzaP2e2lWhEhMCiBlsp9WumvlF
         R71+Zp4WahI5xVQqDiEdoVpasWXTUAlSJt0cXwugp/BzNZlm31F1uWJhiQez1MpFKbVU
         R5I8qW0TF60/JHxYIfgpidoSmSjkVf452NAu0XCBEyIviBJECYVFnOF6Ky1+kVqG9ouT
         8DG55c4LM777+6ZrYaaKDlK4ZSHn4LOo/xcuAPXd43+aXIvQhdc7L4dBQCnFj5m21H42
         Mm8w==
X-Forwarded-Encrypted: i=1; AJvYcCVwjoKnsw3dV4oOSXBGtbLIgsspwl6NLLIqJGuH/+VHxG178JtUYE3oUb+dHSOi+3Hfey4PK+rJ87VZnp+c8uX81lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylhjyPFfGMLSUJ3qHWy0fxa3xifJbgvDodSlJs9eBEUKmPAUWy
	T+hsvzxkC9m/IuTsQWt8assKWE77i8btHPxYhHO5fCXxMPIwqnedfu11vY8FVS86a4wXbGIDjpE
	C8bv99hCWTeTCBRYQyz5Z25bbbHRaDNrNEdpKelJWEYq4HvMj6HTz8xfBfYajBsgYifDOHwxIjA
	==
X-Gm-Gg: ASbGnctDN1w8eFCk0hgwmh8vV1kfdxow11bpxYizpu1i+NDvJtAHnvua25ObCzc4Diz
	TY5JZ4kcWFlbzXAGCHxx4v0rdFc4305ba9P/fC+xiWseFkx315h4NA1cjmfMkaepokOODJ1sw0R
	oc5LlaIQai8nb/TKxeBzEeHc1BWr79eGSKYMk0MH/J1vVafyaarbELaGX/HqxZNTmQlFIrweBGF
	/pvHhbHdxUr0kyFsJnFCgHv/kjojsed425XYNUCF0o+IccN9clCQO6W90F8hzV0e5TvirSejkEZ
	6Y6ylmbCs2jOk1htbisN+uCYlEs=
X-Received: by 2002:a05:6000:26ca:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3b5f18d99a9mr10479318f8f.29.1752493324340;
        Mon, 14 Jul 2025 04:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQH0V/iMOxtMz9uQz0A7Zu8CheLlThnVAI8whDJVkBgC2ZF166O9rwFbccdktxmhQ3vNNKlg==
X-Received: by 2002:a05:6000:26ca:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3b5f18d99a9mr10479295f8f.29.1752493323904;
        Mon, 14 Jul 2025 04:42:03 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26ff9sm12194718f8f.93.2025.07.14.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:42:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:42:00 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
Message-ID: <aHTtCGGlrvOZvnsW@debian>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250714075436.226197-2-thorsten.blum@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K8V56mZGiwUW1Dvvnrk4ljY4c7CUupoNSShMdt0Nw2A_1752493324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2025 at 09:54:33AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Since the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the size argument is omitted.
> This makes the explicit size argument unnecessary - remove it.
> 
> Now, combine both if-else branches using strscpy() and the same buffer
> into a single statement to simplify the code.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/trace/events/fib6.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> index 8d22b2e98d48..903a18836bc6 100644
> --- a/include/trace/events/fib6.h
> +++ b/include/trace/events/fib6.h
> @@ -64,11 +64,9 @@ TRACE_EVENT(fib6_table_lookup,
>  			__entry->dport = 0;
>  		}
>  
> -		if (res->nh && res->nh->fib_nh_dev) {
> -			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> -		} else {
> -			strcpy(__entry->name, "-");
> -		}
> +		strscpy(__entry->name, res->nh && res->nh->fib_nh_dev ?
> +				       res->nh->fib_nh_dev->name : "-");
> +

Acked-by: Guillaume Nault <gnault@redhat.com>

