Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3B54654
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468570; cv=none; b=Ll8ZyB8VkA8PEgVbATzwPJLdTX0Yeaw6sjPNz9jVLfIMsuUKwfc3vuwtc9aCbiGOO0c2vH/OyplRT6CGAB402a1cH8X9CH1dBjzWGgEDNZQbXDoVxmXzkGZNVJTKQMb4noczzlE89JB4+PVMss9IYh7Kjegrf5Ub55bZG0Z57XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468570; c=relaxed/simple;
	bh=OUTcZq07JBkgTrYml5GuZJ2vQhCaARTC9w+Z21EM7tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYGNnIq/yi0AOuxqtHtrX8PDlhl/+s6QLuZlD5tU2lLzUefYR87pos0Ca8btJN7vZf6trNZk9TL29KkOMfYFTYOakgAbAHQorVrWhx3BnPpv0X62tWZQDSRaJph5sZiHD3EHqbSOYsD7SS/BG78T+uaGARHoblD/PTTLhs2sU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QRcaOUvl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QRcaOUvl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so2084634a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743468566; x=1744073366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqJ2N3VREVt47VEa4RxuNWaTBMsssQWWo8kvJYNbQLk=;
        b=QRcaOUvlPOKx8CF/pXQKGrqy3fS9mIj8ystH1ObZE+7CIHxDzwmcjsTxxAfatgEA+T
         0UJvUCOwPkFq8Rw2ohVGu2Gg6ukn2iEuZmfPNSrDtiocEO/CBl7L1lo4RZH1t3jn9Ljq
         4jiAhH3Lcqo75qbRDewmVvWymwBp7d50XAJl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743468566; x=1744073366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqJ2N3VREVt47VEa4RxuNWaTBMsssQWWo8kvJYNbQLk=;
        b=hZLh92kKSvjmlYxL9+VHgFf442UDcCZNIIFiQOhY9RaVWd2dIvX7FgAL8VeRCRdfuH
         4NetL4eReTqkIEwYwfuxqqxuh5JmHu+XlXd+NwRBFFWBBm4bSZUvYYotEGaZqQe1Yn5I
         /WKwgpn8aeEi+mz8HF5gYbog7Qa5FXgPf4zxNaz7PDYaqpW828h6dipTSJfqlJiuYtsV
         9mxndz8cCCmgCMPAFtZF8egQuFqGZPz+baqDfPWLp59HuQi+2XYdP96NV3AJYj8JPSxf
         +6G+Fv4lOHYhls1/0sclna3kpYN63axod2T87fZchWUCnGe5WPnH5U4ES8IedoYbqHYu
         9jrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAPL/8zzjY5r1i9EnFF2mV0noSOOCm8kyn3C+p17b28yT9GONhlD3RP4oIhc7670oSaWLb9nXqMWZuqTFMxnTQx6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWh8GpQxozcs9A8ZV6g3ZZsb0KWs8ZX2KKxQ31o3EG2zkEARc
	f0cwuFXG4Ls1LSS8VA6iHjEWPa/iOxpcoqgbdGRarBVrHSpPW/9X/w/uWwXreCY1bYM6pqHitpw
	75/Y=
X-Gm-Gg: ASbGncssfQbbEVuxrw/cKwns8M06pojl8pCyGctah+Mk6tS3Q255jLJjBR6JOI/RiGO
	7UMAXsK34zvZ7/+aWw0Atk9Ufl1gF8306DDzrkexIAOIpvSChJRGI+PWMmAqf1DyjyYl2eUO9ET
	IQ4fVbqG50Qe4OxY4Mq+nusK+puCGnx6AJLNwZwLafvW4uVznikR3Old6DWEQy5tu9i/bzHG7b+
	YtNdZrnErLdEJDGFyZOKIzac2B7Sz3SPPpwiX8MhMXAzpMZUcvK27zpKENTczl2TbIWjdyswszM
	nZzRE6FP4220e0OYKQR2Ld84kW8TSLdOSNYHEXApi1ptC6/CInNEkMt8BqceJP0WKlozmVKvanr
	9fsj+8Oi0JsAaFH8y9q2fW8H/Jxo1Yg==
X-Google-Smtp-Source: AGHT+IHJbmpzgmcpMhZOliLKIZplnKxd3Sm8hi1T17guQ/iZwTivhUWCxlNcpblUKbA658GPYI9oCg==
X-Received: by 2002:a05:6402:34d6:b0:5ed:c6aa:8c68 with SMTP id 4fb4d7f45d1cf-5edfcbd221dmr9234990a12.5.1743468566031;
        Mon, 31 Mar 2025 17:49:26 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16ef8d2sm6523511a12.38.2025.03.31.17.49.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:49:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbb12bea54so1024717166b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:49:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKYrsOSkBQYYq2CJ2YOQF+6wF7mcPdImlVp+8Q6/igIibC84RxQ5LE42BwLhbFK+uO64+QlANLU1BxiV1ONou5MEw=@vger.kernel.org
X-Received: by 2002:a17:907:97c9:b0:ac3:3fe7:b254 with SMTP id
 a640c23a62f3a-ac738a152d0mr1032969566b.4.1743468563964; Mon, 31 Mar 2025
 17:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
 <20250331203014.5108200c@gandalf.local.home> <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
In-Reply-To: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:49:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
X-Gm-Features: AQ5f1JoBkC_QKfs81TmJ3LMb4XougE5RrROka215j19iecgzoAx9QaQPEIrhB0Y
Message-ID: <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

 On Mon, 31 Mar 2025 at 17:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So *this* is the kind of "bad in a different way" I could imagine:
> things that probably should be cleaned up and be available to generic
> code, but very few people have cared, and so they are used in ad-hoc
> places and haven't been sufficiently generalized and cleaned up.

Of course, the good news is that (a) few people care - which is why we
are in this situation - and (b) the people who *do* care about these
issues tend to be both responsible and responsive.

So not some unfixable morass, more of a "one or two architectures may
care, and we might have to extend interfaces that haven't been used
this way before".

For example, just adding flush_dcache_range() into
include/asm-generic/cacheflush.h should be more-or-less trivial, with
the same kinds of "architectures can make clear they have their own
optimized version".

              Linus
