Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793883918;
	b=YoQOc3HW9uz+CnWPBHdEJoaDlSQwj1YrKjvkJ2obYQQL5TqKc27qHzHGvCZ6nOg+GsF3
	 TMLMOm5qBK5dk8q71ZDPuPwoSkGNR0ChB6KlsRfU+VHjgIuDe5UOuipDl/MqhcrpYevNh
	 96ZjSVjJFuj9UqkDBszmi074Of0lHmAbeIIW5ar/sCNhiX3eeS21VK8ZQU5OddDR50aiz
	 HtBZhfbwfiWNVS448BjxJ+zXaCF1kk960rf37IkPSWuXbhImvmkzT8z1MYcEiqgrrSLeK
	 wJLjPD48YaeyPNi7lDh3gtNhJn/NWqksdo5Gz7v7KQdwk0+RGehKHihsbtA5kF3jP1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KcPe3iGsiI8YrNiV78WqkeLTX76FglwKYzDgJ9jRWH0=;
	b=2efYg2kOdOpffQAFCpXMdVMbK/EKqtJbZZYQHC/aqmImGG95lOPTDv5vdFy4ZRmt37mb
	 zrJotY3WsokI3iVZCK+XD0mJi3L45P2mwpnCIIJqEamwYp5u5OyVPTb2uQZu7Ru32HRQ4
	 OQiTSFWAGjsgWqgPsleVrRzUfvqk2kTBhFzgUGE9NtuJRuTuwvCiCSY+xdCBqt85qnkWO
	 tWbKl/v+zLDbJBSEn6cMXcpTNDzsCbRPaWMgcOj5Ih0ObB2IEZFNv9JzMv2F0elL5OLn+
	 lEl1BJ1j21k/FkOs38Ga2VEphCaDyzsFQAFQtoyrRmMeNVTPxt9Zd5tQ6OTWzLVLbfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNu8S3ms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5BD606A330
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 13:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A5BD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNu8S3ms
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso311588866b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 05:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793883916; cv=none;
        d=google.com; s=arc-20260327;
        b=meIVIJGHNDfY8btv4FbFj4gEodhc/L2Ba2Yn+GXiITpM15ADRY+uM8T5cJa5ZcUa10
         R4bv32T8x56nc7k5H16+CRaDiDUv65kkOcUD/H4M3GeiB3DgvbEOkpNykX/cR2arnZAU
         od28rnQP27mbMc4y3GeFsLP7t/W7mS6bXKbm62l+GsgzROmAVSnAVaxp4suwInFsk7cn
         mFa/EtwVhrha28a9ty9m6HYDvTHj80EpbSweBDdnCqaV2Agbsh398230m3tRJB3H2+vX
         JQ2s8X0NLfHYR16r6ecWGVxnbQd6Pw99BSuooZvckOSw1MfW9IpbTdb9LEiCvczVth2J
         VZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KcPe3iGsiI8YrNiV78WqkeLTX76FglwKYzDgJ9jRWH0=;
        fh=D3TGFp/qaHtEQ4WLWf3yJ7a5OEUZIgDEu/P/ZK+59rk=;
        b=APmJJ5doceCBu+fWh3WeAAndo/sF82taZTkzy1+OtY30+dPosk4qnFIOimhxo8jc5B
         EJHqbtJYhTl5N5B5Bk+ahqpocjgT8iXLCG4lFsuJBaYV934VRnRWR3IZ2j2yglcLcns2
         1qsXScqWsvhTM0k6CFbWfWNShE5Ux2iLGXhCgz3ZAq/Es2K5CY07p+hwFJTzQXTco8jF
         9Sv0aX6Mqyect6eXoNuFWanTDQEJhimVKXsNnF2Y1HzS5pJbuW/QNp+FUjgtwyTBGsje
         +ydvSr5qW1FvDQ280Xihy4mRwyYeLwxynE/YGGKplKrSbUkeoFNRVLHda4dcAso23mq6
         6W4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793883916; x=1794488716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KcPe3iGsiI8YrNiV78WqkeLTX76FglwKYzDgJ9jRWH0=;
        b=gNu8S3msZjeqr8t4q72eTqt4qOegePrfBpE550wQsHcjCc8t6vWkeivT8Y13RXJroV
         wIMlsj8r5K4qHul1e7ybj4VbFge1UvBZ/7hTdxSg8JfgcoqqH4cL1pqrXvF9aCBb9C70
         m6wxhqPdAgtMPtJ/JqycaPURobxtsGwO84El+mP7HyiF9G4+Z8zePCtRWIQIKDkl4p/0
         REEUXEa/xfL3VRRLnctg4zZrbX9jEkuJ1D7+zeOdOg8ByfhD4tjwvyooOriL8lbJi2EK
         kED90LotfXMG94Bx0InugHdua9xFvPMhFUbFIFmD/GnBWH7OKRjKXkL/aaCRWlA+ug8S
         QIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883916; x=1794488716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcPe3iGsiI8YrNiV78WqkeLTX76FglwKYzDgJ9jRWH0=;
        b=Xjlih04ZkcSiSFyNe6nyY8jjQ0z1fzNURUQlQPROuz4/+in6+0na92O9NLDVQTjUB4
         wplQtj3FaKgxaOX0NM0VA3El7T88LE0TDMCajfdnhmcnyd4zUCY4ydVyVUPeWGMMbP8R
         8AnZ51lQRaYfbNT2nq4QQk3LGDIVi3g1Z2fVPP7tOgrwriY/A0OrwESSeDF69ZvoaIs5
         d5VcsuAaTqbwkOj0v2zoHZHU6uUfS02mNH3+xlEzWtzBBRDtXrxA0R4R0SSsNKdvoZkO
         iZp5sqEhfVl3EKxfBSo/dy5IbgXUr9x/jjxNqol6VAjjdoTwZFssFRMeA0OjaiWMCQ4y
         hpQg==
