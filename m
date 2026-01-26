Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250A2DF151
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464720; cv=pass; b=fTE7w181tm5z5fZCYVoc6H204z40YZ/HoOIDZFRd7891VluCIbdpNRH+KyMdxx/KAMqB5/YpFVZmi6Le3KkOGLY7B0jNwH+TCyZZliOcgf2TOourVy+mo8UNrDnYGYhX778vcz/r5enimFuZHC+HleGK1Rgi8ceKVDNl5kLQuXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464720; c=relaxed/simple;
	bh=OgZZYPJNUqsBKrLMQHY/AFEIWgBtulsGVYqrQth1ClE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe7bSaicZIQ+Aml6zulwjNqSawH8xNPfO9pTVcGLhRB4K93jsb7UdwOmV/KuQxPnbdFAS+xSTbkkBp9V2zShPPJTo9X1Vx5YBWJpdlFEYUuVCmp2maS20bFopkla4IGoj0yo7oGivuj6zFlOkPUdPMJNDyn7dIhafXdaEtHmZ7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otxH/UMT; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otxH/UMT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43591b55727so4782229f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 13:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769464717; cv=none;
        d=google.com; s=arc-20240605;
        b=MVK53/wtKEf0TdfUVk/YXKRD6LZL17OE31ALbzx9gL4XsO2ITTzaMt2rBEirTIar92
         9c6MAXC/83neHNhB9daCM9i2+QhyqS8yH40xh4boAsm7xcCCb2HwV9AGph/JT9mn+jdf
         2N4m8zSdMpp7KuFdzvrUhjbQDEjX7AL3BUMpBaB+QJnMK9JacHLViWzL6ES6A48sMa4/
         UlcNak1uz6hFCFNK/gA7xkpiayVIvMn1F4/Se9oN4vk/LBldRSqxu/VHOXQJELu7Sjf8
         HrYc2Q2FfO8GZlgrdLaxlIxCoiTJ+8v3mxn4G9PNianJvSXTlSa7zvzocA43vOG6uBTQ
         6FaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OgZZYPJNUqsBKrLMQHY/AFEIWgBtulsGVYqrQth1ClE=;
        fh=nkAQrJwYD9HubbmsEMA3b6RfjPEEFr8O+V3EAvQ8sS8=;
        b=Djuy93ztWlv/lczvz17nzK7xvudChxsPNw9pMuQeV9Vb2eNTPH76WUabC8qswGbG/Y
         QoxCsb4Dr1yQj2dzxOAHDCRjXMmxQPNI8nKpe2ZxVORbXqOHj9n6cDnv3aE5mcWXBVnJ
         YyRlmrYBLAZMo3jJh/CifQK9BiCGHrc8UfdYFIDwsXhfUM2vUUINwlbviad3k4AyTl0f
         W1LM8xFMyEcrZMoRwsilfl5IYfunZiovXMoEENnJuiKV3zApYeHqVc09XlvxjjiVvhfO
         qnoJoWnDuxDlySNJxGkfNVaIpvsefXvOVFdCoxfEtiz8RHWftT6A4/NLAgA8EK8MPuEf
         qTNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769464717; x=1770069517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgZZYPJNUqsBKrLMQHY/AFEIWgBtulsGVYqrQth1ClE=;
        b=otxH/UMT30aGfMwZYtOcUxLxdxipfP3nwdGqZi9KhhumVUDXdWN9dSfAOnvdno04sl
         wVdw0gWmhkUKXI6/UO6jm/NPAQ67XYgID/gxTvFjVfjpsNdZ3AbuwXQaqxzjpnUo/2ZA
         nGqPIECU6BpL64SL0WE10FfANbF8+SRbTJIc1p5pSTjisvMSFyin562J9QRsqV1l4Zuw
         s4D8NTHIXL47BE1DYwbVWRnvkA7clLBGAWHW+nsVUxzxI3b1Cm5DKU9OePtV/PiZrptH
         O2GkiV+NkLLsiMvUaWNu7jGlpvzhOhZuel2a/nGzAU9L5R3om/0d7HQPnZoB73mGtnCr
         QWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769464717; x=1770069517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OgZZYPJNUqsBKrLMQHY/AFEIWgBtulsGVYqrQth1ClE=;
        b=S1VK0G7LDriFXuWBkQ5+tk0goBvsX+8YmY7wHYlq/TjJFb5InxfpDPIv8NpU7S55BN
         1jVzjApl3oynWrayLAk0hM1G5s+x8e8NhrEJCQWWHba1oPlpH3LFCzls0jUbYqMrQbXg
         zvMZFbPleogUcT2YLjnbGUGeaLcz7ftG+y3NO1vZYxeA3U1BcNQ0gkpPXf7aJLZ/TyjA
         EExPYSqyMoo+aJVf0iqvcoPyTlzfP3MJl7WyVjNe2mIcIiX4HbUvfyelHanzFurnNxdY
         OhN4ViC1SvjJkIMbpyq5WFh7JZdwROl5GAcNUgPphkntuKsG0ojGqyKUSBmW2NJ1+mKB
         iv0A==
