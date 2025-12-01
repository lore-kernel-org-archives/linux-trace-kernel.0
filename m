Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437030B53B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605055; cv=none; b=fBHx/9+o36S7jaJ6V6/9VQfmCYChQiYda4jDe3ROyVLzBjdeeCCCVxFG1fAgob68iGA5hJTe9lcuXIrt/0xs5UTKb50nMc4n5mvNKdtb2gRkSPE2py9Cs1+uUEG9JrSs6GvR6f9yuoUmCvfR1sJXqBYQvwp3WFyDKhNK0txSVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605055; c=relaxed/simple;
	bh=Z2YOr5kYk9GxOy65Jpo9uyk4Ob8LGIIPugQHeveeqto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP6WgwsQ2uFVCoNWD6W5pTxubzW1NFR2XM/sO9XJFDj7nVVRYCmvf6JvbKO1RNwTrcCb60bPtOarBWo60aOWzXVKKtBEPVcplWjW8Rwy7s0KfCcWhZaEbqYTJapR4EMElN4naE8K6br/3Z7r/P18N9/6VFsv5U1aHXOqlO92YPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYDdi4Wb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYDdi4Wb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so1140969e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764605052; x=1765209852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9hMtV3PXrMhCjLem0M5KT+SZ8RXBResg7Pv80Fl+Ng=;
        b=CYDdi4Wb3ba5hX34N01p83gKLJQEA72a23rdSC/iXQwFIiMSzhT9cx7gnR7MTOnm+b
         xjvzw/qSn7IDnfVSlGiN9EFVXGE1B+9NXAu5N95CnDA45t/5jnsRLzrhQS/a+SawgjsD
         mIn12wFQ9TyXw8nMNyfsRLxTRRvWXnD2BhPYtANfm821onh0Lx9btcHFxnaAP+PeEs+9
         txxZhwnvVqFRvH3YlSFxQ4leNQqpbpSzo1nHBXJTkhcdqPfrpgwo2LTKabVhA0ICOLf+
         RrNQkjAUkSDApBUi+QvnamO8J0sQXROaRzGTrw4Z/qACkxeBsVBXjWi7v68QbzzLrSPG
         dCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764605052; x=1765209852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9hMtV3PXrMhCjLem0M5KT+SZ8RXBResg7Pv80Fl+Ng=;
        b=MSnOD8kpcZjwzsy7BXY0m+tXJ6fPQMk6cEDEPlm+NT11FuwEBRA0wzr5J2U5GD9kFv
         pOMRZegebX5M1qK5oEpw4V+dDtfIwKui+E76htF/0t1vk42zRV6mUeQCJQYdBbsxE3q9
         M9Sj1V3YoW35xfqqkWbHYopydOKvlvN0yK8KCDkCrxCl0tmcLaBziWKtooXiZ6LH/0AP
         x1jOb8pi831FZD6S1lBupe3rpZRClGAhwSru4YTBljeIY4z25QHahcGReeHnxVtrDgkV
         4s705hxqMmVbnziO3VnSGYpMeOiTgypoh7f5IpyV9BwjjIymn+sjurk6LQYpoOqWdeCr
         mZeA==
X-Forwarded-Encrypted: i=1; AJvYcCWOXa7yWeESdXXSzL67VwswYSWD/6d39a1HoAj7DiKdNjc9iVlKfFAQHw1t5iFas4LMt6Uws+BSGlAgj4m5dUCJ+5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPetYYB6pwXoBHPXjmHcbRnK+DalcRz3/fnaXQLPgRX39wNF/c
	OnO/o6K2gfaBOkpscBM1LPoKBBiyMOoOt76iw69Nymj+sGO7fPFXmZszRaztjCHJlw==
