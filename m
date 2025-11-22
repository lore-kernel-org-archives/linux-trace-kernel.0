Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA59275B18
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Nov 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763779037; cv=none; b=d0qp8WVhUbh9rorhVObHOBgLG5uVxYEB3DEofdUhXIPnt8UPEf2X31VVPrMvgS8SXw5Ia4rQyk2DwT3Qtg+vdIpg1xvGS9gQsF5PSrMwrmHLHdIz0pmSAYSjT6fKDj3YGPrPOKau3ky2NvTzmi+SFoWF2duODJWNI7G3m9MNilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763779037; c=relaxed/simple;
	bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1D2tgdGmAbgJABRiNa3BWx75sLh8ucaDh5opgDFiHYXJUYcwv57uNq1vnb5yVx6+RQa6HP/4hkDzPADRkG/PD6NiH7gmaI4aqEZQUNUlBFl5e9wtIbGD3cJZFO/ky+8v6jEFXx1vrcCvf/ESvONmAgwXPwc52rCCX+4b5Y07DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Pq4NQr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Pq4NQr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso16334935e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 18:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763779034; x=1764383834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
        b=d0Pq4NQrfC4QsnAsR3HWJ/NOiky86J3ywJROHLunncbUOtJbqrUNhyTx6tFdBW8cEI
         TshyXnlcZOEx8IEPEIHHGyS8QALsgHjE1C96gioDk3kIUmIsRd4bbJcbAYOM6UrORVNz
         Z3gIyi/QvHOKvKrVR96ebd1RKzBYK+CLT8gvSNpNjF0nfSwltQWaAlzqxMaCRckQcllM
         n9qdXGzsVATLVM/JGB3a26puJ253xFa2pjhpRrogKeo3Rg/C+WirbewCjwnMla9+Be8k
         vAmFVQ22GrDrFgR+cyggDTQ4UfKLGlFgzZFTgHfdX10Lr+U4WbOekD1BqfRrJU9WtPO3
         qlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763779034; x=1764383834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
        b=K8RtGspl/Xo4WMhqCBF41BZzluaTnZsGHQAmAKM1BQWUizFAtmgdfhzTN8NMFNEHvt
         Qh/yygKn5qFXY1w4FITmLy8zhsq7Zq9GwU2WiiLOv8VwfRL2pdormzkgAvU+CmrBSDIg
         M3NVjr8APsRAd8r6rgCmF/s5dMsPBXIXuDg54LPmQpuDxMWWUNqIXxNOc4G8e6/rnCii
         DKlAw4Q37rbbMQ7Bm1aFWSuxdQg0CU3pd0c8s39XRRMWpKTxFyrRcJw9e4sYDRgpCEW8
         gyhNwAVNgQmhWrs1FEaCRjskjFVbemti9fboClY1FVsYjO9SzffewaCx2H1nh/UIzDUO
         VscQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFQbRKWGIGAXov0Q00Enl4r0VfIrCzaOzxoQW0Zvh57/p0BjGn2Ao9xU1W4w1qq6sGHSPryse82zbWIVso39xhzT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1bScGvv/K4/IdbjolZMvsKl5Et9C6R8DJVRoN6UrdWNV2oki
	utOufPpaHTHs0+lH7YlBQlE8yYLS06St4i5nbGttIEmGs9yYOqBmx5FUZUm915upZJgBMh6SmMN
	h44qQmfi7NKc9lX5cA/i7Y52uCcJ216A=
X-Gm-Gg: ASbGnct1UZxJkvqVRBRKStw4bfrKH7mHfm7cUGrPk6bujmOGZnrmcrqU364UWmWMI3Q
	1G/oZcbPdVO5DLugI5sS8f4SGnW2K0dtQXy/r3RcDlG4NhcO2YOMqaSfoQZ2v+Ly5BlmRjRi+os
	LxIsAEKu6q9RxoXEXN/+1ju9mfbRw6+J+SG8E43SSJ48M/xE0+/oze0D7Qsr91hCG7ZmU0RCFFc
	8BOCc97BVhup0ueI3GqY0OP8l5ibOp0M0/UQQ61x29OgGEsF48CNYUOcwKVaKaDmUusw9E+QWtn
	QA3y1kf6oxNbVa26SCQ2u7h4YGAd
X-Google-Smtp-Source: AGHT+IHq8TQLttx02HzTcghCCmnEoW2jl5V2xikX6J5I/xeRJaTuYAWoFRPo7RLtazD/sqSeAZIHBDfxSir7BUeY6Q8=
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-477c112f7b1mr39494665e9.29.1763779033832; Fri, 21 Nov 2025
 18:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-7-dongml2@chinatelecom.cn> <CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
 <20251118200304.29f2bd7a@gandalf.local.home>
In-Reply-To: <20251118200304.29f2bd7a@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 18:37:02 -0800
X-Gm-Features: AWmQ_bk-1n4MtV7kB_iJKRoAsqrOjg4sGeLazyNB_E3dmOLPDW9GuTNA0HSP2oI
Message-ID: <CAADnVQLs-kBMi7VCizH5be8q8Nyzx=KYNPcnF-EDNx7OPs4Aiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 18 Nov 2025 16:59:59 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Steven,
> > are you happy with patch 1?
> > Can you pls Ack?
>
> Let me run patch 1 and 2 through my tests.

gentle ping.
