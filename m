Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD12C0299
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001522; cv=none; b=ZJrncYts7nZdpfD5uBf8lTYlOziM23m7syjmkdRBTi55t2N8fzHMk+87IYMWyRGISRXzMpKfmfLeFwg6AAmcnaDXhtiPYv/c9jJ69rRYokFdufiBcKiJmofw8ixEPXtD+6qV1rkWAZyqwoSZuuv9B4wDdWmlaaPBUno+F88AwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001522; c=relaxed/simple;
	bh=b9nrhEPfCiyZMSsvm1GGUlSZszYX6kHmfuhCM7AblyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcMQo+3VZZQ3AvU40taVaVbewAFK3Jx4gzmM+VwVLIJl3hOIGpwrEYodg+hFRJK9HsvQlTQ9WY/egE1YhkIcQRdU67xp225aVabaWn5TIqf5/5ASzftSum+jMOOjeAzTpH8HNUvvGsmBPvOKLD3BZJE0btvPFM5X8nWbEGjIQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajXpbqFp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajXpbqFp"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7260435287so36803566b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763001519; x=1763606319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+96ehWUDXlUzB4eDVsRts8db5j69ugG1igF8TDcUmE=;
        b=ajXpbqFpBUEzBavrZWz57MBp6AJW53Niyg/ko+EmvkcuXsIe11107HiQlZkjeiEB41
         5z9eTf+Yf22tm/J53LbDAXyj8t0e6uk2RgQ5oXBVlqrqzEURGJKdi08gnAEx8+UZIiBJ
         DY+qLdG002KeFI6TukYz9/ApbiL32KV8HTFm+6KrQw2vgzZLTt2FYDZZ2imAyL8DU0/a
         sX0d54XqZHVvrKQjTQkgcBLQ86qqV+4sZ7UwBw/C5K9P02sxQ1Eqr3mi1Gwv1fPrz45G
         +wgLTol73pi8VO3Orrg0ybVb/VHMLsvWvPNFoZLbr57gvJkIDgUNR1isW38u44qoyEeW
         K4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763001519; x=1763606319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+96ehWUDXlUzB4eDVsRts8db5j69ugG1igF8TDcUmE=;
        b=WCEhES1mtCwKvyJ0GjkZzgKn+wtkMhOZ6Tmbp9DrbujqASLYuC1XSAPFcMGxOgkFkl
         FbkB4W98GSLR4tfrSrh87+oXUwYxkqcYWivgMkhFU5TyZJpWRTxd+/l5A6L8D5dC8HkJ
         U9rNPMGTnUfaNAfu+ud4HyrVPCuEDOT58bmNtbo1UNhgkiOGrssmFASutLOD2kOgbBpR
         JkGiSxPvZSQrkJLogpM4lnmZarBB6Ej7+lLERg/c9J2tAmHJAFnq6WCv+IPTtqd4bkn0
         4REaNv/EaIcgp1RupYcko1+QeYj0G/aLgjrPIMci9Btbfb/h10BqL4Zk5IuRYoHzYjrd
         2siw==
X-Forwarded-Encrypted: i=1; AJvYcCVTxKd24ViDQHGeA2TXEmfJQ3OZgsCZe0UyaSywIpQ8xDgC6YiuPBiH0ZsUnvXYaq8cwu4A89jdJx9dzI8EcEuZmak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhuds8bwD62dxb1peZ1i3FZUl43emSaY1d5AdQ6U78navNRdI
	yqoIGt1WWJnZEwvCyG76AxkOQk5TLGubwiedesyNdHzD7EhxGMyfQ5QaVsWCxzPT2YcaS4csvB1
	eEP+GBehgvZ5DDLN3733OGWgKwLSCD6Q=
X-Gm-Gg: ASbGncu4gJz2sAxwQCwIXKwlJwp/JXrbys8SwyyBPwVs0Eh0uEJTYaDlqrCBRLNo1fO
	p4byjxbwRcwscqY9jUC1ZDgUULP38+2V7GJarEu7YeVPD0NiJy2Lhn5KD65HIrPM8f6npeu0ZaN
	qzjKZcGACfWc9tIVR4lYSUN+pwHlL/fS1KGv4k5xO7PVRQhVUPUgPJFxvh06WqYt8e4/h8cbrpW
	37agAzhSbjdnxyUekNQQ9vVAR02IB0eO6c1TeYCfzaoEtzU3efHVYvdEllU0OVFkHOaYcVb
X-Google-Smtp-Source: AGHT+IH00h0RrxArZVMyx5i8z0vIkw51lctnegt2Ez1yz7f3Em2ufp8UAQKctIC3wIwZ1t70+vvarw7vNaphmjfycNA=
X-Received: by 2002:a17:907:3c88:b0:b73:222c:1e7f with SMTP id
 a640c23a62f3a-b7331b2f9e2mr537858166b.62.1763001519109; Wed, 12 Nov 2025
 18:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
 <20251112103804.4a43591a@gandalf.local.home> <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
 <20251112210236.07deb6b2@gandalf.local.home>
In-Reply-To: <20251112210236.07deb6b2@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 13 Nov 2025 10:38:27 +0800
X-Gm-Features: AWmQ_bkw_Ikkq5MjVmbc01vPLShbMH0gn-vMCA9Ltdvj0VuAomw9ENBZWeJzyD8
Message-ID: <CAErzpmsn-uys3VdchF_CKBPUQT+328wtaKnbufoDi-o9x7eHaA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:02=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 13 Nov 2025 09:48:52 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > I noticed that when funcgraph-args is enabled, it registers
> > trace_graph_entry_args
> > to replace trace_graph_entry. The only difference is whether a valid
> > fregs pointer
> > is passed.
> >
> > To reduce overhead, I propose consolidating the two entry functions. We=
 could
> > maintain only trace_graph_entry and pass the fregs parameter to graph_e=
ntry.
> > Within __graph_entry, we can then conditionally record arguments based =
on
> > 'TRACE_GRAPH_ARGS && !!fregs'.
>
> What overhead are you reducing?  Why add a branch statement in a critical=
 path?

Thanks. During testing, I found that enabling funcgraph-args incurs signifi=
cant
overhead (344ms) compared to other trace options (near-zero).

# time echo 1 > options/funcgraph-retaddr

real    0m0.000s
user    0m0.000s
sys     0m0.000s

# time  echo 1 > options/funcgraph-args

real    0m0.344s
user    0m0.000s
sys     0m0.344s

So I thought it may need to be optimized.

>
> The graph_entry() should not be looking at the flags argument. It's calle=
d
> by *every function*. Also note, I recently fixed the flags to be per
> instance and not global. Which means testing the flags would require
> indirection lookups.

Thanks, I agree and it indeed introduces extra branch instruction and
may introduce more overhead when using indirection lookups.

>
> -- Steve
