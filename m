Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4101974E7;
	Thu,  6 Jun 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688959; cv=none; b=dSCxlIkIuSD9j7JZFnc2e7hxbq/VOn+9XBou7QNFqQ8mHWHqe53WIWzx2XvcrXDt3NMCf04hSmAZbCN7lNkPWXaoxwc4hJgDEdGFVF9wvInR15BZKXkYWpYzD+cdx5K0WlKUKI0BU2eFcE5Ac5SQRqRtsfhFDkca64yRMFivPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688959; c=relaxed/simple;
	bh=qKBLsTXNP6vC+txyf96Pbii9gskyvekAxKhkwXaTg08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILXUm2cIdAOApiI2vHKxQseyazoikhe51MkyGKa2ZwCLU8oQuFhGyc/3+HbbpRDm/QL9RIF6TY/1zelyj323Ph4rluAuQHBlXiwqVUNZDCiPgjxFe79w78ZbD7KRU8esvJbhE9W8QLA8+N4hCASYbNxMCxsBVjnBpAc43dsOELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9RA+PO1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9RA+PO1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7952b60b4d7so68013785a.1;
        Thu, 06 Jun 2024 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688956; x=1718293756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzKkLAKlqoZUCODC8uK1zfRTl8mdtLcn1fcJfh9jcFU=;
        b=G9RA+PO11hjIRwK1TfodEhGydCiuJZoi7FcqCN2WeN33nNa3twFUCP1zPAZaPsP73W
         MxcGAqq0k8LCS2DwxX9OcJyT4MuPfjX9nPp7O2vNi2qiJfDjsJ3WA2DNhy424R7V3F6s
         UFTyso0UEkckb3TEZAbFTJd1ZsWpsA4XdsbIgHmYqmR10wFjDNR5TscGD9tXB/eodZ20
         fLCOIV5mrLi5JlR2MAcJokVesF4pQZynCcxicy29TRdy1Zo3n+JCn9zr6BKIDUFczJzL
         q1pY4PK/AGuWeZg7VOtyS1vTULbOxC4VNVoSHr2OYLLsKTWHNwNXkOqZhabNPHKPVwd+
         EsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688956; x=1718293756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzKkLAKlqoZUCODC8uK1zfRTl8mdtLcn1fcJfh9jcFU=;
        b=CUmQcyGGyEss48yltgMNcUKjRGdCH9aez4lMV4qDSqt92+aWpUoPr8SC1oIq9ExYEC
         mSms8E8P+ECFciLq2SRT6qti8xRWtsIwrVgZhOMUiZvn5qnnnrK5baFN7Twd2Nu9MNEv
         0hwW8o2MzylpFlot+bcBk8PiEqNYk8Ix9x1pZCDK0o82csyuZmH1s6tfkOx422/4VPQi
         QPWQgaC7L7JEezzuqVGlsfuP/fW2OfVuPMJv8S6av5XrokQAN22VNH46BhbaLPYe74oQ
         eEoWy2oP+FY7GVa0MpRSVKMqeOzwUh85ECS7cj11RYddTUujYGU1UoTZmVOdM76bC8/z
         I6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUHEhEwV3uW1fL7mqTSDwR//XPVJI6XaFRAIpjNISpTBhgqA5CLTztP0BJUTbwOjTEht7uSa0qS6DXUjPBHYXgasRBRUF0uS8Ej9vtZWOlasbKAB3qtkQm+f4FZ+R1xU1GVL1ud53c0TqIQJ7EuxZZpclOjtJpQYnkSMSF7dNiPQRJD0y9UIOoixIuqvyZhR4=
X-Gm-Message-State: AOJu0YyKjDcRfeMNkROtLiGjqdwpwt4ytE92M2+uYz+cD9StPlNHdAME
	JSZzyFVWoSIYQagBzqegycLKT4ubIPe+/pz2+BFGCQWUUOBeUMUQrBTe6A==
