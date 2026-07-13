Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EAE3AD524
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930888; cv=none; b=Mhb0PK+7C+rvUPzhjUG+0IGu56mCAWm0oHqI5g2NXtNJU0fGO0KJ8bUJ1zovQRnojJDi07G58vCgWDIpXC2PIggyDOoCrkqi5TA8mV3v8l6AA+DCLVcKiorKI9mmrYQzUTVxvUD+GCUdKTfjVOZO0/tpy98p4apnCeNJcH4S164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930888; c=relaxed/simple;
	bh=Yy0Rum6OX/7GHOu3/FJbCVc981c5QVNECD1+87yPWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln4rnZHZ+VwDYpQGFVeM6okN5nvgkQEuCV9cbAGmRKTl94UkEpIhXP0bUZ+J84DhZ5TWBPUKVMtIKDpbtFLtBox+t3blRABqWdxi1kAD9Lwo0MtI0wwd5rTrdgbHC/ep3enKsIEIiRJW03vc/E6L8pfFL+B4oqIaRZkl20DFPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9YcDzZJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9YcDzZJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so19712185e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783930884; x=1784535684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrAkZsSUgpZbjxzvPdeiOWzj9u/doeixQHc02MlsfrU=;
        b=e9YcDzZJghi5jXJVYT0my42/vYXRQbpJdQ+LQMitnRl0YczcPIIfGJVk2Y4s2zBclt
         iD1iQZB3N+6ZencgHVDZbbMiszOAF370/yp6ehSbClzHhdfHUHq2peDjM5OWpmMxKvgI
         oJwXVWGg5JLp/LH+nG/OcdqGL8NEEvTUl+Jn7PhnK5IS7ZXkj+P5/SqOzPDu8F+2pivg
         9YJxI6Nl7Vkl2DlLKX/8PBg6SW6q4S5XnZdddBCDIZJck18MvvEhpUcotEXqhu2SLOY0
         MgGW7X2wF/V7kJcnQMsQgLp4opnktGjcYgx57MS7bkQruY4qGrX7l/F9ccCt9qr4aON7
         0rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930884; x=1784535684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrAkZsSUgpZbjxzvPdeiOWzj9u/doeixQHc02MlsfrU=;
        b=RUBakfRNMDnJefC8KBnhc3qUr+jyZEeCk32wwBCySLWUx/MNW3FMmyrGP5JI5M9BCi
         p6lTUKwTYKJsFhWwF0kAY1KgYMseHzcPLAk9D4lLQL/AldWJKmaWaugydADdaj2PH2Lp
         Tuhi6sOc/kx/KXllhPLGqkfR/L/x/Q75r8HsvUrk+Lu/hS7FrhxjdmKgZPNiCa5Qu7KJ
         uQ06Pbzg1CiCMJ0xSUHp3Jhxsp15+sbkqZ5HtMdD1DaWQlcvHOvuTaWB2eZnOTQ0jIVE
         1oi7TBfEmFoB7jfjl0rXq2+MKrif8Ytg2abeCTH9/nZPeZik5z/bhbBl1SO4Jnynghl/
         iNVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhQkzptWShdPYJ7cw1Mzg9k26G2iYPmHzgvdO9edMzx4uVFINZthIcOpkzXCaH7IDh4MVEtJ5SMIczoqIbbbCkzOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCocvQSrWhwlDciby/thzTl0XL8xgwEuLJiQi69Ub7oxRWz0jq
	4ghC6lrgZu4Cp1bhWFGBSUv/u0kWhvkmzbFdwP8S8/hCCkKu5RFdzqTI/vDCxGa63Q==
X-Gm-Gg: AfdE7clTv1lStctXe+fWi7HJYK63R4BgIMP5EAkVASLPi6S9xt1NGbT5+EOwH0YuhS7
	jXfiZLbqWMDukOhBfUoraFysod8p8an2cLQKN6HBCXrjQf1BhiriP2/XibLA6RRpKgRZogtM3eC
	5xfUnGPQNIf+L4l9Oi3pK9ZLFlVP3WiHEFEXOkoMyeglgJFrf8Gtn5xbYDm1wEBLaHTLOG+iv0q
	7kfuaETPZiQ1S11IBfekHcYQtlw3uvvXhQwsAbbGkM8y20uRUrdwXIfUh6B0bvJfb1gnDDcyjdM
	OHh1mnHQLMgm6UInNzwtnP/9Fmc9IO2+kpG/ZuDA4dg3HOzaubOgFGWm9NKp57YSxYU01fsjeHK
	2t17flTXZML2L3Bgk2RnUCzeVZpMpZK8vbiIWIJpuxOEUOuj4wmAyHZ2aK8HDS2tvAaG9T3jKGN
	DMswFXbT4daMeEmgk6JsdUq3SiNad3vnZUdMJTqgKD+zn4Hajh7Xk=
X-Received: by 2002:a05:600c:34d1:b0:492:58d6:2565 with SMTP id 5b1f17b1804b1-493fd45f58bmr58666575e9.25.1783930883028;
        Mon, 13 Jul 2026 01:21:23 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm521553025e9.10.2026.07.13.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:21:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:21:18 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	will@kernel.org, tabba@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tracing/remotes: Fix page_va[] access before counter
 update in trace_remote_alloc_buffer()
Message-ID: <alSf_uhS2Gjt14ZO@google.com>
References: <20260713072823.2668323-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713072823.2668323-1-fuad.tabba@linux.dev>

On Mon, Jul 13, 2026 at 08:28:23AM +0100, Fuad Tabba wrote:
> page_va[] is annotated __counted_by(nr_page_va), so nr_page_va must
> cover an index before that element is accessed. The allocation loop
> writes page_va[id] while nr_page_va is still id and increments it only
> afterwards, so every write is one element past the declared count.
> 
> The store is out of bounds with respect to the annotation: a build with
> CONFIG_UBSAN_BOUNDS on a toolchain that honours __counted_by
> (clang >= 20.1, gcc >= 15.1) flags it as an array-index overflow.
> 
> Increment nr_page_va before writing the element it now covers. A failed
> allocation then leaves the slot counted but NULL; the error path frees
> it with free_page(0), which is a no-op.
> 
> Fixes: 96e43537af546 ("tracing: Introduce trace remotes")
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

> ---
> I found this while reviewing Vincent's series [1].
> 
> Applies on top of Vincent's "[PATCH v2 0/3] tracing/remotes: Fix leak in
> trace_remote_alloc_buffer() error path" [2], which fixes the other
> issues in this function.
> 
> [1] https://lore.kernel.org/all/20260710114819.2689386-1-vdonnefort@google.com/
> [2] https://lore.kernel.org/all/20260709160017.1729517-1-vdonnefort@google.com/
> 
>  kernel/trace/trace_remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0f6ef5c36d84e..ef42d9c38b374 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1004,11 +1004,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
>  		desc->nr_cpus++;
>  
>  		for (id = 0; id < nr_pages; id++) {
> +			rb_desc->nr_page_va++;
>  			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
>  			if (!rb_desc->page_va[id])
>  				goto err;
> -
> -			rb_desc->nr_page_va++;
>  		}
>  		rb_desc = __next_ring_buffer_desc(rb_desc);
>  	}
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> prerequisite-patch-id: 8bdd7b28f09e97cff4f5995196b83b377c961d8b
> prerequisite-patch-id: 6781b7ce5156d229fd21a757ef0cd66dd76130cc
> prerequisite-patch-id: 56bcbbdceddf4533770d48d1835d5b7e11f47d56
> -- 
> 2.39.5
> 
