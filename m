Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07822FF22
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214597; cv=pass; b=Pb/0AouM3MTWTlFF+XW88pwLH6Yguzgr6L25UEN8tLf94824aGsWZq7dCQshMAj9liN0fnLEP2oahd2YCFugqziC2EWcF0w65UGo+uaE3B6TSabmBXuZpY9RB1LAYtpbK+PtubMcMkCljSnWFEwAOEnCKrv3V3ZYK4+bBTjhO4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214597; c=relaxed/simple;
	bh=/uvihP7EvEzxoRD1cG5Jc59Kwrn80ZYeZsAstsc84E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D80hSq1751ik7BwL6Q72hTPHLDVbDfDEv26c9iZz+tMfybiPRv2TCzziZKeLENXwjJuPdvcA7dZQ9mRD/p/ZskmqCmxHjsZMPg2WRwuTHzoYSWNUggGHw1KoqpLOr9hRfb1tz5spKamuWxPyy4u0bAmqx/09LWoY2Ak9QX+8DTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XScs5C4D; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XScs5C4D"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b88593aa4dcso954727066b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 06:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214596; cv=none;
        d=google.com; s=arc-20240605;
        b=LyXPp7Vy3YlC41wGIbXTlV66aZkDCf/PLOibE2IQ/KF+Q81cnItqnQhIhGyHfsQ6fl
         Hb2n03If7/gXPkEeqlVsjKC6VSrD77wMSElMxX98zKFLwB6DXVYYbS4pxZqJ9TFTp6Ga
         vpJ14xvWD4gvCEk2fVFf4ekXZVEHimHmrCdLSPasFW07i9/7xNFJ9c/LOsEAWkAukYiz
         I9H+Grp6JLZXnOtfu2nhtYNUadYvWmZPBEU2AF0gEzG0yBRVtC/vo9UA1ERsOTwHYI6/
         CK5h7lBPU4rqj9lC8kC1t5GDsEOT4NCsHWv/B1zQKgWWEMJKRQAF6xXDZLKqlegQPcis
         BD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        fh=kJzs6q4HAj6BSxNeqYV5OLaMamUqAToGPgUMd4eRQ4g=;
        b=XQxM/HVHFrbW+iz4W1xe8RsIBkrbhwzfhEEW1z88VjRl0M57OKM+ysWMCDIzjuuAii
         9SwPz/qhdNUjtMKovAZ8vIiPH7DMyVCtzFetQBB/oxS5W5AeaAFf+MJuXLCUpgm7pD43
         WJ7WN4SKwXcGnq6iovG6a1dQm5704qrZIKaFdarhTYi6OL5/xuy+JQaDgMfAKEQhFwe6
         Uh0HYKn9o8Hm3NpzDAarfUEj73a1K6lRr/tz808rmZPWwjApDjZwRkTI6zJ64Zm1Fwux
         3XKAc60NPKUGhbKQVg2a9e5GCWfS76pWZWQ0yrOEPvx7n90A2fIvcrRqdhopO4eh9AZ4
         6G6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214596; x=1770819396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        b=XScs5C4DwTKr8Z7HHkXFnz1Ghu/0/vedqKny0908DhNzJihLnodLUvVK5g908xQxfE
         ZtpUGttTBoBoiKohCit2SCwQN2UQNQCeFB55Alvxu7Mk/Y9H14SSpqk6rB87XRRudxoE
         JIu36pjwlZ8Jm/kq3uQbDmi+lmId+wEOfY6A1VaSuIkZ4yZNk3qlXMtgw/whF0DDViv5
         N+vLDtI9tAX63UAndJyOGNoE9MgUcxSXM+wylIkIhRUI1v2jx87DoJzsxbcwFMgCvqRT
         YufAEdPTsUdmgZy/cd1uBkb3tAAl21T9UJI+NxDV9o+bwhG9bIdonzlhdWphLPpHOGsJ
         ep7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214596; x=1770819396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        b=lQqZcQH5dK518YS/fS6BoYxtpYSkyBlZo/aoaJC+p3nj1IrNkHsB3VoBADicC9g3NA
         Ba5s1+zaiC8HTrvSWpGhcppdxXGuIKZX4p9CmHif58ZywzV6YNVFPZ6cHHh/gKfir87R
         bLozdn1Hi2OKurebNfALO9Dteu6OBN/pX41HZASJe5Vb36n8vSqDdKeb3tdTrdDEg5or
         2s6Yofv+lH+wIc9LHHoXY1E/4P5qcOtGYKcMbmTfeaajlzr3egWEZ1KPOl6ShoavO5dE
         ItmcpFQH6aW6FS6RZLLqxhFTFemqc4EPV7kJhinjVs304b/w8NGuBVh2AKXOTRv/iM38
         5iyA==
