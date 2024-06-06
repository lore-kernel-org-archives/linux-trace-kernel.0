Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1958482F6;
	Thu,  6 Jun 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717866; cv=none; b=UvDFCQt12v17Y8aGU2zVDslc8ouavwBZ1ZzAz7fSzDnNM5JLa9TrJkEnxuDMVrydO4N0cXbgpYIg/izPO/Gykr8g7a4jGD1SKeZsZ72XTyLIrJGIb2d0KfqNgtjjLUA/rQ75gCJfuIVWGsrK21kPKYdqgCnBfncQPpq3Sr/oAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717866; c=relaxed/simple;
	bh=bbVleMmmMakhROC+VISatQueB3wussVSW+M+2HzXVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoWGH3uIp0NMpELibNZtmDdqnuwU+1jxUUW7SCTVnXTm4pFTZ4JCkJmBqcPOhB1L1mlYvW9fNS1JW9uiO+w1LG9ojtRwzc8B7jnAyUQuRGgMegITnz/TYSj+GQfoDmzsMQVPFoqOLHxrKOnPYTwYHZrLHvrcPHt5eixnUADO+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a89D7I0q; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a89D7I0q"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f945b242easo1400413a34.1;
        Thu, 06 Jun 2024 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717717864; x=1718322664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxRFb8jNZD704/30Zm3Ud+U3UJ7d2I13EMGRbHwqT3Y=;
        b=a89D7I0q/3Wuvz2B2r7Kf4wCxTqfa6K2HM4HATO7SPehDGvl8kZfw5uec/TO8821Rb
         t28DrBFqxT4cyl0RhK8RvwGvqH7UpSruJS/ustCjl8gz28fU785dygqEoUBju7V/0J74
         NdinWE0vXdJQHCvthkC2X3KMzVxTIW/cpVHiLnZ6B3KQq8PcrSZiWB4EnXePXASMx3Nz
         rs1OY4EM38mkYCPaY3mNJwwK39buWOzTjqL71LdkCb6AoT+3tV6dWiLZz/7GTduGLjr3
         I1KdbjOW7EOAP4UyXcOjKCPmDfmfI8a/bOBiLXiV9WGxvFFbEGsgHUC5n/C4lP6KsCHb
         bWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717717864; x=1718322664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxRFb8jNZD704/30Zm3Ud+U3UJ7d2I13EMGRbHwqT3Y=;
        b=TdKC0REkJq7uWjLAaa0IMXUEFDfpSLFbPTrbK2heW+iX1VaGLy04y8i1H/bfLudPGm
         uyD7VN99fnUGA6Q3aeQuNOL0NaUydJLz7VXTCjUYQINOI0aV5ZueeEh3iJWfAkp1YJnv
         jE7XI5L4n6aU5FZQ9AqveGsTOkPBCym9cTFECRbjuSbTxKznvzYhCDtatAjeNA6SFPIE
         dBWzo022gOFvrT/NYgqW/pj1TH/9NY2/5EAollawVC2l0aAUq1I62wdKULYmB8hclZSA
         xo2rRFTKDSd46QQ9N5fR46SNt00X0arui0OPzCi6DmdVanYPhYAPN7vSY9vY8nl7MAb4
         u9ww==
X-Forwarded-Encrypted: i=1; AJvYcCXgL5IvMT7sUyOqF87guM/UEczsrl8Wi6L5r4jjjrDSAt7Q4Ywqhs9jHLLTleLt8piC+I2euj+nipasCWV36kXh/JhN2JHmVhmS9GHcIbRa+Tcgt39jRYOuqPbVEFRzuBzAs4I9dd3zIalIXqPwyevXo7Eud867bjltnmIxh+Qxs7a1vxDmMU5F0DDHsIIvCpw=
X-Gm-Message-State: AOJu0YxzztmF5QfrZaPH76Ow+GxqX1TL9jbRryjucrSvQvfBRD9gM9Kk
	L3Le9fGNdsLxUOYigLWEXB7l73BFX369Ifq1U1GYH0zkCd81Whgc
