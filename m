Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A6487BE;
	Thu,  6 Jun 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700958; cv=none; b=kwnBgJQpv3j7XiHc6B7sX55V4lNsV48n6jMQE0TpgTUDT5w8J9+1lizst5Pj7eMGUIl7u2AdxtEjT8h4WpCn7hMmRa8Iqn4uJ57hF0JmkO8swwqpBSvGzhRLIKIDvoxXm40bU7VZ3MNsaXpipXhZ/apB+e3A668ZEibz1ukdHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700958; c=relaxed/simple;
	bh=cwKtlfrp18sije7X+ZFRSL0ktHjGOAoWT9mG1MN19/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfepMxsHQs7rDeAUMq/samX23IrrhQbFB5wfXg6esrjDMqrl7791D47f4B+PG3uCX5/V6bq7SFmPp0HcW7DAZUpG6sezFwVFzKNwX0RYz64McmcLImyGHhr8zTlVJv6yHhVJns3DJqyTndiaRf6P5EEfLNq5sivLvUU/xkbdy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiZOw4sL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiZOw4sL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c1b542ae9eso1017830a91.1;
        Thu, 06 Jun 2024 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717700953; x=1718305753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwKtlfrp18sije7X+ZFRSL0ktHjGOAoWT9mG1MN19/Y=;
        b=IiZOw4sL2OOL8wQsjPPptSW3Ac+OZlVxery5Hx9P7IwkL2qoVyA2HMyVpLcp3y/XmX
         MasukB3B5VXgHk7PWwQpS6xP5sE7ltV+TSPBiCzXfK18DD6RmjbL/KZqnHEPhIpOl2Qv
         eio7d0YczLRxEhfszOUbxLMjeyP0r21YOCL6BC+/rI7YAvmL9H61WjgxxmUu/LFqcIDn
         58duMt285c/O7/lK+o0USYhC0H7BY2wWaFz4CnTgpBHpHktGniUr5jgxsBxRLHbjWOB4
         0GZfr/TJMDfplGU7VW2klU0wrmo3nc8BQ9SQQs48CVGrV27DdCKUN6b09Jn0wTYl8hcH
         s2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717700953; x=1718305753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwKtlfrp18sije7X+ZFRSL0ktHjGOAoWT9mG1MN19/Y=;
        b=CwZenKScLOsPbz8hPS2NcQ/17t7SGo9KqGLcZKe7Rwtmb6fmEzqzFbIiEB6Obvhhvr
         IXHkYqv2mW9OqSCdJqnvKQN/IMxC3GA5D7WN5yZEaZWO9t0PNF5vyIs33XAKjCrBFedD
         U9yiTV5Ae54EokQ2+KJyom23ZDE0fFSeZE1aIoSUhZJncTHUCSK4b47Z7dM0kby49SY1
         yWwGbotDdeI24bO69zij1bhkHEBuPXXNFxBlCj+AqvvQh2kQYik3vrf4y6vy0ADQMUjs
         me4MVaU5q0l5nRkXBbZtSBW7vKQlfFXbkwB+swzidxUfQ9GGgeTDcji7/ONNjt1CCeKz
         S6+w==
X-Forwarded-Encrypted: i=1; AJvYcCUVS2HMPjy/F+N8/Uqy8lqlqJ6OxajIvHmFOR7bmoUMSRh6NO7lbC6K6r6BhXGwgNTyJBnOvnttc4YcM7dFJhNOqIi4aPSmxnauhbTX65Iqx9C0bz6goEDQ4qY33fP+JAQVYIBShTs5E13zU6To1IuyqgZDY43+aQOJB9aZkSYSyhQwHsr9uSCqZIZTlMBIcWQ=
X-Gm-Message-State: AOJu0YyBDKHVC7+7Lf2HGJAP08hwllFktySlQEgUbMJ3IFZ6mf1aKcgl
	Qj0o6cEONtBBhLEHHdeO89oo65k4+J/+jiBDKbHfkCvpCghuI8sSLs3m+CoRl1Ih6vAbL9XxNzY
	XQ3fv2Y/1YF2eFtbq19UvugX+XJw=
X-Google-Smtp-Source: AGHT+IGZ3AsLS5Y+gx/Wv2hDNck0vASDyAJWhxk1DmvjhMzbpVyk348zqEdRS69H7h5r+jC6fOEtNlsvJBNNGywvJ8w=
X-Received: by 2002:a17:90a:2ec2:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2c2bcacb8e7mr461250a91.18.1717700952929; Thu, 06 Jun 2024
 12:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-1-6551627bf51b@google.com> <20240606171845.GE8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240606171845.GE8774@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Jun 2024 21:09:00 +0200
Message-ID: <CANiq72m6mc0U-Vctrnyd0WGMx9cZ04tXhJ4_tnPX2ZjX4abMsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add static_call support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 7:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> This is absolutely unreadable gibberish -- how am I supposed to keep
> this in sync with the rest of the static_call infrastructure?

Yeah, they are macros, which look different from "normal" Rust code.

Is there something we could do to help here? I think Alice and others
would be happy to explain how it works and/or help maintain it in the
future if you prefer.

Cheers,
Miguel