X-Gm-Gg: ASbGncv2Dhb1/jRpHWi8k3TPa92NHsrEY9ivJwOWuwxe9stFCFnkMLvrKrpM4DhJdDJ
	7G8KK0QnAf8KHvI+iXfHjwbx5YUXskrGOKp/w8O3B4hwZB1e3A6NFRvk9K+ppAXGsGKY++AloDd
	fER0gY5HIDq3/oymvPy1E7s6+xAJ5Egp8tBQG+kjukYsz5eJ/uMVkxotjT/ljhmJxBuKHVbcD7O
	KWp48D9iFcarpWIPBrkcFTOL/Xxk2CHp6YEH6HD8RHUl0s8IjAoPV2IMtQZp/00ZAcz/SUgGWbf
	hAj0plm37enBJG3Bc7K8kenlUk6JRVnLx1sre4GQmUpKQJoRhy4JczIM7UvKgCvodsZ9Z+L8hng
	oBQQeMc6hdx5uG3AlvwyM2oCj2guraf2adgsRph1PfEA71L5d445mEeuP/sP7pcIRFsuy1dOLdL
	XxhXlowGJ2FS7lcOtcLB4TNZPMBMWY+KhU7u7w5w2GgCY+T6oVrA==
X-Google-Smtp-Source: AGHT+IGwL72Aeg7rfy2TscsPc6xQDUxQw9XmpdcK/OUqxD4opRrcqN2Rq5mq6/N45bshnzXhV6B/iw==
X-Received: by 2002:a05:6512:1595:b0:595:831d:22eb with SMTP id 2adb3069b0e04-596a3e9fda1mr14183062e87.1.1764605051684;
        Mon, 01 Dec 2025 08:04:11 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa48c90sm3661068e87.80.2025.12.01.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:04:11 -0800 (PST)
Date: Mon, 1 Dec 2025 16:04:07 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 26/28] KVM: arm64: Add hyp_enter/hyp_exit events to
 pKVM hyp
Message-ID: <aS28dyrKgZaOmMNr@google.com>
References: <20251107093840.3779150-1-vdonnefort@google.com>
 <20251107093840.3779150-27-vdonnefort@google.com>
 <87345vfiqj.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87345vfiqj.wl-maz@kernel.org>

On Sun, Nov 30, 2025 at 07:00:52PM +0000, Marc Zyngier wrote:
> On Fri, 07 Nov 2025 09:38:38 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > The hyp_enter and hyp_exit events are logged by the hypervisor any time
> > it is entered and exited.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
> > index d6e033c96c52..ce3953bc884a 100644
> > --- a/arch/arm64/include/asm/kvm_hypevents.h
> > +++ b/arch/arm64/include/asm/kvm_hypevents.h
> > @@ -7,4 +7,21 @@
> >  #include <nvhe/trace.h>
> >  #endif
> >  
> > +HYP_EVENT(hyp_enter,
> > +	HE_PROTO(void),
> > +	HE_STRUCT(
> > +	),
> > +	HE_ASSIGN(
> > +	),
> > +	HE_PRINTK()
> > +);
> > +
> > +HYP_EVENT(hyp_exit,
> > +	HE_PROTO(void),
> > +	HE_STRUCT(
> > +	),
> > +	HE_ASSIGN(
> > +	),
> > +	HE_PRINTK()
> > +);
> >  #endif
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
> > new file mode 100644
> > index 000000000000..4b69d33e4f2d
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <asm/kvm_hypevents.h>
> > +
> > +#include <linux/arm-smccc.h>
> > +
> > +#undef arm_smccc_1_1_smc
> > +#define arm_smccc_1_1_smc(...)					\
> > +	do {							\
> > +		trace_hyp_exit();				\
> > +		__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__);	\
> > +		trace_hyp_enter();				\
> > +	} while (0)
> 
> Huh. No, please. Don't override existing kernel constructs behind
> everybody's back. I know that tracing folks love to play that sort of
> game, but I really don't want any of that here.

And you haven't seen what I had for arm_smccc_1_2_smc()

> 
> Just define a wrapper that is KVM-specific, and use that.
> 
> Then from a semantic perspective, an SMC call, an ERET back to EL1
> host, and an ERET back to EL1 guest are all very different events that
> you lump under the "exit" category. That's not right. Same thing for
> "enter".

The idea of those events is just to know when we enter and exit the hypervisor,
purely from a timing point of view. In ACK, we already have other separated
events that can give the "cause" for entering or exiting the hypervisor. I
haven't added them to that series because I thought it was big enough.

So happy to add now or do a follow-up, once we're done with that one?

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.
