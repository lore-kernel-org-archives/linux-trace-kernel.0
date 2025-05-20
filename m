Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8DE25FA3B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 May 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757107; cv=none; b=lDTUfttKcW77Inh3uqV04tJ21Y+x4NWjDtqTG4HYrzCKA09VUX1osgpJNp6JFvqEmkxtaQqTyrzvcdmhLJ+OsQCetH3z5qIR3liRZY9PIge25HYjSILlsyU3wRY1HpRi68dgI3zS7yFl6BOVE5ejQFfs2dnRM+AkeprrmyfWpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757107; c=relaxed/simple;
	bh=cg5t4eGdtgZu3cXZP54MB4IR+ZBOuN5oWKa4yPo3uQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhrR9Juuzkl3LR2RW55W/xn1PaL4BQBjh38YQDceVc2joU3wORGe0zUycWdVLKHxpfllmKc01SA+Rw2CqXMhhHmzczcEVsgyAHpisnQCt2BkVd09JWQrm++WP6+q757OxjoJPnul9+pCZXIVa04L1e7YHEshNtD4cFxOs7gI1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG+uhMcA; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG+uhMcA"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7cd0a7b672bso389674685a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 May 2025 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747757105; x=1748361905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO/nLRYCjfKcpLfeuNbV08YkbzqqQcf229Ms7HqssNo=;
        b=TG+uhMcAWKjMq/CYX37WIMDeEcvgzGMcUnseZP+rihgSIDyS+AktyygGOrjCH/OplT
         GY1TRRFXhuuEeeANzEQmzFlgxJJXlzCN704hehv9uCzZKSPvfOKSCW12OnDLH1bWAMBs
         HeCR8Hn90jgQDONG5Dqe4+oWI/k6/YD3KUE2nu05i++0AtHdLDrTEv/h7rBk4LohT5Zt
         QIl7N2h+e0ULOBAGUAfwyAEa2RQEhZDDJITYTXOm+iDx66xqd9k0h726l4Pa+PeD/NNk
         lStWQgWyIYs3Z/IhSb+/ec1DxbSSgKX1uQQSCDKIAkWB3TZZIRYnTHcp0PY7qh1yFGM7
         UDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757105; x=1748361905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO/nLRYCjfKcpLfeuNbV08YkbzqqQcf229Ms7HqssNo=;
        b=dQc6thJfp0gulBQ6OSdmySZHBiYPjMUdOBc+hbBmMoSo/di8F5XD3i9CxGR3r5vuyy
         QRvizcsCsPLyIblbqnfVkjgmZ87TdJOQAPt58++XQGuvTh7GSiYnN1+oLQLCofBT5aEB
         YKdHhYvASOblqT8OfInX0M8DqgFzXGZbHLf0pHGcsYf/pLesH7DBUIYk3tdkTsV2oWiI
         WczsK2aCZN26UNjrOXMxG57jvXapBI2+a3BhzeKOKKIjFA4lA6JgcXPKX3cgBg31ckVO
         9cgWHUPRsBX9TEXWPlhYE6cp7hYlTm/ipDbvxOW2M+PHRwcJHWvV33zIwCHnnTGu4Bye
         AxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgABe4OAHWMnDs8f3ZVlGvxkVNHdKsxXic5upiWZKh7lScSrRt5gOaK1J+c6H1PpP3fxRLXTnoMIAItOrLTjMTI1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3DpE+Z45GsrjHQHYqvOFwANoNGjdUh3nKEEj42QYHOCaSj2Y
	Syu2XRbtoGcTdXGE0/farCwRsTO8KjD+f5RNkMC3bPHTS7h7qvvBPZq3p7xP68Wnpy/SrRHV4Kf
	9De3XcQuZe199kVQPEwYshRQuKgPxiaTbxWAlNqH3
X-Gm-Gg: ASbGncsBxjpRGUMRYYqfuN7RGQ5565C0Dcow/ZUI1W6lg8NDnkVMKFPp8kP9LcOee+B
	zwcY0b30S5gGMhRe3Tnymf2AGCsyfy59M//ZfACW3TRK6GdFOMJhE74UjFmo7Ph0t30Y7yQLpoY
	4iw5gAs4alwj6NTxOlZglrxvmjwuboWSYZwaWYzEMqggeVWuQAG8bpmmV7fBwQpXwdOjTUNcbBK
	5w=
