Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E573822A9
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116327; cv=pass; b=hOpsKHvhLRr+QKR8WEU5HjK5dQkgaKYDO6LgmqbP7zrEO4fCdqsqOgUfq9mZ5kB104+FBLLgpyN0nNzpDcxHTOBGNiJM2BKtYQr0ugA/McIv9luQtUSudsN23dkLMKCf2d6cG9cnK5RNRSjRf4MRkcmMpLVQiwPfPwzAh3BD3Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116327; c=relaxed/simple;
	bh=RvSlqOQSZukCTfHZ5R6+udcx9GlCy+uBqLrTdJAgRAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiNgRy71LhF1+c/DNh8HaMjoFB6psSjbltPtmqFNUEcFX4fmcoq5b3YIRAu3CLQbO8YfOdQ5WBlA+38+VeN21rppKQtAb/KOCVoehdlXXVj00wrOnkdp+MKQnOZHNQSFXKhtvG2Azo2xpM19fw/0btCqm0cK02m2HitPeZUoL9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyzaA7De; arc=pass smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyzaA7De"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64fc6b21789so445082d50.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 00:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116325; cv=none;
        d=google.com; s=arc-20240605;
        b=HRovH3zGwQ7vXpwdsoc1htd1MvJ5masvPHoKaq7q6pXiZsQ8ItlnxjAvhdGPzTpTA2
         f791BaK3reX4CayBSCdxUbm4joV3fHOFG5kU5CFIyxbyJKa9oaw87fxJUE09ArQhAkuD
         cgi0XB5RXw+okYtK1J1xX1z5J4Y6VB0/0OItTym49JBoSdHUpFSASFBo3iSLJKHzm3hI
         brtbllzgfWqyfZDuQwDTqXu+ErlLfHivHUQKRvqKw3ft1czA3HX6kB9F4JSqTKyaA7sy
         d4TRF6gxcT4pK7On9yxxH8bdTV8Lmcrxznseglvv/DOwzoSKC9Ha9W2VicqCK3Z1gsyO
         n1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        fh=vHPfwBR7DIZ78P3vzgd0VuQ5Pb/krXOYb++cpRjFU1Q=;
        b=kWL+HD9h8wDjQUYYcPx5LDRokEjuef3DTpxny0xuKRIxeyB+0VxEZSC2kwka3HCV/l
         OeR5jEsTO1e0+AT/OwBHViIaFYPoZ628klVb/AeWwaxeHe6LM2jHZ1TMWUDbXWul5Hn8
         SqJOSrdi2YFoLmz6df8mcPGy8ruG6WJPh2FxcAW80/hQiZjliRRjHovNcKnwOc9ZZ6s7
         oHCtkgf0HJCnxRWpu3BPTfMZWC9JElHb36FwGNc9WUTwpELYNR7FBKoM42n5Lf0f25n2
         dlySEyFBN/48VR5ExFd3bopRRwLSZLHcBZaP+xdewtYoOmuSKKv8JJxJRThmELuOOyY2
         gjEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775116325; x=1775721125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        b=NyzaA7De80PEFXTB7s8zteRVbCz1xla6Mu7uqpgxd930ZWnSZTBUwLkarlBkvJrhP7
         LLfU6JqwUC+94oF5Qsl0ce6kD36Cp42NB0XsLhks2ER6xgzx4xj/ZvyHcE0ON3UGm0/D
         NgZBoRzhPzGFO28JZNxALaqi80dVhhrA3nlm9lgpBIPKm/TSiVdU+Jgr+Q4C8Vh7GdYU
         GDH6Teglv5QmHypHt6Lr58ZovB7QSIJI7BpShaGtfn86KINAeQe5SVkAeAVE5dIcHm0Q
         X0JA5qGP5WSLHUjnDByFsKZKTlC7zSQuDDKv2rP6h5BM5OmaR/rWp0fD5bdlHPqbwik1
         oM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116325; x=1775721125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        b=S9j5SFUBT9AtszJUi1Yf0HM+DGXacdRg+WFVhpe2YehUpHybsOgW9C17g/ugnDXCaS
         px1vg2djIu/eufOMEL8kNuq8OYsoHKN/DyTvGogXzd9LTVqN10pY+hXg8bXiTD9jD1FE
         raiKXsV3XPJS55MdO7PijOkV2ZByDolFiu88ZPzjqpd9skts+IqwRMNVu8Z5ayJmFzoh
         lwpTro8DxMTQ12AYo61+hOeZsJkm+s4J9nhYIpmFRRDPbx87+YaGy+bdHmfsgMYPy0u2
         I8qEkcuh+d3uj8L165esK43EqOzB8+iAe51YSetoyy3BdjJZyy8758Jmv7KJTJTsqM59
         C/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVLaz675+P40U0hw+0nisyn4xPz2fI4RsevlzAiUpYVyeQNQweQtBfbgn4pKEZ65tgIIt+2j1h1PovJffU1rJYhSmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTB/TMNvZGaDwLuYhCeLnKDBLcOkDZt5VvNnCkgBRLXj22EXe
	oYo/bFfY0rgft3dHm8IScNJiLdcgtq4wySV532xFj26fZe0YP6oMquAb6E47OLfsey3U623xo7m
	0hHkltPwMdvc7KY82I388nthY7Xm97gE=
