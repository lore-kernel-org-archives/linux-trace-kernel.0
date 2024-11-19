Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A61E4BE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979620; cv=none; b=pyyP7V3Y79w2ETLL5zVVZvTUGQA5TvfgBcCKuSYdhcpjp1jbZZgpFgfdKNlJM26439D/Kztdq2WDY8ix0y2GIeM2thREzPzip1t/EeCrdwgLGMBUTDPtiuj7ew7xEY22rO7ZxQhGDErFPyxkwOg6QbCmDwsZU31RtLnyB/0hgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979620; c=relaxed/simple;
	bh=P+FMUkipyIhk9DsYbQ6EHACmcKLCrVp0ZaM4Ce+XRRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbxFSZ0471gtLmP60ncZ+8ECBuGgZRe0ZakpN8RJU176T9YmVhULcLwSnuvsiYZiy2N/RWFHdaGDfMglOrwz6PfvAoJdn4i1zdno5sdlowVSYjhmzKacGwG4/W1ZOi68CQb3JtRtXNXOLgq8xa29j5yLJMqdd+KZPfvQBHF+S8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tOsp1xl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tOsp1xl"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ee93382f3aso18175007b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979618; x=1732584418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+FMUkipyIhk9DsYbQ6EHACmcKLCrVp0ZaM4Ce+XRRQ=;
        b=4tOsp1xlevN9/mBcy6CHUwq/MJYNvfUwl7fLpm1gTicRuEqINMsCYgn9AtF5nfViLl
         bSjIo0gpOaU1mH2Btb+3MyddfY4DCGwQmVLSN/2b74bux3i2nwD4YzLjmxe7x3G+C+oY
         vEznwRVTn/ZV6eKLNFV1tgW8F4yKkdLILlas4B1uVzobRkvTZWBAnslDXuz+Ky/BTmmm
         GYuYxK+a+jqh+eF5u3d8wQgYAL8MU57hN6AodXePRmc+vwCFPpCqBx6Th/QJrb95ykPr
         IexRuK2Jt0jg+CwHQbArKyrtrRswwp2/F7i7QgMEwblbfXFPBWE3cQAPG0YMJLOVhf8l
         oezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979618; x=1732584418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+FMUkipyIhk9DsYbQ6EHACmcKLCrVp0ZaM4Ce+XRRQ=;
        b=v+sLnSlmpNcTwkaEgYngWstn+Ou33VRFIZG+ubHf7qnB5qOi98lK2SCgsgTZwOhVmg
         kh4EZmc2/shS3hWFrdqu2wpHowoSE0fd2cdwE7LhFuPyiEtXiQp2OdzTm0NLkimKotan
         CLZ99b4ZS1MuyMf0uzdxwFeHdw4N7MmoPHaRWAHi9x2dthGJkCgON0a9WJhhFujtia6+
         xg1x3JtwgEZ/dBHW2BJ7EoHE2cdrJ6LI/ZvOUsFEMZaxZTcVSnVAbdoeKUHdplmOdRN7
         ZB/T/1IUZT8N5KktwAi1CgpXKW/QrFJXzOTWaJNwf8nrE4s6p2KjiRQzut7MpkptC0tu
         B75w==
X-Forwarded-Encrypted: i=1; AJvYcCUsfoTqkTl2/NtkXe7GBwzPf+L4cyEk60Mv5tLPnZJ4DBUB9uIgQdVDW1g1ANMzVOnjhtbHpWlhiJb/GujxU73mXRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tCQqa0KVXlCYSwGSw8oHFDYRfRCFn05TgJAtu9It+Gu6yHDI
	mYcojP0f15AsZypoX/7vNTTSkaUMMBAS7jVTTmeftoRYoDd7DwgHiumEx7JsvBKNtsB4qGIW3A1
	c1GBQJZxhBobidzDIhHQ0W4s2MDJ2wIpw8YCo
X-Google-Smtp-Source: AGHT+IF/DXqCq/8TFVAre/QWwJyXA1lKz3HNE+qjyozH+HAootmsxdQ4ih74Ob5WD9n3PLNP03pn/ZWTZ92ruGZDHes=
X-Received: by 2002:a05:6902:1202:b0:e29:1099:9047 with SMTP id
 3f1490d57ef6-e3825d3e2femr11253109276.11.1731979617534; Mon, 18 Nov 2024
 17:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118123948.4796-1-kalyazin@amazon.com>
In-Reply-To: <20241118123948.4796-1-kalyazin@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 18 Nov 2024 17:26:21 -0800
Message-ID: <CADrL8HXikDsda6CmG8E2KpNekp8xaQyd8wgZoskkR=p2LvkPQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] KVM: x86: async PF user
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: pbonzini@redhat.com, seanjc@google.com, corbet@lwn.net, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, vkuznets@redhat.com, gshan@redhat.com, graf@amazon.de, 
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es, 
	xmarcalx@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 4:40=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.co=
m> wrote:
>
> Async PF [1] allows to run other processes on a vCPU while the host
> handles a stage-2 fault caused by a process on that vCPU. When using
> VM-exit-based stage-2 fault handling [2], async PF functionality is lost
> because KVM does not run the vCPU while a fault is being handled so no
> other process can execute on the vCPU. This patch series extends
> VM-exit-based stage-2 fault handling with async PF support by letting
> userspace handle faults instead of the kernel, hence the "async PF user"
> name.
>
> I circulated the idea with Paolo, Sean, David H, and James H at the LPC,
> and the only concern I heard was about injecting the "page not present"
> event via #PF exception in the CoCo case, where it may not work. In my
> implementation, I reused the existing code for doing that, so the async
> PF user implementation is on par with the present async PF
> implementation in this regard, and support for the CoCo case can be
> added separately.
>
> Please note that this series is applied on top of the VM-exit-based
> stage-2 fault handling RFC [2].

Thanks, Nikita! I'll post a new version of [2] very soon. The new
version contains the simplifications we talked about at LPC but is
conceptually the same (so this async PF series is motivated the same
way), and it shouldn't have many/any conflicts with the main bits of
this series.

> [2] https://lore.kernel.org/kvm/CADrL8HUHRMwUPhr7jLLBgD9YLFAnVHc=3DN-C=3D=
8er-x6GUtV97pQ@mail.gmail.com/T/
