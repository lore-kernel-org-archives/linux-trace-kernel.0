Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794558992;
	b=TEPSTJJihGdw6uYuEzcEl3sdV2yF3Xmy0+l8GEicO6gQ7Uq3dY9X8GTPaww1QCMLfGv+
	 wjTrWH5t5oEA1wsFWm5NTU8fy6fJZk7Sd1xCfHUNOk2kXA2PzzNK7cRyF46swcVVXIqpq
	 oeRcTaztf4v9MTpbyrYYcOX7QHNaUd8GQkHrrmu3OIXP4nRcUvBn12T+SnoDN/RV2smOG
	 xUOtbB7I/FvXDgxs6ruEFq5pPaHVP6sOwsXy+In+cygWMwUrS0hDxQgY2tuXzhyElHMmm
	 NbnOC/vAmKHCSdpVnRssK/AoLf9ZqkHJlBQM92/1RTksWT9iiQor7pbpuuPDOE7Izcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hxmzA0feh91DNcIpNzzQx0/hKehxa0qmErlzD8WJ5a4=;
	b=WycQiutPVT7IpjIPG4x646aXqdWkw1/mhzLWndOYDow7iJtm2xps//H2GcfPzQFcM3qk
	 tKcqL2YF3yTbzsxQ+qHzwPQQFN+Gj8GY8BJiTWBpVG15ehBWSHXBhAAbOgWBI2n5JxdIC
	 yv5AydvPh4cEgM1SOzFczFZVqgbhnKKGlKaiz9v29AlNTT9UjIW+/t0yJW/It88Vs5UQA
	 cNzcDn+Gyb4Rk5miwWX5R2opcfE19nG+MX33aisdCXe8RMxYSp6LbaIMJ5xZYjh788dbw
	 Zz2IEbAECEi3xdvh/fSNNir2juRQNcAF9aREdFTf2hmKz9xdLs+6MKipfn8ukaC4WJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="sBm/Uac7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44688606A33B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44688606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBm/Uac7
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eae1276409so298971e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 00:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794558990; cv=none;
        d=google.com; s=arc-20260327;
        b=AyoIzIUZpxeWBbcwodhSg2t3/4ga3vnu/k49ZUcNYn5ndKgL9WdyHN19bjzEwQY0gJ
         4SkdcHwRLE5BmcQw7RdZflJbV3oqEt2mDotScAWX3aA8WU7L77zd9YaQPljZN8pFA7DZ
         z8pxBPJWkXI6yuc5UY9GxJsS1Iu2lxQ3Cj0TTZnec78OG5kXS4gNbl3J3P9DZ/JFd3BM
         GCKi893l6VHXRkBMKhgWtsAyu2aeQnrwC5p7yu0FN8AHkaDzpqoQ4LOAPKMT8ER7aNEt
         Ecv+lyJQP5SlhBW6NKNh02u/SdxVowISCEn12RR+vuEg0+so7eNSDeLGGHFR2BV6SPkb
         HkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hxmzA0feh91DNcIpNzzQx0/hKehxa0qmErlzD8WJ5a4=;
        fh=i2keD6VjLKHA8bsHjyK22ncxodNfp3dcZn4HUg2DeUA=;
        b=OPqrGyFoRHPebLfwgT9+MRCYr28AigG1A8i5/6OS9cTGvZ5rIYyo648XpSEFc7IOND
         AUuz/T+tltSBWKhIh8RptvxcSm+tK26n0rag8fphjZ7dLZ30zVxwCI2d6YdQJKvJTpuK
         5kg/qCNHf1SL1oEOGrRBY+1IfJCaDht1peVQky0o8dBP6MbEgcGwUbmIfQ32s0qpaF6Z
         uZgYo7mlkFCAxMSWluCWNSUDZLkdMgf9R7ufxQ0PVetfdMGvLmnNfCfF0ucO72l2FmcR
         rOGlgSbEr/QrxT1ruRD1R9FueskiUmdoNmLKNe9jLxRlCRE1H7j4jJnIWA6+AjBb5PxH
         QVzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794558990; x=1795163790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hxmzA0feh91DNcIpNzzQx0/hKehxa0qmErlzD8WJ5a4=;
        b=sBm/Uac7Xy9miXA4791/toihhk3ivVTr2fXA7vyOLLTcnGLV64AUiOBUs9v2eyclYK
         BKOVWiHBXDOPob2iemIB78h3nzKegH8nx035uKSM1NfQZ6hzjyNx6fGxSSISysmWy6M1
         NEkifNZH2XZx+tmCSknJgt5Df5U3x8n/kaytyl06nMXw55dSSTGbt9tPirhxdvrflvGr
         bM0HxUUDqmcqtKDXUJ4P8YWWbIb5OrMQILt+wj82f5h26UQlh6N07v472GTQLsdOOKdz
         fAqbHK1BdqMl+fHxz9+nAnBtWL+rholojpZJXOxmzNTKc6OpVCed+gop+5BdCSYHHKnG
         4E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558990; x=1795163790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxmzA0feh91DNcIpNzzQx0/hKehxa0qmErlzD8WJ5a4=;
        b=rZXVFqJ7rQD/9TEq5B3dfGjwYRlaSKzfaeBgCZ19b8UoJFYIg/wN93KBxFFwwy53rY
         LI7wCMjkQKyyv8GnkaALlXuEv0zHf7+PyrltUXKVf7UMEe4x/Hyd7ust4rIZLHU5Sldd
         JTh0lmuj80Q/9IugVWUkM5s6VP+O7yMpy7gwdVcM7NCYTun/rSJHzJ/8ViuZpfL4x5UJ
         qEQVp/JOGZG6JpKDbexuj9AGX24kvBv8Dd+Zj2jvVN4k7wHKbB5WmHOkGmvFkqVLjHqd
         GuhMUPBpmux6tMac4yxxIl8UmTYF4rpm/JRn2+f6Gb3JxKgrOj6P2mJUsNbW5py4ePAk
         F2Fw==
