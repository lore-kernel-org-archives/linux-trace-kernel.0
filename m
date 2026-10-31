Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793454486;
	b=TlGzAcU6ywVjQWwqEmksPmNDQmylP4RPCTUgXWZZ11WW6KwMcK1C2cjKVMqRCfBm7xtI
	 bnD4CMAJg6SaV1BrxdR7V8bTzWC8nBKoR2FsPucYfTuknGhLJxBUZhCA7tr0/hGIlU+WJ
	 dX5XjN6piQZgpesFKN2DUbkXfic3UZIAJ7UVrkiQwJ5iDoCWNItKiwruqM36/C50kgB31
	 +4tp8CJvZ3KnRvG3SOjDXHwjQipKIQnJbzptvnW1ihTodwlB486mf61pzQf70vs9Q+Cx1
	 At/UJja7BhXFn1BjLkhnCw8Mo5vxP7J9jXfuo6NTwvYuU47MjPWP2L6pdSxP37PKBdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BbQ2P2hdcvSxuVd0XerZaY3G71JLR+7tFvsWSDDSvFg=;
	b=5QAtlhxyYmz8fq3x20ZkaY7wbaeaZedP3gHzfPbHn9lQSKA2E6LKw5kMFpjjZtjNuBV3
	 Dy56he4Z+WwSyIGF9NwwZsIR70ChwBenOP2R0PT/e0xhA7aiDuZvCWXnPYyXTzYR6eUdL
	 RQeBIzy1XPDQJJImoaUZ+JzVhokaBiJeVavZh0I4exzZT7dbrTMmvHwufniBoqgCUNXpA
	 hir0+rElEiBSIVQYrX8Hw8+2qWm0v9NDHpcPmBSAMrajxykXmADnpNS6s7CSlIa3EfDKo
	 cSbMxsFieA+5Kq5ZtLTpmEWDJFq2x0oNUJbbB3hKDJQhftfrxG0yOma1lKERFAYEg9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkDRkqWi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C830606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C830606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkDRkqWi
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ec20398b05so1396512e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 06:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793454485; cv=none;
        d=google.com; s=arc-20260327;
        b=JjyNd/7uUwSC2R0QVb9fOSm8XLjl9/Al/rPS3u5XnEJjcYSkdkmY8/pjRVj/DMNc5R
         YuJ+8LgHY2BoKio5L4H8+35DbUhlV0wRHTQl9xqlBKpzktJ4GpMzrAu1I0BcMWGfTqUK
         pew17fdsswG+g6ovzUbdM901rFSz5eeIhpdDeVj4Vn6MnzVep/+UYIRMxhqmA7YQKHib
         SPuPLYSm75AqH2lta95kazeVAycFR3kNArdSdbkbR6TPsKqtV3bP0qp9I4viISC7wNhl
         l7qbGaDhY9Yn1qxzotQpv1QHfphr1O4SlLDZBnnXbk886SwQ0mZLhBdIqmX9kc2lPQdG
         iEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BbQ2P2hdcvSxuVd0XerZaY3G71JLR+7tFvsWSDDSvFg=;
        fh=w6lulAegO+hEqZOTSi1TTS5zmPm6Nz07EIUf8z432O4=;
        b=TtOFhfjTvnmSgwD/4ett4pWFXtZQkQpTccyx4VB1xzcPezWgGYfI7vl4faPJ/HfXRs
         6T/F9f36z7dgdKNXFN5jfnfojPuQ40/3dGwUNfEz0eTv+XUuZX1Y74TE8QcVcFS/uzYF
         j1cFbw3EpGXeiclBjIezHOuxREAp5X8WgEu2fCUv/og2Fued2TaS1xqzuOVrIYWXuTqO
         GNj91xgl7RbIL8JvcW4oyk15kSApB6uOk16kSKRM85qG69JEQwGKdKzxuEoUkvSbMupj
         qJLBf9cUl4Qi2NjxmlebstRN5NMUA2Z9Ms31O3n0tMtbDAI8XkpDkfDtUAOKSBc18O+a
         CJQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793454485; x=1794059285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BbQ2P2hdcvSxuVd0XerZaY3G71JLR+7tFvsWSDDSvFg=;
        b=rkDRkqWiP7mYasGzl7HLsSyvzgviydPmn2SFlPqV2nM0CwtFqG7brFBDLIakLKQVA2
         KYxP3jLGnrG+5/8BNcD4wAUoY8jediwgqGrJV0aZiRQiexnGUkOVocxVMgrDQM9UwHJo
         BYu1MbMROC6gUJTqoXAi0ugFZhLv6Xx7i2o1JG6a2veTgUXZ8NQmM+r+bFXZ6d/OWMZz
         HBS+9lUN2pFLAKeGpFmglMR4nOXrTku/FS/H83VOX/8pyj9rI9R81u6lhKqT8+XHIqB5
         wstnB3ykdVefN27zy/RjSJWPZ2oG69ew3Nw1vVjqSV//dkLpJNrV3ZJDioq/Lrw6O/y7
         kzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793454485; x=1794059285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbQ2P2hdcvSxuVd0XerZaY3G71JLR+7tFvsWSDDSvFg=;
        b=GAoSeB7zNEsRNuxEr5D43PL2ezeGeAeG8yhTLVJ/d8t+2MSDn1X/OKlZfsU/vOiOlm
         GEawlyIeYo+GYW67sprOP4LczjFClH4VjJe4tmqpEXBoFijTGqYEXmszCB8KaYnRwqM9
         GLJXGjDi+cp41io0XsTk0zSkvZdcPsCzUMYp2fPQg9wK3SIYxgVlzzie3qS87vxl9vQ4
         XRahygexGZ9tu/9TAOAwnH4M1pbHsl4nVwR/Kce/yW/87xmTNAozP/xprx6hwbWo+tbd
         Ly3Y1It+XEzZt0WbhOQSHpLIbiYHQ942EwS+ne833pG2CrYldnXEJZkBf5UaOtCe3mAp
         OZzg==
