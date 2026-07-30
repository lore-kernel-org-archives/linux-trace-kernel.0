Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1EF43B3DD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419320; cv=none; b=Z7XAhWq4AerM8MYxAn6rh//XY3QntXCSRBcLJVB5hIslDkPoD/HSYxmQkEn2OQ3STLBlVXezv5L/9a6r24UwDnm6M3JqsqXYsfUHy+eKo/H1XirH1Du7d/B+lrVw+qN3vgDEyPpxyngQfEcl1opw1Gip4DYV0rbsc1lMKhalpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419320; c=relaxed/simple;
	bh=VfMZ6NMtQ/ZEGuLShhpxeERJUadr0O85JZ12jMZAvXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp7tGt73SEgSEDiJP5WsdxIG0UOd3+GfyO24corkrVc8F5KHBhmfSEeUW9Uuinygf29+vd9cczmczMsJlu+LkN/zHXLklCIlUMapl8D7RD6zitKYblS+5vkVaImsMABY1u7IbNrzHI0AUlUoosTsZJ7uyCxwKkFpFJaG2sdQnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+85ldr/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+85ldr/"
X-Forwarded-Encrypted: i=1; AHgh+RqoAOW1/ooPcnyDyXKxEpHg+NP4cFgMMb+C81ehDT78ds02flskiZVPH6zAp/ymZ7AL/53MHTFEmhqxA1JIhczc09I=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785419316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPMt+aR9T4Y+jxBcYLYdMo+Qb3zQCW13YSvAT1bAsYk=;
	b=r+85ldr/AjvWKjaqa9HO7glLVa9ifvbQnXYzklAJmi4aj/TR0zbG5bluCLkl40DmG2U++h
	5bx8r5i8QRFqGS3w6m8eAdy1iv/G2eWqrk3lxDWafIiR0eOObnBvr2mVSZW/juIaMOmuiU
	oDqh3LVQiIZ5yA8DY6dC9fmASScmKpc=
X-Gm-Message-State: AOJu0Yw7bqlgQv8FKwLNVaplsgSezxiVQaYzy3oDrX/kWYhnHJ59Cmw1
	qX1je9jrF2tFhWjbLk1o7f+LnPu0KdXrI88zLzRJK6znIidYRk23xMsr5PH06jYJGfcCgeHBOnj
	Tm6YWmTY1ac6HfWuPbG4yUY4svOzvMXAX5JJmkAtZ
X-Received: by 2002:a05:622a:5506:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52b42890329mr1575781cf.10.1785419298935; Thu, 30 Jul 2026
 06:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
 <20260720161343.1367007-10-fuad.tabba@linux.dev> <86jyqcd55u.wl-maz@kernel.org>
In-Reply-To: <86jyqcd55u.wl-maz@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 30 Jul 2026 14:47:42 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwT38rV0DQKW7R0=ZVHvQU0jnvJbjDBqnpmNgu34biuMA@mail.gmail.com>
X-Gm-Features: AUfX_mx9CQmsqra9xcBkaqo79ZBW6DENHL3Zuxa95e-ym6s_uC8W9VwDyVSlgQo
Message-ID: <CA+EHjTwT38rV0DQKW7R0=ZVHvQU0jnvJbjDBqnpmNgu34biuMA@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] KVM: arm64: Type-check hypercall arguments at
 the caller
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com, 
	vdonnefort@google.com, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	ardb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Marc,

On Thu, 30 Jul 2026 at 13:37, Marc Zyngier <maz@kernel.org> wrote:
...
> > +/*
> > + * Generate a typed stub for each declared hypercall. kvm_call_hyp_nvhe()
> > + * resolves to the stub, so a call with the wrong argument count or types
> > + * fails to compile instead of being silently truncated to an SMCCC function
> > + * number and a pile of registers. The stub inlines to the same SMCCC call
> > + * the untyped macro used to make.
> > + */
> > +#define DECLARE_KVM_HOST_HCALL(ret, name, x, ...)                    \
> > +     static __always_inline                                          \
> > +     ret nvhe_hvc_##name(__KVM_HCALL_MAP(x, __KVM_HCALL_DECL, __VA_ARGS__)) \
> > +     {                                                               \
> > +             return (ret)__kvm_call_hyp_nvhe(name,                   \
> > +                     __KVM_HCALL_MAP(x, __KVM_HCALL_ARGS, __VA_ARGS__)); \
> > +     }
>
> One thing I find absolutely horrible is to have to specify the number
> of parameters here. It is already bad to have to comma-separate
> everything, but having to count them is too hard for me ;-).
>
> We already have facilities to count the number of parameters to a
> macro (see the COUNT_ARGS macro). You could make use of it all over
> the place.

Will Deacon mentioned the same thing yesterday (offline). I'll drop it
in v2. The count was only there because the macro that walks the pair
list is a copy of __MAP() in <linux/syscalls.h>, which gets its arity
from the SYSCALL_DEFINEn name. No better reason than that.

COUNT_ARGS() does work here. The list is (type, name) pairs, so it
counts twice the arguments, which the ladder absorbs by being indexed
on list entries:

#define __KVM_HCALL_MAP2(m, t, a, ...) m(t, a)
#define __KVM_HCALL_MAP4(m, t, a, ...) m(t, a), __KVM_HCALL_MAP2(m, __VA_ARGS__)
[...]
#define __KVM_HCALL_MAP12(m, t, a, ...) m(t, a), __KVM_HCALL_MAP10(m,
__VA_ARGS__)
#define __KVM_HCALL_MAP_N(n, m, ...) CONCATENATE(__KVM_HCALL_MAP,
n)(m, __VA_ARGS__)
#define __KVM_HCALL_MAP(m, ...)
__KVM_HCALL_MAP_N(COUNT_ARGS(__VA_ARGS__), m, __VA_ARGS__)

DECLARE_KVM_HOST_HCALL(int, __pkvm_init,
      phys_addr_t, phys, unsigned long, size,
      unsigned long *, per_cpu_base, u32, hyp_va_bits)

That drops 40 hand-written counts from the declarations and 40 from
the handler definitions. __KVM_HCALL_MAP_N() is for the handler side,
which truncates a fixed list of six argument registers, and takes its
count from COUNT_ARGS() as well.

I diffed the preprocessed output before and after: token-identical
apart from the __LINE__ values that shift with the declarations.

Cheers,
/fuad


>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
