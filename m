Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566733398A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485241; cv=none; b=syO9F10PyktmNfXM4lJZKHD00+1EemL04J3jzX2+i4mXo0il/eVc9YK1P5nR4XNwjJlw1kFHHbCpk1XgfmlTm5elROuUDFaiIYoJ/gfdPRJE10wKqmwao99/IIzmPQJ1BkyiROsbjSwDxXP6SniLKw9rl0AwAHT8w5gKTTxtVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485241; c=relaxed/simple;
	bh=7dftcd3gpORal5tdW4nSoIicKcvSkaRlFW4x371Uyik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGfBPG9iPYAjHWu+ina82IXpOL/en61Q454O9A/weCPnXcC545wtYTQiC+5xEs4XuwpOSmD8GLYcVf92ZJBGAN1NH1izn4Obh6y3E6hyjfuhufZVQuonQVSaPpGq9YUbkp15LEMs4SZ44QYes0Y12q/IdDrJtdcb/Ruik9d9NPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sr0nvYj1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sr0nvYj1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so46716066b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485237; x=1735090037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=Sr0nvYj1euECSxJjv162PBpyBpGnNW3VvpTNDQqbELAcP84xhog+k6nynnvkqluakh
         sDc2kuHhM26GKHY0aqRWOhjCrKzpu/hZvbkzcZHfTxlzwfuSRlOX9ZDPCshKG+1CMk9M
         oq95TTjtIIfJHoSPuRrSK6DHLhgBLaTbi5HzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485237; x=1735090037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=HVQm15V4/g100Y2mhtf4lOS29mRxhyymsh8yv313aaJh+GaZ+oQJp8fKOZwkeBrOBw
         BMWv8gBUUuUQLATJ/SeZk8RZMy/x4yZax6tYBIpCnrnO6ji4GjYKvts50qBE/xC00mx9
         VqsCj6PRZIzEkz5aA/AWAkRdi8pryczUb7cWUjnGPg45jqJ+ht7yUIrfoNn6EJq/ZJeP
         qQx2SyDZ04ThyxOrqIVjqe/qOyghmvDXFed5w44w1hXTLrn5Bny4pYQj3YpVbr/9LCHe
         /eYJvuKwENE7wmPmkeRjh3fD7bnyovWrXn549wl9iuhj0rVl6RSE2iwUW6V3gr/Tr+M6
         YSXw==
X-Forwarded-Encrypted: i=1; AJvYcCVHnnKnjxTERQjKPF9WIB6gHkCFeIpUPfXdhcCT9zbrOHTiBNl6adMg80cCWKnZdDA77MGgC5tEoilF/WYa59RY954=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KnqM63ViSYkuIWOgPTKcp/0ELYFZvMxi0/INGVAfzWNUckhu
	JvjdkZqIQiPCG8jyzHxAP+k/8cgRLK3f3gG50vbMR1Qs9dzFaCRi0mD2bQg+Zpa3nFB9msnZHJ3
	1PL8=
X-Gm-Gg: ASbGncskLhBdozbsBn/ilePLffOjV0nrDnjqkmbiZa9JoGQjXVstNegRuYO4tr+z2Xm
	OMzVsRkLVj0SDMUKlm2vI6bnpmzMr/YBnElM5oMdEa/dH7v/fkvVOm2x1dhopa15OVcVDRDfFvI
	nETwn5H+JQQ5rRX/AkuagYc9/tnFPlBLDiVN2np1os4MmOYCDyflyQoLMW811eDNaj+ibEIVnSb
	GFhLIpbQZ7BNjoBeSQqt7HL9RdS3RR+qqE8vB7wiMBFdmebjbJWtUIIAblPbqg8P9Uvr2204Q9N
	Y53fz2rYi1Wg2qs6pyTGrIHDWZ/nE+4=
X-Google-Smtp-Source: AGHT+IFhCd/x048IRzpBtTKo0AkeQuS3nkHUl2V4iNFvOJhZ+f9Y9LmWcw1nsC7iNMeQLXRslJXvjQ==
X-Received: by 2002:a17:906:794c:b0:a9a:e0b8:5bac with SMTP id a640c23a62f3a-aabdcba2655mr361570566b.23.1734485237569;
        Tue, 17 Dec 2024 17:27:17 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f35365sm5039601a12.80.2024.12.17.17.27.14
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:27:15 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa692211331so52185966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8+DrZW6n3eRWdx11DIhHjtjArBA9YxWPYitNl1iGxIyaZeGHqkrmZlvq8LWIVvOldfDiG2wuxXLeD93NsQtzgg2A=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-aabdc67c3bamr505528766b.0.1734485234499; Tue, 17 Dec 2024
 17:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
In-Reply-To: <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:26:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@google.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 16:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Since we're on this topic, Daniel is looking to reuse format_decode()
> in bpf_bprintf_prepare() to get rid of our manual format validation.

That was literally why I started looking into this - the many separate
type formats actually end up causing format_decode() (and the callers)
to have to generate multiple different cases, which then in turn
either cause a jump table, or - more commonly due to the CPU indirect
branch mitigations - a chain of conditionals that are fairly ugly.

Compressing the state table for the types from 11 down to 4 types
helps a bit, but then also dealing with the "smaller than int" things
as just 'int' (with the formatting flags that are separate) also ends
up avoiding some unnecessary and extra cases.

Because in the end, 'size_t' and 'long' are the same thing, even on
architectures like 32-bit x86 where 'size_t' really is 'unsigned int'
- simply because the only thing that matters for fetching the value is
the size, which is 32-bit.

(The whole "is it signed" and the truncation to smaller-than-int etc
is then something we have to handle anyway in by the 'printf_spec'
thing).

So I have a patch series to clean some of this up and avoid the extra
states. I'm not entirely happy with it, though, and I've been going
back and forth on some of the code, so I'm not ready to post it or
have anybody use it as a basis for some "real" cleanups.

I guess I could at least post the "turn 11 different types into 4"
part. I have other things in there, but that part seems fairly
unambiguously good.

Let me go separate that part out and maybe people can point out where
I've done something silly.

               Linus
