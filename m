Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AA310620
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854489; cv=pass; b=LWbGmMpndT/jfFFRrY9UwcIrUcXUOqt5JijQZ18NDkyblPEXL53wm3DUFhAF3rvvchIRIsFWJ1pDWuXxQ9uQZ9brwKwmUfmo5vEiKyHrCLoWfhYaTRL0LlM1x+YaZVrd3YdqeqxQwfn8cwlnfXNi359WCd58wt2T8llOu2depuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854489; c=relaxed/simple;
	bh=JJFMGNt3smn/nRo+9rSXfk4rP7ZcWNohnOcxUFIEH/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnnNNQ0/yJ8NMP5UJW0N4kHnIcy6Wd0IAlnZ5wODl1RD7xGi4PveIsHYfGeW8qcWBYwa7HJ0z+rzQ2hW2TYub0CPjfYF/Yky9MW57AgRn6Tvq/nDtxQkrduAHrxQsSH7v0BMU/BlPwFyGcugSDAEixf5Zmyi41efGRowUJN0ymg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=f9gkMcn0; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="f9gkMcn0"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so11533435d50.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854487; cv=none;
        d=google.com; s=arc-20240605;
        b=bxKYbYKjaI+fL1zqSWyMiix4mD4w/+477DuYa0rGeO/Zy1o4+Zp0fncHXevsZHGR8g
         zuRT7JGWSADddBhnRa5Zc5RFo6+QLoI6qYIr13knNDFMg4wCELeTd5fhygtSpLfVhcxN
         YZdXdfOgrdAcXlN2KUyulRSgAbl5THFW8G6k1ROPMEAVWjft9pfNVEJqt2LfW3xcafsY
         TpxveuuktCiBV078uy5+czQwmR4aD2jhNCAdrVvVtCgFaJ33jFArix0loyAwPKKs1w03
         9Y2105Mrh4PzU4sDJpNQ4L+GsN1cfvMWUKOcyYXwUq7hRVdbvkFXKy9p/BaOElHKDj2F
         Jh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJFMGNt3smn/nRo+9rSXfk4rP7ZcWNohnOcxUFIEH/c=;
        fh=Mf6o/n66hiR4iqA+wxOHR0705GU570wSCNgigvwfD7k=;
        b=lmJUCpeZ/0IljMRlwAcwJVPSuWE7zHSXxxw39UrfY+OUECVJpfkOWaVnimSKadbu3z
         FIEV3EohcXsY03TjHKjMd7cWYNiN3nAD56g1xURlw9Us5tgoshb4SFo6XNo0M2mnTpYF
         vt93XKJ0MZOtgkY0tXs8MrqLpNpBAkD6q7LZ/xnwaVbikYd+q/h6jps8a4iJeMdppL0h
         duJapotb6ja3c8nAUCBsaE8GQaMag9JO9paOzk6ocqy4XF4GcN7xIrgjS73iWAoMc83T
         RFfa95sl5LDPKHAy0tLDHo7bZXMxHNBdjMSHavqPc05TeVKjb/+o42qp9KTrV22pWeE1
         2NUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778854487; x=1779459287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJFMGNt3smn/nRo+9rSXfk4rP7ZcWNohnOcxUFIEH/c=;
        b=f9gkMcn0+zZUc4O+wXYzpeqXNTjdOOUXo5oQRYPfrZ9kQaKhILsKiWalhlD3yFcWmx
         OG2ZFnV6n0Y7v7lkKl6zKaLjGNvlC0n7oWoJk/xos2QeZMlqbp5yl+HiT6W7H8uarXDg
         MmOqwN5u7HgKlcmgNhE7k5IMMUhogHhYwIAKqOhtjMSKyXfAQdDlAd9vdwSJj2YRBCqZ
         KqxsMtNPRGpbaSrHhaBacDaO1MexeRULlACItSx0EdMx3L8p1Oo3A+h88xqV86ylKCpJ
         CN4fBylVApV35Ov7rMJlG2zLRHSXo/aOfibfp+4gt0HDHPnAfVfXtyE5DeqaBykLyfNp
         KQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854487; x=1779459287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJFMGNt3smn/nRo+9rSXfk4rP7ZcWNohnOcxUFIEH/c=;
        b=PGGUtdWt2Q912bA/c6qNyj92yRaDS4ffCj9Mr3/NyIzHdeG86Mqla/q9SIurrszmZl
         wpTUuOa0tpobsdDfmH2ayUDVhQ6mx68UId6mmqETO5sFc4u53LhztPR0LdSmx0gycgVP
         qTt//8/shA+GKz5d4KC+Q6txw8Z4wftSb+wYljQN3kEaB2pRALN8wglSbO8R0Q3A7Kmr
         sV3ObC+OLzlvxih7pcC24neXAiElsZayE8WL+DH/sgLuobQ3oUjSGM5xOmKoRO9/ACxt
         PTGjGo1/jAnwRMZQsxv0QnYd+es3RuJcvoReF6V1Kw3xtn/jmq3pGU5JWfLIFspREqtG
         tQRA==
