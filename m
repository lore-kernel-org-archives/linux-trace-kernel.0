Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE133D6D4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156083; cv=none; b=aTGChG6rLiCh+7L3KapmSsj8aHh8ALvH9G/qdMY8lgy+CPiBrA0fUPkaOhSc0UA+692nz29UGXgc85kZATcduj/yYwPYjysmjZ5x7ypk5ZcBv4P73i0otnFbZxX3JA1JTih0B9SaQKK389MOkGdSkAwDjqMg7h1M/4q3sFR3+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156083; c=relaxed/simple;
	bh=4Xdt/E0eKuLiqARs5/+NwNizpugYWI1QB+HlCH+SMbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDYZZ3R3RQFyhaG5LWNaIcfKY+Ln4AJnpCRnG6RJt6BiLuv8+nvPr68EflhYy69tR3Ln0M70J6jxIIDTfNTXDHRNfTLAcaHXqFuh/jLQ/OYle4F+1vlS3/bL/XnElHf1/bDfuojWTaRSS8ujlssrklQgRzMECxIZ/oR2HCy+nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh6FSf/t; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh6FSf/t"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-6420c08f886so2405749d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156080; x=1766760880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDdaTMRRYAY1qSHlAuTYn+8+uE5UBoDcaSos5vnXy9g=;
        b=kh6FSf/t9mCFBt1iHZ+MlgKIXW7Yqb9pIOMPd9uAbrvR2sToE0IM56TS9Tf37eapb7
         CoWl2MxEX4Z8TSFuy/tEQJaJbXe8uJaC1yn1HqgcbR7C8wlAZXpeJe+QuDvz3dZTwMvR
         aYq+9nFZE4owwzz16bNlrSGcARiNU3Juen1CmiRxfck5Lsabm6n3J0UkW/djztFkyRKR
         O4hq73syL7UfsdILWPy57VSc2S2PzPSHb16gAUTFq6PEswB9jVqr67Bf/anil2iM5tO0
         Tk1MuD2+OPIXOFVNK+A0oKY2hXZmn3gYeqPlfrJGs71gN0J/8F27evd5L4saRJBOUONy
         5eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156080; x=1766760880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDdaTMRRYAY1qSHlAuTYn+8+uE5UBoDcaSos5vnXy9g=;
        b=YgEAZtC/Z5c/NhYrtVFT1YS6Pst1v/9ITTBJ3x7sgo6TNfC8yN3b1Sva8d9UTskYy0
         sXO2Yenp8cn7y1zVZ+5yP3wXwnD+snLRYlN8VHy++jk505Qv0qyoucvsyPREPCe68aLm
         d2FK28YKcCpBP61gcRjgG4YjaGIKQCjeplLsGQIi+BIqKKTsDdtpHOqL9SWYufNi2Ox7
         zMMFS132+s+UYLOUBqcoQx+37LfBd+e8SJjRNAXahMHacHPGouxJJi/conVWsF5G/AD7
         MT1WxMe7EmZ7IGzkb7fDFK2yeAjQ/rNIBQvVv4eiTg/XwN4sqOCOpeEJDdiviMJNlnRP
         ksfA==
X-Forwarded-Encrypted: i=1; AJvYcCXNHnRU3kUYzNcOs/FZUDxguH/9zNmXv+RjAFYwPV80qFqWuMQls9G/Y3XPVWWzAjfqbKLE0Pf8Ypndc35ohd4Vcc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytxf1lBJpexBMZ0RXCfp8CDhmcenZ/tUcTsxz6YwSC2wUWysZO
	6wADbGuRsasgHCj+Ngph1psMLS7h3ZffAYCLUGIoQwFQQsGxWWs0KFRgaIfOUawCAESzgysb9tK
	e3/3rVQLLK9BZBb5KT14lJ31kRItE1r8=
X-Gm-Gg: AY/fxX6LCVXnNlodJWWUvR6ZZJc2dvlzfNh2aS/5tDS8DadcjiwKs2c6yYD1d31/pmU
	MaRnz1k551QvQCXu3GUK6TXkXa2de7JZFR0B9KRnPwJRCf0TQROCGh8+ay4csMABc9fOKqrqKvA
	0oPu0Sc/Bzp8RZgS8GinobQjmeQx2uVdCv9oQO/eWIivzWnt7jY7yb7q42p3XQ8JR6RpIrOO5ZF
	8rAI4W7jg+Voel3uSwugR76VEq9E3PnToXI6JdEW+9oKxqrrDZKtEkR57DUIeThXaXz31cM9tU=
X-Google-Smtp-Source: AGHT+IEQpU2uHORHsSaJvH+4Kc5a7FmzNED+x1TC212I/IRWbm5lKmfSyUpFZx/jrL2TYMouTF4PT26t1Et1Fqe+jxo=
X-Received: by 2002:a05:690e:4184:b0:644:43f7:11b8 with SMTP id
 956f58d0204a3-6466a844038mr2341085d50.13.1766156080207; Fri, 19 Dec 2025
 06:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <875xa2g0m0.fsf@igel.home> <5070743.31r3eYUQgx@7950hx> <1948844.tdWV9SEqCh@7950hx>
 <87cy4aeg56.fsf@igel.home> <CADxym3Y098836fHHRSjeryxCp=CPB8sDU19TBBVs07VZOERJXw@mail.gmail.com>
 <878qeyedaw.fsf@igel.home>
In-Reply-To: <878qeyedaw.fsf@igel.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Dec 2025 22:54:28 +0800
X-Gm-Features: AQt7F2qQ1ufef4ZaQXp8N9zw3HgOD1aYzUQ6NsLMEQPkiIIuUt3G0BCDsWRcz7k
Message-ID: <CADxym3ZSHtqAn+_6pKEO+95tRp13eRCUuPqCfcM=xqMbhcf3PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, ast@kernel.org, rostedt@goodmis.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:50=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
>
> On Dez 19 2025, Menglong Dong wrote:
>
> > @@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct
> > bpf_tramp_image *im,
> >         }
> >
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +               /* skip to actual body of traced function */
> > +               orig_call +=3D RV_FENTRY_NINSNS * 4;
>
> Before this line, orig_call still contains the same value as func_addr,
> with the latter being dead, so there is not much point in using a copy.

Yeah, we can use "func_addr + RV_FENTRY_NINSNS * 4" here directly.

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