X-Forwarded-Encrypted: i=1; AJvYcCXsNbzTsoW++7WJp4hWbDY1g1K6OX60LUgSGfMmtlAwuheiHSxYyW099UyThuqMZSvbEPyucadoS9P4blTWgMF6eFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xKEnh0pmyCTk9LB6kT8OOi66yV+iX/JFHWFOf2VQb5P6yHI+
	04RfmRtI3QyFUOeb5LUMsgmC0+BU5LqIgMBIjYNYFmR2nEz8OK2eVmxwKASwoAbnKaein9mbigd
	ffr2fC8o/JZlo2GE1YcW/0BjX6veuEaU=
X-Gm-Gg: AZuq6aJFtGILeXdxAT4Sa5KlzhnHHpJJ5H0SSOBiLtz9Vg+0r7ire/Bml1WM2ZlkIHV
	9Q8MkA1WVWCgtMAr5rcxBzhDK5EEPm6tcUpWmLkhK3W3m+6b7iEvt6uOmKzZW86ITNYAWFrW5WL
	nZ8PgTHf7ekWsLj8InKv1t2hXZjgxHBbbj7n/3QoxI0SaB4UR35Cq1DLV2przDxxBB76ydGbZL3
	3VoTQFmWiV+ot4MK7do98eGSbd+uv2pNAYaExO20H9JPJmcCV6K6YTrJV9H4U2yipi5tqN1
X-Received: by 2002:a17:906:6a26:b0:b86:ef1f:6d19 with SMTP id
 a640c23a62f3a-b8eaa105212mr109290166b.59.1770214595769; Wed, 04 Feb 2026
 06:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com> <20260203101707.52965eb0@gandalf.local.home>
In-Reply-To: <20260203101707.52965eb0@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 4 Feb 2026 22:16:24 +0800
X-Gm-Features: AZwV_QgWGCvg8g2Ns9vomUQYUfDH4ZiKmkw9hkMOoT3Tdq5N5y2-5kD4RLk-iJ0
Message-ID: <CAErzpmsjt7=EsLZfSMALRTM9ZBKPDYWGWE9__w49OTk_VL+4hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 3 Feb 2026 21:50:47 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Testing revealed that sorting within resolve_btfids introduces issues w=
ith
> > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > invoked by pahole. However, it means that we need a newer pahole
> > version.
>
> Sorting isn't a requirement just something I wanted to bring up. If it's
> too complex and doesn't achieve much benefit then let's not do it.

Thanks for clarifying. Analysis shows most enum-type btf_type have
small vlen (78% =E2=89=A4 10, 95% =E2=89=A450), so I think that  linear sea=
rch could
be acceptable.

>
> My worry is because "cat trace" takes quite a long time just reading the
> BTF arguments. I'm worried it will just get worse with enums as well.

The delay stems from `btf_find_by_name_kind`=E2=80=99s linear search over
vmlinux BTF (10k+ types). This was resolved by adding binary search
to `btf_find_by_name_kind` [1].

Performance tests [2] confirm the improvement:
1. Original funcgraph-retval:
# time cat trace | wc -l
101024

real    0m0.682s
user    0m0.000s
sys     0m0.695s

2. Enhanced funcgraph-retval:
# time cat trace | wc -l
99326

real    0m12.886s
user    0m0.010s
sys     0m12.680s

3. Enhanced funcgraph-retval + optimizined btf_find_by_name_kind:
# time cat trace | wc -l
102922

real    0m0.794s
user    0m0.000s
sys     0m0.810s

Binary search reduces overhead to near-negligible levels (0.794s vs. 12.886=
s).

[1] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gmail=
.com/
[2] https://lore.kernel.org/lkml/20251209121349.525641-1-dolinux.peng@gmail=
.com/

>
> I have trace-cmd reading BTF now (just haven't officially released it) an=
d
> doing an extract and reading the trace.dat file is much faster than readi=
ng
> the trace file with arguments. I'll need to implement the enum logic too =
in
> libtraceevent.
>
> -- Steve
