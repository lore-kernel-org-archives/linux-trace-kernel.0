Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BE1581E3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590223; cv=none; b=LYaaK+tbRWMgV8ELO/G058hSj89QFQkl4f2LP+JI3/vU1R/3DDoghC/iNZNw2TTp/jKYsNn+HQXqKoJXTS6qMVWV1I1YWnlUz6ye+CSlAAruBmgGIhyjGh+s5j+CDIt7glC9qMFRckePhqZzw/uhizwY69RXPDNrj7AzMswCXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590223; c=relaxed/simple;
	bh=5cDTheXxPIdIssxnQWjv/qLVCXYIkgJSlf1PwQPKjZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kplGhDjTQu+sXV4kGmtXlbXDexNnADiIoQAD7k1rtaqGK8VdojkVAA9Opt04Ca5l5HNDHyRHRrtrmusRo7Yt3LcCc76wTDaLtkYph6On/6ZzmseIfoODzoMwLl++ghD9gI0kPPUKysueJYpiVqrmTsBct3EeKfM2uYEdXVSFInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VmjSGG5Q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VmjSGG5Q"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfab4779d95so3855321276.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590221; x=1719195021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqCXTr60lfURDiU6o/ziPYUoB/pkh4/Y0UTODd/6hiA=;
        b=VmjSGG5QQuHHAieYtNzm8JYK0MbU/t6m4n/g6jT2in/GAto75KeMPMKk8XdCWOkzFZ
         LwsV0WAXPOnUb7aLPxybGSFA/+NMl++TXndfYHbOB79aPYMKu0bxTkaWlXNy5RRvkfDh
         HRhINwDdPr87TAGC6gf7w9QJgMCNgihSO/OC+pQGpKpPGkQ30jeXDNEUpgiN+ATCWwJ7
         qLhZ57iGHeSvi7w+NJTsTFDka3+TTElJGLsWiRtndGZuGzrvzMDLCFjHJvTi9WckILMg
         gCoSJtioj0JLpB4HyWmaLyTv8K8L3M/BggOQw3/TxM/0jJP5MdEtieaRcdLJNDcMYVEk
         Qeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590221; x=1719195021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqCXTr60lfURDiU6o/ziPYUoB/pkh4/Y0UTODd/6hiA=;
        b=W/Ng7tizt3IpS0iASp2rfxac0xjj8cEKca763wJej7KVinONY8qkgHpCNhF/Oh8qiW
         /xoD71X3rQnJV5O4sfgwa8w+Ehl7dP7RKQZg8PEMLzSVOua6IzkPCv/tu1O3VeNC/8zi
         YbuyKmV1p9KYANXLcbrpNm4dbroaVJyXojTbUNVPQaaFg/VtwoNgiIU4D2GKHdgQOsqX
         6AK9vB+XIb6b8Tu9/iJDe1YM+o3lhdgoSf4DsnhdiYgV1QEm6q3gye1D38f1Uv4eXUN/
         budR+kLraai9YxsZk75dr3Mh7m0DOuCvYHQZuXW5dz6c62LzfRgw4E+PSoqJvDtLf3OG
         09Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXi7uRa5iYJk0yhu1jx50Ftn5+F02DjnrEWGElmwhKwxL5O5/lf/1NrNYBI0JucAaRT4sgSg4exL3MfXU6Q1SppTsm4ZJBhmeT+yReUJ0IOMwlp
X-Gm-Message-State: AOJu0YwcRVPmc+rNpy5DYyso7QHeCC4Tbz43V6eK3rWxQ337vNMfG/bJ
	+Nq6jdomTark/Kx/Y2CyKOzYNDkwOs09gSu7CL7WP4BShscrlmhsFtMgotF6vUPlGnd0MA1w7PY
	TTFQVSviqOgav4PRrH71P7ge7rp96y2lmz2m3pA==
X-Google-Smtp-Source: AGHT+IHVdf4CeK9m5TY7u8n2i5EYX8aCm7rXG/PvOUZXj0qTxh3niUzEWChMP06D9pYzethEgSj8BqmnKZHhXWATYww=
X-Received: by 2002:a25:6612:0:b0:dff:3b6a:6322 with SMTP id
 3f1490d57ef6-dff3b6a64a9mr2668500276.34.1718590220902; Sun, 16 Jun 2024
 19:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com> <20240613093233.0b349ed0@rorschach.local.home>
In-Reply-To: <20240613093233.0b349ed0@rorschach.local.home>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 17 Jun 2024 10:10:09 +0800
Message-ID: <CABgGipXB8uQ7XZbBFMZa8b7mymKAW7qOkKKaA8qVZ0hGXziSYA@mail.gmail.com>
Subject: Re: [PATCH 2/8] tracing: do not trace kernel_text_address()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 13 Jun 2024 15:11:07 +0800
> Andy Chiu <andy.chiu@sifive.com> wrote:
>
> > kernel_text_address() and __kernel_text_address() are called in
> > arch_stack_walk() of riscv. This results in excess amount of un-related
> > traces when the kernel is compiled with CONFIG_TRACE_IRQFLAGS. The
> > situation worsens when function_graph is active, as it calls
> > local_irq_save/restore in each function's entry/exit. This patch adds
> > both functions to notrace, so they won't show up on the trace records.
>
> I rather not add notrace just because something is noisy.
>
> You can always just add:
>
>  echo '*kernel_text_address' > /sys/kernel/tracing/set_ftrace_notrace
>
> and achieve the same result.

Sounds good, I am going to drop this patch for the next revision

>
> -- Steve

Thanks,
Andy
