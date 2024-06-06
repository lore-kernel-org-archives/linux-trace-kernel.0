Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571E197550
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688831; cv=none; b=g4rPVKIDQbThFBoa1lNp2dlOojzH1AwwRxc+hdvK6SYkmntbdEncJtmqLh5FwmqPgtYXJy3mWQxTPTEZmvWL9zHvdDG49lyk5a568nYE2V9dKn1EhbIt3/nLnAaSsP5yaVUVbC084lZMlTFEofuWXomRXoVOMUA93crroBSz4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688831; c=relaxed/simple;
	bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIZfICA4g4gPcmLxAeIVsYrgsnVWVRamlHSNzUd1loMXM2hR9yjJh5O16g7MfLJQHbw3yRzP+Wb9aNGVwVUwGOKGij0L9MLEA445RPE+6iY0hinkoOUEtyYo+94+FzH67Fhc74/Bzjxg1ad6yDA1bq3screKpZw/cHAUsDQ/WQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZNx6c2/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZNx6c2/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dceef4227so1091656f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717688828; x=1718293628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
        b=OZNx6c2/IKmqQJcxrj0tQNl2zPD5oIkhrhQGFsoBiwvg0uKo0JcRyiJyw+KzMdVdeu
         Td+E+VwRLrrt3V9uWxkPdw1WOkQy1W+hovlj5if+8p7WjWHFkYnBaCrdgqTjO0wC1xU7
         va9+oTOj5z20OS3AtlP3Nqnbxm1BHWI/eYgOaRCEbDtdRUixsdylUnBmGbhpqcSoeuYX
         4/9J7WfunmnqKXh4KUmT5aeghIPTjsFeLAg+x0pp7r+7NqkAfkEgds6it/TZviqje9/1
         1IfaAUuGG0cky3yhJyFPJkC2jUzdBvSxbFHLAzsCP44/0TIQCfmNq5qUpvdLO4np4A7K
         lZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688828; x=1718293628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
        b=lKAKefMxOS7jWC9TblXOCVp9loKSR7/suJAsbA0XEQ+G4QG2sFqsjgROGpGbVKjrcU
         HzO2u6Af8H+CHvuuwQm7lShkkwuUm65KJH8bIxpZXHkRcXBrRhW3t1++3fQZV9939Lsd
         QIHH9El8GlOckRzpZJqeL8bcGi7RherFQRci00JxonrCkkOR7zi9Gs6uuoTdI6iHYuqa
         HNahYreClI+0fE9rYf0VKMUYs1iziFHFWOO1N0OnvQDbIiE/4p4aYzVQ/yxc06f+KvaO
         Gj/Egr8svx1rnzCvv5feHUeoGtSQzGN9JwYrPl1GRMj91kDGzhND0xeW6ThA9QoNvMMu
         3oag==
X-Forwarded-Encrypted: i=1; AJvYcCVAoiGe9IaK2o9gXnh4VD/mYPwkOnKZqN69ylxiJCWCm6oQSHf0irfZn/U7gUKStoHLp5e6acndg8oCBvwAnDXmyFFent5YSEabNhZnGEV1ulss
X-Gm-Message-State: AOJu0Ywys2MSoUAM01Hs4j+pXiFodgQ1vbTDAr6D/xj1vAwQ+S/SiUCU
	13pq3kWj1JuFhG64Rmj2WoL0/75e/v1W4tcmk+JmcY5wdKTGkL4pUjlHDe+8LqMw8eo3UPYZSPm
	uRU1IfSVUOKHyy5dO4hp8H1a9ebIE9VIt0r8u
X-Google-Smtp-Source: AGHT+IHRaKVw7qOuW6NYsVktUE3gSn+rIAOkyJWHl3lX8amN9wd4ANmNf31Gd3QTmhu64UAg4XcBRWc+rft0gePr+8A=
X-Received: by 2002:a5d:6ac6:0:b0:35e:8333:28f4 with SMTP id
 ffacd0b85a97d-35e8ef7f346mr4448223f8f.60.1717688828366; Thu, 06 Jun 2024
 08:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com> <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
In-Reply-To: <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 6 Jun 2024 17:46:55 +0200
Message-ID: <CAH5fLgi4zs5ehDCEgkxPzaamNKn_2cP5+qH8KTy4ujdf2_D-vA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Tracepoints and static branch/call in Rust
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

On Thu, Jun 6, 2024 at 5:25=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-06-06 11:05, Alice Ryhl wrote:
> > This implementation implements support for static keys in Rust so that
> > the actual static branch will end up in the Rust object file. However,
> > it would also be possible to just wrap the trace_##name generated by
> > __DECLARE_TRACE in an extern C function and then call that from Rust.
> > This will simplify the Rust code by removing the need for static
> > branches and calls, but it places the static branch behind an external
> > call, which has performance implications.
>
> The tracepoints try very hard to minimize overhead of dormant tracepoints
> so it is not frowned-upon to have them built into production binaries.
> This is needed to make sure distribution vendors keep those tracepoints
> in the kernel binaries that reach end-users.
>
> Adding a function call before evaluation of the static branch goes agains=
t
> this major goal.
>
> >
> > A possible middle ground would be to place just the __DO_TRACE body in
> > an extern C function and to implement the Rust wrapper by doing the
> > static branch in Rust, and then calling into C the code that contains
> > __DO_TRACE when the tracepoint is active. However, this would need some
> > changes to include/linux/tracepoint.h to generate and export a function
> > containing the body of __DO_TRACE when the tracepoint should be callabl=
e
> > from Rust.
>
> This tradeoff is more acceptable than having a function call before
> evaluation of the static branch, but I wonder what is the upside of
> this tradeoff compared to inlining the whole __DO_TRACE in Rust ?
>
> > So in general, there is a tradeoff between placing parts of the
> > tracepoint (which is perf sensitive) behind an external call, and havin=
g
> > code duplicated in both C and Rust (which must be kept in sync when
> > changes are made). This is an important point that I would like feedbac=
k
> > on from the C maintainers.
>
> I don't see how the duplication happens there: __DO_TRACE is meant to be
> inlined into each C tracepoint caller site, so the code is already meant
> to be duplicated. Having an explicit function wrapping the tracepoint
> for Rust would just create an extra instance of __DO_TRACE if it happens
> to be also inlined into C code.
>
> Or do you meant you would like to prevent having to duplicate the
> implementation of __DO_TRACE in both C and Rust ?
>
> I'm not sure if you mean to prevent source code duplication between
> C and Rust or duplication of binary code (instructions).

It's a question of maintenance burden. If you change how __DO_TRACE is
implemented, then those changes must also be reflected in the Rust
version. There's no issue in the binary code.

Alice
