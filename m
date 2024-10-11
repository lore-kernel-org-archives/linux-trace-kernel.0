Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA61C330D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669139; cv=none; b=Iswxs0bhaKfzmVmKpT3GWVvDPGcmDBEUkGHpQymwvk631gjjycxrg46P6hh0zitG2IhywGYn2yEauVX8RNZGoNeaHKFZKbSCJZMcPVJI2YulU4D7Y/qCqVcP/BoFeFS+c+IHuYpoOj/JQG34lIXbxeNSh4kVa6bDawkdpIopUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669139; c=relaxed/simple;
	bh=UbA/iFDHRQ6qK3Ht4X9Feltcke5IsxxCQungku19kWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcjSdVTU/wOlhdFMxnP8FVwtG/K4zHaRP0vZz3lgcgI9zRj5+oV7QshGwCgpwhnHp6zGQkMfmHTsFWA+xpakxZi7KKn672CGAE4LpxiGXP1iMLJ/1g7MYa33LoItBSL0uH2VZ9WvX/NqQYT6R3AJeq0efQXpj2aPO7KeKR4DDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcHkz36s; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcHkz36s"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4603d3e0547so11661cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728669137; x=1729273937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFVu/0Ci5Drk+gHVAbW8VDcAFM6IjgK0BzGcAxp3FVw=;
        b=zcHkz36sijyfW6L3+oqPlDl3WZgl0pIx4cWL3ismpt0KhOIp9FYNmOvDw3QRfdbfhB
         wjJqwIB39R7OKQLgc14nmTS5w9ZaOB0uwXWDP/8oKdDUUom0oB0l6tdT4nW4OEuhIusO
         QiN8UQqlOeEEBa/6+D1OGpci8N6eqEGTt1Htv5b8GymqG23U/ELZ2min8H2RpfLDvXVv
         FtRAy3F7W0IlSAHvoGmubITdjrASOhQnzMmyX22+8HpIsgjbJXkAsWu1wvbKogrHkZcF
         p5+oqa++lDFyPLN8zc0nHTOXYuU7BSz9eKjMmVLZAxzDy1/oHNwtoR/9HuX713KDHujN
         b0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669137; x=1729273937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFVu/0Ci5Drk+gHVAbW8VDcAFM6IjgK0BzGcAxp3FVw=;
        b=DozsHAqXldZ4OCKnN+R+Zzg1YN4Kg4kGLrkiGywW84ssxMozJq1Qy8WY0B26Gv8Aiz
         pSnGkZPMUbrYPHjhEVNOIeq9haiQaLrnywWwKrP0QX94c2I9p+d24TPc/E0UScKgctDA
         8p0gltd5V+T5/DxD4lCeVSk0n1K7x4IpNj8xaWgFG6xOxG5jBR7UGqqchFwpUB5GImHd
         h2t9XaAuiNfmqEGLmBEpAs0iTw/gtdYw0QrZlSboByG7jxcHdT+3Ng4Y1y7bfowagcUy
         Ael476MokcHVcymizTROA7o3Smv7zaNWcJdE6jMLt61wtm6FzfeoGd+4FGXQn4WlZ4mM
         zMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm/R7HhClG6Wmv3NTaMt8odHFn+iud5U9CDCj7uUfJfNfEWDWm0w2nDh30exsnlHwV70uYrwAomA2J+Wphz2KuLKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTH1mt97LSntl6+cyb1BMEOIqeFkkGQ4AUo+z4oBGPk4M9qnl6
	Rgh38uP3YPKxiKe8FUiDtGJNHS8Q1VmCZhClA/s/VP+CIoSOIs7/ZgR/jz0VMmF+mEny9yiVBZQ
	iWNCpCBUw1XG/fLfqHlL5JS5/pDP011zbWSUm
X-Google-Smtp-Source: AGHT+IEEPPLA8HdfmHuDQ6n+ZWN9VIwgJKQNohNKF/6PyZg/dJQ0X34S6H6r+67M6aytOK48Tol7C6iHV8tyTZjxViQ=
X-Received: by 2002:a05:622a:2d11:b0:447:f108:f80e with SMTP id
 d75a77b69052e-46058edff6amr144611cf.16.1728669136519; Fri, 11 Oct 2024
 10:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-1-7fbde4d6b525@google.com> <20241011131316.5d6e5d10@eugeo>
 <CABCJKuesYQWvfScFaqv_rW5ZqAJNn4zK9iOFAmyTaYKO3S5hgw@mail.gmail.com> <20241011171251.0bd53f01@eugeo>
In-Reply-To: <20241011171251.0bd53f01@eugeo>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 11 Oct 2024 10:51:37 -0700
Message-ID: <CABCJKue7qT9drhgrXPEjBO=gPw79vYELAZxz747Z8WMF=vj2MQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: add static_branch_unlikely for static_key_false
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

On Fri, Oct 11, 2024 at 9:12=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 11 Oct 2024 08:23:18 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > On Fri, Oct 11, 2024 at 5:13=E2=80=AFAM Gary Guo <gary@garyguo.net> wro=
te:
> > >
> > > On Fri, 11 Oct 2024 10:13:34 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > +#ifndef CONFIG_JUMP_LABEL
> > > > +int rust_helper_static_key_count(struct static_key *key)
> > > > +{
> > > > +     return static_key_count(key);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
> > >
> > > ^ Explicit export should be removed. This only works because we didn'=
t
> > > remove export.h from all helpers.c yet, but there's a patch to do
> > > that and this will stop working.
> >
> > What's the benefit of removing explicit exports from the Rust helper C
> > code? It requires special casing things like modversions for these
> > files, so I assume there's a reason for this. I asked about it here,
> > but never got a response:
> >
> > https://lore.kernel.org/rust-for-linux/CABCJKudqAEvLcdqTqyfE2+iW+jeqBpn=
TGgYJvrZ0by6hGdfevQ@mail.gmail.com/
> >
> > Sami
>
> Ah, I didn't saw that email, probably because I archived the mails after
> the patch is applied.

Sometimes you might get pings about patches that are already applied too. :=
)

> We're working towards having an option that enables inlining these
> helpers into Rust; when that option is enabled, the helpers must not be
> exported. See
> https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@gary=
guo.net/
> and https://lwn.net/Articles/993163/.

Interesting, thanks for the links. It would have been helpful to
explain the motivation for the change also in the patch that was
applied.

Did you consider using the preprocessor to simply skip exporting the
helpers when cross-language LTO inlining is used? This would allow us
to use the existing C build rules for the code instead of adding a
separate rule to handle Rust-style exports, like I'm doing here:

https://github.com/samitolvanen/linux/commit/545277e4d0432dafc530b1618f0152=
aed82af2f5

> It's also quite tedious for every helper to carry this export.

It's just one line per helper, but sure, I do see your point.

Sami
