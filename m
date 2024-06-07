Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7E187358;
	Fri,  7 Jun 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760791; cv=none; b=RtFltLRBznglxpQTKm0zYKEG/bVkhRFZg6vTyB/14z6MhryMZ3ogEPbK01BPcuMBBadTWNvQC6MAnmv2m+mG0xpKxRht3W6DgZBRcbIMoEdcC/TeAvhiicTj7a+KvdHgD7L4dBwqJpIVEODE3MLuStjPkJJ4Hl4faBZv9KkwTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760791; c=relaxed/simple;
	bh=MksdrsbJ5svjzf6jDBrszTDyTVTa0+EnUEUUE1OZVxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMvmjVzp0LMTgQFU8v1A/hheYxs7lTLx73uIAKDENhZVaYAx1NkOKLCisSGOT75tsSQ51Nq0CHpllIEbXskfIukONFRIFyEvV4cxCPYnJIRmLo/l4G5mgZHdZy65oUXgAaP5tuFi92bjvrRd6Gd0Dt3s17EDO8rWdoGs9ADHD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWAuWg/v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWAuWg/v"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c28d50f16aso1442021a91.0;
        Fri, 07 Jun 2024 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717760790; x=1718365590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAkUIoGQHtxZMPQO45fRmdhKtMVjNeA1ZhO0yG7ZitE=;
        b=hWAuWg/v2CX35DmdlG0GSWFmJGZCOVsp021pgw6ESucr3PUd9gKh+Ty5MGli4STDxI
         CI3qrInjN5f/LDdaqPW+36XVhw32qusjsO6GvixcVX7G1tNkWZJvOE07jnl2fJdhwq+y
         82fJMGgU1RBc2icGZLNFzBMG7W+0buhIt1L7V1WBwWV/UjRMNg/JyyAmi0WbJKR4s/cN
         HLc6wmxovcEf6TXsURBPjEXsk2GFHWccRrAp2PVeap+JVzWk56iGw31WorfR7PQMcRBO
         Gm1CXzEcURztJ5OfERVshPP6oDpzyxyO8yeOT3uo+YOsrDXjVYyxFp2l7b7F0CpqVd9u
         ixMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760790; x=1718365590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAkUIoGQHtxZMPQO45fRmdhKtMVjNeA1ZhO0yG7ZitE=;
        b=cTeoLUtKN5j0+tRWrgd+LFWXegIIKsWIaQIbBi9zsmbJVZc4ybJuOOcDcn+8pLaDz8
         chxyYZzG7Xexg+hpNHdtYNYQ7LD2+Rt5bH4P2NIALUMvvwvzRQwTQbSwvf6X0xOBBBeE
         Y7V59QGb0EObiFn4kG+CbvZU9pL7JXqAlMcQuaN15ZSlm76BMjq8gQKYFCwO9m2BOdPq
         liYjDhyWfC+HANUBxfftTJb1UdqLgE2zCZesa16vchJ9A2KqnWje/YlotKPQSvwz8wSg
         jHMwZGUGumHX17LyeRqWy7+KEmmtxvpbSduTdNMwXkfD17hPugBZmsrfJXXzzeZGqGm7
         WVGA==
X-Forwarded-Encrypted: i=1; AJvYcCUKGnNV0OCYBiDPn9IG0TmSuZRCkRlB6be2W5CxWKTMOCJmT6+2zl3s0jRLmuHho6Z3jPSoNwYyWhttDp2PsFUAO/OYCynpgbqs5Ex9czjkVVgKU/k7UgP6SU414L70rQhzWP8V657EOJ1u5e0NWZDpM5KmpYxKGtH98I01LXN4tkZErWQpz1gxdJG4ow5dbn0=
X-Gm-Message-State: AOJu0YwP3fdXGi1UYcBA2cYBEz+6yLYuBR9yC0E65zi3ne0dVLkDQVh3
	KZab/9xp8Y90tpg42fBQMlSzlGXHLqNbgFAOXlbAoD+BBRgXAz5cL1KHQNLRUR/qd+GDMxeHam/
	ZRsvpA9/c3uKnI5yEuqPQaGxM0Hs=
X-Google-Smtp-Source: AGHT+IF6/OJhB7sayOU4uVkxQbEc9EJA8bdBUJ3pZJ8OjFRI0rIXJFvSLeMQYgIiS1t0pohJABV53TlTzJelBVh0v7o=
X-Received: by 2002:a17:90b:b07:b0:2c2:4107:4cb1 with SMTP id
 98e67ed59e1d1-2c299a4764cmr6660301a91.24.1717760788894; Fri, 07 Jun 2024
 04:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
 <20240607094329.3878781-1-aliceryhl@google.com> <20240607105232.GP8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240607105232.GP8774@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Jun 2024 13:46:16 +0200
Message-ID: <CANiq72=4y84CrmkP-QsrW7YYNbpNJRim3oFK=kfEE8oin38pMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add static_call support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	ardb@kernel.org, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, jbaron@akamai.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, ojeda@kernel.org, rostedt@goodmis.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 12:52=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> I'm sorry, but 30+ years of reading ! as NOT (or factorial) isn't going
> to go away. So I'm reading your macros do NOT rule.

It makes it clear what is macro call or not. They could have gone for
UPPERCASE names (for instance), yes. On the other hand, they do not
work like C macros and are ~hygienic, so it also makes sense to avoid
confusion here.

I mean, I am not suggesting to do a CPP-pass to Rust files, but if
someone really, really wanted to mix them in a single file, it would
be nice to not confuse the two kinds. :)

Generally they feel "closer" to the language (given what they
do/support) compared to the CPP ones, so it also makes sense they
don't "shout" so much compared to UPPERCASE, if that makes sense.

> The above exaple fails, because the next token is :ident, whatever the
> heck that might be. Also, extra points for line-noise due to lack of
> whitespace.

$name:ident means "match what Rust would consider an identifier here
and call it $name for the purposes of this macro".

So, for instance, $x:ident matches:

    a
    a2
    a_b

But it would not match:

    2a
    a-b
    a _b

For the usual reasons why those are not identifiers.

https://godbolt.org/z/G7v4j67dc

    fn f(x: i32) -> i32 {
        x * 2
    }

    macro_rules! f {
        ($x:ident) =3D> { $x * 2 }
    }

    fn main() {
        let a =3D 42;

        let b =3D f(a);       // Function.
        let c =3D f!(a);      // Macro.

        //let c =3D f!(a2);   // Works, but the variable does not exist.
        //let c =3D f!(2a);   // Error: no rules expected the token `2a`.

        //let c =3D f!(a_b);  // Works, but the variable does not exist.
        //let c =3D f!(a-b);  // Error: no rules expected the token `-`.
        //let c =3D f!(a_ b); // Error: no rules expected the token `b`.

        println!("{a} {b} {c}");
    }

I hope this makes it clearer.

> You just need to extend the rust thing to be able to consume C header
> files.

I agree, because in practice it is quite useful for a language like
Rust that consuming C header files is "natively" supported.

Though it also has downsides and is a big decision, which is why, like
Alice mentioned, some people agree, and some people don't.
Nevertheless, we have been doing our best for a long time to get the
best we can for the kernel -- just 2 days ago we told the Rust project
in one of our meetings that it would be nice to see that particular
"project goal" from that document realized (among others).

Cheers,
Miguel