X-Google-Smtp-Source: AGHT+IEFetjUuprranDmw5ZJd0GeJKi72Itx5uTqS/pls2I9jPyyGvrMahCfHgf3e26E4HEjVZYsdw==
X-Received: by 2002:a05:620a:2ea:b0:795:2891:12df with SMTP id af79cd13be357-79528911570mr468163285a.47.1717688956356;
        Thu, 06 Jun 2024 08:49:16 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b7198sm71192185a.90.2024.06.06.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:49:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 537D11200043;
	Thu,  6 Jun 2024 11:49:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 11:49:15 -0400
X-ME-Sender: <xms:e9phZuktlMhXYjnSHguXm6OfJRRfYrfGA4UwMfqlJaBs0xwYBwyCEQ>
    <xme:e9phZl3-GDFB2xgTpu3XI5Jbypqr6rrnDkWJuT3TkXujXXRZHOPrL5MSJj1XcaS_N
    r63Kqt-dGZU6ppmqA>
X-ME-Received: <xmr:e9phZsozSHfFYDA7ykoIoAqeRpAx7QTPohdQVzW4konswY18aZk82i6lyXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetffehgffhieetuefgjeffveektdejgfetueekvdehhedvvdegveekiefh
    heefudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpvg
    hffhhitghiohhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:e9phZin1YNe2_r_ALQcMD-NUy8M1xqu8jyo5GgIL1Wez4MXL8WFJuQ>
    <xmx:e9phZs38mpx3G7AEbhJ0kFcr9otaZW1agHN78O64tz4e0byaS5LRbA>
    <xmx:e9phZpttAEGG_fPgoEGwtNub35n1iU8gm2Kck_OAbP492io2GIJJfw>
    <xmx:e9phZoV-KfexwDEIcrrNJoVWyzmKtRdk2EXpwsuFLNzF-XlSdkfz4g>
    <xmx:e9phZn0po4UT8M4EZKy8Qzev0BJ-BcIh_Q-Nv46mbzFtM_QEOmWSajsM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 11:49:14 -0400 (EDT)
Date: Thu, 6 Jun 2024 08:49:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: add tracepoint support
Message-ID: <ZmHacqvRwBj7OvWm@boqun-archlinux>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>

On Thu, Jun 06, 2024 at 11:30:03AM -0400, Mathieu Desnoyers wrote:
> On 2024-06-06 11:05, Alice Ryhl wrote:
> > Make it possible to have Rust code call into tracepoints defined by C
> > code. It is still required that the tracepoint is declared in a C
> > header, and that this header is included in the input to bindgen.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> [...]
> 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 2c37a0f5d7a8..0560cc2a512a 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -165,6 +165,30 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> >   }
> >   EXPORT_SYMBOL_GPL(rust_helper_krealloc);
> > +void rust_helper_preempt_enable_notrace(void)
> > +{
> > +	preempt_enable_notrace();
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_preempt_enable_notrace);
> > +
> > +void rust_helper_preempt_disable_notrace(void)
> > +{
> > +	preempt_disable_notrace();
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_preempt_disable_notrace);
> > +
> > +bool rust_helper_current_cpu_online(void)
> > +{
> > +	return cpu_online(raw_smp_processor_id());
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_current_cpu_online);
> > +
> > +void *rust_helper___rcu_dereference_raw(void **p)
> > +{
> > +	return rcu_dereference_raw(p);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper___rcu_dereference_raw);
> 
> Ouch. Doing a function call for each of those small operations will
> have a rather large performance impact when tracing is active. If it is

Long-term plan is to 1) compile the C helpers in some IR and 2) inline
the helpers with Rust in IR-level, as what Gary has:

	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/

and I use it for the upcoming atomic API support:

	https://github.com/fbq/linux/tree/dev/rust/atomic-rfc

and it works very well.
	
Regards,
Boqun

> not possible to inline those in Rust, then implementing __DO_TRACE in
> a C function would at least allow Rust to only do a single call to C
> rather than go back and forth between Rust and C.
> 
> What prevents inlining those helpers in Rust ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
