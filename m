Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C641991A9;
	Thu, 27 Jun 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505654; cv=none; b=kj61BPXySl78oWnQJ8RNK1arWiIrVea7/FWAmpNePoYMJeManbcI+twxRNypU5DKWI6/utAMPvX5NJJa0e9LQOW8mIME/TSdRYB8Ea9Uu5t04zf6f/RXGfzrK+9gzBvoJ93uZfEcjAwhOyadlAYQl87Xk0B2TcH3XuEu7IWJRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505654; c=relaxed/simple;
	bh=t/mlo7YOmJpKfpzQN0RD7EEKMLvicfCC0Lm2qcWAkG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYbcEjRHncsUeYiT+7ioVVgzG2vWAvI/rVfbyJDYI5itGUaMYcmITwxYisumjue1ZT5x/Ri1rZsvGR8JC4T08Bburv3p14rTTliHQdOiNrgSHd4fNTV5hTYY47NLVTTLgU8nbx9MgcWWlWZFdyY2jaxrFR4+Axo236OR61e+9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFmB+51L; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFmB+51L"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-700d1721dd9so1201928a34.0;
        Thu, 27 Jun 2024 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719505651; x=1720110451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=920O8PJb054pqxNaJJIQxYWqrCoZjbSlHkszY3iGPvs=;
        b=LFmB+51LXMqwVAlUe8ynQIceJ9oQDPbqc0+LMI/4bT8k7TIiS92OA8TjbJj0XbHn9s
         KW7xnbJkce/QKHeTvkQqxifWH3N3RKEqnVKr2vheyKqZWl+VUDyr5WyyVtw1MBN7wYyM
         lqvJ6Vgh1rol0KMZ1ktrKRa7Zf8LkUHEutx92PIPy0e1kOgJDiPN6pXNfXMOgSLATuVD
         TE7daAwAcyAbm3dbtwuTPNYmxVKS0PMO+yVawEkdM28EPelvHsi9dwZMokQ2MMXyXYpz
         yMZrXfuYmtjT5cAHk9nX8WdqGXF3FKT+k+X7thwOjeKjq8F/o8AZ9Q5dPYUd74UEgtw3
         iqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505651; x=1720110451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=920O8PJb054pqxNaJJIQxYWqrCoZjbSlHkszY3iGPvs=;
        b=UfoSuvZvqs1bVj2CaW8+kOtiU0qMr1wUaM5DhHxa9UWfyOuS7Wu2lv37Y/KOtgwOq0
         Rv+BAPF7ANZFUYzu19/xWWUCP5h8jtBWbshCzg9+hL19bVctcycqBGRkrTb5966uBlWf
         PosxdCbsW211riJpaKDZJUrEpVgnTsjk/RW6/z4B2qP5f4nl8N/nNmC8BLvKYU8gHWWM
         eDf430IV2p6hmFYUhpIxKze6MXGE48rvX8skqdbX2c6+NNcE0UL9WxZmLJ8D5RICj5CH
         BsuFun5VGfKmmDzKQR8RnR6jOmkMTdbpF4HGIfUctxcvaJuXSwadatb7Cb2V7fVqrMNI
         Hdkw==
X-Forwarded-Encrypted: i=1; AJvYcCXomcxdUttCWCLHHPqktdo8zrh5nStcteBqhRMDYP++2XevoTbSLKxvHMT2l5tT7SyW7gSrLo8cPjz7qcbew2TWGNGrynoCqD04XcTcyeQ+weRNSd83cpE9IYOEQMzxuLLueVUUw5SniPD3PNhaoBwJYtY=
X-Gm-Message-State: AOJu0Yz/QYTChBbXfR0ng1IKooEABgydg+LNhiKRPUo8CX5KBdKywn7c
	JNyIViwN5ALJ7xKD9Mr+JUDmZ79trn8CbxcIGbq6T1o8uyM6PNaLHnMWQw==
X-Google-Smtp-Source: AGHT+IGtxkj9q+MuV9hPKLDs1WYWjSnutMr24viHqxFRA0ixkobVLmpIKr3zHIzusqBFjnzSHILUPA==
X-Received: by 2002:a9d:7442:0:b0:6f9:61a1:aa73 with SMTP id 46e09a7af769-700b11e972fmr15703870a34.9.1719505651156;
        Thu, 27 Jun 2024 09:27:31 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8ade9csm68978785a.88.2024.06.27.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:27:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E6C3E1200068;
	Thu, 27 Jun 2024 12:27:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 27 Jun 2024 12:27:29 -0400
