Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B731D37B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139494; cv=pass; b=Jg6SEQaBLv0PFCpK3PeX5TwPteLJ5HSLKiTHfXIo3Bl3+5pvznChagaQsjLlvBenX3puRNJtJxXLpeYjFQZVPYuDs9ZOsMDaXG1Rd3ezcse3kwmeXObjXdedb+79hdTUKhLhWZK0AODJCcEMzHKQJVbUsP4tiaU9r95dAGRPjqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139494; c=relaxed/simple;
	bh=gnMtZmchYRzH7dNslEFA4stp+XJm4brsj9Vj7PicmZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT7/GRJSzyRDEOeStZdxEG06sk6wa2jlLEaGKsOwjIDNvwQ14JSZsHwVA5i+vm2+wp680qmIFzkTMpw4o4WJzWI0/uaVQbVWwsPy2uz8Z6bD2tH17U1l0/tO9s+exaJWm3x4RyzLEkHYG6ABRO7rLQOJ20fTPJofPf59Ty2RdJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHZ03lJF; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHZ03lJF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so48184755e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 09:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770139492; cv=none;
        d=google.com; s=arc-20240605;
        b=ddsZTs7OpteNavResVKODWvk5U1IC9MLNASXhtd9nT4uR4bBwi7OWGLNnRB/pKpL6r
         wElDBbwA4jYFszTTrApvNyDx9E2l/lTIRhsr/1SwnQ4plPNln6TYWZZBklYO9jLSvj/I
         MpwXdnoQtWOG15NJdh833rkRkXmg7fSUKqcQpceZMzBBwCWqHOofcPEWUkyBuJrQWdCl
         NU+PvkfWRBRiD3I7ThjXOn/xlGdQJl9MlBasN4lwJ2sD2dubAzRD7upylV3PhpKMv0xU
         fHziY0dlHCcJZ16S+bGhQ62xfWoJcIosYJm8McnsczuIInGsH8p8AMSioiayaa8keCJ/
         EKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        fh=eTqsabbFEaXtF8f5z1QyjBYjEXSiMUo9glud5Mr994I=;
        b=l2v3fd//c6ooBBxGuVA8N1ATqeLdChuUuMOew46w6YVGlnwO9unbhEyqSJKEU6fJfq
         SQCE3byJ6MpaD2Flu9+S2GJj7/mky8+UL0pTTe5+1d19evjDW8GKsvcku0uzH4gPFeeE
         37wu0O7M4vwCJfqyMfGkTaY7iLgU3BcoyNNSTWL960EeF7Byq8kOUpbCzhwJsUnVflMk
         bgVuwpDDafwjKsCl7G38fxIgUaIIR2052se3PTdgApCaugMjDCiORLK0yfwWzqcMy9UU
         yrw4g2RGLrrh5so3tOE+ylhyvKH4hAvogubPzWvg8T1JuvyLqwE1KGNQqN5o/P4iu/gd
         IsLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139492; x=1770744292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        b=QHZ03lJFlmtMqhr7Hwglf4I6eqH2x5GdtUUWjn4lT+Lidt7Db4o9TjrGGKpVXb7G6M
         g9s5RQ09Q4ksNdyTjcjbF9uhPMAlCUxHSiBQJ9pN43UfhR0SBynMzMedXLG4BAO8r9U3
         glbXYlMt74cgfiWefbdVzTwBl4zvUHmFifOOm6EmElfj3/t63shfKg3eFsfypJy6n3CK
         KVplAi2CzR9FYEWSk8k747MRjYAFn0KTvp036oAW1Zjn2Wnd2HucK1/JFnbcfHANBpDv
         9AN/0nfvXX/Mey5eLia5YOYhoL1r9KAglLaT5eKPvFXHVtc681DB33cZFUScVSpwcMAZ
         U7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139492; x=1770744292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        b=GwNUH1tTRST0bZz8dObPybu33yw3ojCiJDsEkavl3orglVQ7ZBoSTHg3UjueDfP6zf
         QaAP7zHtUwikjw9RJZNkIVT0Sx8BkSbiXOEwvdu83nCr4mgHGVJ2n4/+/EOy7rUYCgQL
         SMttUVeOTFLlitGXpI1anx1AjSe214xHdKnfbyUp6lqRE/lz7bgQAD6rsaR3Nwi0g7UC
         XGLoSAZJlhZI88Pd9XEl+wU3P7QoiMFTV0pz6gT1N9XMjnLX9VYlLtVr4NUM9nqQ4QBJ
         JKxMP1b6lHLXO2mFY/rATMlQhXG5AEhb+cCM9sfOY+/U+irOooukV2IffyJ6MHGONVUP
         qWwA==
