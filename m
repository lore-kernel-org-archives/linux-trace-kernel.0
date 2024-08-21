Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CC1D1311;
	Wed, 21 Aug 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264203; cv=none; b=qPTFD+aHfgkIflcJhNo9l5JeC+Za2EH24WaPllLAtcPAlozoCIwKqn75XO0/FTiS9j0I42SB4QG3fJ25G4TOQFkxoBsphE9S5Fsc/e7XChaNRiZce63+q+TJR/W7M55W7kJ8ykyWhcoPqlL40iPCCrjiKm2fZbFtLL20kdyt6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264203; c=relaxed/simple;
	bh=JnxeSLPQhSwfoYfEPIBCpVy3r4CFvAx9fVu3+4VZyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfk+5SQ4GRgMGdUB0u5+rV93CTJ/hVqlsm5+ajd68cpQW0ejN9M3rlFnOoCjRpT5babxVL0ob2j6CxrQroFpUFu2qV1QKbgXoa6LaGyzY0zkVchAZiBWSUoPr3pAL3TzAzarTgN6HfwJcP7BUMyMCR/TlFLO2R/ysm+jZDlgwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ozmzGD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ozmzGD"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dca990cf58so17343eaf.1;
        Wed, 21 Aug 2024 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724264200; x=1724869000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sG1wp5ENtjpkC5FIqQpPJO0RYHtQ0kKqwcDpDZ1g0uo=;
        b=T9ozmzGDZUCkdn4+5Mdzy3iYDi6RLAgMkJ47l6lJ9NGtlub5iUHSGrH2rhPCS6q+aA
         qCRL5ey9nmHbC9scRFmRO/e2STgLTnJ+WEtVKVBBthyPTkPL+auVgaVUTF1eAHZDh56l
         bvckTApoB8xaqjkfWwSaJ7EpggPqVndF2t7nE73NOhI5nYBLqo60NQVMkG+5ZLu/ySX8
         v/tDUFhWdPbZNaqSvBRH+ELGTDmCXulYjJoMKtP2f85TjcrALV5bw+ayzh8k64LLRFGh
         qXXTQ9EOcLrJWZ9bjLsgLr7BQoet5W3cfu4c0Fvw45mICBJKJiyRg7KHTf60Riw0v3h/
         JeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264200; x=1724869000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG1wp5ENtjpkC5FIqQpPJO0RYHtQ0kKqwcDpDZ1g0uo=;
        b=OMVO+n5k7W16KHIj85w/Ahs55GotbKuIsOOCuEGwqcZ1QYqbl1Tn9bt9YYUZs9bovE
         C27tEb2pOfVg0/MlX3ztTl7qJxz9sxAHduiKl/pqWlC28oaA/ISMSQRidACaAwfZHtwW
         1L1JyciPfdT65Ya5HMGNTa1UpvvnqyZb0e+snlO2+n2ifZVTCltRDsCiXAxFbiopbLUK
         tAXSWHsgrEuuOrN7KGetuRn2TZjXyFstdBu0zX3pXFXRRO5zkMqx1IP1jVkBetNvqTmI
         mMG4TKhPchJb+VI/dyKDYnAsAOuonUeSo76E0yPpoQ2PpuH3dKg5qx3LUeMgLss2l9Aq
         sipw==
X-Forwarded-Encrypted: i=1; AJvYcCUZDSBLp4SQdXvyCGdH086UfBj8vR4gIJc4sW509CIOCSnAz1n0BIlR1PHY6iqwj8vH6g/8y41Wr5O7PYGTve0=@vger.kernel.org, AJvYcCUaXADcfIGo7d3zBI1h7BWbfQJ12Xe64NskpS2bTUdizj7K6JSwC7m0P7Fq45js6ugeH9cO/pwHLKJk8Tqnt8zdDxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfc6UNBScGHXpZicYP1w2oae1DvGXcztvQK+i/cU8kDeCE1HMd
	WVKj/U3Ztmpc4gnVginhjbyxwNAkhX3oLjRZ9I+Q7ZK2i73hXigc28fgT9fZ
X-Google-Smtp-Source: AGHT+IEYC5yLoufqQscWvQWa0icdP3UTpxKK253dNcPoK5mxIqZjjQ9ZLDS9sAJnVYTv2+k7CNDHTA==
X-Received: by 2002:a05:6871:5825:b0:25e:1c9d:f180 with SMTP id 586e51a60fabf-2738bec859fmr3013947fac.50.1724264200319;
        Wed, 21 Aug 2024 11:16:40 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e04f6sm651280485a.82.2024.08.21.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:16:39 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D2D001200068;
	Wed, 21 Aug 2024 14:16:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 14:16:38 -0400
