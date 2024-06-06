Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3319883B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690817; cv=none; b=f2nKmpCKz51Dsco4vJ8V5Lk+xXys1hqprtP2jfvPBzOYlym0LMdRV6cM4CoVBiMETGwP60AQIkCBbQ1HHchz+soPWFIK5NX7bvwN7iMkX8/SjNM13L6SDbbL3xrkqJQYU/pc8UfDCAqoJ977+2Jh8ofNSbIbAbml1zHGcQqLmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690817; c=relaxed/simple;
	bh=ZYlURcFwlZWBoEmpmanElgYTGN9iA9ugx4UNBBgiXQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCYL+O35MHS1Hor5O/bf69IwKQhDPaZ234cWsn9LqAZIXbjXcjuBReJBRH1VTFHG5WYOhPX83u3Jpw3O/n7f4LwsgH8dzQOVZtnVkN1dWKbukxyRImOhLjc/kUDPdbGI/eVJvZVnwS2l92dqwd755QaHPSarpFMKvzk6Qtdxeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4HHOO24; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4HHOO24"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4214f52b810so14837275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717690813; x=1718295613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHzv0DB4S/dTAB7HwRBXbDFCtMUP+G2lJ1nMvlhvWYI=;
        b=m4HHOO24WhnzFTRpaDqyWn2JH/MKXmtJzLhtfLOz5tuEWqBSqu+5BxWBMbXDSyVEWs
         jZCDF7KNlFEIBwk9+0Xyut9OxYET41GCrACJbKnKTdDd1j56FsVar/uf2KCpnmCacZ6E
         /Jn7+neSrBDC4V/aq0bvJTfRz9Y0AA2DUuA4/wkfYdph5OgF+pwoh8EFBe1f1BzbcKZ2
         0oVdZfLgIvsYhj5NwtvhvjHI9o1uD/y1zhmMrH3Wsi6zOw7wo4k8h9Y5CNzBdMYnGimA
         c/hncn1CxGdqw9isz6buZQRtSss/m9FUzPYqVFoCLlCyHo3ykF8z8EPe+Gtu5rdSfuct
         qOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690813; x=1718295613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHzv0DB4S/dTAB7HwRBXbDFCtMUP+G2lJ1nMvlhvWYI=;
        b=QQMdVxQ0QdhEafZ+84X6A4D6MLWxiD/axkbkq+nHSeVqG8F+MiN7dSHIPI0QxTtoq7
         4F2PoXBDqIK/Yc93tRDypOk1EjzxK6AXeJ9xJcknqn4s8dREWG+ishs+t8ru/MG0pScv
         920o6csL3blbdDfT7rVfJoAE1U6Jmbab7dNKEvoqx2ekEH+BocIXPqDn99zKSkSBf+U4
         LfNebNR2WNhgGhWrSARbrcb30qNh6hpQIlPHzsrNBKm5TkQaurcAknimbpUXaLR7ueEn
         j4O5jAysFTjWqq1kMUBVjote3aII6ocM7dRhOeC/bK2UtqCqmlvERbGC4P+ZZwRn4HNK
         seQg==
X-Forwarded-Encrypted: i=1; AJvYcCX1AZ5QBrNyX6Qflo0i4fgcqfl6E3wqVVfYNGyCY8Y9HY8rsioAdfyCImYZ/cK7AuMkttY/4gWlr1wipvVpPyyUwiGVxq2Zxn85hwQsOo4HSu+P
X-Gm-Message-State: AOJu0Yw5GerX9U55YFT1wQicykB0xpkggRNSR0RANvVVDxfbDxDcidcT
	bZ4jgCJc9NtTucSbkdFNvhYbpAANxSmRtv+R6f4phD1VI/P5p5PhzIjXoIPvCv+2zabDNsFHLOh
	8U1+sX/JI6Ds1MCK48gBLhirZXQ0sQwrQ1rHV
X-Google-Smtp-Source: AGHT+IGWP0vnCQqDGg/myqbgXbXR/k3R++lTytKvP7EEBChR4VJMug4g9KshqYD+ZH+KxIWwywvgASnBhXBQQ7JpBXo=
X-Received: by 2002:adf:e888:0:b0:35e:5df9:b91e with SMTP id
 ffacd0b85a97d-35efed5fff6mr100326f8f.41.1717690813150; Thu, 06 Jun 2024
 09:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-2-6551627bf51b@google.com> <ef201f6d-48f1-485a-b446-42822b765c1d@efficios.com>
In-Reply-To: <ef201f6d-48f1-485a-b446-42822b765c1d@efficios.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 6 Jun 2024 18:19:51 +0200
Message-ID: <CAH5fLgj7SF87tiifH1ktU_E-pBaTGRBcYxghswLfPkohF0DOOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: add static_key_false
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:37=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-06-06 11:05, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >   rust/kernel/lib.rs        |  1 +
> >   rust/kernel/static_key.rs | 87 ++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   scripts/Makefile.build    |  2 +-
> >   3 files changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index d534b1178955..22e1fedd0774 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -39,6 +39,7 @@
> >   pub mod print;
> >   mod static_assert;
> >   pub mod static_call;
> > +pub mod static_key;
> >   #[doc(hidden)]
> >   pub mod std_vendor;
> >   pub mod str;
> > diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
> > new file mode 100644
> > index 000000000000..6c3dbe14c98a
> > --- /dev/null
> > +++ b/rust/kernel/static_key.rs
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> This static key code is something that can be generally useful
> both in kernel and user-space. Is there anything that would prevent
> licensing this under MIT right away instead so it could eventually be
> re-used more broadly in userspace as well ?

I would not mind.

Alice
