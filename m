Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89D333733
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641672; cv=none; b=trI0vHbC4Sstlz/FvhGPaB2kWUkmagH2X/3A+5PJYLCePrg+7UUdCY34BwzppQln6ZlxIYV0EP9g07/JQzKyt8YXbCO042wtdm+6GSym2znliZ1sw/p/rQeDPR+4jTTkn3dAWkFy2Pfakc0Y2L6gSckhQLLfZSverKq4RIVcdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641672; c=relaxed/simple;
	bh=L10GaSAQJIrnyis8mGo7hQR+sdFEFFQeWaeqDypnHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1YkSTROU92WeFqGbGcuqeeTLLjMy3vz6SeoOk2uXBdcCy7rWPYFWS+6mHPklN3Bkpq0BEiWzL+UyGCo6wdEyfuCiq7m4UjngrdBRL2YDPe/bMaGYCZx8WTT0G3ZYMqFFluqcvo/kyWXg3H1ds6skZdry4+R+/f6TvPuGyJ7LIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXGUVx9M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXGUVx9M"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477770019e4so8169315e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 04:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763641667; x=1764246467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HhtSTqCGLLrH7sfkvwPKz4oo0QSbD9ECCA73kZYpvQ=;
        b=ZXGUVx9MT7XM68n29bFrSaVrIae2YlM2SVMuyTWl1YpdC9oF8+4x5JeJzw1LVJv2Ov
         x9DsXQuA98j10wj75dsKM8KAX++KlsnRybXKxKt8AabvfmlvyGjEt7s/RtVRRdf1c7sA
         j5ZdbzWSqflKfP77x1W9AN4RU2LBBKbtLLEr+kaZTU1F4oabU4tRtBfg3GgM7ZAeJ+JM
         20W1n8y40AvLzmEr89tvL8fnp+DrqtO7X6uFn/KL9qYvWy0dQF1VFoMptU+MsZJbePp1
         zJSShftEUwlt0PgZ60Lcq1+8QvO7BU1phJmBJcPPkFky7Vl1ZFmaHlvS93MoGEut92Ec
         f/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763641667; x=1764246467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HhtSTqCGLLrH7sfkvwPKz4oo0QSbD9ECCA73kZYpvQ=;
        b=CkN3tSjhbs+1bimEsuHkO2mJHDxrKljm0YwphwxlO+pPf9a7aU3TvelQcqbYdYLSur
         1k7IUr2v4L++DaILmNLKGjpHletXE0nT+hHlwp0npNjm6AVH/XrQ3ATjdF2GbyancUnv
         Ij6wYC+G6eKisZjAFLuY0bcgsBBo12QIGqIfEg3o8Iy/L0G8PP6E3aRmUsUFYXo7liQp
         hAg1uhM2G7PyvQuEhiZ/uNVF1jAhFA7uQCfXkNm0J8JQCw2z7t162+gl4tpL5VLzDMLo
         iIO8pIZLHHz1rjTaFhoIalreMke2SXAMOT9Bmy92T40LSzrZtXwbZEpTt0oDsOu6VQuA
         ZqTA==
X-Forwarded-Encrypted: i=1; AJvYcCVSrp2KWisWpIWryjxoZI/ocFVP4mG2dsKXqel3R4x3iRBLVF1mVA4IBPw0EITe5pkuP/P9IV/4emOw/g9DpcevNM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjlx2fPujchTA7tAGt/pRCbzU5n42QZvcEuy7PHE1teXMPDVl
	0jDHMyFIqvqprq1RIr4B224WA+WGlJUpBOqg5m2afIoMA/BMZp3+2hdb3+boUuJFeg==
X-Gm-Gg: ASbGncuZgP6RqwE12qjvS6a7BzhHYTigqZ2kHrDIZT1hkxtEtJBTrhpu9wlh9QVx8pB
	oljRpTp63in8UG6RU/hXTNmCqhNWmfruIURvyBhRJTFuB6bpecb2gRkqI3CAts1pvvPNKIp2WuD
	hBCen8rsGYQn0ZR4xarfeFpviPSHww5s+XHYGfebi+k5PqSXVsyuq93pLJN9C2YWOd2bfuM1mAG
	0NyFrMYu27Jios41O0nm9oPM0CCMJx90DUNl+Hul6ToE5qTFSSvZpOEUMAnPlX5Pn61JAVdR6KR
	uadatta9rvOs8Zik8XkZ/YPddO7ecUCngMOgeVmB9i8+/rNXDXPRQhmK7fxOO4/QiRMIjksSXwX
	VUKEtBB8P93R6h0805mxigLUMh3GCQwaCzdECIIAJnt0UHhlnLNVbK4HRGvXcdAgwpvo1JGc6rP
	JeDwxCKmNbotVpn3imke50CZ+7g5mvVevZNMXK6inQxGft4jJbgg==
X-Google-Smtp-Source: AGHT+IHpeFeIGGZiJTmXFsR+6beF5U9qh+UXPfFDdc/PMj/YV98aLC84HYj/PIpbhK9tkAcu44ljjQ==
X-Received: by 2002:a05:600c:4e8f:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-477b8a511d8mr26758955e9.8.1763641667024;
        Thu, 20 Nov 2025 04:27:47 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dbec2bsm64229035e9.5.2025.11.20.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:27:46 -0800 (PST)
Date: Thu, 20 Nov 2025 12:27:43 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 22/28] KVM: arm64: Add trace remote for the pKVM hyp
Message-ID: <aR8JPxRHg7vEOME4@google.com>
References: <20251107093840.3779150-1-vdonnefort@google.com>
 <20251107093840.3779150-23-vdonnefort@google.com>
 <86a50irkst.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a50irkst.wl-maz@kernel.org>

On Wed, Nov 19, 2025 at 05:31:30PM +0000, Marc Zyngier wrote:
> On Fri, 07 Nov 2025 09:38:34 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > When running with KVM protected mode, the hypervisor is able to generate
> > events into tracefs compatible ring-buffers. Create a trace remote so
> > the kernel can read those buffers.
> > 
> > This currently doesn't provide any event support which will come later.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 580426cdbe77..64db254f0448 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -87,6 +87,7 @@ config PKVM_TRACING
> >  	bool
> >  	depends on KVM
> >  	depends on TRACING
> > +	select TRACE_REMOTE
> >  	select SIMPLE_RING_BUFFER
> >  	default y
> >

[...]

> > +static void hyp_trace_buffer_free_bpages_backing(struct hyp_trace_buffer *trace_buffer)
> > +{
> > +	free_pages_exact((void *)trace_buffer->desc->bpages_backing_start,
> > +			 trace_buffer->desc->bpages_backing_size);
> > +}
> > +
> > +static int __load_page(unsigned long va)
> > +{
> > +	return kvm_call_hyp_nvhe(__pkvm_host_share_hyp, virt_to_pfn((void *)va), 1);
> > +}
> 
> I struggle a bit with the nomenclature here. Why is that called
> "load"? Surely this is a "map" operation, right? Is that because this
> is called at "vcpu load" time? Something else?

I called "load" the operation of getting the tracing buffer ready. But for this
implementation specific part, I can use map/unmap here. (same for
hyp_trace_buffer_map_pages/hyp_trace_buffer_map_pages)

> 
> Also, how is this working without pKVM, in a normal nVHE environment?
> Being able to trace in nVHE is a basic requirement, and I don't see
> how this works here.

I can probably make it work with nVHE as well.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
