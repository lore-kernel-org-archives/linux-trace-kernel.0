Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A26158E;
	Mon, 24 Mar 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832733; cv=none; b=DXWfK9JsnMSqH+eEHRJLnvIA40CPdRXNG14Walu0kzSBf2nXFIC3/0+v4mc0hmEALqMiN7rGoS3IPY8XSL6vBD+dnO6VJuElz8GADzR1VcDLBrf+4q5lLKjxs/R73tIVaW9dbonnnWO58P6AWtwlB81X+W/Q5gHeFcK9gfwcgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832733; c=relaxed/simple;
	bh=QG6XTY6hPpeWjaNYJLY6bvREGZypEO+xDVvz3yN4QYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioBiyI6AYZ4SzMbsG77HKxz0VKCQJlMCJVsebPtZAcqxVWbmoKgryZ8v4+f7op6CY7ntiKA4Co7JBIGt/qOH8dOXuZF/Slfz9wWx6M4P24mtOzSP5UjzUg+X96vzIOakTtHrk8Fu0qddDcxTDEtT3UtJDCJDrGS7qncEjrSxTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLkVnsGr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLkVnsGr"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so644274166b.3;
        Mon, 24 Mar 2025 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832730; x=1743437530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2wkPmRgHq2bLqP0oD2Mx07MkxAskvfdfv2BP5iExu4=;
        b=gLkVnsGrq/U9MKrgApld+IyvB+TwOi8QQYXPI7dcQ5RjVJgUbBj4lFnFvQOg8R/IGj
         1iO5zQ5rKKcl6xO6aanDx/9T5dssAlDNfII4IC9WyVL75XUAlTmZOPuAIoFT2u1XMusp
         AcRbv+eikjqi1QHew5/ZS77XKZVNXefHVaXNR6ZOmjWUam9KJaSKN5unBcx7Wp3zhLt9
         1sR1KWJ7QIQPbla6uZE3uswbCENix1MI/WX4Cs8sMwb//X77RHEZD1DdYl9tDZglGvn+
         hvBQq9EzSEhTOJXl5L6cZrnO34y++Iz/Z2Cnv2lr6ufdGF3BsH2/L4kVPamChRdqGLa7
         ZoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832730; x=1743437530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2wkPmRgHq2bLqP0oD2Mx07MkxAskvfdfv2BP5iExu4=;
        b=KWmUckxuAT7cL2ZjIoTSYvchDrLXE1v/gTk0G+Dnefjd6AKWJyLCBZM6+KEX/8Lzs/
         TniV2cPm9dqxu/LH+rFfv3uXVQsvloiISqyD945ubljkb8XhmaeHlcd/ZIlfyEdIbBa7
         MTu5x1aOtB6S9VpQv0pShf8Bam8IXLNc23QNb6K7xdi/XR06KVG/EMi823sNUoEpO5+P
         aGS9ZsP86eXkg5QZasAeWESyV39su1903wHK7bJFCG1S0qg6ckHhXz1NrxHyjtDdzx9o
         RUdYykXzfm1maf8YcHzildLDvX2PahmcXr0o+auQvSW5TtlP09Qa5/oJU7vk8+A0Q2oL
         Pg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVLrlpgJAwLytGdSYABj5QWQABVQHW+n1rE0BcmdQibIL0x8F3GiMiUzgL/xdUDmsAHnBVfDXCesiCsd57AHiY=@vger.kernel.org, AJvYcCVP/5C/0OlHybYKf091q3oNEAiTinhjroaQYrhkPmv4ldeJeyKHYAy3YMBWB92JiqlYFijD9hAe5fiA99YGcbdrYMCA@vger.kernel.org, AJvYcCWluo7THV7rISSRcK7XSxHjhZVB8dqh5SZTOVkaoRZX9whxHFxnZFsExcTfz9rsy/+OCzckp1RTLc2CLdFL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRzqioYp0l3GijRl7j0nDwU4qUxIhpy6vpxwBELeUroKQfdTI
	GupT2VEbS3H6N5GWDNKyHhlJx2IDqh9JKWRsPuHTdYyRD9f9yY+CXpSR6OE6QuCMFeqY4FVNVKN
	TBcZm8tQXB+PphTHDlaqoDH9r0l8=
X-Gm-Gg: ASbGnctWaSQ/dWVO5JaeplbGdNaOxssbNi3cV1BbtL/E8tJTzBnN3PRVJstd/ezKJQz
	y4q9fEalN7fZaJOvNeQDcHtgyOD9xQc97Lfjsd+zzZnB275/pOre0CSNYVo3gBlP9NxVMgHK8Gq
	RjWKbTLO13Y+ntm+v+JjJ4IHXPhEkM4aum1JwEgZ8=
X-Google-Smtp-Source: AGHT+IFL9U0A7ifaDxb77XvQrFD13twdirQrJx6mPjwmEa1d/1S0+ELWJS9/e4tUZ5jQfM+wBjL4GvBurog2oHRtTWE=
X-Received: by 2002:a17:907:3d8e:b0:ac3:f0b7:6ad3 with SMTP id
 a640c23a62f3a-ac3f24c835emr1407053266b.40.1742832730122; Mon, 24 Mar 2025
 09:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-4-andriy.shevchenko@linux.intel.com> <20250324120242.49253139@gandalf.local.home>
In-Reply-To: <20250324120242.49253139@gandalf.local.home>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 24 Mar 2025 18:11:34 +0200
X-Gm-Features: AQ5f1Jp0nTy6YtQdWpgYNFERUuCWiqzYfALslgyMReY4_LUZxGK9AwEgFIzK7WY
Message-ID: <CAHp75VfnGKJ-2L-+rTxR=qf=vxJ-nnhBQv9um8z8wYKbio9nZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] tracing: Mark binary printing functions with
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

On Mon, Mar 24, 2025 at 6:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Thu, 20 Mar 2025 20:04:24 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > -static inline void
> > +static inline __printf(2, 0)
> > +void
> >  trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *bin=
ary)
> >  {
> >  }
>
> Do we need to split the line after the __printf()? Can't the above be:
>
> static inline __printf(2, 0) void
> trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary=
)
>
> Or even:
>
> __printf(2, 0)
> static inline void
> trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary=
)

I really tried hard to be consistent with something. tracing code is
most inconsistent in the regard to attributes and other things (at
least in this patch series).

> I rather not split the prefix elements of a function over two lines. I
> rather not even split them from the function itself, but tend to do that =
if
> space is needed.

I also looked at the approaches that are used in include/linux and
tried to follow that when in doubt. And I think the way to leave
static inline leading the stub is most used, followed by attribute.
Then for the declaration is all the same, leading attribute followed
by the returning type and so on...



--=20
With Best Regards,
Andy Shevchenko