X-ME-Sender: <xms:Bi_GZjkYOU0_uPVPB7K8kPU5t6uwe1a7iRrD-8l2b4FwhEEHvPWNqA>
    <xme:Bi_GZm2ilDewDM48ADFZyAyLkN8ETYp8o2kgHXVk2M3oH1XV2KSY8l8XSHpaXSdPi
    vUWJDJ9vpJCTKTtBQ>
X-ME-Received: <xmr:Bi_GZppuE27zSpGhNm_MKiRYFzIueXaa6Olt3HDwdTYkHLAy97t7mvl_E4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnh
    guohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
    dprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhpohhi
    mhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrg
    hirdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Bi_GZrnffxrLWDEUyOfAuK4X7MxRHl41DuNXEXwU9qN7EOxG4IC8rw>
    <xmx:Bi_GZh08QhTMZZDvPplmdtt8yUAyIg0RVUC7Hs34ECG-0ApoLpa8Lw>
    <xmx:Bi_GZqtC2DOqemnStVjIsc28f6yLb0riAR4qzKHtDsMZ3qIXiCyfOg>
    <xmx:Bi_GZlWWO5FFsKpoIG5v09YA8ZfPbtyqcLKXJfL7WsrB9b0kzX0aXg>
    <xmx:Bi_GZg0tfLSerjrQuTHq9tMZrxOF1nPbYUVoJWR9XLUkCH6bFCPKKA61>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 14:16:38 -0400 (EDT)
Date: Wed, 21 Aug 2024 11:16:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
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
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v7 5/5] rust: add arch_static_branch
Message-ID: <ZsYvAJbGB8qUcjXA@boqun-archlinux>
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
 <20240816-tracepoint-v7-5-d609b916b819@google.com>
 <ZsYfAFrBFVewchGM@boqun-archlinux>
 <CANiq72np8GhZ4V22b7RekvQOhCbM67A-19Px2aVLgweC4Qxebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72np8GhZ4V22b7RekvQOhCbM67A-19Px2aVLgweC4Qxebg@mail.gmail.com>

On Wed, Aug 21, 2024 at 07:54:51PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 21, 2024 at 7:08 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Have you try this with "make O=<dir>"? I hit the following issue, but I
> > am rebasing on rust-dev, so I might miss something:
> >
> >         error: couldn't read ../rust/kernel/arch_static_branch_asm.rs: No such file or directory (os error 2)
> >           --> ../rust/kernel/jump_label.rs:39:17
> >            |
> >         39 | const _: &str = include!("arch_static_branch_asm.rs");
> >            |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >            |
> >            = note: this error originates in the macro `include` (in Nightly builds, run with -Z macro-backtrace for more info)
> >
> >         error: aborting due to 1 previous error
> 
> Yeah, we should use a `*TREE` everywhere. In addition, we should not
> use `SRCTREE` but `OBJTREE`. It is my fault, this comes from my
> prototype I gave Alice.
> 
> Please see the attached diff.
> 

Yes, this fix works, thanks!

Regards,
Boqun

> Cheers,
> Miguel

> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 7757e4f8e85e..ccfd20589c21 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -36,7 +36,7 @@ macro_rules! static_key_false {
> 
>  /// Assert that the assembly block evaluates to a string literal.
>  #[cfg(CONFIG_JUMP_LABEL)]
> -const _: &str = include!("arch_static_branch_asm.rs");
> +const _: &str = include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> 
>  #[macro_export]
>  #[doc(hidden)]
> @@ -45,7 +45,7 @@ macro_rules! static_key_false {
>  macro_rules! arch_static_branch {
>      ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
>          $crate::asm!(
> -            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
>              l_yes = label {
>                  break 'my_label true;
>              },
> @@ -65,7 +65,7 @@ macro_rules! arch_static_branch {
>  macro_rules! arch_static_branch {
>      ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
>          $crate::asm!(
> -            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
>              l_yes = label {
>                  break 'my_label true;
>              },
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4f0f6b13ebd7..746cce80545f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -269,7 +269,7 @@ rust_allowed_features := asm_const,asm_goto,new_uninit
>  # current working directory, which may be not accessible in the out-of-tree
>  # modules case.
>  rust_common_cmd = \
> -	SRCTREE=$(abspath $(srctree)) \
> +	OBJTREE=$(abspath $(objtree)) \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>  	-Zallow-features=$(rust_allowed_features) \
>  	-Zcrate-attr=no_std \