X-Google-Smtp-Source: AGHT+IFuzcYU+uA6LX/vYx9r/+oQDDEQSuMV0Oemf+DdwTHJ9qBvX0k0i7ke0HkdjstOhtn9py4nlg==
X-Received: by 2002:a05:6830:2049:b0:6f9:1b6a:1e66 with SMTP id 46e09a7af769-6f95721b518mr941006a34.16.1717717863703;
        Thu, 06 Jun 2024 16:51:03 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953286feb2sm105196185a.56.2024.06.06.16.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:51:03 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 737B71200043;
	Thu,  6 Jun 2024 19:51:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 19:51:02 -0400
X-ME-Sender: <xms:ZktiZsH4aZsVUspSdFzpOEcEVAij3zCRcE02mGlcHio889FJyI6saw>
    <xme:ZktiZlVsflnRrml9apd5_f8cqMGJhmOkwzUyxTfls6ZKNZ6UbJK6-TU_JC1i7_HLQ
    bkZW5v8FSP-1Iq_pw>
X-ME-Received: <xmr:ZktiZmLW5DvQFZ_F3rNK0V4x7WdPDAROp8OsiQ3eDI--rSkIo8NKDCLZFeIsrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ZktiZuG_RvyCgWk6Ifqoxu7O-LKSWSFZ3onBDVihVDholxptnBNrJQ>
    <xmx:ZktiZiWdMzhoLT4WxVgZRg9JNtBNX2iDJ86jPKCVPrJ591D-QiSNCw>
    <xmx:ZktiZhPDK8IIMAjRzfdT8frumB1S0qInFbIwsxjAsyo9zXQyH5imBg>
    <xmx:ZktiZp2yBsA8CHXedkxGLqyZXy7G7LjLkwt59Cz48JIMng4OBnpdeA>
    <xmx:ZktiZrXnv577hIbiXo2I_-EucD7YefaCI6qrzHwPANqjL4OHZZszvyhA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 19:51:01 -0400 (EDT)
Date: Thu, 6 Jun 2024 16:50:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <ZmJLXDWo3gL8gkID@boqun-archlinux>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <ZmHacqvRwBj7OvWm@boqun-archlinux>
 <20240606173544.GI8774@noisy.programming.kicks-ass.net>
 <ZmIHVIqEukWWRMgd@boqun-archlinux>
 <20240606192951.GJ8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606192951.GJ8774@noisy.programming.kicks-ass.net>

On Thu, Jun 06, 2024 at 09:29:51PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2024 at 12:00:36PM -0700, Boqun Feng wrote:
> > On Thu, Jun 06, 2024 at 07:35:44PM +0200, Peter Zijlstra wrote:
> > > On Thu, Jun 06, 2024 at 08:49:06AM -0700, Boqun Feng wrote:
> > > 
> > > > Long-term plan is to 1) compile the C helpers in some IR and 2) inline
> > > > the helpers with Rust in IR-level, as what Gary has:
> > > > 
> > > > 	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/
> > > 
> > > Urgh, that still needs us to maintain that silly list of helpers :-/
> > > 
> > 
> > But it's an improvement from the current stage, right? ;-)
> 
> Somewhat, but only marginal.
> 
> > > Can't we pretty please have clang parse the actual header files into IR
> > > and munge that into rust? So that we don't get to manually duplicate
> > > everything+dog.
> > 
> > That won't always work, because some of our kernel APIs are defined as
> > macros, and I don't think it's a trivial job to generate a macro
> > definition to a function definition so that it can be translated to
> > something in IR. We will have to do the macro -> function mapping
> > ourselves somewhere, if we want to inline the API across languages.
> 
> We can try and see how far we can get with moving a bunch of stuff into
> inlines. There's quite a bit of simple CPP that could be inlines or
> const objects I suppose.
> 

We can, but I'd first stick with what we have, improve it and make it
stable until we go to the next stage. Plus, there's benefit of keeping
an explicit helper list: it's clear what APIs are called by Rust, and
moreover, it's easier to modify the helpers if you were to change an
API, other than chasing where Rust code calls it. (Don't make me wrong,
I'm happy if you want to do that ;-))

Regards,
Boqun

> Things like the tracepoints are of course glorious CPP abuse and are
> never going to work.
> 
> But perhaps you can have an explicit 'eval-CPP on this here' construct
> or whatnot. If I squit I see this paste! thingy (WTF's up with that !
> operator?) to munge function names in the static_call thing. So
> something like apply CPP from over there on this here can also be done
> :-)
