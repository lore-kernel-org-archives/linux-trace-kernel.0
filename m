Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3D314D13
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097851; cv=none; b=YQwkp7GOFiGXlDkvQUi4agrh8IcQgWp1fMW5sGTxz/VQCBOgwW+F7YksMs60jQXXm02TqyfTS/XdhymeawSUcFT8zk2tPCEXtnNlEc96xWCC/O1pDOm5+mW/XIqwwZ11PR9vVfFTz489ykJmQRyBSL2b8bBt0awSi7b7BfldNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097851; c=relaxed/simple;
	bh=JnRbtAqdkQCRSWgMj/IV63VrjsPLGJXuE0DkppoZBT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TATYUfiQVp3ox2/MPLkbc6lp1OGswX+Sw0mTwcPgWzjYWELM68yMQKhwYjVMhcrQLXnGDKy2P4Wz4YzrSxYeotthrZPrd+Ko81W1PXaGUqjfaiAMy0RytfvK53SXvCbfJ56v3f+3ITjPakDXM09TdsBHs3txRiuGx6iDLfUEqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOe7h4J8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOe7h4J8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2747593f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784097848; x=1784702648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=reWpCNU6/x7BF2W+S+DROQRBvzRQCIh7CY1H85aUcy4=;
        b=uOe7h4J8A1uH2geUe8oRNZD789XF2vyxjv7BWfkwsQaLR81iOKecr6Ts2/ss+obgot
         rQIVDpBBXWnoV0elLORkGPn03ixT+51qQjuVYFzABDKWWkTrftsHXxAk3+JcAZgpK0kX
         kW7rhKzrXJ/UjQDitxYNDLnx0lSz0ks/YaM0bUDfBVNqn7IymPem+Evlhw0lPHamRs6C
         faSrR6/OM/G/xbX2TgLolM7HJ/UlqrMrhJIOEC4Fuo+2pEwNhn7m3xi6TeAORNC+j8K/
         2k/4ADZzeYSMejBTfaEtB9kI8dVU7RU6gKqXuuKuVIr3I9MiPDHAf7jEe27zen5N07lk
         JRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097848; x=1784702648;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=reWpCNU6/x7BF2W+S+DROQRBvzRQCIh7CY1H85aUcy4=;
        b=qtU0yWo8dbjUCrI/Mt6LtFVn4FPbrqvOi60Kn9CXWmap+3s9DiR3AfKCmDhRxOFeoM
         pTQL18tBfkBYO+H0BvrGco8NRI2alrEfhh1jgISUiRbAX6j0N286uy1xk0NgK4Dk3AQI
         bDE2CrFjljeYaccYQcJZ/Hy3wZ6Z/h8ftUbwY3TFWxmAOJZrOALveL4H2Eq+CvzD4Ziv
         tOgkNL8un+nzRpJOFMh0qrwdg3lPW3hwCc1ygCPcmaCLoBMxnKlMfEEU7i6FzDQQlvYk
         qn1/OFYpQMu/2nZvJFaj/ke6YcWElr1296Hvw5DhyyuKga5sAPi8P6DlKYP+WuXQzEEe
         MLPw==
X-Forwarded-Encrypted: i=1; AHgh+RqMz/L9RaBRbkSkxdI+2eleT/PkDhhQ4egQk4g+b2lkw88EbWSKrsiYCQx7lrFx5zZzyJgXK+AaesIA6fOxYFcvXcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6dZ6+FmwU364C47c/uy2DprN/sih9X+keC3tG/ey8R1EcbC/
	l5x/Jc9LTC7kmKI9LcutuPXgzOgP6JwqZ76xn+NuSxtsK3XFcCd4oYssTv/eKeK0bJD1NHAF4Hy
	jK1B84A==
X-Gm-Gg: AfdE7ckF1djQCjzVz3sqyIy87pwUJUkj9vjfM1sJN1wGYaU9jXxYKNDQsBskK3kaQAB
	tPRUzRbdfjFYMfdXGXFPChK3FXMJ4iP1Gqdfn3OL87+ZjRrJR2dVw6lNkmuU0My9A/j5aOEEKTl
	FhScnbL3oos6gY+bfOciWK3rdctcWLRwDjXDwYjE3A9aRPqlR3LO/whuKvWiqTiGl6ex2aFj6jS
	jTtrA3W97J4VxGDLw0DozyZVHTXABkxPye2FZ8bV0vt+lEIOuMIcQKQgxvzDvzhwvb9c+vhcuuT
	TnFYDcvQaiuJKC9Vuqwf+MPzvirW8Xr3i+WS/RcwLj4h/9l+oBhW70bxUk4ihzVEtmepLjuzsWD
	Qc6ierwgS11J7Gm1G35YhslErVVtA3lznC64KJiSjoXOzawvPWe7jQtg+Bz1RVtyn4JK8xddFBN
	ZprppPICjsjI1CeN62DS4/ZGRQPNqHQzOxGrqD06ckAERd2xnQ4Pk=
X-Received: by 2002:a5d:5f87:0:b0:475:f0c2:5b00 with SMTP id ffacd0b85a97d-47f488dea53mr6135067f8f.54.1784097848123;
        Tue, 14 Jul 2026 23:44:08 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm13412585f8f.32.2026.07.14.23.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:44:07 -0700 (PDT)
Date: Wed, 15 Jul 2026 07:44:04 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Jackie Liu <liu.yun@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Propagate errors from remote event bulk updates
Message-ID: <alcsNLVLhWOH3KbJ@google.com>
References: <20260715060448.17674-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715060448.17674-1-liu.yun@linux.dev>

On Wed, Jul 15, 2026 at 02:04:48PM +0800, Jackie Liu wrote:
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

I have sent a related improvement for that here [1]

[1] https://lore.kernel.org/all/20260605163825.1762953-3-vdonnefort@google.com/


> ---
>  kernel/trace/trace_remote.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0f6ef5c36d84..5212e685f0a3 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1149,11 +1149,22 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
>  	guard(mutex)(&remote->lock);
>  
>  	for (i = 0; i < remote->nr_events; i++) {
> +		int eret;
>  		struct remote_event *evt = &remote->events[i];
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
> 
