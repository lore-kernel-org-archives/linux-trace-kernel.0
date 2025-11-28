Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5061FFE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764308158; cv=none; b=BpPSAoxDhOQ3lErhWiJe4Wm011AMvVBu1WrpOO1Z4f9wtY5XNqevvSqPyn1XvSl1pLnIUpoZoPAIZwd6A79Zsy5/qjhwcKoeleVHHzTXGZQliiBznNF6De7oHjNtX03kGN8g3sPn8R7jTeaJARkP/M+9z14Y7O8Xh1t4D+bVtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764308158; c=relaxed/simple;
	bh=vs1yg4f34u5WJ1yPdJSEYZL0CSP4S2CFc9DmmbkR8AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evhk29QUx6Dxesz7Z0t3CzxNE0HpDwSxNxdgnrc0GHuTmfML7hUKuSd3qoZiKd6ws/hR2PHjYdDE94Td5hDvzRY+ErYJ23L+J2urgMYxZlzpOb6D/8PNKsNrtHGiS+1DF6YnGhi8xugbL7nQ7S29vXG5kJ+iApoh2z8RqLAF7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FQu9vsjH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FQu9vsjH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so2320172a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Nov 2025 21:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764308155; x=1764912955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Eyw2ecIRLyY8mi8vSAM8Rof7rADC+bcj+32Ia5uSU=;
        b=FQu9vsjHamqCPE2kU21OwuzKXh+xTcsI/zJlfcpiTOkW+l0tTNXWYcsXXNEZs1HHYE
         8OO4BFUi/al0dYDTMtaPshUpK6juq79scMnD6wHrPaEDdP5WNuPaS2LCZbQmTH3EmOzG
         hl87PD+p/5MD0YEMfOEhvq61TDy7B1yYBxag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764308155; x=1764912955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+Eyw2ecIRLyY8mi8vSAM8Rof7rADC+bcj+32Ia5uSU=;
        b=dulmmEU+MrxT5N6UzLnmnQ6hiqc/AXiWmLKWLqZ2ttVkLYKdYWoI35DHFapOR+PWnj
         KCsq348fERodMJedAM6/NQw9HM0SuE4bCRTRC8ORLQURjWR5fLo28zlCYd73QW+4VonW
         V78NeiRD7DKvnNiEu6NafPMjMLMrZdphMrP/hnLg9bdz//S10HVe2ENLXXb81OBft9KK
         JblDB60OP+9zixaPtNEybyZEBtyOLxdqqRVFkBaJbKPyF9vx26IrkQiz0Jh3VOfHFjYz
         2L3ZwZm82WhVD4CD6dh3492ass45KGbZh087wMq6vBeoB7AHz0E6MJ3FWF8jAY/N85Q3
         uIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrd9AZ8lzh7bpar7W79qlAqlpjpl9mm4GEQPxkZLW/agq4zUYUB1wkye/MAD+ftTvQt0lPWAXunyoqZDZ4wtJ70ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ98FpTsId5X24jvbPxDLqQCjvHdNNZCTv41JxOuZODrFubd+z
	AEM7JftJShyt8YkPV8k501pmEDqt8EA5pRgXTmhKxhHqRXEGHAqYG+EHoDqQ06HtAn375ZAfIHX
	vYYlO3Co=
X-Gm-Gg: ASbGnctG57vw2+c09aO59AbnKOLwwI5pXvutXuwBmwauYaLJaH0IwGgunIyh5i3nY3y
	l2N1J0zcN7eqzMDlKQpteJiEVIZ0D1OKGBgt9VW3avBvLLqTDuSmPWtj45bB8ztNisd4fvz2L2R
	NA/T5R+EXdhsENhzT4x0qnPBtVcUcz/p2Lxp1r613iskYL7y8TBXVjanjrgWNPO5npVKey8kz43
	wS1lWenOEiC00LLhnNcADMHhk5rxhJYQt6cwhupYZYFLRgzneDoQ96m81UKFoUy62a/j5jeoy4E
	x70iEQX+Eb/ENDgRxL6XXRyErCaM0UesOvoJcL1mnYEKLQmqA6/ouu7I5qoQV5BN+e2OIP42LYb
	BLm5zhNJsYEe43IbQlC4NIoGitU5ehCcQAMAuyJUCaHlXlF1vHeRIFunkRhPlpvnUkjKACXUqJq
	MdPrCEIeNwGGcEFcWKXAIURFSaPHkfGtqZ/UgnShju78oBWFiWR1JaQ9oKjfe9