X-Forwarded-Encrypted: i=1; AL+hErHXrrrPd0SnyG5ESZGSSp46uQ8pdYASIv6o/jbH3h/h5IH8vNKj4rjwyFrB1ZU2rbT2T/7wp0veAF6oVmBFVS/b+ig=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8N0zkaRNHwICWPlA+XR6qDtfY8HfmzqpGeZOZGVNw1vtFYSo2
	YR5DZkHg1ARmTcW4G8EPlAQJwmrcKTpY3pzr4w0pFFwlQv41QDjSsYEWYbjyXT6R4Jb5T0udkko
	lSeyOrJ1SMqRtXeRX5R9LW4OBD59X0MP0O4ZB9/8=
X-Gm-Gg: AYBFou1xe2WigE2JwP2UYuzGYBiyyJPjuMEcUzBoJchhevDmUa9t0bJnGyTsxdTzRgg
	KMAxgd70w6UEW5Y1azEd9IifMqBGASfUHnCIz7zVx7zYJxfVARyJv9zRpLMOiObBWSWcRn5XAl0
	Boo8lyYhLFIho0Lo1S3Thf063RFyTN5zmKvYmRfy8btcfGQ32XAWubuoX2OThkAJNDNun/xm0PF
	5dpvEaxQMtIKmG4zA0QaHi8WXmT17qDcJBPAIDQQD5zrK4vglXnF2OPbYft8WsEo9EK/GKlGWul
	NcBubIt59dnmqfh7Npn3rq9clOtcBPJ2awqK0ywFBYOzxM66WrDb8S5pe7kCztUSTvLWu62BJ3q
	5w99OxOUkVeFTSHE2Psigj9n5YjXtNd67MP5MJxyx44+J8O3pDdX8lOncWwzIdqWPgN8FgkFTVw
	Y8BJ9sC9xzy2toMgT4s2ZKgH1G12pYyDwe1iRQduB8voe9CWNHt2gvoeFIXCFLGE+DghU3doHT2
	0gjxhn/mLfxanSbqh2QuABdqT4zOTRI7xOvxJ+PfYBF1WIewuECfN+y6a5nwUIjBEqyqSOn
