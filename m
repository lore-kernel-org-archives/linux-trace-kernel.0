Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B416257AD1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493298; cv=none; b=m0qpBmXDaZbqCoMvOCd2gLHHcYaOPgNrYouUaIvyJ1amNlcQlaiB0b9gtiDePFpZQcv4FZEZgOedIbTtVqAXCHERRksof8REhDq+8fXC9Ra+Pb5T0kzU7EKoDll/tpft7enRoiFQzejr/oIbzu9v2YXe5sRnk+5iqIlYYCCCTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493298; c=relaxed/simple;
	bh=XurOG7TpFv0gfvogsJdszOTmGbj6A3F6k9kfoi2F3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgv++HytTexxwoyJfkG4nvw/7xa8GOMnNjwu9hipqH8mzh4+PMBMxK1wdeajHqw87yeHw+ZtAvMcd71LeNNihS2prQm/g9ZwJgYi3nYDruJu/ctByhtr4EvTWR6iOe4CLzt4lIMbuskxEecEMgCXL++8JcmPw+3iuwxzAdHjKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czvnqr0N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czvnqr0N"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e29d65728so35671135e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493292; x=1761098092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=czvnqr0N+eerJQJje/D9zgReXoCqNulL2VXNWGCfXQVudLbXRhpBBF7YmuXQPPZsX/
         gwqPz+dRamW8b0IrM7qXvag9sTtTB2Kinrl5LVOlkK0Pd410p1o083PYQyoRp7Hyik5Y
         6IzUg42K36rOajl5Mo72GBm0excCb2CflRNcpQVCAxGzfeId4zFPyKW9uJG7w5ktjiEl
         UTBQyVVaNNzheeSZe7o7Z+7c5JNRTT8cT0FEptwWGE/WsANYHPdXXxbuy9IM7NAMw6cX
         Oy8MR0Snt33xXmbduFw6CcYDhWw5eO2VPXkGnZL0zTdrkDrv6hUWxeXQsmLhBf3RDocf
         bfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493292; x=1761098092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=XHYo1RKV/0veyCB96c5yOqJo0JP4okG2r+Vq3bHD8JSkWmvYFk9ZdFTdmgBFE+KZNX
         UMS08Zb2IWnnIBejToFXtnf4SCc48K1LD150jFKyGkSUdn2f2FVeM4ly452xyNwnSVry
         MjYxaMeEYQqhfodf6ndZs5zd629W1Q79gMhhLN4gYBnoAACoNjZXLXanMxdf/tqTjitN
         gXxfcx4MPgv4NwxNRE75qf9+LD7/I/2mFYTSEJsXpgXvPrArbOZfZbB7GXgN/wC0ox5W
         v1L1Xii2oqXS28MW7Q1THQtE5qgIlP2e2/4hZoxJDwcr5qdoPb6aw4idBaInnk1hxtMi
         Xd0A==
X-Forwarded-Encrypted: i=1; AJvYcCWSwYgBNOgsqvcbWatuRM+GOPgEF5jPhR41UEmWk7AmIgKjFYKbRkiKWy7wsJKMsGu4zDaYTdhkAnpp7Me0MmgQtl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw413wt0QhEnx76zCBbfIPP1/beRVkXEwiEIjoFlEdra2RP5Grl
	N5Y9sU31vIIKrcN3RwoQH3gKiAHKGIQYVd9po8eWx5YaxhqY+7PvrBnbCwcoJYqxFcr4+c2Xe5v
	8GVmboQl/qXx9pKIZtL8vEWmgJ5rWlKytliF7
X-Gm-Gg: ASbGncs2z/ko7OvrogwTWxBrcJSkMt8kI0N9Q6CkECATeN4rsdFEbKeR2NmS6LZtawB
	NdgdzpyKNVagsv4wMO4fByTwhiV2G8DqgNSTK3MPOgSk0u/cPX/JS9TtLp+FzHXl/8MY445Wn4C
	e2p8bMCyKDRelgidmDKH53qjG2Mqc/EU3KNpGLZ4IXYEaFPD0waYWC6dNv6ykSIKGvZrcOQF5L5
	tbu7wwGQsqzct7BaM0ehE3ED9z8mVnhfm3Yr8U3T+rrqjPpI7JDwg6TkUqes5ftiF9s5A6wCHZC
	Gt0m
X-Google-Smtp-Source: AGHT+IFwtktUuLWBY0+rVfzsz1di7iWK0c6AtHOqKHIJNThUvRz/7fvIWwgTANA7fSwebNkxx9UvlZXTBs5LRF3356I=
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr167355365e9.23.1760493291529; Tue, 14 Oct 2025
 18:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com> <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
In-Reply-To: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 18:54:40 -0700
X-Gm-Features: AS18NWCKhuwcHSlUElwUIAzX8T7zdY15gvsdXmPJO09MLBADQKHWSXQwuUBXyho
Message-ID: <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> I=E2=80=99d like to suggest a dual-mechanism approach:
> 1. If BTF is generated by a newer pahole (with pre-sorting support), the
>     kernel would use the pre-sorted data directly.
> 2. For BTF from older pahole versions, the kernel would handle sorting
>     at load time or later.

The problem with 2 is extra memory consumption for narrow
use case. The "time cat trace" example shows that search
is in critical path, but I suspect ftrace can do it differently.
I don't know why it's doing the search so much.
Everyelse in bpf we don't call it that often.
So optimizing the search is nice, but not at the expense
of so much extra memory.
Hence I don't think 2 is worth doing.

> Regarding the pahole changes: this is now my highest priority. I=E2=80=99=
ve
> already incorporated it into my development plan and will begin
> working on the patches shortly.

let's land pahole changes first.
