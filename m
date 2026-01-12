Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F498361660
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235868; cv=none; b=UhvtDliIyOkYMOmleCSs2YQj/BMTZpXHVmsl83tks+GiGHXGaUxnybWSTtLzXoX6x0ol+1ESj/7+//DjwKWyT60cgpqEvInBROi6ZaPTWgT2Fn1aBqgXJ5yCcuQdZhKDRKOHowCWc/ZcJGm/z58nU6PHYeC6Uod97NSmj7+gF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235868; c=relaxed/simple;
	bh=qbHH2uUXZGAirgnbzgLWQWuiN6LQaxR7aImZlpSiT2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPysmzxiVSeQLs/hFj046qXtYlNkK517fXyyyCSCVmI5g8+tcY9zKb9Ld/MyNKBwCa+OXSUq5khBViquSH8rQXE+3R9XpAQVrfRxZqiBeEr8JG1sVu/K0j/HrlYiO/xN8cSEf8AKpRDPmPfWpOXCR6qEFqJAAXGWP9XeC8DpCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDriFAPT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDriFAPT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so62397645e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 08:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768235865; x=1768840665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbHH2uUXZGAirgnbzgLWQWuiN6LQaxR7aImZlpSiT2g=;
        b=jDriFAPTWmpReEcQfHYbOoct5L1RVXgSBr6PkSTwmj0tzyoM2VDg5iLsykjuaoeOP9
         IkfrRRmb7nWcnTQTpFQpf+0lwHs/iP8WVbLXFS6lP6PRECR6qTbu3it6P+2q0lorbihT
         MdKI9RTT2wt07pLJuLyL54LZ1W/Pfj8MdaoF5YuQfUWemFbBLKQ0hngZfzts0svRpJHB
         QmqbC9T/nudomaU0Dmmw2CLkcyinmRKV2q18u0S25wi18fn0LPp8AL/8pxD/HwjSXkm6
         v3U+gg3Ml0sQrXp0wt9oIXVwfmEjl114oGVGTuwkHidSuMt9UzzaZblGsTOs1oL3j7t4
         Hp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235865; x=1768840665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbHH2uUXZGAirgnbzgLWQWuiN6LQaxR7aImZlpSiT2g=;
        b=OlRcb7dtQ40X8N9gn0bvtHOJOtvh4xJ6/31OofL0cjUBuziP0Jgo5H5AM06sTZP8Z6
         OgQrohEelKki9OWBjLeZOIOZBjYfBMuWGaWAEqbTdKjRc/zRsUP+5nlBDKTMkdoPbIW/
         oU12aWDob7I4HIvAUnypCLbaY+jySAC3M1ncAmwPKInxq7fRYvfet0nQ2sp2IuCrZAaK
         CNFP6DDlEQ8BPJ+NTEKqGmhzhpqIRbub+wlXScoy/+MBzHNp6fniwstAVY6oWKguaaom
         nuKYadlgBjC8dsGtyMbuCjfH+D9OnZIM/hGFv1/eKRJusZAPFQm8oL8dFtMV5wIr63Bv
         QmjA==
X-Forwarded-Encrypted: i=1; AJvYcCXi1Wi5x2IeSLsKtE1bv+PBfMp0cpgk0iZEXqAYg1Pntx7k2eqO5yWKwEaqHPEi9TD3ZxVYsNCwsbFHObXy4qUhhzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnhitMpUZb7UZ3P/QabG+BE8G9S3MJc1voM3NEWXTSM35YbAy
	wmZ8o/5Kj4aBDgh+6UJKuXTLxVRmlbisJ/fcV2dK7Or7NV3vMHqx8UpnSfPmSsh8DgBHiZA3Rd1
	XDVO7OxZJzrsj4kX+fnELczEvLgRPfy7AkBa4v5XH
X-Gm-Gg: AY/fxX5Adw5cZGBdzYqUJWX/Okfz5Nmlm3tUH0IuOWki8UwcieZ0XPcSeyKmVspmsmk
	imbKWMMcd/jKv9fXSk8hBUgeQGDb98UuP3hRToT1Ju/d7FwS06am7xsepFmE7T8qcMT6CousnRj
	5lqpIR/Rt1K9HVpkzVJbnJgKXMd8WjYgwn9sqyDysqcLf+g1eIUgpwBLcSzoYgqnmnxXD121R/k
	6WWModIiqDPoAVcnrnUVFZLw8gqpy5r4pzv/7ylvuq+DuAWR0a+QZ9SYToTP6dY2285Cap6Z1eS
	jjMXrUGznpuw/MtG+KVxnAdE/w==
X-Google-Smtp-Source: AGHT+IEHcPZ7R9CDAIhyc3AM3Ss29uK4mSmjfi+TyeddptL2PHq4zEuLMjOROhcBaID5pvKcF92BOZM5wyjFzJ3Txho=
X-Received: by 2002:a05:600c:890b:b0:47a:8088:439c with SMTP id
 5b1f17b1804b1-47d84b3fa84mr168029735e9.35.1768235864860; Mon, 12 Jan 2026
 08:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
 <20260112122236.22214-1-fushuai.wang@linux.dev> <20260112132238.GDaWT1ntPxY8VD1hlH@fat_crate.local>
 <aWUWBfKhP8DvzhDl@google.com> <20260112112842.5d5171c3@gandalf.local.home>
In-Reply-To: <20260112112842.5d5171c3@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Jan 2026 17:37:30 +0100
X-Gm-Features: AZwV_QgZp613Wa3TWm-ZwxrtghdiPsL6LgXYqRgaKdYQOWbZNHKidFRs7i4NiKo
Message-ID: <CAH5fLggMj6iC_Ky4ki5j_sZZBLmLkwvgZqiN3evFZhkFxf8hRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>, Fushuai Wang <fushuai.wang@linux.dev>, akpm@linux-foundation.org, 
	brauner@kernel.org, cyphar@cyphar.com, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, luto@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, tglx@kernel.org, vmalik@redhat.com, 
	wangfushuai@baidu.com, x86@kernel.org, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 12 Jan 2026 15:40:53 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > I'm getting the impression that strncpy_from_user() is the real problem
> > here. It should append a nul byte.
> >
> > That would also be a lot less error-prone than the suggested new API.
> > Requiring a length of N+1 is not the most immediately-obvious API.
>
> Should we make a strscpy_from_user() API that acts the same as strscpy()
> but from user space?

Sounds quite reasonable to me.

Alice