X-Received: by 2002:a05:6122:489c:b0:5c9:a60d:3276 with SMTP id
 71dfb90a1353d-5ee34a5865fmr541373e0c.10.1794558990121; Fri, 13 Nov 2026
 00:36:30 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com>
 <undine-1794536932799279555-f9c303a1aba9ec59@undined.local>
In-Reply-To: <undine-1794536932799279555-f9c303a1aba9ec59@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Fri, 13 Nov 2026 09:35:54 +0100
X-Gm-Features: AclHuK8K0CTjwHiI5SVtOzSff1K3qWkjs_5Yb1Q03kRVurlcRWeppGiFjFExasw
Message-ID: <CAK0NWSON7B00NfsGO09preBcQXSWtAjkvpM_Cd8vJTao0QLQiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bootconfig: Preserve values and key paths during
 parsing and output
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

I do not know the jargon in the Kernel workflow, but I imagine that
"checker" is the flow I use?

* Custom Python reproducers and bootconfig tests
* GCC AddressSanitizer and UBSan for the runtime errors

Best,

On Fri, Nov 13, 2026 at 3:28=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Tue, 10 Nov 2026 20:08:44 +0100, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > Hi Masami,
> >
> > Thanks again for reviewing the earlier fixes. This v2 addresses the
> > issue Sashiko reported in the first patch.
> >
> > The parent array in v1 assumed that the parser always enforced
> > XBC_DEPTH_MAX. I reproduced the reported overflow with AddressSanitizer
> > using a 20-component chain where each parent also has a value. The
> > existing verifier skips the subkeys in that case, so the parser accepts
> > a deeper tree than the formatter's array can hold.
> >
> > Patch 1 now checks the key children to determine whether a node opened
> > braces, using the same conditions as the forward walk. It no longer
> > keeps a depth-indexed array. The existing verifier gap is a separate
> > issue; this revision removes the formatter's dependency on that check.
> >
> > Changes in v2:
> > - Patch 1: derive brace ownership from the key children.
> > - Patches 2 and 3: unchanged.
> >
> > I tested this on my Ubuntu machine. All 137 focused checks pass for the
> > combined series, and the full bootconfig suite passes after each patch
> > (86 passed, zero failed for the complete series). I also checked the
> > revised first patch and the combined series with AddressSanitizer and
> > UBSan using value-bearing chains up to 95 components.
> >
> > Review: https://lore.kernel.org/all/sashiko-outbox-207566@kernel.org/
> > V1: https://lore.kernel.org/all/cover.1794333957.git.edumucelli@gmail.c=
om/
>
> These looks good to me too.
>
> BTW, what checker did you use?
>
> Thanks,
>
> >
> > Feedback is welcome.
> >
> > Thanks,
> > Eduardo
> >
> > Eduardo Mucelli Rezende Oliveira (3):
> >   tools/bootconfig: Close only opened braces in compact output
> >   bootconfig: Trim unquoted values at end of file
> >   tools/bootconfig: Preserve values containing both types of quotes
> >
> >  lib/bootconfig.c                              |  5 ++-
> >  tools/bootconfig/main.c                       | 43 +++++++++++++------
> >  .../samples/exp-good-mixed-kv1.bconf          |  5 +++
> >  tools/bootconfig/samples/good-mixed-kv1.bconf |  5 +++
> >  tools/bootconfig/test-bootconfig.sh           | 29 +++++++++++++
> >  5 files changed, 72 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: 677f83795fdfc25ddc51b665a9111f5ff199f7ca
> > --
> > 2.53.0
> >
> >
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