X-Forwarded-Encrypted: i=1; AFNElJ8DNxx4BqKaCDu8x5QvIeF9Bmo/oTjrDAiigGsvue3dr6LJjKFEJrwgKD+K0MGZYQvQJV36BjGTYIJ007ILrCY3G98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpz2lK6RAoN39NI1cnDdm8inznYQfGt6m+tpL6uHNQe5I9tUH
	ZvixjB9/tXPHVUHjZl6u8zA19AW6y1J1E0ocaMgS/v51fidyJOmOLBDK1Xxpk9S2r2tjpVicJsH
	RIqBDjwOpTYXbjgRkIf1hCKY/r1ymci/ubP1eyi31IEgrR2erRz/EkGvHmg==
X-Gm-Gg: Acq92OGoGlJXtVEDhHxXkt14dJtCl2dTX79AIOT68/ZPe0Qpp0JpqqdUcxScLEtfBLc
	zMlNW2qlIYa1VbcMOrfIYs5Ses+BLDwetWsFv3pJ3b6ky5mYYSW020x4LLffp85z3/UQ3cWOS23
	4fmTFtJ76HmnhYHoZXEnd7Ug7s7mIwAInfWS+BqwBRTkMP2YQHkJOHvRFgVemzTtVsEN+F/SFIC
	gq8l1n+ARUkBXuRs9L0s7Olaj0hzZH/s0X4z2smAJx3j/0cuRHvQv0DX0ihK/8zoMBzBS21KhYf
	P0SR6CfGm+YXIXZHt9w39TxJmcpzc80BRBtP2aQu
X-Received: by 2002:a05:690e:418a:b0:654:5d65:9ff4 with SMTP id
 956f58d0204a3-65e22674e00mr3815940d50.10.1778854487348; Fri, 15 May 2026
 07:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135903.2238731-1-vineeth@bitbyteword.org>
 <20260515100448.715589f6@gandalf.local.home> <49e77605-6227-426e-8103-329474bf88f9@kernel.dk>
In-Reply-To: <49e77605-6227-426e-8103-329474bf88f9@kernel.dk>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 15 May 2026 10:14:36 -0400
X-Gm-Features: AVHnY4JoBz_kAVO7oVVxjOoTR7W-h3RFbkpi3j0LZXngCIQFZfxRvShyMiW_Km4
Message-ID: <CAO7JXPg+MJXF8smC9qXs93YziJT_amQwWKVW38L7F5XdS9-SaA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] io_uring: Use trace_call__##name() at guarded
 tracepoint call sites
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, io-uring@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:06=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 5/15/26 8:04 AM, Steven Rostedt wrote:
> > On Fri, 15 May 2026 09:59:03 -0400
> > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
> >
> >> From: Vineeth Pillai <vineeth@bitbyteword.org>
> >>
> >
> > Hi Vineeth,
> >
> >> Replace trace_foo() with the new trace_call__foo() at sites already
> >> guarded by trace_foo_enabled(), avoiding a redundant
> >> static_branch_unlikely() re-evaluation inside the tracepoint.
> >> trace_call__foo() calls the tracepoint callbacks directly without
> >> utilizing the static branch again.
> >>
> >
> >> Original v2 series:
> >> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vine=
eth@bitbyteword.org/
> >>
> >> Parts of the original v2 series have already been merged in mainline.
> >> This patch is being reposted as a follow-up cleanup for the remaining
> >> unmerged pieces.
> >
> > This part should go below the '---'. There's no reason to add it to the=
 git
> > change log.
>
Ahh sorry about this.

> I pruned it.
>
Thanks Jen :-). I can probably send a follow-up email directly to the
maintainers to prune this part, similar to what Jen did. I guess one
more version might feel like spam.


> > You should probably also state that these can now go in individually as=
 all
> > the dependencies are upstream.
>
> I think he did, at least that's how I read it.
>
Yeah my intention was this, not sure if I worded it correctly. I will
include this in the follow-up email to the maintainers for rest of the
patches.

Thanks,
Vineeth
