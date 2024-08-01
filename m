Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AF14389C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536818; cv=none; b=mI7XhbtkbYNNHlcQEYcH7HPxFvLjcCT2dpU4XSGok4sCTUJOp1gtXVPqTfH+jdAJARIM5jRxPMB8Bv7pt9ivk+QCVN9KLaLmD7Z2yLxmwYk5eUrMhTQK3qTr9QhH+l4Cw+4NNvwJbcq7mowup0EBkYzNurGnoCM/oTlMzGWjaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536818; c=relaxed/simple;
	bh=lHbIHLFhtQNciusEsnruiPFrsux+ubJl8cotIGgu9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWZDC/xz06v+fz3koh4M7B+iYhM0EGYoMEo6yU8krv5rNS43TZ2AUfRQ26EBLwxxxnOfzxoOAyktU6tMqwWcEmcGdil1qoMgT7knTddcigHzO/grF6y/1lOu32OHR7GaopUm57OiXR5jPk+S1IdXaZYqgEe8msY3ZOQlZCEbLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM8HMEdn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM8HMEdn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684407b2deso3681208f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722536815; x=1723141615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GkfD0g8hTHOTE05py9mAwmf1QYzZu9yR2OS6+zzI80=;
        b=rM8HMEdn29YaHok0uYeb+av22l4a6P6iEOCn7o/LV9v4EdyOHlzN6IHGcd7CIJUX4E
         JZP78BzADOkLTOY7VGY9mzcY9lR6uv++P+4QzVCV1NtxeUxIG0XyNC1oggfy9WKHqHnr
         5j0ukVCpF+G0UVmRGOy318RMhnFbdGmIxT5aTPYg2vB+iIs5zRGWaOqVXQWWidujkT9n
         p+UnahzdH7A75jfvm/FO4wxFf1spK+L7Jy9iIzi8iDGP6RIGgAXcfKIwYo4nSJLI811z
         NJKXXEYTd53a8/xk+mV8Z6VM27AKDtUwwSE+V3jLZat1FcZ7Akz3iFDWExUDsyrIdUxd
         MWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536815; x=1723141615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GkfD0g8hTHOTE05py9mAwmf1QYzZu9yR2OS6+zzI80=;
        b=LGD4++0UZiE4gHs80E2Adc0nvewQkhE1ho7+YuIp1PZYJtHtY/yh2qVehz8wDahkzn
         WMj4G1RzofTIyvJyOOTbWL5CWXaWnF4mJaD5O4gCY3GQylGFJ08TK/chBP6Pf+rh7Kx1
         o5CggqnppFeH0jRNIvuApp9NDHLX3s6A90kCIqRCmUKNAdvauy4a+NKQQ7hgQ1Rbnb3x
         itg1UD+yvfuG1lTOOR9BTF0dwnwkgZt9zSg08QRRM/ityZUR7JnbrUtTKgaIW1CxB++g
         sb3RSU61JtB7CMr9eOC1MWu04ED4hk06XssPrS3yUWj+YxL0m/eeCXbMHDogVWxr2V6S
         A8mw==
X-Forwarded-Encrypted: i=1; AJvYcCW+T3GppwJeppGVerM2gDJgdd7eRSAwYwWOI3T4bMnQ013/35AIkPkp3l2KK0i4yiFpBWfIvRK82JTQmuwLPOfSpb7pAR6L1zJTQv8Da5UgSAGl
X-Gm-Message-State: AOJu0YzYQolkEV5sNfeREzOh75oXV8lODCupCwpZHF3dEw8A0D/NzB1j
	qalTbYOhD6N5FzMgB1wMOKU8foq6+toIXuKhypgXoj4O3dghsG3kJBaX4/TTBnEoGaV0bzehpqs
	QxYwonVxkTXqPfVOeeE1BzgXtWujvInlN3/0L
X-Google-Smtp-Source: AGHT+IGwaGkw42I/amAH0IQd6LdSV/vkI/phXZAUV/1lm1vKxK6jNhFtpwWWcpoa+ZqQDQpJUtDs/GFofzfYgLUeu2Q=
X-Received: by 2002:adf:a356:0:b0:368:3895:67d6 with SMTP id
 ffacd0b85a97d-36bbc0cbe69mr533475f8f.20.1722536814320; Thu, 01 Aug 2024
 11:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-1-353d523a9c15@google.com> <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
 <CAH5fLghYodekhH-1A0BWZVwgbqkWbP3WP70-us2FtHqvOqD_Hw@mail.gmail.com> <20240801102804.GQ33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801102804.GQ33588@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 20:26:42 +0200
Message-ID: <CAH5fLgiOe1ECCwE1cwczsT13iPyymdUTbV-9ZHeDrp_OGq5FgQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
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

On Thu, Aug 1, 2024 at 12:28=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 11:34:13PM +0200, Alice Ryhl wrote:
>
> > > Please work harder to not have to duplicate stuff like this.
> >
> > I really didn't want to duplicate it, but it's very hard to find a
> > performant alternative. Is there any way we could accept duplication
> > only in the cases where an 'i' parameter is used? I don't have the
> > choice of using a Rust helper for 'i' parameters.
> >
> > Perhaps one option could be to put the Rust code inside jump_label.h
> > and have the header file evaluate to either C or Rust depending on the
> > value of some #ifdefs?
> >
> > #ifndef RUST_ASM
> > /* existing C code goes here */
> > #endif
> > #ifdef RUST_ASM
> > // rust code goes here
> > #endif
> >
> > That way the duplication is all in a single file. It would also avoid
> > the need for duplicating the nop5 string, as the Rust case is still
> > going through the C preprocessor and can use the existing #define.
>
> I suppose that is slightly better, but ideally you generate the whole of
> the Rust thing from the C version. After all, Clang can already parse
> this.
>
> That said, with the below patch, I think you should be able to reuse the
> JUMP_TABLE_ENTRY macro like:
>
>         JUMP_TABLE_ENTRY({0}, {1}, {2} + {3})

Yeah, I think this can work. I will submit a follow-up patch that
removes the duplication soon.

Alice
