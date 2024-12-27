Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC535954
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735268659; cv=none; b=FYHcoKzRbEop8tkxvHX5EQ+QFEmnyouelq3TFjPoHkGwJQDn/6GLE+/uzsLYUardNOU/76JleIkETes+RmMKS9R/pdSMwgE97ExBMEoNFIArkW1bTeiU012AHHEAWMrCYQqnQOgGLHUExwAxASpthd68dRb00eCw61taSA9FmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735268659; c=relaxed/simple;
	bh=ThQ9KV6K3n5aFJXUeKhastYFmKYHErpU1Qq4XCFqwn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRhDIbRcI4Xq7bW8HST+gkr8aWqNRPeguhfVwcDW5PnFHZDOppRVCemEndUbpiaOh65cgOydO3UfKDjPbg0ClWUnpjBUCDa9QSf5LsfdZxhKSpAwdl0FuxYDuRzY6fhxmP8CtqEgfFBT5AgUFuCN73IyxJ2/dE6Rm1f+Ug4jwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=atp/A42Z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="atp/A42Z"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so11546858a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735268656; x=1735873456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIvsaxrrzusHG3DGldZGLiyb0altyr/HFAubLTJu3hY=;
        b=atp/A42ZJw7VdhrZpfFrbwtvMkGQbspCwpf18Kw3sXWasDEQ1aVNP/701s3RylDtiL
         UtYpgsS20D1Xhz50ANioUYlz+aXZ+H8q0ZMl8k0f5XYKI95CelGq7o/9f7B+3aKH02GF
         gCeXcnJ4YN3SknjeS0u7Tyvqpz75wBRWSUPJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735268656; x=1735873456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIvsaxrrzusHG3DGldZGLiyb0altyr/HFAubLTJu3hY=;
        b=Q6OAIEBlqN+4LWvenHg6FpYmgQGTGAqg0XOCiIcKLHKeeYw09vw22QbwULI5gB0z7k
         1iLAA2iebHyTWPcgNIuo8gM8LkEsfDwImfduH6LKCze1Cnqh3ZXNTXAK7bIize+dWce8
         zMtXXrE+Q1DSiUE1YxXJ/ccKcqHYM1p3hGOJFjOZc8U59yuYKnNhYGQBdhwpZonB2tBG
         Kh2Zw86VFI8dLxiAZPpbQFVONzRWLTff0xW3HI4VpU4RGrRGUwJenLO5wPMEth+l/4sm
         sJFbaSlKgYL+dzjxIKoM4Je7SZqKwiEiDZ3Z2T89+dJ6h11n7O6azMZVjDseFtIMVajg
         ABog==
X-Forwarded-Encrypted: i=1; AJvYcCWyrpCa9b45Jlop8wS5lmPGSt+UjBKIcKLZ/6UM+4f8+3Va609rQT5KOEWx+wIvctP+8hriyEE43XYQJDGCRGErZec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzj0kiCOzm1K0rT/NRQW0jILyOdc5he3I24sdfKCvjj3UWAG7
	MOV/qfpqYsZ9o43YXY6dV7g57vOdmskUcB9Z0RYjl5sDrMPPAl5bo6B1l1M9Hp1ezNFoLxttbnb
	ONqXr7Q==
X-Gm-Gg: ASbGncv2RFgr9QSL98x3mrmR76UTB0A8HLCMrf98jhKckO6oqHm83WrY25Bnzh+n0jz
	l10DMhxway9KBxdTN+u4rirDp8V5UNgTo1SOkTXcQ/BqiacuWA9i7L+f9C+tuMzeqlSqOKnayCz
	SzjF1i5w6DcSIGgl2HkSx7AQKCPqbF6cmUm3Q8k1ID56EzOj9vhSOQY9ck1d8Z3Ztordgnq+8lq
	YrMdnh+uX8sqTH9yoy4z+e4VrStvrMDQayWfjyP9HHFBXpQ1zDa1QECiPMsjIywFHWrXNqkIQ9j
	v65Y69ouVmCl9wE6Mnmq95qFhkVw2Os=
X-Google-Smtp-Source: AGHT+IFWyln9+cZ7LiOYexdm1ekiy29FhMI9hQ8oGFxGOu5YxN0NZBhGjQRN+TC39LuY64oSqxsBww==
X-Received: by 2002:a05:6402:5189:b0:5d2:7396:b0ca with SMTP id 4fb4d7f45d1cf-5d81dd8ea7dmr20992356a12.12.1735268655914;
        Thu, 26 Dec 2024 19:04:15 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a71fsm10052449a12.18.2024.12.26.19.04.13
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 19:04:14 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e44654ae3so1117647466b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 19:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsKax1EY6yfGNngOyRiCOGbg1Fdc3yeDrEr0IVBZzSUJuUcnxzTuIGef3OdOnoJPO/A6228zgAnHEo5lBUOdxaecE=@vger.kernel.org
X-Received: by 2002:a17:907:7f24:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-aac334f1984mr1642418266b.47.1735268653379; Thu, 26 Dec 2024
 19:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
 <20241226211935.02d34076@batman.local.home> <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
In-Reply-To: <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 19:03:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5JZ62=FFZQi2=doEOwTf4sa=cO+iAFEvnwBr0o7687w@mail.gmail.com>
Message-ID: <CAHk-=wi5JZ62=FFZQi2=doEOwTf4sa=cO+iAFEvnwBr0o7687w@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 18:52, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> So, does the kallsyms patch set from Zheng Yejian fix the issues?

[ Me goes searching ]

Oh. Instead of adding size information, it seems to add fake "hole"
entries to the kallsyms.

And I guess that works too. It does feel a bit hacky, but at least
it's integrated with the kallsyms logic.

                Linus
