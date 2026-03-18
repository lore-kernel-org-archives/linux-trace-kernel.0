Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868F38A71D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845508; cv=pass; b=DR9GoMVU7PYzHOgd8Pp7wOifrf2G5JKmYTFiD8Od4Eoz3oXTlkM1O0JMR1SBPDrRWzLj7cceFY4KJ8/o4fhAAsgMq6TwdnxAoWIlpXPE1XFrmRsRLIPmjnwbtVCb92pacY9s4pDySWzJsnvzXTDg+2epFeoXo7Xxc00NoCWMC9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845508; c=relaxed/simple;
	bh=1FISFWtjLoHF5EnuYPOgvH0ljgC076KLVSofovMd6Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T675kEVQH1dup4BM3hY5y1fikWRMWhzlCe/+DuDD9w/EzPEL/XNJoHwsBIOeG/QtZS8SG6gx5yJYL3MVTHkQp+xT0T7TTJJU2LdXPjU59DKzX4x2gNHsCPStItoeMQroq54TUaxsIxoPUaRfEktbthDApPbfVxi5s1JRpoVWYd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=XpJ1DAOP; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="XpJ1DAOP"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64aedd812baso4287d50.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 07:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845506; cv=none;
        d=google.com; s=arc-20240605;
        b=TUB8Qtw8O2E493ajLnSc/rWPXK7ZidpK6b7k4TWqPaQmeei9YFzrNOWOwWmR4LFABi
         HbmjNg+U73Sp1ZAuqQGkvIOFemrdn1O1zhNe7JNigGEOXE6oqMWnZJeUitxhsGQtu9QN
         yz1EEwUuOXX7QbESAhydTYljVF/P8tm0X4ntqpwkqSTHMam+5Hf9ysB5KIuk9oP7EaR4
         unPgzWcoaLQtEpN8P0GPjAxyPpBv+VJLlOeAlAeenKwni3+s3d499lgzQQclVwlBYc89
         JJrjHrwonlbOkdTjtEHJgzOdBfNhzW+iuNE+VUvBqGwSMkZ4I6mWuRmmISKs6c+LS7wb
         3xPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p+amKP2hSQ8rLALonagLiBWsS/hjEbvlJDIAKI1rnTk=;
        fh=w5MOAxii0zg3NISFKvtfHpUt4RK+C7pwcrWvYAR8FYg=;
        b=LvntVtWqkdqJ2kxglo+nSAiiDT73ST//F3nKVClMqd62okvY226DIs7VNaetS2sV7g
         xKbMzVeZmTdlECBCvdDo44z8ThMjKoJ/w6J6C59Jezi5Nhy+HFXy4a6eDfN/KvVqMu9v
         kyUZc0gdPw/txN+XcXsAH8z9yHY2TpEGQni6iKvnW0D4swOKAKy3USBcUY+HtWHg1ZDf
         A4WMBE9FeTK2il/wh/YYGTY6sck0ddUXg212bPMAXGPmnIe7d6fQMlQN5t6OjT8M2hmI
         jtuMg4LEZ2AA1EmJWtsBAIVxQk16NJDYmjgWt4wTUO3tpb85+q9jtVjrWHd0nB0/KUqR
         EZww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773845506; x=1774450306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+amKP2hSQ8rLALonagLiBWsS/hjEbvlJDIAKI1rnTk=;
        b=XpJ1DAOP/4nAdBA8pNInAjErrB1WwzEJFuO8HmuDUIYaj2cg/1BDSwWXXh5Ed05U3Q
         bEzFS7R7c7xsBrws3lVzQJLQQJFgLEij7/0GOiRjugLMEXl29wR670phhRL3ueHVm8QE
         3mz3euiuEHCK6YyC5OW3x2Sf/xMXOUyaKql0t8Ag/4IlnklPQeUzQu9MtNvM7KgvNSj9
         hU5W4AYkFS4Lly5PDu0SI8uDIrK3wmnvFYsRdI0BqlvFNxTf3dNc6SxGRMVenPGgKuF6
         VF6oqB961lMxoSCe2NtuaTM3bIoXQwAJBwR4oBLXTWquf4IytutPq6FXV/dGE2/rvbWz
         Kn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845506; x=1774450306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+amKP2hSQ8rLALonagLiBWsS/hjEbvlJDIAKI1rnTk=;
        b=Y9IKoFHluVlxJy0DJ+TtMWSIMaf+AxJR8/EE+ucf0Ov3CjkVx/76JxyHMdgbaBHtFp
         Cw8neTJFwgSA0IXRSESFKXilTzzO25wpiCm+RxHZSIEIOCBUAMfyKov0qlhczQzp9FrW
         Q10FZyXnRrif1C2wruKIgG4l4VRZbm7JkJvZKq8np36vxYL/sva4LPK09IquVk838p0X
         iBlVbwaLkF25fjjmY8Eoc/Z+Anny6J61SCJdthKY9ISSS9vrzkktpKGG1VBDZdJumMjB
         9bW0SVr56PCshYFWazhn8E/j3NJuZGyw/9VbR5aV6vN6nUFhlUsHOwXcwX0cV4W2jkUs
         0A1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpRVRfyXOtB9HeXPOGKjG4uNR3/DkD/MTJKUqgKzSsPRMyQcnH2CFOjJPtbnJMMyhb6h8eyjOPKH4oK+NI9k5t0ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfA0YtYE9ljjTZfu17SRhuYI1fwhLTtFNS4LD0Zd0fTLqoaiJ
	KoGnN889VFP3NnKyBWZXb/+UGe9YH/OjqsraZRXjaJGH3gFiGJtMH7kvV44aQ87u6iT7hrSRzPP
	OxZSa7Q+19+2uBTHoKLf2tWGqU8PXgD/u5OYXj7NVXA==