X-Google-Smtp-Source: AGHT+IEctazZU95TAdOM2Py70rzLbXXswnML189iWNcKKej+1E4sE5RLKNbUjCL/eh0PGvC9pd8HdYPKfxppky5e+CI=
X-Received: by 2002:a05:620a:394e:b0:7c5:4088:e48c with SMTP id
 af79cd13be357-7cd46731a86mr2518057385a.29.1747757104799; Tue, 20 May 2025
 09:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520082435.2255639-1-tzungbi@kernel.org>
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 20 May 2025 09:04:53 -0700
X-Gm-Features: AX0GCFs4NJkMHkJZuPMpivpKDaXRV49LM_WCCI_dDOeQOPacWqE-V5WduNyzJJk
Message-ID: <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol
 device drivers
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, rostedt@goodmis.org, mhiramat@kernel.org, naveen@kernel.org, 
	anil.s.keshavamurthy@intel.com, davem@davemloft.net, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:25=E2=80=AFAM 'Tzung-Bi Shih' via KUnit Developme=
nt
<kunit-dev@googlegroups.com> wrote:
>
> The protocol device drivers under drivers/platform/chrome/ are responsibl=
e
> to communicate to the ChromeOS EC (Embedded Controller).  They need to pa=
ck
> the data in a pre-defined format and check if the EC responds accordingly=
.
>
> The series adds some fundamental unit tests for the protocol.  It calls t=
he
> .cmd_xfer() and .pkt_xfer() callbacks (which are the most crucial parts f=
or
> the protocol), mocks the rest of the system, and checks if the interactio=
ns
> are all correct.
>
> The series isn't ready for landing.  It's more like a PoC for the
> binary-level function redirection and its use cases.
>
> The 1st patch adds ftrace stub which is originally from [1][2].  There is=
 no
> follow-up discussion about the ftrace stub.  As a result, the patch is st=
ill
> on the mailing list.
>
> The 2nd patch adds Kunit tests for cros_ec_i2c.  It relies on the ftrace =
stub
> for redirecting cros_ec_{un,}register().
>
> The 3rd patch uses static stub instead (if ftrace stub isn't really an op=
tion).
> However, I'm not a big fan to change the production code (i.e. adding the
> prologue in cros_ec_{un,}register()) for testing.
>
> The 4th patch adds Kunit tests for cros_ec_spi.  It relies on the ftrace =
stub
> for redirecting cros_ec_{un,}register() again.
>
> The 5th patch calls .probe() directly instead of forcing the driver probe
> needs to be synchronous.  In comparison with the 4th patch, I don't think
> this is simpler.  I'd prefer to the way in the 4th patch.
>
> After talked to Masami about the work, he suggested to use Kprobes for
> function redirection.  The 6th patch adds kprobes stub.
>
> The 7th patch uses kprobes stub instead for cros_ec_spi.
>
> Questions:
> - Are we going to support ftrace stub so that tests can use it?
>
> - If ftrace stub isn't on the plate (e.g. due to too many dependencies), =
how
>   about the kprobes stub?  Is it something we could pursue?

Quick comment,
If I recall, the thought process was that we could consider it in the
future if there was enough demand for it.

We have these drawbacks with the current ftrace stubs:
* doesn't compile on all arches
* silently doesn't work on inlined functions <=3D=3D scariest one to me
* is more complicated and has more dependencies

So it felt like the better move to go with static stubs which has none
of those drawbacks (works on all arches, all functions, and is dead
simple) as opposed to simultaneously introducing two ways to do the
same thing.

You mention you don't like how static stubs requires modifying the
code-under-test.
Since it gets eliminated by the preprocessor unless you're compiling
for KUnit, is the concern more so about how it conceptually feels
wrong to do so?
For the Android GKI kernel, they have (or had) KUnit enabled so there
is potentially concern about real runtime cost there, not sure if you
have something similar in mind.

But stepping back, ftrace_stubs technically require modifying the code
to make sure funcs are marked as `noinline`, which this patch series
does not do.
I've not looked at cros_ec_{un,}register() to check if they're at risk
of inlining, but wanted to call that out, that ftrace stubs
technically don't handle your usage pattern 100% properly.

>
> - (minor) I'm unsure if people would prefer 'kprobes stub' vs. 'kprobe st=
ub'.
>

I'd personally vote for kprobe_stub.

Daniel
