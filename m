Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93B25EFB8;
	Mon, 24 Mar 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832532; cv=none; b=WJ+Hz6AFBZLYqOMEhXGwmLxj5bIer5SXXaQIORljnBUohU4fc0nRPg9euUTJIiiMUlKoE7y/5H6n2z1qt3Oq9T3GrAdx1xU2l7hKr/migVjsycBJDGC5tL0TaDLbYQJcWFgGK0jmf4fz0eBgXVNrE7R8/xkBRUqFF1RJEf0WFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832532; c=relaxed/simple;
	bh=VW1DPt60kg+z6PqsW6i+OiZJbScj1lTmLErFY/sKVCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj8mqKLvIvQhiIpHUb+nUv4FKNnw42EzEogzOPhzVggmr8jELyIuELLm1zvEpXR8Nf544v8A954WB9KF3QfBc2OgdVs1qAkhTInUv9BwvoJ4LcBrUlslpaqiCdmgli8UgtSMg6z661P+0bYDt7JF/lOXUN5Xkr92XPwbd41CMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mry07P9U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mry07P9U"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso772057566b.1;
        Mon, 24 Mar 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832529; x=1743437329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW1DPt60kg+z6PqsW6i+OiZJbScj1lTmLErFY/sKVCM=;
        b=mry07P9UTnAKugJ0yf6ycmhC4vI3BhqEaNbeWPLB+CZCibba5DX2xP5DtvJ2LXuB6y
         f8imo5xZ90AEFWOoe/5J8rMCGUwebI+rRuVULh9CAvAZH4ELep7GVkRDYlQqgjiAOBK6
         s4Zkrf72PaXA7ms53OBvQRmD9rmx7Z/fzRIwIWqdTbGf/zeghYxE0ep15gQ6nTowpHNs
         17MmnOfq8WZdpkX8sw85TGH8LcTbpYukuwlinqTfoggVnfdw792X/JcVurxe0OyPD93u
         5Yjpop/FO1/VWxSuBJltszpIpFskhQOLl4aFCqZjPmzt2KwGvMpfNi9fgb4BiWywEVJx
         tFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832529; x=1743437329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW1DPt60kg+z6PqsW6i+OiZJbScj1lTmLErFY/sKVCM=;
        b=HBn2ljSpqrC4LHl30yJSda2TuvyjkhE22BwQg+DuseLbbkK12+4UQwzMfWXlMtfcin
         09HCE4uALkRXEyzsMdJ/kR1DijJuFI3cFbEdJ41kkg2TGT/KHk8fb8P0inPlB+X4gD6O
         bCU93Ib13IMZA6lFnhVhS2QB6mxJJbuStN+n/QXTJVIM3IfQm3YChCvdxgPiz+lrUpzr
         ke+bfo/arEnQjqp565BhfKvio/bs+V/BWtREyrASp/ZrQ6kr8LV/MHZelV7w0ypaDTUo
         Knv+3d9eAGOdLQBer+3mmXnmiylErMlVxslT5NX/WnuCJopoSTZsXhJCfI5/YQRwPeNd
         z+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUelV8rqRtmHrYY/0yC9AnEh5A1HMRKgVXLUTy06ntF3Kt7t6qWq23g81EVZSvCyj3uhnQXEJTAIGIk54p7AX0=@vger.kernel.org, AJvYcCUkbzeBGaz/gzevHh+Gg3iJXFzrZQvm/wugliIECGjgptadSlmUsBy9v4FJWEeBuzwra/Ik9NGyPZh86bAM@vger.kernel.org, AJvYcCWyctWfQW4SXg4Aj5gQfQ8IoIZohb/5KVZ2y59f3Vue7VMBh4qrA4gYiB34qO/sNZQkN5RrA6hQ9s3DfVoYo+rQDCVG@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeQ9iqADKzExhhDUxc+oyhNjWKL44uzNMaQ35L6aE2hdYfaMM
	ELy1MFuN7iGx5Vg+S8F+X57QnFITxof0NUTG1yK2lLvOu0tYbK5ak+nysxSV01VRI5O2tBNxeM5
	vJzvgy1NGm4Wzdko3n2H62o1fEV4=
X-Gm-Gg: ASbGnctT9pT13JZrZojQ8snV8X9av/XxU8Jom8n99ijPpGmwrS+8TMY2HmguMxO95Ev
	e9wMV5g0ZLMrxiO4OFzNUAGyJInklFnZRAuqGOcabvVuUUSoYoLqRdRkGXTjC6aIHsDcM4u9GsF
	AQbtNqat6IFs74F2ZihsjEBEgtUF2b
X-Google-Smtp-Source: AGHT+IHLgw3FBa4AMsee2XMO+A9UYmpMsaDaHKFTHBmhr9q96OQ5zXR8M8Kb0e6W1UdVoLRZt+TUe4oFErjCD6ffqwg=
X-Received: by 2002:a17:906:c10f:b0:ac3:e4ea:de3b with SMTP id
 a640c23a62f3a-ac3f22af3ccmr1357807766b.27.1742832528737; Mon, 24 Mar 2025
 09:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-2-andriy.shevchenko@linux.intel.com> <20250324120430.0620a8f6@gandalf.local.home>
In-Reply-To: <20250324120430.0620a8f6@gandalf.local.home>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 24 Mar 2025 18:08:12 +0200
X-Gm-Features: AQ5f1JpH4W2er70BdV0ueiV8XLiZtZk0RevZIcaoOPH1sTCgGcOnWCwDK8LVNwQ
Message-ID: <CAHp75VeB0+jW--U7seG005aprgxUOiyeb=RoQerhakvB8Y68zQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] seq_buf: Mark binary printing functions with
 __printf() attribute
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek <pmladek@suse.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Kees Cook <kees@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andy Shevchenko <andy@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 20 Mar 2025 20:04:22 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Binary printing functions are using printf() type of format, and compil=
er
> > is not happy about them as is:
> >
> > lib/seq_buf.c:162:17: error: function =E2=80=98seq_buf_bprintf=E2=80=99=
 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-W=
error=3Dsuggest-attribute=3Dformat]
> >
> > Fix the compilation errors by adding __printf() attribute.
>
> Should also note the removal of "extern"

If it is worth it, why not? The idea is to make it slightly more
consistent with code around (file seems to have both approaches).

--=20
With Best Regards,
Andy Shevchenko