X-ME-Sender: <xms:8ZJ9ZkwJQn3hGVjppSrTV0IZyrxtIWOEEpPcVprEZGpYEKndneZdBA>
    <xme:8ZJ9ZoRZfmuNC_KNH9Mloe836UALKfMuxCj6toj6ZkgMcIokFm-s7skTzdbFK2hxF
    a1FfTrhbD-VSodd5A>
X-ME-Received: <xmr:8ZJ9ZmUNST7F9h19vO8rHuGtFfi1CieIGpKmgCo01SoAAvDNjb7l9XcSn7VDoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8ZJ9ZijeIlsxoOLKTT3HOtZOSh6yMswoZGAqWT-utfHKi1PTqMGvfg>
    <xmx:8ZJ9ZmBLlNoz_h24bDEAp5hVZIrDBw_SkEIY90BRdzCghwCBifhRrA>
    <xmx:8ZJ9ZjL0QopEp0Spd6lmQAPYta6FnBpwFrCXWW1ieXd4ByBmUrsDPQ>
    <xmx:8ZJ9ZtB2nPKWDSX_1IdDt2ch85T0JBrm7Lj26_uwmF-czPtXpHktkQ>
    <xmx:8ZJ9ZmxDzs_ruGAMdNA72uLCPg_m3GLOZAcirp7AKUUUeM4G9aA8ZuMo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 12:27:29 -0400 (EDT)
Date: Thu, 27 Jun 2024 09:26:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Jason Baron <jbaron@akamai.com>,
 Ard Biesheuvel <ardb@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
	Sean Christopherson <seanjc@google.com>,	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>,	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,	Ryan Roberts <ryan.roberts@arm.com>,
 Fuad Tabba <tabba@google.com>,	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/2] rust: add static_key_false
Message-ID: <Zn2SxvgfbWbmVnYY@boqun-archlinux>
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-1-9e44eeea2b85@google.com>
 <ZnrtuaUByT70tJY5@boqun-archlinux>
 <CAH5fLgjCAbz39-8EzBxxrWFXFg6VK=ts98BBvpEk8=RZoMuBSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjCAbz39-8EzBxxrWFXFg6VK=ts98BBvpEk8=RZoMuBSA@mail.gmail.com>

On Thu, Jun 27, 2024 at 10:34:39AM +0200, Alice Ryhl wrote:
> On Tue, Jun 25, 2024 at 6:18 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi Alice,
> >
> > On Fri, Jun 21, 2024 at 10:35:26AM +0000, Alice Ryhl wrote:
> > > Add just enough support for static key so that we can use it from
> > > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > > deprecated, so we add the same functionality to Rust.
> > >
> > > It is not possible to use the existing C implementation of
> > > arch_static_branch because it passes the argument `key` to inline
> > > assembly as an 'i' parameter, so any attempt to add a C helper for this
> > > function will fail to compile because the value of `key` must be known
> > > at compile-time.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > [Add linux-arch, and related arch maintainers Cced]
> >
> > Since inline asms are touched here, please consider copying linux-arch
> > and arch maintainers next time ;-)
> 
> Will do.
> 
> > For x86_64 and arm64 bits:
> >
> > Acked-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > One thing though, we should split the arch-specific impls into different
> > files, for example: rust/kernel/arch/arm64.rs or rust/arch/arm64.rs.
> > That'll be easier for arch maintainers to watch the Rust changes related
> > to a particular architecture.
> 
> Is that how you would prefer to name these files? You don't want
> static_key somewhere in the filename?
> 

I could have been more explicit. My preference is (for example ARM64)

*	we have a rust/kernel/arch.rs, where we do:

		#[cfg(CONFIG_ARM64)]
		mod arm64::*;

		#[cfg(CONFIG_ARM64)]
		pub use arm64::*;

*	we have a rust/kernel/arch/arm64.rs:

		pub(crate) mod jump_label;

*	we have a rust/kernel/arch/arm64/jump_label.rs, where we put
	ARM64 arch_static_branch() there. (or static_key.rs and
	arch_static_key_false()).

Then linux-arch can watch:

	rust/kernel/arch.rs
	rust/kernel/arch/

And ARM64 maintainers can watch:

	rust/kernel/arch/arm64.rs
	rust/kernel/arch/arm64

This is similar to how <asm/*.h> are organized today.

Does this make sense?

Regards,
Boqun

> > Another thought is that, could you implement an arch_static_branch!()
> > (instead of _static_key_false!()) and use it for static_key_false!()
> > similar to what we have in C? The benefit is that at least for myself
> > it'll be easier to compare the implementation between C and Rust.
> 
> I can try to include that.
> 
> Alice
