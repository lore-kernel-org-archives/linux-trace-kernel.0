Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D361F8905
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323001; cv=none; b=aUE0EI9CqA5JEBYXn1fb3RsLOo6bOpjh3kzlGdSpScXjyUAXTjcQy4p/hc0FPgA6q+gAMC2DZ/xqEWpTRbSInaxLUUhToDLcvdDo1O9ShMTsqJdbzx1ETg49+mXN1CD/vpplgzbfvYRPvLSzc4Nxiw/AeYkJ3FGy8YBS/HHoHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323001; c=relaxed/simple;
	bh=lIgCGRIjaCWKrn+E11kdlmQyFebXDmv69x2tOk205hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxA4oO9J+a4+ctSw8qkQIVHkesL6L0xM6fwfenLgyD3Nq3SOdo99Ky3ZeSfMllg1mckoAeUhoeQAZkpuo6o3xwfCtyQZTeYa7BW/JcRV+pcm7K9c6c1AsFvnnzTfAptb5R8jAEKZal5hZqNtS7RKudH7uONZtKee6MLnOzKSkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FvRlaoBY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FvRlaoBY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa66c1345caso335650766b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735322998; x=1735927798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yX3BV4MQOHPYJPObPt8JUHeYgGfsYXEGdeuM95hlgDk=;
        b=FvRlaoBYHpGIMtjx/Ax11oZir09L47Uw7fdI/RwdX1NCjFJ/m4ASkS/skmP5OkkKQP
         q3xLavUXppaNxzIrjDMkGjR8L1LX4lIkdYd3WHdswXJf/XhQyXxJ0q7qc9btvrVUTk0C
         eGABU3PDiEp6DaeD5U+BwbrPFw/3MrcjKeImE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735322998; x=1735927798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yX3BV4MQOHPYJPObPt8JUHeYgGfsYXEGdeuM95hlgDk=;
        b=ki7RgpksGP65Gmky53KzScVqP+YfxukgT0GxvXejQEEOim7e8S/bXjynwsDOPDqz9o
         /GqMI/cHTATFWOVJAqIIY6GYrvMy5jfqBh/lbkRhuKvthCN01DdixpBbUifD2eqrkPIc
         1Cc8tekuitQgyX2sPFWePxykUZTPv4sjaKwXJqKZ/q4ZkShvahdeyWXCVDdRNg6JEZmS
         iNAjKP7W2YtInZA0bEwRls8jbr9XdUz6/oSkK8XpQ2kQnoOYsMRB0WgCfUq5beCHg0cx
         z98AITnIy+7L3yAHTFX4vsU+FBS8QyEHpydxRiQIpQk27h0NLxKPxMV/hUWQfknByxSb
         jd9w==
X-Forwarded-Encrypted: i=1; AJvYcCVw/n4v8AhCsqyJk0tg4yzoPvVigBhGgeq7hYACqaYoC8Q/n+HNRrfV+OLPj0b0JtTj7r6CNt0OYIXPm8+NTnj0+LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNjoQNhy/JYm86c87oDzitJPxBp/oCHgpFVOXonnQOueg+D7y
	JIJj+eHyKU3w2KdxOsHGVjj3DaMyuueMHcPGWsKfPwViRAGyXwsfM8v3qJwbgF5kutGdBU6ucJH
	HzaytOA==
X-Gm-Gg: ASbGncs7/VqcqxRT9IlmnYFwZkm0yS/Gn4Od4Kg9UCrhl84E+NQXcHXA2BkKSorVgf7
	Fv3a4bxE6MlbuGbyNSJZ+uBrO0z6Ggj/4Ow9AgA5m5aT/u3iItVv35/dWPPzubAce5ejsoFfaba
	UvfnukG4r7QrklUWScVYscXolVH8Cv0y7sIXQbsXrMrxKjx7xxvfuEWa1i0vrrCjQpLelZwgSX2
	TNUQdefMo1hvih09XNJBF3N7lMpz2bh7Wzw+eMRbbfJWeFlWyC58EUpx+JapjYOgM2QeOKQ/22p
	YGLkYxpj0iAERnd081Zm9XkkxzLtTms=
X-Google-Smtp-Source: AGHT+IFZTULwpZJpt7W1svhZDpRBdiH62l5JIOxn0LIINHERzjAnVGmHdhi0EK2wYkK7FOP+2qqNHA==
X-Received: by 2002:a17:906:c10f:b0:aa6:af4b:7c87 with SMTP id a640c23a62f3a-aac33442793mr2799432766b.21.1735322998227;
        Fri, 27 Dec 2024 10:09:58 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae4369sm1145105966b.87.2024.12.27.10.09.57
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 10:09:57 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso1261106566b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 10:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1hQpVR33WZwBxRB9FgK1VgJSYdgnpbHfIBuMgq3VaoyhgUpIn4olRD/5PyUC0uNh6EykM1nABaXvD23AizZxqr8w=@vger.kernel.org
X-Received: by 2002:a17:907:9812:b0:aa6:738c:2ddc with SMTP id
 a640c23a62f3a-aac2d4472bamr2701724166b.4.1735322996702; Fri, 27 Dec 2024
 10:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
 <20241226224521.2d159a02@batman.local.home>
In-Reply-To: <20241226224521.2d159a02@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Dec 2024 10:09:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
Message-ID: <CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 19:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >
> > Btw, does this actually happen when the compiler does the mcount thing for us?
>
> Yes.

Ok, that's actually good.

I'm not really worried about the "unused symbols aren't in kallsyms"
issue, even if it confuses the mcount logic. THAT confusion is easy to
deal with by either adding symbol size information (which I think
would be a good thing in general, although perhaps not worth it).

Even without the symbol size, the mcount issue can be dealt with by
just knowing that the mcount location has to be at the very beginning
of the function and just taking the offset - that we already do have -
into account.

I was more worried that there might also be some much deeper confusion
with the linker actually garbage collecting the unused weak function
code away, and now an unused symbol that kallsyms doesn't know about
wouldn't just have an unexpected mcount pointer to it, but the mcount
pointer would actually be stale and point to some unrelated code.

So as long as *that* isn't what is happening, this all seems fairly benign.

               Linus