X-Gm-Gg: AeBDiev/6bqYgNkXnTVMSpbaD1SphsjedGLv8OqMEfyRU+sf9FQlMGYD11cLBRs3oYj
	i1X5jrJPVoTEfN4XkTD/z4yIPqP4tzQNuFaJj2iG0r5qF3MlVy1oHNzVYTgyslzeHPZ5XU9a88n
	Cj7jWjW/mCMRMcLXWVo3N0/qn+atePBMvAnhoHKvphnW/XApHHb1HG9HkJBs9/LlRVlQvL7Td0F
	KOVmwJOkw9yo0Yy/O9Kj9YuVXnMqXyxyeGR4UdGqQ7C0q+tuw9Qv+5Fi5xnOfNj+ICauMhZjGpr
	YUNTcX39UQ==
X-Received: by 2002:a05:690e:2550:b0:64e:f106:60e6 with SMTP id
 956f58d0204a3-6502fe6a29amr4650514d50.57.1775116325153; Thu, 02 Apr 2026
 00:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn> <20260402061251.273705-1-leon.hwang@linux.dev>
In-Reply-To: <20260402061251.273705-1-leon.hwang@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 2 Apr 2026 15:51:51 +0800
X-Gm-Features: AQROBzBHmTyM7mG6aiqVl7652RBU8GMP1j57JJF9F1xGYP4p9m1mpS4hJciVsSg
Message-ID: <CADxym3acSo0gXO-K+=ZJvcT+ne-He06S8QcOwCKyzNDHQHRBQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
To: Leon Hwang <leon.hwang@linux.dev>, ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, jiang.biao@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 2:13=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On Tue, Nov 18, 2025 at 08:36:28PM +0800, Menglong Dong wrote:
> >For now, the bpf trampoline is called by the "call" instruction. However=
,
> >it break the RSB and introduce extra overhead in x86_64 arch.
> >
[...]
> >
> >Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
> >Alexei in [1]. And the logic will become this:
> >  call foo -> jmp trampoline -> call foo-body ->
> >  return foo-body -> return foo
> >
> >As we can see above, the RSB is totally balanced after this series.
> >
>
> Hi, this is a late footnote for this optimization.
>
> As this optimization landed in the 6.19 kernel, the function graph featur=
e
> of bpfsnoop [1] cannot work because of the missing tracee's FP/IP for
> fexit.
>
> Before this optimization,
>
> caller
> -> call icmp_rcv                caller IP/FP
>    -> call trampoline           icmp_rcv IP/FP
>       -> call icmp_rcv body     trampoline IP/FP
>       <- return to trampoline
>    <- return to caller
>
> After this optimization,
>
> caller
> -> call icmp_rcv                caller IP/FP
>    -> jump to trampoline
>       -> call icmp_rcv body     trampoline IP/FP
>       <- return to trampoline
>    <- return to caller

Ah, you are right. The target symbol will disappear in
the stack backtrace in BPF prog, as we jump to the trampoline
directly.

We can pretend a RIP in the stack for the address of the
"function body", therefore the target symbol can show in
the stack backtrace. I have not tried it yet, but I think it should
work.

However, I'm not sure if it is worth it.

Thanks!
Menglong Dong

>
> As a result, the function call stack entry for icmp_rcv has gone.
>
> It can be confirmed by bpf_get_stack*() helpers.
>
> $ sudo bpfsnoop -k icmp_rcv --output-stack -v
>
> In 6.14,
>
> 0xffff8000802bda44:bpfsnoop_fn+0x6a4
> 0xffff8000802bda44:bpfsnoop_fn+0x6a4
> 0xffff8000802bd064:bpf_trampoline_6442573163+0xa4
> 0xffffc7825c984df0:icmp_rcv+0x8
> 0xffffc7825c91bcb8:ip_protocol_deliver_rcu+0x48
> 0xffffc7825c91bfd4:ip_local_deliver_finish+0x8c
> 0xffffc7825c91c0d0:ip_local_deliver+0x88
>
> In 6.19,
>
> 0xffffffffc0209069:bpfsnoop_fn+0x449
> 0xffffffffc01ef2a4:bpf_trampoline_6442568724+0x64
> 0xffffffffb1085cda:ip_protocol_deliver_rcu+0x1ea
> 0xffffffffb1085d96:ip_local_deliver_finish+0x86
> 0xffffffffb1085e95:ip_local_deliver+0x65
>
> So, it would surprise users who care about the tracee entry.
>
> [1] https://github.com/bpfsnoop/bpfsnoop
>
> Thanks,
> Leon
>
> [...]
