Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06232E154
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170481; cv=none; b=Q078VijxbeK4UmIF4NqHuRIzK7ugBi3/CxuRn4aKuXwwGgqlqFZBKhOCdY1QHGROAl1VsO+5ZvjAqs/14Y9Ukel0htuE/1jdHKMUsAe450K+OmHxhuatT3anHKtXqrQMdX+yL4j2g3DiSmR9W+rT2qvJvqF5kom915qjDpvilGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170481; c=relaxed/simple;
	bh=Ce9T3W4m6/vcOQUXLPphIZlsQw/xgJGwy4YRYY0Co0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLzYJx6YmiAiB9MtlXvJBOx7FD3bZUPhI0HSF5vJx5Di6wv7WsT1zsHVjawemcUQ+2vseCxe8PRpmeDeooMdsHuc5RwD2uxypa3XRAkUF9zjfmWWpEq+c6JZlPHugl75j00utoLqAV4xrF82exDwvmE1CzfG0oeXLyywRXoErNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6m5qxWZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6m5qxWZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso276254866b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 04:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769170478; x=1769775278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TjQY4k+dQBxbGIX17/gmMMohp7SpaOH5R0C6AKyoiw=;
        b=N6m5qxWZd4WidA8gEB+kDerXT74yVFT1zRjYV1yy6STzLHOiys0VNE0wDHKx5gOogJ
         MvhqnQLIuOJkBjzFYafrwIr9wXPlWsUod6QIKyfX+HiOr30E5Am6uYCnHfEFTstZTZ9g
         BLCKI3GsAA44zKkJm3N4+EoAvOsI9/r18/sXVSLp5m5JebcdUpwUt6qjyOtWEY20fU8b
         1A4vwwrxsJbbGXxUwewvDvUt4Ebc8SI7Mn258/FVkvpsGCLbiS09rw2hzcDykaju5tdn
         g65LaggGdZpjfcJ8kkOjigH4bF7AM/Z8bnoAr8aAOqFr3opCPB4OjAlndJsC1ilXMX07
         t20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170478; x=1769775278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TjQY4k+dQBxbGIX17/gmMMohp7SpaOH5R0C6AKyoiw=;
        b=t+DKK7slaam6QgWPkxhMnwlOV3NWbAOA7MSEhUVGkbtaDlKphFFIqLUr1xPD4CJtNj
         +gBBsiji1TjXdSx55oYbwhTXLrQBH61FCv6/kFiCL1erHS5OJw2SdYU2k2e8ZOaAvHnz
         nAFjPEGYTLQBhR29YH+fA8VWOoAWRTUOrpx6UrE+WN5mIeIhJebS/PC9mC2K+YMeuLHk
         m4kuTxgwa59NvRgjj85do0a5+gT/oHgXH65ZUHEJmjBWaJ/6V6p0O3HHVp6oakXm/37E
         VGAqDl6gGTW0czKdFIpN+aRVBOc+iERuZky3mbtsgvAqTn8BmusJR2/S2mvHdV0RrQdq
         Wq+g==
X-Forwarded-Encrypted: i=1; AJvYcCXh0YN3G1X3wfGXBjxbPhYghsYxT7I0tin1/xEGdq9Ec5ZWoq6xCcnV72xhk6jwykmVKg0ZKnN8mIL3ZwHEsPYey0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Rs9Qr4T9a6vaFrVQccy0sKzVeqX4nhkozP5k/H2F9i2tT20q
	M7L2b3mTGC18Wr6OUs0gcTiBJDYPHSzynN7uh2Yizczw0qaMwWdzf35cXYBKNQsOJQ==