X-Forwarded-Encrypted: i=1; AJvYcCWLTiSMzWShuJeGdFZmnt8SruDBdRqDgZqIeAy5rkvTyIWo2EgYg6bjzGD3zLZJTnnbYb/CxfI27rwcr1ADD9SHiu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbIqZOQ5hh+EAFfiEY09MWQ9lvTDsAJvo0eHVCOnpLy3kXGtL
	lQ1Ccu73DITgoXGlxxEgyXHVLXWcp0Q8oEag6CGStoWjR/SF/+yIclPihE46dPZ/4b0CqvrYRZe
	67JfF4ARUgYJ1kwBbw5cbBBA5g5JtFj4=
X-Gm-Gg: AZuq6aKmLTIU1RUEImWMD4QZI9IPU5LbFJ+FpivKnv6BrXpABSJ9YMG9o+Ze6DczmKT
	MvqZE0W2AGkrIpLaDsMH+KgqK8lJpGj6fZNizZK3EYwP+Uf5C7slTd6fzhKTTm677OGbdm6YCiy
	NStcaXvdcqblmeNJ5gZzrkgDEOhgCVn5W3gpnxQUSSbhr+w+O3uCg7cFYADqIfjECiPFkWq/Min
	YB+OsQsvkzTXcEqoXS2UJhIZT2H7XQcxLUjLR+Eyh+mSsl8CdXmR9CO2puMilY5q4P1T8JFBfKT
	o3TD9xiGaF9JEnsgkK+ALgHEzDHepzun0/zDKM0VOXhv4ZtzcMA49XTDfFEE5RwjwBN8WQ==
X-Received: by 2002:a05:600c:3488:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-4830e970950mr5148595e9.25.1770139491825; Tue, 03 Feb 2026
 09:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
In-Reply-To: <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 09:24:40 -0800
X-Gm-Features: AZwV_Qjq5yJ89ITMl28f2X126VP0vq1wVQ3IBzfvB52Lw1A-jsn_Ewvvp-lFM9A
Message-ID: <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Some internal functions in bpf produce a warning when -Wsuggest-attrib=
ute=3Dformat
> >> is passed to the compiler, e.g. in 'make W=3D1':
> >>
> >> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> >> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk'=
 might be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-=
attribute=3Dformat]
> >>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, da=
ta.bin_args);
> >>       |         ^~~
> >>
> >> The attribute here is useless since there are no callers from C code,
> >> but it helps to shut up the output anyway so we can eventually turn
> >> the warning option on by default.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This was discussed and it's incorrect.
>
> Do you have a reference to why it's incorrect?  It seems harmless
> and gives me a clean kernel build in combination with a handful
> of other fixes after enabling the option by default, but I assume
> I'm missing something,

because it's not a printf format. There are no varags here.
gnu_printf attribute takes two arguments:
format (archetype, string-index, first-to-check)
Also
"GCC requires a function with the 'format' attribute to be variadic"

> > Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
> > __printf() attribute") should be reverted instead.
>
> Reverting that one would appear to introduce warnings elsewhere,
> so that would not be a complete fix either.

Somebody needs to root cause it and fix it properly.
Adding more incorrect annotation is not a solution.