X-Gm-Gg: ATEYQzzN5BkAy3RnWF7ufiOCMhcFx0YTopH3CwV/9Lc/q7oogYXjkUtixkNsRsrKnUt
	gpPId3MgrYLjtB7XpLZHZn0aFtXILdJDNfvnnDHBVNed3qYTJ0GrYYr1uFl8l3QQElvS2p1nCgf
	OPP45GYCyKDwTCfOo7IIejXwmoqoZDTpNTzkJ45JnZ/fYNESsEkpjdmT2LYeIoI5IbDLjaZhZWb
	kpRd2EZ0AEsUmVDX3VFfl7hz1zC+sJ5LAtE7KZozDg9S6oVeowZKtmYoy0ZV+p13qsgRTasZleO
	vDt+ykM=
X-Received: by 2002:a53:b74b:0:b0:64c:f001:f6b with SMTP id
 956f58d0204a3-64e912fb730mr2882157d50.9.1773845505787; Wed, 18 Mar 2026
 07:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-4-vineeth@bitbyteword.org> <abLapcC7YGYDyJ3L@kbusch-mbp>
 <20260312113816.01de2b53@gandalf.local.home>
In-Reply-To: <20260312113816.01de2b53@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 10:51:34 -0400
X-Gm-Features: AaiRm514xL8rsuaoYk7l-YfTLHyaymoFYPgJ2hsw1mDadffK5Tx7pElRtPxoCsU
Message-ID: <CAO7JXPhV=08g6AFKGmeaP8T9Uuck12Ky3ZmT8yXTJzZkJ5Gq9w@mail.gmail.com>
Subject: Re: [PATCH 03/15] io_uring: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Keith Busch <kbusch@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:38=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 09:24:21 -0600
> Keith Busch <kbusch@kernel.org> wrote:
>
> > On Thu, Mar 12, 2026 at 11:04:58AM -0400, Vineeth Pillai (Google) wrote=
:
> > >     if (trace_io_uring_complete_enabled())
> > > -           trace_io_uring_complete(req->ctx, req, cqe);
> > > +           trace_invoke_io_uring_complete(req->ctx, req, cqe);
> >
> > Curious, this one doesn't follow that pattern of "if (enabed && cond)"
> > that this cover letter said it was addressing, so why doesn't this call
> > just drop the 'if' check and go straight to trace_io_uring_complete()? =
I
> > followed this usage to commit a0730c738309a06, which says that the
>
> You mean 'a0727c738309a06'? As I could not find the above 'a0730c738309a0=
6'
>
> > compiler was generating code to move args before checking if the trace
> > was enabled. That commit was a while ago though, and suggests to remove
>
> It was only 2023.
>
> > the check if that problem is solved. Is it still a problem?
>
> We should check.

I shall leave this patch as is for now.

> Which reminds me. There's other places that have that tracepoint_enabled(=
)
> in header files that do the above. The C wrapper functions should also
> convert the callback to the trace_invoke_<event>() call.
>

Thanks for pointing this out. I just had a look and its not too much.
But I feel it would be better to take it up as a new series. What do
you think?

Thanks,
Vineeth
> -- Steve