X-Google-Smtp-Source: AGHT+IHJLY6xmFxpB+K7kbXDUZOTzCpD9eYIqds0sLQjrcuxIRC8InG/rLCGw9bqGa5oL+1W6xQfBQ==
X-Received: by 2002:a05:6402:1d50:b0:640:ebe3:dd55 with SMTP id 4fb4d7f45d1cf-645eb23f84emr11439770a12.6.1764308154666;
        Thu, 27 Nov 2025 21:35:54 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c24sm3415639a12.22.2025.11.27.21.35.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 21:35:53 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2209793a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Nov 2025 21:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1yog+fN/cOZOAGJ+u2fpaRp55MHvs8L98+sTGNaHvKUPw5bd61MwJagrqw+n0nDbjyVzSJusbCeU284UVfh+TQYI=@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:641:9aac:e4a9 with SMTP id
 4fb4d7f45d1cf-645eb26ba61mr12717665a12.15.1764308151943; Thu, 27 Nov 2025
 21:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126145249.05b1770a@gandalf.local.home> <202511262356.6FE5084CB0@keescook>
 <20251127204342.05fc985e@robin> <6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
 <20251127222710.324357cf@robin>
In-Reply-To: <20251127222710.324357cf@robin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Nov 2025 21:35:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
X-Gm-Features: AWmQ_blNfUK3d20i2UnAsBf0zzgIcxgwgDs5L_j02ELWuaSJF7VpIWmt1gr56Yk
Message-ID: <CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of member
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 19:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 27 Nov 2025 18:00:01 -0800
> Kees Cook <kees@kernel.org> wrote:
>
> > If you have an instance and not a pointer, just slap on a & :)
>
> :-p
>
> I guess that would work. Although it will kinda look a bit strange.
> At least to me.

It does look a tiny bit odd, and it's not always wonderful, but there
are advantages to conceptually passing in the pointer rather than the
actual instance.

The two main advantages are that

 (a) a pointer is *usually* what you have. Not always, no, but it's
the common thing in the kernel. We have a lot fewer cases of 'struct
on stack' than we have 'pointer to struct somewhere'.

but even more so:

 (b) unless the macro makes it very *very* obvious in the name that it
only looks at the *type* of the argument, dereferencing the pointer
can easily look absolutely horrendous.

We had an example of that (b) case recently [*] where the code looked like this:

        typeof(VAR) *__obj_ptr = NULL;
        ....__can_set_flex_counter(__obj_ptr->FAM, __count) ...

and note that combination of "NULL pointer" and "dereference that pointer".

The code was *correct*, because that '__can_set_flex_counter()' macro
in that case only looked at the *type* of the first argument, so the
dereference didn't "really" happen as an actual access to any memory
behind the pointer, but it doesn't make it really look any better. We
really don't want to have those kinds of visual patterns, it just
makes people go "WHAA?!??".

Now, with proper naming, you can make that obvious. You can make it
really clear that "this is looking just at the type of that argument,
not the value of the expression it is given".

But honestly, I think that "really clear" comes close to just having
to have that "__typeof__()" pattern.

Can people learn that a name like "struct_offset()" always just takes
the type of the first argument, and get used to patterns like that?
Sure. Absolutely. But I'm not sure we really want people to learn that
pattern if there are alternatives.

So I do think that the "struct_size()" syntax - which takes the
*pointer* to the object and then does "sizeof(*(p))" internally - is
the better syntax. Not just because we *do* typically have the pointer
as the variable we are trying to get the size of, but exactly because
we do not want it to visually look like a dereference of a pointer
that may not have a valid value yet.

Put another way: yes, it's slightly conceptually odd to pass in the
pointer in order to actually get the size (or offset of a member, in
your case) of the actual *instance*, but I think "slightly
conceptually odd" is a small price to pay to not it look more regular.

And yes, I obviously do realize that 'sizeof()' and 'offsetof' and
'__alignof__' all take the actual type, not the pointer to the type.
But they are very special operations in C, and we should not make
other operations act like them unless they have some very clear and
obvious clue.

For example, we do have 'struct_size_t()' that takes the actual type,
not the pointer to the type. It _only_ takes an explicit type, and
cannot even take an instance of an object (although we could *make* it
take an instance by adding a '__typeof__()' into that macro). But at
least the '_t' part hopefully makes that obvious, and even if we did
make it take an instance, you'd never use it on the above kind of
pointer without a valid value, because then you'd use the non-_t()
version.

So that 'xyz_t()' version then gets used for things where you
explicitly state the type, and it all looks fairly obvious, eg:

        len = struct_size_t(struct pid, numbers, level + 1);

doesn't get that "WHAA?!??!" kind of reaction.

[ And so I actually think it's good that it only takes an explicit
type - if you really have an instance, I think it's better to use just
"struct_size(&instance, ...)" even if we _could_ easily make syntax
like "struct_size_t(instance, ...)" work. ]

          Linus

[*] https://lore.kernel.org/all/CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com/