X-Forwarded-Encrypted: i=1; AKwUvByf5zvp5EgMFAZxRbVDr9OUVt46zky0uMGjspqtywO7Wnw92ysjaiJ45q56q6VKHmEPv8uUgeZfiXESHaBkPlV0N8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sphJsa2fmfYWlFdL0xGQZ0NQmKsitlnMtVfpJ/e4aHwimVhi8
	x9U/JyaxFFNBY/0VmTdCjJ6AItKmjyol9vqHCvY18WzTwuxr4KZ+IkDlSu3Xi8DdWy24zLYQiXn
	OBnQreSGiQjZsvKC02brBKHf31v/l8kafwEBp4R2rRnpY
X-Gm-Gg: AYBFou2nmSucgVW5mkvcEC2ArT9AtJjYRcNFWwbveLHhT9fjmBLMooUX5ON58GzWuji
	G5tv81NaQs7+Ejk6rhfQoccUuSt9zfnXCQn0k5aPbdtTzQ4UCuOzvt36NfQ3IIMNXaN63AnlyLC
	xYM5XZczt0RHu1AkdIpBw9UfHKYo2vf9m43zYZFY3yUpLkBPv5y7T0FjFjnZ9eiHE1yt0UIoRN+
	znovyxDm/iPIKU6ikok2UpvewuxpNx4I2Tam9p5W/kfibP0Z7jLN42uX/9D5OsSCfV+B1u1GXq3
	zXW6gQvTGmKDNuluE3WRYxWebzsGPLJ2zbTLsjQ9/48Nfp+qkhCLoYQFQw6W9kMP+R9IITqoscM
	PNkY+c3jzFcfd6ZB1Aua4GT1Rl18D9cKKIkLAmzJ0ZPh9AwrZO8feQFcj3DtW8I5TuSUF
X-Received: by 2002:a17:906:eec8:b0:c41:4964:90b6 with SMTP id
 a640c23a62f3a-c4ca7ab11b3mr1742173166b.36.1793883916192; Thu, 05 Nov 2026
 05:05:16 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031175213.704021-1-bestswngs@gmail.com> <20261102111707.484df6f5@gandalf.local.home>
 <CANgPUi1ev7Zb13Z4o=YdHY_JFf=7xXNHNVbR3KBDQ_p1rzUmZQ@mail.gmail.com> <20261102134747.033bf744@gandalf.local.home>
In-Reply-To: <20261102134747.033bf744@gandalf.local.home>
From: Weiming Shi <bestswngs@gmail.com>
Date: Thu, 5 Nov 2026 21:04:39 +0800
X-Gm-Features: AclHuK9Od1HtaH50PjJ3mlGdeYmha5rMEoqz_j3PVBWZG02f-bzcwJ0rLWoI34E
Message-ID: <CANgPUi1K865BrtGoM_5tMR0vDfKrEmzB5VjczhS-HJJvJ6QONA@mail.gmail.com>
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2 Nov 2026 10:31:54 -0800
> Weiming Shi <bestswngs@gmail.com> wrote:
>
> > Hi Steven,
> >
> > Please disregard the v3 patch, as it was sent by mistake.
> >
> > I am still working on a new patch. There are some issues that I am
> > currently investigating, and I will send an updated version once they
> > are resolved.
> >
> > I apologize again for the confusion and for any inconvenience this may
> > have caused.
>
> Ah, no problem. I did see your reply but then saw this email again and
> thought it was different. My mistake.
>
> -- Steve

Hi Steven,

The new patch has been sent:
https://lore.kernel.org/all/20261103175832.3374540-2-bestswngs@gmail.com/

Best regards,
Weiming
