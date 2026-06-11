Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD834252C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199315; cv=none; b=q5yWyKCzyu/ZpkjFBZbPSPFkiAujTimwnT7oA96TxrK/zWn1vs4wILB12uMu2mqBhKsJ8wRuhSfvi+CV1skDI2akwOdXFV+otjrI8UZJAWCNhnyMNWnnpTBJ8xeMAKSVA+TjQ9s5uYLIjcGjpVtBkm8GihGIEVP6cK9nrzae5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199315; c=relaxed/simple;
	bh=vbkZN8+SdeptEibqFYK5kEEH1xB7aIc1ObJ8q49tt+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DPtJnlnu+r2SHMkIm8QStsVaqetILRforJ4G4drY5te0AsCgs8w/OX1iZw6r6mcpMSyRx2kYSI1H2E+Zy4/QZLEIxwb3QXsLeI7cdQ5Gb0RyAytcVj8E8obToqWZzQ+slaaKX7BoYQE2EtJ/S78xWP/Kym2BYKiOYwb2MeCDtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYZ5dLNJ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYZ5dLNJ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-487135fd4f9so90692b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781199313; x=1781804113; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbkZN8+SdeptEibqFYK5kEEH1xB7aIc1ObJ8q49tt+I=;
        b=BYZ5dLNJ1IBvEK5ib/bzK5ktyDRpKQtTz0Pa5eSPDrRyO72d5rfJM2JumMtKNGXkt+
         Ys04gx2n/EgEtvqa/TSdPfzMZ9NGwrNvFbA7nZdBKZ7mync+PH0VgbJbYeU9qylu+OJW
         zBLsD/iHJocBFpsF94KLithPi919Q/dyq3PY1fp69kJ2OpG2iRbw/ati5BXIU6THDNgL
         OKZqkhrDOZdaNUPLT5o3neeRa9qQxe0bm/ErKIHk+b35QEn1KAaIafA3mRt33tldqUBp
         9OzcgR9BQyPWiLi1hd3rv2DL2b7z1Udg54FK6QybRP8eh33Su/SWLQprae4W4efFY7kG
         66nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199313; x=1781804113;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbkZN8+SdeptEibqFYK5kEEH1xB7aIc1ObJ8q49tt+I=;
        b=HD2MSN8qTjBE2eRvks0sPbyZ74w84bPEgR8N9CYjed4Mwjqn4Omk8yyOM96lH49o/6
         qTeVLFuWTcVzqvm+TeARSNPTqHFz7X539VN0BEorw4wqAxJNEVOZwik8kgbJA8V/GMut
         +a8cMisq5xOkYBeGqkM9yRpS7HdbA2+BHCd2N0AKLKmAtpCUtysy5PO009lyUn0j7pAh
         CCQ8yVqHBT+Y9i+n8n3ifuRAY8GDwQoz24TGEVE4TO0PBYzrr7bchcNvShprFLraIM5u
         yQq9LoJ+k6z7K2g4bJ6uC9EZCsJL+FKaPEC9nmJvJSC8cWU/GZPybrqpRBO+6r9NHGKT
         Bc3w==
X-Forwarded-Encrypted: i=1; AFNElJ8pJbH70VmEs792oH++ABC5KNs7dRtkHAzuv4hGR+WypxEJOMl+lEb+APqEfegew0pAPX4sq5/GCyJVePaQM46BBoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRgRHvNdR9Fzgz1VNWbH8NBf+SYJiSxpeH/zxgwOrIYYNT3lO
	xZ1y2rzIz4gyweblJG7wJ1nAeoUa4vttlCdAMpd5qtU3FiqYafJxiUhX
X-Gm-Gg: Acq92OFdPD7NqJXAWYkZd7CnV9poLbK3UnGD6fbm5Qrcb8yUpkbSS+Vw9AUT/XYpAwR
	Ss2dGVI/cfMx8CcKRekZl+lcp1Yj/OKeWWIFhlzJ7ObKqAAOrecKgRXocuEeFfnxKPfwD6fJ/jA
	0+BMWDQ8ux3JeGoOYLtb4t+v8qY6G3LYBvq+hqj9t2TnlA3sjUtnVQE3iDsWuqfq0BJIo5dTxds
	e9MrFE2dq5S7h5X1nJZwtCuvZD55vYviZPaURAFqad6StVtl+Mwgicw08B9fAGJzY7ssVMznVQD
	/oFFK6IISVzsxKZcdG8W+ym9JVCvhU37Z6OAPyBZQ+2+lLpPNkzmRciHRMtCNYydEVaycG+Xtej
	JCJlyPRkn269Z5W4QNybkOw+GUiE1V/aOWAlOQcyIbTUQWm4kCAHKewfVi0DIomEVHlG+Qp/D3O
	Kzwr7nt9WoSE1KczdTzFVlE29Z/Y8rVEVIKTnT2pLxVS+Jid5cG2N82eJV/BzYpDRVk3gMwri00
	g3CoyP2YMqKJj9BOg==
X-Received: by 2002:a05:6808:c2d5:b0:485:29ad:d1a9 with SMTP id 5614622812f47-4871a1611famr2717742b6e.37.1781199313083;
        Thu, 11 Jun 2026 10:35:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91f944sm21186925b6e.9.2026.06.11.10.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 10:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 10:35:11 -0700
Message-Id: <DJ6EGJ8S87HP.2WOTGYK374XKI@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "bpf" <bpf@vger.kernel.org>, "linux-trace-kernel"
 <linux-trace-kernel@vger.kernel.org>, "Martin KaFai Lau" <kafai@fb.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>, "Menglong Dong" <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Steven Rostedt" <rostedt@kernel.org>
X-Mailer: aerc
References: <20260603110554.29590-1-jolsa@kernel.org>
 <20260603110554.29590-4-jolsa@kernel.org> <20260609102922.3c489f76@fedora>
 <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com> <20260610113536.77172ad1@robin>
 <CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
 <20260611094648.04622890@gandalf.local.home>
In-Reply-To: <20260611094648.04622890@gandalf.local.home>

On Thu Jun 11, 2026 at 6:46 AM PDT, Steven Rostedt wrote:
> On Wed, 10 Jun 2026 08:42:51 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> If my memory doesn't fail me you said it's fine during v1,v2 iterations.
>
> I'm fine with it, but I wanted to test it first. Did I give an Acked-by?
>
>> The last v3 - v8 you were silent, so we assumed you're still fine.
>
> When I see AI reports that say the series needs a fix, I don't bother
> looking. I thought that was the entire point of AI; to let the maintainer
> not have to review if the AI found something.

AI finds things to consider, but when they're considered and postponned
to future it doesn't understand that and keep reporting the same thing
every revision. So it might look like that patches are landing with
outstanding AI complains, but this is not the case.

btw since patches touch ftrace from time to time should we add your
ftrace testsuite to bpf CI ?
How automated is it?

>
>>=20
>> While at it, please review Mykyta's set:
>> https://patchwork.kernel.org/user/todo/netdevbpf/?series=3D1096695
>>=20
>> It's also been pending for almost a month now.
>
> Have a better link? I just get a blank page as "TODO" is set to what I ha=
ve.

Ohh. I meant this set:
https://lore.kernel.org/bpf/CAEf4BzZFjsEv3aLktwdCZF6EXoCL+eefX+6xa3XGrhBmfO=
1SqA@mail.gmail.com/
where you said that you'll think more about it after pto.
Would be great to land it now for this merge window, so we have
discoverability right now and if better approach comes in the future
we can adjust to it later.
=20
