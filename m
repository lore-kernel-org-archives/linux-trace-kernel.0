Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99744502A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591740; cv=none; b=AYO7l7JSe14YBZhbBllW1/k4YYp392QsKzPm3czA2dkqz7mBkhgU9Jns7st7rcoeAReRZd/J2jr5KO7tgo9MwJMVA3SCh92Lfyk8cxjwD7EuSR8YEHNo6SpNjUEYh3ivfxHDcPYu2ax6Pb4WWsg91iiG9D8j0SjLvoZTFHdqqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591740; c=relaxed/simple;
	bh=LfaBtJpSWCF5kA4CdK+iSTrFtU8Ddk4D4KH57CT9f/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJlavlIP9FYsgcwHHnUNjrJVUPlpdVbJM9qaksKq7hJxXUy+juAXpxm5Q42FTLbqeKZdjlNztM2eAvuBb9Xao1w2rfA7uUFnflD4uQ7xFB7yh8aWv78SOrDVNLCsATWtBCSqqykbcAsqa+L0/yNRo3CDg/ELr4DtIkWsMTkMYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sZH+W6n; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sZH+W6n"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso53633305e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769591737; x=1770196537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrjnjrWJRJ/MpDqQmBtQDJOql1m90JNXl6Q6zdTxfG8=;
        b=4sZH+W6nbqOE7yyIEUhfpdr3XmOK06qUCq2A+ULWc0YxqzwlMr1asECRW4RTmhCC4Q
         XuE3AKdIqCNd+rgF3GMvivBQ8O+s3bujYAWdxWPgHGUeoHnxGF3JE/fSb9cQe8zLAwdF
         utTofSqf91WQJSRyb3MSQOcx8s4UN8rUi+3EYe46rVVqIluBvn474vCROpXAzT2dwXV4
         6GqgOx88ssfwpsdBjk58y4YwX1dGj1qDQN6SggkKKoowAMtYqlWVzwV/zbZqMdrvEp2I
         BqNj13GxNXsxYkzNb+u5mz7bNiY26pMYnbSJIHaXXp45Jd4DnoxHcGnT9b9cmST6bE0Y
         ZDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769591737; x=1770196537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrjnjrWJRJ/MpDqQmBtQDJOql1m90JNXl6Q6zdTxfG8=;
        b=Gn+5e5yC40icwYBnmRR6hclQwJX9p6ir1C1mXJOUOTRDn5zbF8jQd3soyaoR8cDyeR
         t+6Z+bpgB0Op5TTOSUIGLNasGBmNAXl/e5g/MCU6S+LM8qmUujG72M+Dfeh8+WTvJDpM
         TH+XHiL0a1+Z251bJ3fpJz5xvoD9nF94Njwc7JiJPJhqjsX3nbi6qcFyKFZS1fbRtZn3
         yMxDgWbKKgfRLL+V/WSNcOBS2R2Bofqm2AYKJPRVVa5GY8gRG1ep2Nv8crHl8pI1WV4t
         u1WeEosznKSQ/C/XZFEa9yfjAeqLvUrdGP8Nup0MTpiWfcuDNwK0oI0tGOXO7jVXh1VE
         tlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1YyPGtcwb9lQg9XZeQufmFaVBfRNoMe2CYVrp79HfwencBEm0dEVcS47TIBI4kEsCSKhj+lR5sAsrrtnCHKCy5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYrgqr7PJr5jjc/N+38YhsVao2ZxMF7ZM6i8nA1uDleyyAdKd
	YQCb0F5FA9sPIHtQPn4G2wKgALfTvnRbzzRXEavgcaGaG3MXZWxR1KYV/f8ochm7Mz0rWGpQV4b
	rvMj7AgCwAyQ3/SVPwQ==
X-Received: from wmby17.prod.google.com ([2002:a05:600c:c051:b0:480:6b43:8a18])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3113:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-48069c3fb40mr58701215e9.6.1769591737025;
 Wed, 28 Jan 2026 01:15:37 -0800 (PST)
Date: Wed, 28 Jan 2026 09:15:36 +0000
In-Reply-To: <aXkEiC1sGOGfDuzI@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
 <20251203-binder-trace1-v1-2-22d3ffddb44e@google.com> <aXkEiC1sGOGfDuzI@google.com>
Message-ID: <aXnTuHQgbEFHIrhw@google.com>
Subject: Re: [PATCH 2/2] rust_binder: add binder_transaction tracepoint
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, rust-for-linux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jan 27, 2026 at 06:31:36PM +0000, Carlos Llamas wrote:
> On Wed, Dec 03, 2025 at 02:48:09PM +0000, Alice Ryhl wrote:
> > This patch adds the binder_transaction tracepoint to Rust Binder. This
> > was chosen as the next tracepoint to add as it is the most complex
> > tracepoint. (And it's also an important tracepoint known to perfetto.)
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> 
> This approach seems to work well considering the limitations. I wonder
> though if it would be more practical to simply pass the individual
> primitive values used by TP_prinkt() from the start? I suppose the
> downside would be the extra overhead with the tracepoints disabled.
> However, this might be neglectable and the solution much simpler?

I decided to go down this road because the same kinds of helpers would
be useful for vendor hooks.

> > +static inline rust_binder_node rust_binder_transaction_target_node(rust_binder_transaction t)
> > +{
> > +	void *p = *(void **) (t + RUST_BINDER_LAYOUT.t.target_node);
> > +
> > +	if (p)
> > +		p = p + RUST_BINDER_LAYOUT.n.arc_offset;
> > +	return NULL;
> 
> It looks like this should have 'return p' right? Sorry for the late
> review this has been picked up so we might need a fixes for this.

Fix sent:
https://lore.kernel.org/r/20260128-binder-fix-target-node-null-v1-1-78d198ef55a5@google.com

No idea how this happened. Thanks.

Alice
