Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6126C39E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069756; cv=none; b=Bj1+wkwqImNNN2yJuGp58eDrMRFGwOdF938HsLY+8trUbOtofxfEeHTCgR1FOoFR1LSNRO8tUll6GBGreaM2Y4RKtiPmhB95BkNoP+BPgq1WL2yma52nEQ8wePSOoKZZpoNEDIKtkomZIzZxnUZ6GuzLFeiyqrj0WUfXFWdFM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069756; c=relaxed/simple;
	bh=8A0ajViliK3Xk9CxMhdKP1RnM72/06YSeBi3L9O9P/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqTV3iOG0Vce+e+yqTV6MMhH6GG++p0V5TNeGy6aiXXOr7/C99KlMnC6cVqHbZwo5fV1+nXqP+/670eWRY3Rbog830orSk4x9Za54GpdSQTCXjJTHCm7BqHUi+7N8opr6nHTICQPoITQCdQRZ6b+cPCvQTJOqDHqMxlJOFzN63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpvxHYaG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpvxHYaG"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42bb288c219so4611453f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764069753; x=1764674553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GHs616mr7dTyieWIVUhqR8ZeVc35qwPIJKCi+VXq9s=;
        b=bpvxHYaGpsFVsHwtmdZ+12O+pcMqjLujdibOAuUQ4W+4vDug8zOY4AzPi3Hz19UzbK
         0cFQgXmNdtIa7DRhwRoEO53DmisPk1oVAAcrcyYABVD5300q4Qf+k2+9NI6SHAl4bd0E
         oEhubd4qbWyMFS3vgd92jQPqZC1jt0qsasHZIUNFwbv9qdBG5UXhWx9q5Wcd2YB/Tejp
         wYwTz1hyORiNZziuV7ze2uyCqDGgZKt96P+fMvIfQIMc+Y4y3MiJ7ej7JnDaCHiTa+Bm
         05p7/B8omA/ymz4uvs1qAkQtI8pTzth5IvzhEKfwwTDabAwP08og+BH+RbjoaZiIt2PO
         +Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764069753; x=1764674553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GHs616mr7dTyieWIVUhqR8ZeVc35qwPIJKCi+VXq9s=;
        b=QnXAv0HzSaBOc7rL/EEuZg1jWr+yU9eh7BH+ifkFCQZh50LQSzeG30TY3+V/dDCqra
         cckqSKLehA0siZ8L18jrEmOFjrmMhe3P/PGjOv3qEnwQLbGZtWpGdXqAtga5CK66X/EJ
         awHuxHSlcUp9z5RiqhfvZfw7BXfWKssZDjuTtMjByvyu8fxH/wd2rRdYr7V7SBLwJS0u
         eHGgfa8c8lF7obb7VNry1PPHjDWZj6iscv4/hJlRHy4ur2LSj5apfkykqaS4mB4HLCta
         694OTHtiRiOT3tYOrSLYkHfaUZxu8ttJQGPQI28ebRXxhHvFOfNbfgxyD6GOYMFU3JnS
         IQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlLUYbzAkjyEpIuquNW3YYgz7MZsPhA/1nxz9V+SBuFLGFeKtlx9qyskZbSBzOIBvbQ15Yt4krkoBDho5rQe281os=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuzpyJNths+sHdJfCVCrFQ60lGqMjyBB24jtYr1GyJpyF393w
	3Gw06Yl0D7kf9vxHvmOAgZWLNNNqelt4WZs7+xb/k2vBfRjM9KuNb6ckSOQyCg7KKQ==
X-Gm-Gg: ASbGncv8AERMJOsbXSpTTCPCvmiussm5wvmOuYHhENBGD5xIz+i2YrM6yBieT6LsvBn
	cZ7IZwwuGFmympAo852ePEInnQuQ3UsPvKlp0xQOpaLGnyVVV82vV29VFB08ZZIlOXg6UxrkZu5
	PAGBQ+yk9fTg/TrRBoNVO88pzhZ7yG/kSVzcGnDhzQDpthf7yTKMp793RXXP1KmL4yWtmU3YzrE
	/JX557TG4X50MVQez4LHWir5z9/u8WyHxzz0GpVqmfwYIQturZ0KkqsHquuboammKqKVgftpy8w
	IGxq/XlRYdQ53Op5o0PVtDOLYAWtA/Bwyn+GZv/QtxrKHK6ijl1VaE8H7GjHT57ca1q5tiVXa3m
	tahPZ18HJsYUSM0TuhUANrYM26u9pO1gL8TAwN3vMsMpPA0k/fT/9HQBcTZTbALu4k0eJlMx/eM
	v2wUGdzNXFKbFfGja/QwAD6GazzOG3YodaX2uhq/wV/RrbhgZm6w==
X-Google-Smtp-Source: AGHT+IGTMkYeA9p+ckKB04IyPeZJ4YUR/HSDsAZGnoL2ifU24s5TxikwdtgZkZDiTjUCKMsk8yADHg==
X-Received: by 2002:a5d:5f94:0:b0:42b:3b55:8917 with SMTP id ffacd0b85a97d-42cc1d0cd7dmr15814872f8f.36.1764069752552;
        Tue, 25 Nov 2025 03:22:32 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm33172639f8f.4.2025.11.25.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:22:32 -0800 (PST)
Date: Tue, 25 Nov 2025 11:22:29 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 21/28] KVM: arm64: Add tracing capability for the pKVM
 hyp
Message-ID: <aSWRdSELuYpAXCM8@google.com>
References: <20251107093840.3779150-1-vdonnefort@google.com>
 <20251107093840.3779150-22-vdonnefort@google.com>
 <86bjkyrly9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjkyrly9.wl-maz@kernel.org>

[...]

> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index f55a9a17d38f..504c3b9caef8 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -29,7 +29,7 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
> >  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
> >  hyp-obj-y += ../../../kernel/smccc-call.o
> >  hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
> > -hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o
> > +hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o trace.o ../../../../../kernel/trace/simple_ring_buffer.o
> 
> Can we get something less awful here? Surely there is a way to get an
> absolute path from the kbuild infrastructure? $(objtree) springs to
> mind...

Because of the path substitution below, I can't simply use $(objtree) here. I
suppose that's why all other paths above are relative.

However, I could probably simplify by including simple_ring_buffer.c into trace.c:

  diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
  -hyp-obj-$(CONFIG_TRACING) += clock.o trace.o ../../../../../kernel/trace/simple_ring_buffer.o
  +hyp-obj-$(CONFIG_TRACING) += clock.o trace.o
   hyp-obj-y += $(lib-objs)
   
  +# Path to simple_ring_buffer.c
  +CFLAGS_trace.nvhe.o += -I$(objtree)/kernel/trace/
  +
  
  
  diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
  -#include <linux/simple_ring_buffer.h>
  +#include "simple_ring_buffer.c"

> 
> >  hyp-obj-y += $(lib-objs)
> >  
> >  ##
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c

[...]
