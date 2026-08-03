Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B4376A00
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753199; cv=none; b=SPo6gyJWpAZdMCHfgFxwWaarPByxbLgRNqGWIOPQFZVAmZdk6lS7CiRJkXaJNZGuAK97ROGGZuYYA/7UDyqgatkq4aRHh3pelHE6OZllmE8KtDyUQr92gfoalOHSgP2lS7wBPIdSxHEkt+CcQ/PMSSUb9h+sJVtUi+0zJXOwWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753199; c=relaxed/simple;
	bh=mQbaH5tI+IruZWucS8AJeU4qoJiDpkOvFU79qqUCJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2FYomL1eBAFuk/0m1yW70BDHbq2/XMtXu/1dswS+rpMRmtSmfMX6A8Xfs4FLt9dP48Bs08c61AdCzcMDgBSIjCwW3ZwoHVvNC9FdT/U1JqAWjJQElffacbYI5d+YrVM4TXboTPN1w4itPEl/ZsiZ+W+D4QcvBpPGIGpjTjE8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUNLPHTy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUNLPHTy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fdb6f7d72so633126f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785753196; x=1786357996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kW6C1+4rNhE+0PMn+ucH4K3CUSEGpMH1odrzmczVGFM=;
        b=eUNLPHTyle+K1jy6YnXFv/hWDuBZ3SXmPt6m2LD0zF+9vQf64wwU4KPvn+O7IQ61Tl
         8ed/F9ueqZM3OliXxw7Xefun2aPnjR3NpVXeapvFjrOHuclosOS9r7aQHAtrA/QMOig6
         COyzHH50HolnbSSQbJT1eYT2Z8yOne6J/3fw97UoazsEQGxMbO6XJPI29SKR0EuCVyuq
         KDUN2ur/rla8J4DaxEyqleuycs9lBRYzACYrmVVLWHz1kZrmdxLBSHxXtE/AGXEtYiY5
         ZMf0LFoWcep8X7t5FcNONuI/5wtak+Soox8Iy1300hM99iWSyndQyq56QnZAEnUHdeo1
         bZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753196; x=1786357996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kW6C1+4rNhE+0PMn+ucH4K3CUSEGpMH1odrzmczVGFM=;
        b=sZON4j4xpNwHEC2Ye3ElspeQJpIrwi90U8MxtPxzLdcDFQbQz+RRSANiZnQK4sAYlm
         LRik2dr4JafKaFc58lpuRIc4edqBvl9GVDZ5lalq7k2dHWnThDgVUWjopWF6EXfksnNe
         KsTWm/vvrC3Z/myOHPf3uLuAe+YOFGLzFOTY40RM+27pQ5FP3IfkFdmWKAcVmGhrxA2R
         iE42R1wRk9LK42NJTjhA0JkFHIdBiFZ84fOKs0n6KQsV6jF4Y26YIQOq3xbmrvQCJ6gc
         SA4dUGE8ySsElf438UtnHoZ/uQnAThmIP4GYg/Zcvwa5UJ0DzICDM4cA9b29wc73h3xl
         HK5w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1uWCsl6uV/gnAYZ3TM/KcvGTonXOx/JvNSDAyOOLacUMfu4VPwIcehpPiedDbfi3D3yPyBvixjFq+tFqzqrqjPQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcd3Xb0L0rJurB1UfMmJ302qWawTnmR4rYP9Ws00JkmOfGLMY
	wFX/G+aPqXZb7Y+f8VyIfRpLZ0iBIkw99Ay3+5zPZT1qTAxAyftJXZEwKd4Vs95lHQ==
X-Gm-Gg: AR+sD11+5tcz8zQU5gbACmQj+HOfGncTqeE6+wI4bAyPW3BXrTXTuAtatOdAcAR1bI1
	NzK5yT6qa61gTQnBHh1TKEoxng22qUKyLo8ko8AmI+IEgBSNYJZNJVbrDhrIpKGd63b3bVKc/Rg
	r9gWwzRq+qZKdVtUCFBLt9o1kFTiUUvORjOQ6iVV1OA8pIWeuAC2ou8yOJsAkbMEL41rtzb0Lnm
	yBE+SvT27ngNG+aY0g9oWaovvcA8VG8E7hkEPxf7/P5LLg8CCOiebgfb2D4L4Dpm9W+4Vj4Rh65
	49SW0kack+91ejmnA3MRGhfgnU5uaWkIEZ/5rumIsxT1EcZ58pG07kxRt1I6yvpuSenQuAyMxpm
	i9rqEMBnaPhXAcdJut+kOgXERFGAqFcPK+pTBle3lfZ2+83HC3IELGXxsp7m31pE8f60iZzzU/X
	L0cmbACTueMKXv7nA7aaIfi0bVXeb3jQVn2Vdiz86V/imSDvkWLSTijwO6pE8h7C/7paaaFLNHi
	+A2ZoW128Ule68RARDqux9AJI3kyQJFxVZv4KPu3mVh
X-Received: by 2002:a05:600c:8711:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4980c652515mr253557695e9.11.1785753195960;
        Mon, 03 Aug 2026 03:33:15 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm209718545e9.6.2026.08.03.03.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:33:15 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:33:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	tabba@google.com
Subject: Re: [PATCH v1 03/11] KVM: arm64: nVHE: Declare the hyp event IDs
 before defining them
Message-ID: <anBuZwkjDQKRKVlr@google.com>
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
 <20260720161343.1367007-4-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720161343.1367007-4-fuad.tabba@linux.dev>

On Mon, Jul 20, 2026 at 05:13:35PM +0100, Fuad Tabba wrote:
> The defining expansion of HYP_EVENT() in events.c is the first time
> its translation unit meets hyp_event_id_<name>, so sparse suggests
> making the symbols static. Include kvm_hypevents.h ahead of
> define_events.h so the extern declarations come first, as with the
> tracepoint headers.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/events.c b/arch/arm64/kvm/hyp/nvhe/events.c
> index add9383aadb5a..b845be0acd117 100644
> --- a/arch/arm64/kvm/hyp/nvhe/events.c
> +++ b/arch/arm64/kvm/hyp/nvhe/events.c
> @@ -7,6 +7,8 @@
>  #include <nvhe/mm.h>
>  #include <nvhe/trace.h>
>  
> +#include <asm/kvm_hypevents.h>
> +
>  #include <nvhe/define_events.h>
>  
>  int __tracing_enable_event(unsigned short id, bool enable)
> -- 
> 2.39.5
> 

-- 
Vincent
