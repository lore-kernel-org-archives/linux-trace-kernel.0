Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C24A1D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735268327; cv=none; b=A+aWT492PC87HqoIDXhghuVZMt+HGIzLVHvMhu+Mqhpe9SN4uUJ49nwXTBjPBOBk4t2isBepnZkfJE/5pTR6en1XDZTRmyfuNpxaxlzb8CwKP0YT2mt6YvRG20JLjPqieywOeuV0tO/hQMjojgBijs44nY4JUe84TvRXfu0u21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735268327; c=relaxed/simple;
	bh=FLl3QcbQ6gl5PtwWermYbCj21YqJX5D0JrVgwIktLPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibdV0UED11DDc522LK9Rd70ktOlgW3UfosZe3s8hII2RkGM/ql7IK2eNrmMcE9pY/AHomhIdY1R/hHwzuhrEF2iZPG1zt0a6LCmchQs3NMpLWyQgymw4fEtriCj/Ax9U4tdA1VE7cOQalHyjEngzoraL0tqaoLgYIKRODMjIWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fB/xXnds; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fB/xXnds"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67333f7d2so1019079766b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 18:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735268323; x=1735873123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvIAPNYP54LEnLyIp5Ezwqoks125tVudSg9dAYgT6rM=;
        b=fB/xXnds3hsGR/5oZ7kLn4K92ibILGZ5D9YgR2NJbJ6+0spRVw8KlVXWwEchOec9VT
         AqILd8lJOW5C+0CUDNyi+Sqkueaodu+CLdLBNj2dPLmjrjduLZNyjHehfGk/FbSx5WH4
         jxSBqW9PuPG/43S1O5aF0N6lKwjgVR8cHvGXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735268323; x=1735873123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvIAPNYP54LEnLyIp5Ezwqoks125tVudSg9dAYgT6rM=;
        b=km6eTh5NuV4DX8PYGGSZr8P0LYSm0C+u6rVFQ8h/n7vrzPtQbAPjWXeP8CphU2DRTp
         AQPDREl8/4PXNUbYHGaCZm2nxfVAtspxtiKpvqJK6/34VmTr9mOqllOT4V+8gFb2TqrX
         qCaAXs/87gegwY+RNBYgdcR1Ii6LThOvB+u+q/J4H4gRPg/96i+6wdfHTOx3EKhZwGlR
         3L3K6MLHAPfLvlPaCq+l0IBCiJPQqIFi/sUr08ckoIp0hHp4TNOuMN2YRWnzWX8I6xy5
         2zbdGzjICXPajIlQaKS4+/al8Z4P9RVyNR26yVKnGzDL2rcfSP3J1jp8tqy2TP+3yD4C
         NCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWAh79BLsFHNKt3WQnpYDZhTetDfsuUsgua6rc1VYL/wpU6xaeZssGdyXIqPyH9C5mPVmum1C79QmPsCy6WJyCsGFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGW/0e4+nDhptZolOHUC8lxVzjFS16/kICFDoxRED5yAjFlUvf
	su7QhcXZDgf5Hhgis75a5/9VBDz4d+Dv37G8zOZhI59QGXow65qKhS5VD6Abq1wHO7grLYueDmL
	MXduwBQ==
X-Gm-Gg: ASbGncvZ0oGC4yVp5bS5oUWYuuDlrvmSC5m1DUCcB/InpCoIYyUq4ZMfF+hVdMZ4M55
	D8p0gGBtUbN9/c10HlHAAkxzZpTvd4wARgA0VeBAaBXYwF2LRT4/fT6nT+CSwwbIPZEA9//42mc
	QgSg8Vf43qHe/23tRq9jS+tUnVSN7Hlh9/Lqqpf4MHc3Uy9Z3CPQUd3RlN7Ep14IdCHTY0LtXBa
	21txccDDxJPoZMVbJYnQDoQG3k30xA/ytNI6Tz+qvgDjESt+MlfvgTQZaYFr8jt5rFR/Y3ksefq
	cqTpsH1GVk/V+OqpAuw+aIlHlRxEGF0=
X-Google-Smtp-Source: AGHT+IFz1a5Ke1JAANsqnVOTwfxDgYf6DBSoH6AuW9GDAmwnr8Bluw+LIiCmTSBe61CA0PlTDB8kJQ==
X-Received: by 2002:a17:907:3e1c:b0:aa5:2575:e75d with SMTP id a640c23a62f3a-aac270369b4mr2294459466b.2.1735268322646;
        Thu, 26 Dec 2024 18:58:42 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e898689sm1043915666b.78.2024.12.26.18.58.40
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 18:58:41 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so1117225666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 18:58:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQBd+vKQwt+SY/6qX7DCv2QUCdggcBVSlyUoO2hV6nBMTSKu6y+zoVVN1JBdWFrY7bPoLuknZn4rAGJ6Y+hKCfVZs=@vger.kernel.org
X-Received: by 2002:a17:907:3e8d:b0:aa5:1a1c:d0a2 with SMTP id
 a640c23a62f3a-aac2d0478bemr2183880666b.34.1735268320564; Thu, 26 Dec 2024
 18:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
 <20241226211935.02d34076@batman.local.home>
In-Reply-To: <20241226211935.02d34076@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 18:58:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wii_nN1X4O9=nztJy3rexKp9w5Gsp=J5kZ43Hekja+Omg@mail.gmail.com>
Message-ID: <CAHk-=wii_nN1X4O9=nztJy3rexKp9w5Gsp=J5kZ43Hekja+Omg@mail.gmail.com>
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

On Thu, 26 Dec 2024 at 18:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So basically the real solution is to fix kallsyms to know about the end
> of functions. Peter Zijlstra mentioned that before, but it would take a
> bit more work and understanding of kallsyms to fix it properly.

Yeah. The kallsyms code *used* to be pretty simple - really just a
list of symbols and addresses.

But it took up a lot of memory, so back in the day (two decades ago by
now) it started growing some name compression code, and then some
serious speedups for lookup.

See

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=e10392112d315c45f054c22c862e3a7ae27d17d4

for when it went from basically a very simple array of names to be a
lot less obvious with that table lookup name compression (but it had
_some_ name compression even before that).

That said, I think it's really mainly just the name compression that
is a bit obscure and looks odd, and it's only used for the builtin
kernel symbols (module symbols are still just a per-module array of
"const Elf_Sym *").

And you can actually largely ignore the odd name compression - because
the *rest* is fairly straightforward.

For example, the actual offset of the symbol is simply a plain array
still: kallsyms_offsets[]. It's slightly oddly encoded (see
kallsyms_sym_address() if you care), but that's because it's an array
of 32-bit values used to encode kernel symbol offsets that can
obviously be 64-bit.

Encoding the size of the symbols should be trivial: just add another
array: "kallsyms_sizes[]", and it wouldn't even need that odd
encoding.

So I actually think it *should* be fairly straightforward to do for
anybnody who knows the kallsyms code at all.

The main pain-point would be *if* we want to actually expose the sizes
in /proc/kallsyms. That would be a file format change. Which we can't
do, so we'd have to do it as some kind of strange ioctl setting (or
just add a new file under a new name).

But maybe we don't even need that. If all the uses are in-kernel, just
adding the kallsyms_sizes[] (and accessor helper functions) should be
fairly straightforward.

Of course, I say that without having done it. I might be overlooking something.

           Linus
