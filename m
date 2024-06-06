Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469438DE4;
	Thu,  6 Jun 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700451; cv=none; b=Kzoo/NRJblJY0FLH7MOJ8TLZ8Sa58iVvhQFqygUw7w/sDtk36XnLSXfZw4INTgv7dOEpP8iTE+ysevnhcA5cMKBfpz4FDeJFwBtiE+s0X/sIEx9Hax1zxHd7JVwBwpM1Nz3WUGX/Pp/C4vyf9c0PZd23sk+DH0ykIr1vN8tcqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700451; c=relaxed/simple;
	bh=M8H0xy1DWWc/H9ZG2Ee51cJpwzjTKk41amkrJ5t6vg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpKpK6MeJWqnZvK0aXTkolN3mrECpZOOBaIWLDaiL+NSe0Ca0LDGMBjBz54vu/8+mL9GQKwAuhQ8rOJ6HM2kQMxXTtXpGaJHb210tF8L29nhfiSydfU1Xz+fwNgxC4+XofDOOOuCpISj83/eZsuYIYpYZ/6fomcJeggoV8IEkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB5TPFkr; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB5TPFkr"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ad8243dba8so6196406d6.3;
        Thu, 06 Jun 2024 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717700449; x=1718305249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSI3NIhPWMG6BD/WGBLSN52oRpjiTs5BIySoaDVF5A=;
        b=bB5TPFkrkjTe107LdClyhXoqBkLJTDKaByk9m6EmL0Q4RgtuAuCu0/Ci3Fswg5h+yq
         nOAx2c5DORwnV1fdWINBdzGEoBg0e/DIqf8bz74fuNbZrj9mASTGr6fztrIx1qkQw+HC
         J/WnYj2twOCnA2p+NZ6oRe4zZFX+8kTxrmDk4ehSO5RoVKTX5xZ59vYgsr8vfz5afko7
         xMONggt+cK9z2Q4GbYbBUnRvhi4Ro8C0YEapI4wZqy5UacQM1+cStjVw8ORbiDn8y3/X
         Cxjl6uWtFMnkA5A+JqoiFbn1Qia+tfy2TwtvORHkY/9NG4J5AIHYHv3jzLyXDx/46Jg/
         ikIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717700449; x=1718305249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJSI3NIhPWMG6BD/WGBLSN52oRpjiTs5BIySoaDVF5A=;
        b=xKI2SUuV32RFhdWmlLB9mANwLbt68/6tZUzn67KKo75HCfsc2y2OGEwZTU5AwFlzbd
         ZfMEhlAKNIqK5U83R/v4I7emOsjLRdgMqqzjY7Bxvx1F58cFzEUpf3JkUqpfBF/AWsg0
         9fGlOFN6YowJaKKVEXfgDg2XsEhuZKT7dNP0swdDaE8wc7hHh2zRIm0ig/LoYveUjrsw
         jUBjIA1R30jE7Fj8v0LJGUK9dFdFEMvYYRhy/DnLRyeONs1aP9z+jPqu5KHWuF4ZJIkj
         v4IgoMBL0kDA+Fa/tK5cofYbB0MQMXu/Yy27WyZ52/EAkhGoqirbJPN3Q8PBevInOJdB
         Ftng==
X-Forwarded-Encrypted: i=1; AJvYcCVWwR29kBIgKdcD8HQcOJObtN73bAthR0EV1nB40FPLm/Ex2UiL9jKbh7mB4VmqQH5hJPYTD8uwZVXDMWxudkpAfE9SL2Kss0tuBJwh3vkjlkgLf2aSFPQXDr7XzhE9d2gQN97rozvivI+XU1boApS7yaM2sj7fsAWtcsyDsBNkGaKVYNutxE4r/VxxiWoDCtU=
X-Gm-Message-State: AOJu0YxW/ICncIkQFzWYJEQVjzhTKF6B21qgXnSgxsIXFRqCfzqazWip
	MrNSMH5Obh/KmH600A3d96LVMKuQ/LzwB73XMQ5D75g0DNsKkBM+
X-Google-Smtp-Source: AGHT+IFOp9gYgqV4RZHHnvLu8DoLTWoXwWYQmb0M8EL8ZoGT8LWwFmlNERK4ERZIRB3euxXxOc4okg==
X-Received: by 2002:a05:6214:398c:b0:6ae:2f16:561e with SMTP id 6a1803df08f44-6b059f942b4mr3292806d6.59.1717700449225;
        Thu, 06 Jun 2024 12:00:49 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f620e8asm8886706d6.2.2024.06.06.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:00:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 196F01200043;
	Thu,  6 Jun 2024 15:00:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 15:00:47 -0400
X-ME-Sender: <xms:XgdiZjjzp4mBDiFlMp9IbI-xGd0sFLiT3Nql8z3gnQsRgo6S1MERRA>
    <xme:XgdiZgD7nJDKTjFMwZexehjcn4sv66d2xnydx5hOVJA0i-PzfdaFdNmtqRXqPfj5L
    2lYlXH2xui-QSIc5g>
X-ME-Received: <xmr:XgdiZjE3ufdkQXuogjJ7dZL_D_cx1iIotz9jCrsX0HmjKUnMnEQ5srRLszA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeu
    hfdvfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XgdiZgTygYU-bTpl38OO-Lc9Ed4MVX-_HjizOrEDfqkQxN_qq8-H1Q>
    <xmx:XgdiZgxot2emvToLEK0uQn0I4nKNM0StNiz66Pxd3bMp3IRc8fG96Q>
    <xmx:XgdiZm6xiMRtMKdpDm5T-ajGdqte27LYzt25E3QZeYqBxnF7vHjc0w>
    <xmx:XgdiZlzxoeX1vxK6sWxaMxNuWPn3_XswKdi70Ot8ahLcHCJY_qR47A>
    <xmx:XwdiZgg5TZaG81_lRGvcWkneSN2np1aVwny1AuAsSxyX4u8zgtKsnE9A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 15:00:46 -0400 (EDT)
Date: Thu, 6 Jun 2024 12:00:36 -0700
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
Message-ID: <ZmIHVIqEukWWRMgd@boqun-archlinux>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <ZmHacqvRwBj7OvWm@boqun-archlinux>
 <20240606173544.GI8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606173544.GI8774@noisy.programming.kicks-ass.net>

On Thu, Jun 06, 2024 at 07:35:44PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2024 at 08:49:06AM -0700, Boqun Feng wrote:
> 
> > Long-term plan is to 1) compile the C helpers in some IR and 2) inline
> > the helpers with Rust in IR-level, as what Gary has:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/
> 
> Urgh, that still needs us to maintain that silly list of helpers :-/
> 

But it's an improvement from the current stage, right? ;-)

> Can't we pretty please have clang parse the actual header files into IR
> and munge that into rust? So that we don't get to manually duplicate
> everything+dog.

That won't always work, because some of our kernel APIs are defined as
macros, and I don't think it's a trivial job to generate a macro
definition to a function definition so that it can be translated to
something in IR. We will have to do the macro -> function mapping
ourselves somewhere, if we want to inline the API across languages.

Regards,
Boqun
