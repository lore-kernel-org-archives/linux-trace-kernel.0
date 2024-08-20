Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904D8F48
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166684; cv=none; b=o8/ylZS+GBddSBgMH5QJLf0Sdeq71SB/Enz7j07fbEP5fBklj/VC4IMfF+yw7a2uXGO0kndRNX4pqdS6jz0RUaq8PtjoBD1F5uXxwwD6LF5myJ1+dUOaEfWxb5YGtjHDGNSL8CAR0UVAMmI2r1+2hTh63cBWkWgtb/culal7hx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166684; c=relaxed/simple;
	bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR3nxPd4AaHfOqRfmT7gnQtnSSpeZAIKOYt6vQwbFYY30qNyVsqRZ3RdwZoSoThtfjsM6T7YXL/uxU5Yk+U3Qz5FGgePWJSRjaLbUuc5+wcGZevKoOnQDH2So2HwymumblXy881ca9OoZEcscQd71hovqP5dkqAWcq6S7qbOg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ5NuEF0; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ5NuEF0"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fee2bfd28so165261cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724166682; x=1724771482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
        b=DQ5NuEF07xkx0RtPCO8Q9h0cIe5x55eYVyU5HynuZZ8vTXbbzsDDR5BL7TVLHC+RQH
         40QbLiMUB5iNXLBxOmnbt1YNhT1Qc/+Wd72BFvoSHh72MBVxFRBCy1X5ZR7LN3s/e2i1
         RLk2UEk/Y1+cRbaV60UTpjHtn/b+acPSjZVjdf8C4MA44ae4ionKrgv94RtlgfsulD79
         1pxrliE0dj7FaPTyfYTrloGiKr3xycutfu5zXanxgoabB9N09HjFS1K0swWdxC7MylzD
         wim6ZbQKxYzxeG7o7m0ygS6LNJ9aHnjtK4GUnNLqTlq7CDl2MtqkZKLViakY2W8dsH/2
         nyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166682; x=1724771482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
        b=JI2uSf6vcjhQO7nfM17PzyEzbhjKZ5Hl+lsLTw48MyC9kaPM/aSs5zqklOB/StHHk8
         RaJ/BbngIcHXnEv3aLLktheHhIfhojE0ozvHbhxgaj1uq0HYyp6VjX4PqxfdWQPitrvq
         1Zqe7qWddVaKVZnHPki0JFbSXECLPMewfzjTeDxb2/NCp4mjkNjYO41s5TDZlj0/YDQI
         EO4dxgnEO1v4gjEypgb6kVezCzipXzBBtC99bL00DPKb3VFp4vBMqwHFqgRw3/RMT5ip
         PQsnPzCu8znarwMMOdz1qti4YLcRkV/JcmRkb7sRuQ7/Tig1I8rhpSEY7ZuN6Xi4l8Le
         wPhw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ROBLYxT/NJ6XZJvqj4Mg+MAPj2JnIJVomRnz43pLWoPkG+ovHZzaS9oV8AAoEMCFHoknDC6t2h96kI8n4JqIYG6SATpyBbfYmsFadTf2bXwa
X-Gm-Message-State: AOJu0Yy/K7jJXA0/OCmVbr/R4sQGCIgGmuAOP/paR5V/3kNVEFF+uA2v
	Oo/zX9pIJ6atrjsUZX+EUk4ZV37gFt5NY+VdDoF4rqKzlVgMcNtRKsVyN3DPguk2dAVokLJVHu4
	J3+oLevUCR3RJBOdCLbmJUeqKdWQSVq+zlqfe
X-Google-Smtp-Source: AGHT+IGxHrWvwxkET5G9KFHE2OTgjBHj0rFGE1objVdIM7lhI5d9VSUlLjMmyoZSbxU87Ybr//Q4mqrhQSjJsbsz524=
X-Received: by 2002:a05:622a:245:b0:447:e728:d9b with SMTP id
 d75a77b69052e-454e6ac44b5mr1928511cf.26.1724166681458; Tue, 20 Aug 2024
 08:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
 <20240819112902.11451fe8@gandalf.local.home> <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
 <20240819120244.5657eb2f@gandalf.local.home> <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
 <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
In-Reply-To: <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 20 Aug 2024 08:10:42 -0700
Message-ID: <CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:48=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote:
> > On Mon, 19 Aug 2024 12:02:44 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Tue, 20 Aug 2024 00:56:49 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >
> > > > >
> > > > > We may need to add "noinline" or something to make sure those fun=
ctions
> > > > > don't get inlined for LTO.
> > > >
> > > > Yeah, we need such option at least for function call test.
> > >
> > > Could you add the noinline, and if it fixes the issue send a patch?
> >
> > I found the target function already has "noinline". I tried to add noin=
line
> > to the testing function (callsite), but it also did not work.
> > I think "noinline" is for the compiler, but LTO is done by the linker.
>
> If LTO is breaking noinline, then that has much larger implications for
> noinstr code and similar, and means that LTO is unsound...

The noinline attribute is preserved in LLVM IR, so it should continue
to work with LTO. Which function are we talking about here? Are you
sure the function was inlined instead of being dropped completely?
Does marking the function __used help?

Sami
