Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8628727C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063958; cv=none; b=GHAn8AQI07jAZJvvCKJj6C4zQp9ihVrgno+CGBm/8WpWoW0omIabTnpXcRMt69qTR9CrjoK92CfCg2WgDufu2K+cCQI60moD9Sxl797H+4lB4+TrjXcLCwNTd6pdYRBcUFVgLdU3Tf1MNqWERuzYfWdcaUrX1PUql1zlARFGjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063958; c=relaxed/simple;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+erfT09DRBN9VL1aHYLjBdu10H2mBvMtFFpS7TCGlXgAashLBT/T7azmh9YNriewQ7iC+8YjCXGQOpE/6dys/XSBZfgPyb6WFihYpMlIvXSxEJu0E4053n+WRRLq+ieJLIHqTSbnIx0n/MZGqN8B3Ok/zl+y7r1apZS857LJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AI381P0r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI381P0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754063956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	b=AI381P0r0ioz3VcDtzLsdSkl57i8MbBG3ae2LxNV/vb2ChX3HGNtzyNMzK68FOSTp6Lhuj
	1VZxgyvm4ge2bdey9Ky72fbtqpxrfCSglu/uOw8QoJ2Pa2jpzA+ugmGidNwkxAKZhqbPMu
	73d2dpk1lrAYiMY7J0VCP29/11TwVZY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fpytRtgyNwKHB1gI9sGU2Q-1; Fri, 01 Aug 2025 11:59:13 -0400
X-MC-Unique: fpytRtgyNwKHB1gI9sGU2Q-1
X-Mimecast-MFC-AGG-ID: fpytRtgyNwKHB1gI9sGU2Q_1754063952
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade6db50b9cso185738166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063952; x=1754668752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
        b=wykYpbImr29csKXwnRHUCXC+lwgX2pCzHXF73od9XGN5WCiRR+HbL1cFzaL7SPICwX
         hJvSXb3YF5SDElGCkwOvNEaxIq7RK+7z5FihOW3y6/4foZJFNkX7ZzVLO33Ls+5mH6v5
         8UcAjXrmPU0wves/MW9RlY0REK4x2k4fAhBM4Y4O5lyXGBOXgn6CpxXuECNEUJ4tn5gL
         bvga/jHkAKJt6gN7Ok0+Ow0yTAssTjckN4/mKUF46YDUmx/Nz7Yr8B2lYpDWGIH1UjbU
         I9dLh3sKWoEwCqoycOtqZaVKbwibvpKZrAN++yvqnzcE9gIGYzt9ZCLzmYGCqFO8fzwp
         XzVg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ul5byDWv0Lccel9if+BOa5jUkUaki0UkafRA5fLtFcvTtfYx5h086euUV8/5orPZmqT7hJZyN78V6Fre06Y33hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxguOvsowjmkCyn5pzFBKtZPTpyX4kGz+zDiMUjYiv0BCdA/vDQ
	EQempDOVZnOp20fgoDpiQvyOIQX7aN0QTLPnbtanCX/PfJhR1m61jF3LvqpE4oNFWHMSwzPQFwB
	cPMtNEuTkcpUu7C5zYhiC1mZvgTtTnYWkGOKvDvWXg283ihn0O2Nkx01ygVxIZGJz5JeYe4K+s2
	FuZZdDR1EFJGJtCX5H+yAB/7PH7VBNOFwhUid0CpBG6jD0EFVy
X-Gm-Gg: ASbGncuV4LHt8bdmH6xDyGTMrkHKMDRebg3acu536V8Xw/CN1MsLQR6LKzmzvPsdl8K
	0EjhNVACpSarDw+7+/kgwmFDMkhENmH3Jt2iDySnX0mSrOiSuFA6X/Yml4FlNCoqRLaAlNgtNmx
	LBG31eoA6aXwQarhlGCk1KG91blcQw3mTvmSRp6+bNtPk+BCLTDLs=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id a640c23a62f3a-af93ffce9e9mr31676066b.9.1754063952286;
        Fri, 01 Aug 2025 08:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gDLgqDRY4tShzR8qch1OHQdTeFZwbZn86L1VGXm8xMl9d9FjpVxU37mgy2WPfkCsyOBoNeq6AkntpSnGTks=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id
 a640c23a62f3a-af93ffce9e9mr31673166b.9.1754063951899; Fri, 01 Aug 2025
 08:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
 <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com> <20250801115649.0b31f582@gandalf.local.home>
In-Reply-To: <20250801115649.0b31f582@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:59:00 +0200
X-Gm-Features: Ac12FXwcKBqQk5Q39rPaZjcF8K0IpRgeY7lVuPr9-grtekwZqZCa6oQn2sVe4Us
Message-ID: <CAP4=nvQEtaMY9t81ZzyWFtDzy+jVfQubotW7ypg-Kt9aoA-hbQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6K1jP3ojxjgcU9NVnx4SOJQQ2T9qilVShLpCwhbRYjA_1754063952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:56 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> But regardless. This will just be a difference of opinion, and I respect
> that Alexei doesn't want to use it in his code.
>

Of course.

I just wanted to point out this is (in my opinion not nearly) as bad
as what C++ is doing.

Tomas