X-Forwarded-Encrypted: i=1; AJvYcCW69uMtX1o3o2T4fqqTMDGMx/oev/qYmwyoECWrIn8NLWtcjJudHeiZgBtMjUv3WNxXoc4KTHW2VRQgBUQMOrSlfZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JZXVkmTD6QlRnpEjlKrkgf2LUGea15zjeqwDw9WWKNlNBSKp
	RK5T2IaNDlEVEOvdErldl68TqV8VMjNOL5kDAAAiPbyMlTVj3xA38QCw8oFfWlYjYs8OVM1Jmu3
	cyILGxq5gLfO8YgMdlSZp2dMYPmKoWxZG1PS/h4wT
X-Gm-Gg: AZuq6aIqHh6LF3DPxPURTKTyLIyXSY1IhPwq+VFy2t5RECvgubXRAzmo9e0qQzCeuDX
	+a7l6i2Hrqr4zTxvU/W8zwcySi3ydNRsdZK4U+UG0aGeFqzmDPuL5sADOO6XsRoVwt+2XykFSz7
	pCRT479pnfkbVP17OOEaHl30bTkCDo8rBWu9blaevTCImbd9pZjufxX5qT2ILtjUnzI6PYspMWl
	OO4pf5LbmJDASdQrBEYbkMQl4q6cFGLtNYsPcudCH1wc667Yd0Tn698QWL2/nC9GEk0Z2ijhP3D
	xQk+Aiut0SA1EfJ+d70O+Fcmag==
X-Received: by 2002:a05:6000:2905:b0:435:9223:bfda with SMTP id
 ffacd0b85a97d-435ca147759mr8332178f8f.21.1769464716802; Mon, 26 Jan 2026
 13:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
 <20260112100006.7db6d31d@gandalf.local.home> <aWUO59edshSRit-Y@google.com>
 <20260112115408.48ed4d35@gandalf.local.home> <aXddnjiHCX-XS5S9@google.com> <20260126213748.GR171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260126213748.GR171111@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Jan 2026 22:58:24 +0100
X-Gm-Features: AZwV_QihZvcwiBl1p-Lov7buKmEkVHfq8VKsqtX0qbF8wCZDMWiYhzhA-vv8XL0
Message-ID: <CAH5fLggpBodWYv2EQy5sgg5eSp9=7PM9ZqXcKaTuozNKN1eGGg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Mon, Jan 26, 2026 at 12:27:10PM +0000, Alice Ryhl wrote:
> > On Mon, Jan 12, 2026 at 11:54:08AM -0500, Steven Rostedt wrote:
> > > On Mon, 12 Jan 2026 15:10:31 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > > And have the M of the other sections be R here?
> > > >
> > > > Sure, we can do that.
> > > >
> > > > Are you still willing to pick up the patches? I think that is simpl=
er in
> > > > case there are any series that touch both the C and Rust parts. (Su=
ch as
> > > > the initial tracepoint series did.)
> > >
> > > Yes. So I guess you can still add me with a 'M:'. But I wanted a sepa=
rate
> > > section so that all the Rust expertise is still included.
> >
> > What about the STATIC BRANCH/CALL subsystem? Should I also leave you or
> > someone else as 'M:' there? It's unclear to me who usually picks up
> > patches for STATIC BRANCH/CALL when they are not a dependency to a patc=
h
> > for somewhere else.
>
> I think that'd be me -- I typically do the static branch/call bits.

Ah, thanks for the clarification.

Are you ok with using the approach Steven suggested for STATIC
BRANCH/CALL subsystem too? That is, add a [RUST] entry below the
current one, list you and me as M:, and anyone else in the main entry
as R:, and patches land through the same tree as where they would have
landed if they were a C patch.

I'm open to whichever setup you prefer, but I think it'd be nice to
get these files into MAINTAINERS somewhere.

Alice