X-Gm-Gg: AZuq6aKV0YdC74h4BdidAKkbmYL9fmdygCuU3SSXaFQNPY3fQawyyEP7nrFas5qD4Rf
	HF86Ph2hRRraIHrwlsjTAYdUOQSUqKM0a7F0qLtiuRum9SfCepGKQCpCa6Q3FnTN7bS4hYobh6b
	A/OlgCjUTcjzm0RVQk8xzztzem3NNVnCnS3xHY/nxMQ1IrJ4hN7tqrXRPHkcIY0NevD2q4TPL+b
	Ot70IF9Qzy1WMfZhXZ4G0MGBwV3cIXGs/CRe9mHErA7sRs/HEG+lRB4zAgiY+YyBYYTuSHef6i2
	p0C6lUGk/Je6mhNlMPkPtWe+6hRGRiNUEpIts815gGTd86BuCbUzrvsNzFzuz/mBbLUxiseJ1Gq
	8C+B1/V4kURCyDRs9BpBHWc144h7txRMQjr5aeQnsIjGzBNtMDmmKNMeJ2iK0ie3mg2xJexJNAC
	0bYptNZFlrWarICD/MMGrL0yDsTcsXH6H6yYIlk5N1VLVvw4TOnA==
X-Received: by 2002:a17:907:2d20:b0:b73:544d:b963 with SMTP id a640c23a62f3a-b885abea126mr190175566b.13.1769170477880;
        Fri, 23 Jan 2026 04:14:37 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff08csm99028966b.43.2026.01.23.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:14:37 -0800 (PST)
Date: Fri, 23 Jan 2026 12:14:34 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 29/30] KVM: arm64: Add selftest event support to
 nVHE/pKVM hyp
Message-ID: <aXNmKpHqVw93BegX@google.com>
References: <20251202093623.2337860-1-vdonnefort@google.com>
 <20251202093623.2337860-30-vdonnefort@google.com>
 <868qe9mnx5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868qe9mnx5.wl-maz@kernel.org>

On Wed, Jan 07, 2026 at 03:40:22PM +0000, Marc Zyngier wrote:
> On Tue, 02 Dec 2025 09:36:22 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > Add a selftest event that can be triggered from a `write_event` tracefs
> > file. This intends to be used by trace remote selftests.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 37c015b54ff6..e2de7ad64938 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -96,6 +96,7 @@ enum __kvm_host_smccc_func {
> >  	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
> >  	__KVM_HOST_SMCCC_FUNC___tracing_reset,
> >  	__KVM_HOST_SMCCC_FUNC___tracing_enable_event,
> > +	__KVM_HOST_SMCCC_FUNC___tracing_write_event,
> >  };
> >  
> >  #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
> > diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
> > index 268b3cd7a1b2..c276fd28e0bf 100644
> > --- a/arch/arm64/include/asm/kvm_hypevents.h
> > +++ b/arch/arm64/include/asm/kvm_hypevents.h
> > @@ -42,4 +42,15 @@ HYP_EVENT(hyp_exit,
> >  	),
> >  	HE_PRINTK("reason=%s", __hyp_enter_exit_reason_str(__entry->reason))
> >  );
> > +
> > +HYP_EVENT(selftest,
> > +	HE_PROTO(u64 id),
> > +	HE_STRUCT(
> > +		he_field(u64, id)
> > +	),
> > +	HE_ASSIGN(
> > +		__entry->id = id;
> > +	),
> > +	RE_PRINTK("id=%llu", __entry->id)
> 
> Not strictly related to this patch, but I find that the trace itself
> lacks context. For example:
> 
> [001]	  323.847422: hyp_enter reason=hvc
> [001]	  323.847423: hyp_exit reason=eret_host
> [001]	  323.847688: hyp_enter reason=hvc
> [001]	  323.847688: hyp_exit reason=eret_host
> [001]	  323.847706: hyp_enter reason=hvc
> [001]	  323.847707: hyp_exit reason=eret_host
> [001]	  323.847722: hyp_enter reason=hvc
> [001]	  323.847723: hyp_exit reason=eret_host
> 
> That's all fine as long as I'm dealing with a single guest, or even
> with a single vcpu. Trying to trace multiple guests, or even multiple
> vcpus makes the whole thing completely unusable, because I have no
> idea what I'm looking at.
> 
> To make this useful, having some context provided by the host really
> is required.

I could add to the event header the VM pid related to the currently loaded vCPU
(if any). I can access it easily with host_kvm->userspace_pid. WDYS?

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
