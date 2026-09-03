Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCF43901F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457221; cv=none; b=qIQQ2jXgGY6Wl2i0Kc1ptlzBqayW4feKyu/cofphetKCiGTej2H5V7IIT8rkQ82srQtncRwwM4G+75c/+LGQHNh7opYotvJbQ5Bq/TVeVw4RUGUz2QN2jSvgFhrlTzr72hqKs5xi0H3vI6zaVxTrDQkAs6QdhrL5nY2AY7hlWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457221; c=relaxed/simple;
	bh=SuOQAOtQywZJY4j9IpQ+ul6vkKdDfjLj9vesTCvyKd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOYc03phjZ2TjdIT7bJFP0j5HdUIYzWCFszGIL0m1laEb1ZnlqIJqiXYWOPLa186KZpAqjwUIgsw/JNG2Zuk3E2Anq8kJhUywft94k+Mx53Nw30UqVfGPMVF0HclPAsMcx1E87cLqFwAecHocDQiD1ZGgzYhf9Aaj5HL2V2bTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T96eUvve; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T96eUvve"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49557167508so1631535e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788457218; x=1789062018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBKoFpt9THFLwdvM+DVkERDMkeUWCyAdDpd/d+wp8dc=;
        b=T96eUvveMLZ1jHKuZheDGL0yvWIJcMP2akY/W12A6+y15vnj/Mt01BNSUpyy7Yz5yl
         2A3BrF1YpMr+VhZvEuDVohT49abfItNNCGxqZKJnPHpYvjqqkdFzqFCoykSVspe/ywUz
         xbxHPmaWWR+MnluHmuHwNNFKs3IuLxRylG7SbINqUqf91ZWP9QkkYIX9ko0KxwJM5JRT
         Y7wtqqCJxvE0QvayDZ4046s2v4feUoVvGYTPy3IU4uaaKH+i2ZZc9gk9pIvsB78fH8Go
         9GdpZ0HdtlZqhLhI27VWtaYebjNl+Lj/y9dLJd0PpkWN+BWWfU7FCMtfm6vUoHgXnKa7
         nghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457218; x=1789062018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBKoFpt9THFLwdvM+DVkERDMkeUWCyAdDpd/d+wp8dc=;
        b=Jdr1cuwfbAeJ90VjtIcHVQw4I8QIyQI4QLOmk+ciplkZlEaPDEHg1AL9t9sW8TEIQs
         hp5iOneTCi5ebXm2p8y2YZ5nvLiIl+L5N8GCcpxg6Em1UrNtSUJoaB2TnQQBchXpAeHa
         oRClyfZX+xeOGqyU0yL3fe3tDGDBOkwLQ2auinRatQAoIqQJFNj5EpnGo9gAqLmDtoY3
         zdqypdvOi6q6NsdmQwX61IbxHTQYzT0oG+S14dTY1+dRcid4ldE2/91p+g3yAK4qkjTq
         najElpthNCy4O4WXw+MK8SWKBLj3hsQx7/eGWPb93MorWk0rL/k78aGNT+iCkxZne1C/
         Gnew==
X-Forwarded-Encrypted: i=1; AKwUvBw4YPdgWENhPVU5qwXjjtDUxLESzsgKV3XWvo6QzogX24th1RNOeFcKCZUWxSU8rTBW7Od9z2RdGsdMbj8zGuikIWU=@vger.kernel.org
X-Gm-Message-State: AFuF++lSiq6X+R3f//spjCnUM6kFnvkMrCaSr3IF29Ar8cMWLOy4AM5Q
	5rmHuMo8c1XaUOoUTDAYpF4tiVzGQEihfOPv2ToBpXrymRrPTpD5CdoFVNXOHa/Rf8B6Pw5BpA0
	VtzVy4w==
X-Gm-Gg: AYBFou1M1qeul8Hq2HBQA4QDVUcknQNB9MDnaEs+XUfjl/1/+7WRM+vQU4P+YzgXQG5
	r2d74GX4591NUJuyTdZS9WKt2JmpafKal9UsbcNCm1akV+ybco58nRahXR+BTpQCb/n3V1gJkgF
	psP/gV6iMSmCzo92noBEC7uv/D2EOBPaA2dkMvZfjV3IiosfCp39yXCXKUytA/JMM1c23aAKqDQ
	Y+BVBGJQO2VNJrGV5DaKN5PohjYrw9Z2+Icsv496GgM7FPi5OusXppEWyDhacxdxUG6QLgYDENg
	wuSrCII2Ozuw6YcYz213M4ojefsDKsNhBW69ndoH2cLDDLWf+zW1xL0lrG5rrTqABjwyaouq0Du
	ABOvQ1cSLBDpo18qtY5mYfyu7ZkC2U8eA1gZsULVEa7HxTIZu0SEd1JzFvTbIJ2XqKOo7J9jvdC
	+fYbU/hIVPhdKjkwzX5G5nvGI0aUnlBHW1mpWvMv1g9iT7a08DgV/0cI8k/WtXwmgyY6IffohbC
	sQNFxm801n4mtrC6Cs43Ms7MDHIgySP
X-Received: by 2002:a05:600c:83c8:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49ce581779dmr270002055e9.4.1788457217723;
        Thu, 03 Sep 2026 10:40:17 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7ac52c3sm109436735e9.4.2026.09.03.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:40:16 -0700 (PDT)
Date: Thu, 3 Sep 2026 18:40:13 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Add checking nr_subbufs to persistent ring
 buffer validation
Message-ID: <apmw_fNwwGvUR-Sy@google.com>
References: <20260903132728.7fb27d34@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903132728.7fb27d34@gandalf.local.home>

On Thu, Sep 03, 2026 at 01:27:28PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Sashiko reported that the code was using meta->nr_subbufs without making
> sure that it matched the nr_pages + 1 on data that was assuming the two
> were the same.
> 
> Add a check to the persistent ring buffer validation code to make sure
> that the saved nr_subbufs matches what we expect.
> 
> Fixes: f5b95f1fa2ef3 ("ring-buffer: Validate the persistent meta data subbuf array")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260901164836.D962D1F000E9@smtp.kernel.org/
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  kernel/trace/ring_buffer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ef66f726e2e2..748d4ae8badf 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1869,6 +1869,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
>  		return false;
>  	}
>  
> +	if (meta->nr_subbufs != nr_pages + 1) {
> +		pr_info("Ring buffer boot meta [%d] invalid nr_subbufs\n", cpu);
> +		return false;
> +	}
> +
>  	buffers_start = meta->first_buffer;
>  	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
>  
> -- 
> 2.53.0
> 