X-Forwarded-Encrypted: i=1; AKwUvBxWmW9WgAhK+d+ca+kDPTmQqEri6pKOwL+MrSvQOklMagbXe9Vxp3uPeVmQ3XOl8Ur3zJlno4DhImHpZ1+6DOAe8no=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkV1VUpfvLuCCJIb5V1RJlRi6XDaV3OTVQF3B27DM655ACQGgJ
	AIE/qIADAB++F9h98+Tv09HXe5eseWqrMS7vSOUHk/3LwhNJuhjZM+a/V2B6QkOmvF7WYvtDoUH
	zrVOdletd1rlvVFMy6SiefvWFGo/uxrFUGaBTnFcX3Q==
X-Gm-Gg: AYBFou3ApaItcbyanhS+3zkUAMGPunMTyK3Tsr9SBB3YNT6+Uk8n+y3LgoBqRfKYkQA
	t79N2g+Az3n/aMnLpsa45OWvQ/s94CmGV384P6edvTFgW5SWmynnn3bw/jA0ZKwu64uPmkFRycz
	IEfeT2xKzmLIm6CHOjVBn3GJFZ+WkD3IvTF0AiNZoxzqKhOpQFZuM6Z1A7EztvmFkh8q32ZrqUb
	/+3y5Ahbr6Zh8G3psHDbnoxezk1RGLqlhW45EwS+g7TieOTxAbeTw8ClbpgFlrlZ8worEpARFLq
	QWcwI+G7othym17AUthmJT6wxE9szySX/gxc/Zc81NV1FwqSRJ2lHPrR5UomVfIedMyaV6zCYa9
	WysihKXVL8lj/mvTx905NHSaegWwm16A6NPt5cZkCH2sbI2JAec9SjEzrmQKunqadIgfmXNDX/M
	KXsiAmU0RiThNu/9+MYugfm6h9oHUa05jfY6DS7ocZLglRu7QVg9yWCClk6bZQmUHA9qONGM2Yd
	curoUJ/i8cZqPgIBCoJhKKKcg2bHawb5AcqQhKbMwnfJoigS8PYkeuQ/qrkSDfPl4YRARLG
X-Received: by 2002:a05:6122:2089:b0:5ea:bda1:7689 with SMTP id
 71dfb90a1353d-5ec6871d58cmr2859290e0c.4.1793454485423; Sat, 31 Oct 2026
 06:48:05 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
 <undine-1793452028139689664-4d0bf20c02a1c855@undined.local> <undine-1793453483000634761-30a1647e17bcfa19@undined.local>
In-Reply-To: <undine-1793453483000634761-30a1647e17bcfa19@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Sat, 31 Oct 2026 14:47:26 +0100
X-Gm-Features: AclHuK-CABaNQB74HJ7PdtyWxA8ibq3ZtpeO760CuQ3ML4Pfc3yrhorQo8HvhwQ
Message-ID: <CAK0NWSMdLB2Hcyw64ah+SB2ir+-idmRRDJVDqPZUABzbfetMJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] tools/bootconfig: Preserve tracing settings during export
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Masami!

On Sat, Oct 31, 2026 at 2:31=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Sat, 31 Oct 2026 22:07:08 +0900, Masami Hiramatsu (Google) <mhiramat@k=
ernel.org> wrote:
> > On Sat, 31 Oct 2026 11:25:30 +0100, Eduardo Mucelli Rezende Oliveira <e=
dumucelli@gmail.com> wrote:
> > > Hi Masami,
> > >
> > > Thanks for the review. I've updated the event-filter patch to use the
> > > explicit delimiter pattern you suggested. It now warns and skips filt=
ers
> > > that contain delimiters and both quote types, since bootconfig cannot
> > > represent them. The other three patches are unchanged.
> > >
> > > Changes in v2:
> > > - Patch 1: use explicit escapes in *[,\;\#\}]* for the delimiter chec=
k.
> > >   The semicolon also needs escaping for the shell to parse the patter=
n.
> > > - Patch 1: detect both quote types, warn on stderr and skip the filte=
r.
> > > - Patches 2-4: no changes.
> > >
> > > The series keeps event filters, generic trigger counts, histogram
> > > variable ordering and paused histogram state during export. It is sti=
ll
> > > based on bootconfig/fixes, including the two fixes you picked up earl=
ier.
> > >
> > > I retested the filter change in a temporary tracefs instance on my Ub=
untu
> > > machine, running kernel 7.0.0-38-generic, with recording disabled. I =
also
> > > checked the mixed-quote cases against real tracefs filters and added
> > > regression checks for both quote orders and all four delimiters. The
> > > fixture checks cover each fix and the full series.
> >
> > Thanks, this series looks good to me. Let me pick those.
>
> BTW, I will move these fixes (including your previous series of patches)
> to bootcofig/core, instead of bootconfig/fixes, because it fixes a script
> which is not related to kernel build/boot process but just helping specif=
ic
> users - who can easily get the latest kernel.
>
> Thanks,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>


--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
