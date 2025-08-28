Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD19278771
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413759; cv=none; b=D5z7yPaIKH7nhezPFSKgl9GG5F8X/FJPYpSrkfj5Rgp1N/JWXn/Z60tFj5JgzvgcKmbz92GQD0lES+NTnY3X2s2p5+bJNHyNnc/J03Z1dEFDii4me1Mf+2p1/T+Bvbw1b0K863Qh7aw0YH0akwa4HDLYp4mQVuotzl4dQhZqovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413759; c=relaxed/simple;
	bh=61464PJI4DWr8JkU7InPmzajWChIA2O3MGIoKRnsdwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQaYeE3FUUBje7dwJegqWXicseoJQU2fImqpGo69xn/wA7BffaeayB0Eyj0B1jnPay7Div7kFP5tofLTDpV89nu3fpRlCFThzAnCXM6zGUP8NMWyCDOV6EhIJgHpIYzbFf/19Eo+ICQ0PMIk99JHAI5ybeyVyw83e93xpALIcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T8EIouBG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8EIouBG"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso2614255a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413755; x=1757018555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=T8EIouBG3D2Se6+lZ9Y8Y6gs3nrHr8gKHvLULn4zm17Zv7dekl8BbjF1sl6ZylIH4g
         2IlPw/y0jLPMGScgpU8R7h2BEqRv2G4RxrvCHlcxYfSForyG7RPhhGf+CFCgUxeTDzpk
         2GZmqIJn4cELT7HvVtPI3FBHZGilANs7ztFOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413755; x=1757018555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=JB3MDw3IqTghP8btdUN42y2mYHMf0By7O1a9d5XZzr9hWlSkJs1p1qHcPsn3q9IYmT
         R+UjQdj5sW6X6i+S4tDvbnA9g12hgEceGhJCda9BNB5qJ2mupQhaQWqi8HnTudfi2Vxy
         RkdMLG4AZfsIaI7U/CeLxi+oV99gUvcEEVeqGZZgUO8aJ6n+wRmvBiChTsYGPrnA5E9H
         OVKJ9EOil83qPO+m4g16UlaBJa2Xl3ux//endD44baivC4NvW6sxPSfXVn4KMwSG2Ua0
         Ng9d5DQzTg8axcuVKtikqiGE2Y+8iMZXhODvsHX13B0o/cKTr5rVo+TnyluZn9DQ4JKU
         /mow==
X-Forwarded-Encrypted: i=1; AJvYcCX//7aCp6epN1yMaV9XDH/qQHFDcdPhZNBo+mux0sTY3+8yjcXagaHfi+WcnxqjFbsn89pEUOBa7o5bnk3kObSXa/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKmlNdGXYcC+SOlCvZ6eokw6oQA209wLMbFle5ym3pnb63v7U
	f0XBcR93GqWMPR8Pd8iJm8m2HPuYU1xf2sByKElKfklw9e/NcRTgXeoQYF8KQBKcH8FHloandHD
	T80kloZU=
X-Gm-Gg: ASbGncsb+21RhP5aqBybFKZPk1/56FFQbQlyFnRtD3bmc3M0iYtlm+1DLXDDpKYNcGW
	OAl1gEI3ZIPa4rNoHD/zNgu0sGgGwLg4TMjcYHvgzKVyuNenFmv5whE2vTEEdX3KShhCDQhH2hW
	pOWRF+Mj/LtfG3AjCTShXtxql0ZgK8m+Sd84O9t5DUkZkiMAj0lrGAFJKuFou9f7lSdoXQmDqTm
	4ZzuKtb66QqWfaFW+ZM+lGQo/8mDAy8XSJ2bFiiI82bjVA059qUcl0o5Fnkv0+BxrfMNAtO1W0g
	nuJcsvX1ABtDtabsMw2P1D49y/H0hIVqRZoN82YxfFcgK5EDIykdEe6R1FYYx1xJG7iNgI5aA3o
	kE1IsZWNReD4LbP7PwMfTdv7h7ilZOinBCyWfMbbk2z9tLqLjKQWO3T1+BvwnGAQVxejSZBwRCh
	k48ki/bLE=
X-Google-Smtp-Source: AGHT+IE1FA4ALwy10exm7V2Y3G5dm+/gXjk2wGe2/4sHGUmAvXYhN89dOYLRziB3MfXNFxHZ+TMsvg==
X-Received: by 2002:a17:907:9444:b0:af9:bdfd:c60c with SMTP id a640c23a62f3a-afe29446f75mr2100781366b.47.1756413755288;
        Thu, 28 Aug 2025 13:42:35 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc6ea3esm33600566b.109.2025.08.28.13.42.34
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:42:34 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afe84202bb6so175908766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:42:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKjp2Vh37fXwWI2Cwol2A2UyIXzG8mJd0XEG5g85hWEFGAxVFHNQjevDgkZBy9C8zMVrWkVtBwnGgCEnKfJhcfk0o=@vger.kernel.org
X-Received: by 2002:a17:907:da2:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-afe290466e3mr2506319066b.31.1756413753770; Thu, 28 Aug 2025
 13:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
In-Reply-To: <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:42:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
X-Gm-Features: Ac12FXw_0KhKfihCzO_aKUdUYEG3s81RDFh7edU8NIuCUQQEYmMIvEmP-xmYRFk
Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:27, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> The path name is a nice to have detail, but a content based hash is what we want, no?

No.

We want something easy and quick to compute because this is looked up
at stacktrace time. That's the primary issue.

You can do the mapping to some build-id - if it even exists - later.

               Linus
