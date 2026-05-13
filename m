Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A94DA522
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685382; cv=pass; b=AeZ1Rh9cm2O5Quh0TwzNCoPpyf1pxnv8c+dHYz46vBVYuT2SZrVHceZPDzKGFpdNQSHf27kBMaH9yV+oSfrwp9tq3vZ7gBU9cQKBXSz43MjczWKjGKUvAv+hAIX4jpRQ5cciFKbcTjVXoKz3UWBHP5izKJ4szVEpDikmHxocN64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685382; c=relaxed/simple;
	bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjX0rREoVF2jmEnMjL25lZNnngN8+5P/wCkCPIYvZtwTkzFbTYKfMEItWukTOdkJ3EJJXqQl2Ic/+ExFG7CNkKnDWC+7CdokDpz76U3Ea/eQgF/I5vbwoGZrV3qjTyRo8boCg00HnUde4FOkSuAu3AhIegnPpmLx8vun52n1K/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYf9ReZR; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYf9ReZR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d734223e4so4294577f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 08:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778685380; cv=none;
        d=google.com; s=arc-20240605;
        b=HrQQnNsm67YEEuMjYGWXrDstOMik+AYOEQe8qP7uOuJU7tvuDqLZPtLWrpICWmuGPw
         gTJzUcG1Nzvee0zi+iPBrcEILhalf/IrmgmyTvvyLhWPD2BjkMw5qJ0xJZkwD01O6O3G
         vOzXU6DxP7Izp0QNZ/zpA8ATmHt3xBpuWyYS3jBu4pzsCUjq+EYAYZcZrOoCTojD2qRQ
         fatvBJE14COxjCRSY8K/3hTpvld21jHlJI0Vu0jOJ2nQsIJdXoWmpv/LsQ63R6ilZjwh
         4/ya5jS9e9S8yGXAWfSykuTQqNZIYc+YJKuPyCDtB0vVx4iG5QKQC1l9hDUEeA5a2va0
         UA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        fh=x1ZOX/ZFYey2hnufO10Y1P4gRyoqD600qP1Yakw04z0=;
        b=czjjmR6SNO36/R4XhhOdmu9XyNj+FD1Ur4TFY/K7keBbJade+iZFyL74rQr8f8v0xj
         zKhq+p1HbWRnjTEXWfT79GoKi6iUXfa/1aeTCNfP0bLhZOULuLj9A7pMUO5z7Q2GaBCx
         NpBmOKN+no/ZQL0qGvhbVTqJjiKWB83790sV/3ICeWwktmneon0IqQXQMkhRT0e3KZhD
         Vaa7RKaY74hqDPAnwqHragAWZ6cYd1NL1sJL04nPlIdtc2aIcc90NqrBSqZJhxH6Jq7b
         dtOKZpoPD1mwx0lDIxMvpOKgmKiEjll1Y7pYd6VQj6P/HnzZuQ4e0ADJbV33KlMbNWgi
         0+/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778685380; x=1779290180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        b=RYf9ReZRO1TZr91D6SdFQhXfIE1FZMq7OYS4DO+Qz4bUwBiNTOANNBMCuNOHAqvfqp
         ystNKvsLnaFyhDhfeiBLnEVYQSuFLO/lBZ+kolsZI9bbyGdKA2HjzhgSkSIALcDTq95p
         TdE/Tjksk53u+JSxNgCdqU5S6QW3fkmraOv/5Slb3f5r4uzjhR9pZBxI1Ixfm+nxcHDQ
         DHWNoTxDhJCT1CC7C5KyLAWUAlIk1zTkQYgX00KToUj9QX47aVUq7F16gg+pBkbkn1Rn
         3TPrdMm3jsVs8RGtpMg5vPwnXP2GOPMpVdtM72onjYZUvCAFPs4FRuVqEWmjtjcFSgVF
         0Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685380; x=1779290180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTWd08QYLDoCVU3wPjbZfH0wB1JeDMyEm30KX5aLTcg=;
        b=e7RNTT2JEble6slyzZ3xd5/MiA0cGDEaYJAOKqrD8D5wgMJpoyX3rjfZQxscxpyvwE
         CkLb1harYuVJsrcFgJKPnUmSbjpJWb73ThlcLN0M6It//52O8c2fKZRMPUPZDZ8TOf3G
         Um6uuah83hb7kCcYrSw/GQkjWv0qwZyY7AFkRPR6cb+b4yhqTH5b/hmU4M5oLllMulC1
         XM7JdThAuwneCY7uoqPOq9I3FQPQMdp6Gj11roFeDrTcNbFZN+x6s7kMySv57pJhhF78
         dRZaMAe6oP8tpCOR2VsiKpCBvtEeOWV0q0hN29cDsMEAgSLnOpw5vYoa1cAEqZ7YZ3af
         /TxA==
X-Forwarded-Encrypted: i=1; AFNElJ8js9ASwgWGEKwurURAQw7GP/33lA3KTdeG3sRilvXLkVajJ0MaItRUdro+1w/ztP30cZLoxwUqkNZDI9uqh4Prizs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwsdhuBcy/Fva9i/HRfllmJOw8ddwrBm+HrUjHP4dvGC7dfao
	JlD3dDA226l8YF1oLaY1C3oYPVfJLFhR8G+YdM6Mdi/Bx9IX8aZ8d9kC027Xv2YxAdu30rYsU4k
	kBVQ65nwlH+Wg74pB8tcO208zUAFG6VU=
X-Gm-Gg: Acq92OHsM7QdaNOQYAuBZYkmLMWdETMZoyLaEhO2MFIZClS3VOlSGsGoOu3y/B2f5+3
	fV1L2YXILKzyJfpSJ9yNCo5TjeVHyD5ijBshvDRA6W0oJaSfkFjnPU2Q6cGI66p0IXuqzvpDvLL
	OVIjFHZ9LkVgZnPce+MDm4TofzSeuzA1lEWn9J2VaZimFv7xsjQaTIn0JIZxnudSyR95AqbpYBG
	TLWjcuZ3STNi7n2jTlibYPj9Qd5Zfq2+IoAgJbWC54WWS83qxPXvDAcIoQg5DouYCacc1BD5Pn7
	yZunkH2MPTsaNmUBIYWa2HHBEICzFHfJDCiekCoGUz32e9R+ID0OStI8urYe9Ys60tYetpZLrA2
	o0QV9ZCsod1IL/fggu9TptXIxqFZsWsWcntoP
X-Received: by 2002:a05:6000:230c:b0:45d:7fdc:2e99 with SMTP id
 ffacd0b85a97d-45d7fdc3157mr418669f8f.12.1778685379310; Wed, 13 May 2026
 08:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com> <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
 <20260513111331.7bede512@gandalf.local.home>
In-Reply-To: <20260513111331.7bede512@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 08:16:07 -0700
X-Gm-Features: AVHnY4LJfmK-dE4pIdLQKgR6OWhmqcSutGy2bdmOOCvWq48N6k373-5ZSYGW1q0
Message-ID: <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 3 May 2026 21:51:49 +0200
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Nack.
> >
> > Please stop this spam.
> > We're not doing it. These helpers have been around for a long time.
> > There was no need to taint then. There is no need to taint now.
>
> Hi Alexei,
>
> I'm wondering if there's a way to see what modifications BPF programs are
> doing to the kernel? I try to make it easy to see what modifications ftra=
ce
> has done (like the enabled_functions file), because I like to know how my
> kernel is modified since boot up.

It's impossible to track all modifications.
See what sched-ext is doing.
What does it modify? Everything.
