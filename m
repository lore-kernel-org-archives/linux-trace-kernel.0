Received: from out-186.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C73FC5B5
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005920; cv=none; b=F1XHuyPWSvvNsT1Qz5m4haxeQxf5enWOz6yaBoDkuOYmqG4Ps/UDCo/OqpJOW6PlDMQ4isZTeFwYZ8goT4z9dw8kaW2GAkIvUd9Vt+GaQvOobnYbo7Pz9aZAYTkr5qrIfwTzV0b3nWqksc1RqNgsKvpChPsWdWZ9n8OqRnZe1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005920; c=relaxed/simple;
	bh=h6ooHdgjRZHBBwOsjyP2A+6c2LHkGT/fTYtdR1Ur6o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYb0pJ0L424tt0gYhAYrVUD0G7+6g3liU23ljveXnulVr0mxIOMw4KN5KaJ6a6V8xso+18ZirImN0jKmKgONNZuGRQcNE+s7OkEgSMuW5M1z95p5U+ixPGXaV4Np3qRi3DWkpJ9P43c/JstqrPinSHLglC5fc0DAKR8nuaoJ6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qin/QCTS; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qin/QCTS"
X-Forwarded-Encrypted: i=1; AHgh+RqBpeXqfaZ6vCq6DVu/cUW28pmA6ZP7egkpNXYweXB/8TZKRdiRKNj7s1QHeW1rX5/ZjUIC06F+Ef4FZCZ2jO5ArWI=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786005916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ePEtl2m67fNMAuLJ9Afbk/hABXEN6patEcXoPge2F0=;
	b=Qin/QCTSjG4UseQJsTep68RaW4m0a4vfk0Lgv4rl9juo0nd+YiZkhHkz/4OFzt8fw3v9u3
	pLuyIpzjOwAQ5hdGZN9GG3dyyJaJv0dU+tnt6FqXlopXA5NvpsAgWD1egV/bRSWchrgHgl
	ckxKyKRq4td+6AYdKSgusQr6M7l57TM=
X-Gm-Message-State: AOJu0YzJVIqTNw6X3Nfb30KKzC94gcybv2YM2KOQAzgOC+4dBoTLWE7X
	BhiNRjnDTpmoUX16WrzOcpi0WwAVvS7Q7CMzxiJTpjV4qZXqgo97iP8ZXjfA7lFMNSqxrHqu6T/
	Q6qpzPUZc97mVmGBx6ceqnKnxGZxmYTc5Do4DS1nv
X-Received: by 2002:a05:622a:4885:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52cfea4c54fmr11135181cf.13.1786005891634; Thu, 06 Aug 2026
 01:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804112317.1937387-1-fuad.tabba@linux.dev>
 <20260804112317.1937387-2-fuad.tabba@linux.dev> <20260805165432.0118a513@gandalf.local.home>
In-Reply-To: <20260805165432.0118a513@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 6 Aug 2026 09:43:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxZ1tBfau4eK-nOdqig1xwngzsq8YyHtiE-iAMkZpSF8g@mail.gmail.com>
X-Gm-Features: AUfX_mx7LtwidANKMNRCu_ciAI4sGIOLaBR410JmLmjAj3CDd42EszWO5YDN5aw
Message-ID: <CA+EHjTxZ1tBfau4eK-nOdqig1xwngzsq8YyHtiE-iAMkZpSF8g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] tracing: Include linux/types.h in trace_remote_event.h
To: Steven Rostedt <rostedt@goodmis.org>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, alexandru.elisei@arm.com, vdonnefort@google.com, 
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Thanks Steve,

On Wed, 5 Aug 2026 at 21:53, Steven Rostedt <rostedt@goodmis.org> wrote:
...
> > --- a/include/linux/trace_remote_event.h
> > +++ b/include/linux/trace_remote_event.h
> > @@ -3,6 +3,8 @@
> >  #ifndef _LINUX_TRACE_REMOTE_EVENTS_H
> >  #define _LINUX_TRACE_REMOTE_EVENTS_H
> >
> > +#include <linux/types.h>
> > +
> >  struct trace_remote;
> >  struct trace_event_fields;
> >  struct trace_seq;
>
> My ack still stands, but I wonder if we should just not use the include and
> instead s/bool/_Bool/ ?

I'd prefer to keep the include, if you don't mind.

As far as I can tell, apart from the typedef itself, the only headers
built into the kernel that use _Bool as a type are a uapi one and
arch/um's user.h when it's built for the host, neither of which has
bool available, plus what looks like a leftover in bcache_ondisk.h
from when it was uapi.

The include also covers whatever field gets added next.

Happy to switch if you'd still prefer _Bool.

Cheers,
/fuad

>
> -- Steve
