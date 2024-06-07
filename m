Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC41862B7;
	Fri,  7 Jun 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757568; cv=none; b=SvIOtYnMl1Qj6S+iqv3ySb1ku0N6nTpqzN8ghHYaknUrQd3+Pcr/R3XUv2q5i0dPuPjd+qk3Y3GwzgSdWMS6LLbE7gZ2IXQZzfghLYicuAqHzRLW7ZiiA6ovOSHO7e2fY80Dmr6iEaIbgAmplYZVhnhkpNzIBDKhDzurJUkCRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757568; c=relaxed/simple;
	bh=3SY741i1aIiLsGZWztwjlZpBTWd8uktQ6DwDmA39LP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHOTcUur9KlqJQPTnOfN+74eR+eVSfjqvfGx6Q9iwnonFND3iXec1MCQiLnrBIoIhAdwKUaPsULkmXG6UXMzM4tH+uDUx+i8oPOj9fbqw2F9729+XxdYJGbRWRSeaUDdaO/rcYYdEhbmYbvKO+8A8qPZn85sX8Dw12z0zsKJ6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zk8JR6ka; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zk8JR6ka"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=juY0wWEQb5LaFKacVEjtLjtoEwuz5HfLcwyYZHOCQWo=; b=Zk8JR6kakPe/gsurlaGxk40xu0
	mkoAdiKJY9k7PVZIAOGadi7BlR8R0zYEcA9+/4pVqJEwkQbJMTKmwP0aWbDqBJrGYVz4BSRWSr5Do
	6OOCTKY5AaVy0AnKtxVulTb5sI3lx8PC0gfQXIONNmopaSsrPt9rs762eRIwMiTYyKL/ZedL5fk03
	o2hLpGSlRRTs6IlzJWQqEIUJIAe0asxns/fuWJZYAYrFSv093wSFk9NXz9r4vsN0cTN64P/KObQNE
	TqMqcducmFtsrch9WxIbBUGy3U/q48AnY3aYdCKhUL/XWtP23N08Y+HQuPHU4kTqFaK3cgg/WnQvu
	woHRPJxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFXCy-00000005mUb-430Q;
	Fri, 07 Jun 2024 10:52:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 947B530047C; Fri,  7 Jun 2024 12:52:32 +0200 (CEST)
Date: Fri, 7 Jun 2024 12:52:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, ardb@kernel.org,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, jbaron@akamai.com,
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org, rostedt@goodmis.org,
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH 1/3] rust: add static_call support
Message-ID: <20240607105232.GP8774@noisy.programming.kicks-ass.net>
References: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
 <20240607094329.3878781-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607094329.3878781-1-aliceryhl@google.com>

On Fri, Jun 07, 2024 at 09:43:29AM +0000, Alice Ryhl wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Jun 06, 2024 at 09:09:00PM +0200, Miguel Ojeda wrote:
> > > On Thu, Jun 6, 2024 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > This is absolutely unreadable gibberish -- how am I supposed to keep
> > > > this in sync with the rest of the static_call infrastructure?
> > > 
> > > Yeah, they are macros, which look different from "normal" Rust code.
> > 
> > Macros like CPP ?
> 
> Yes, this patch series uses declarative macros, which are the closest
> that Rust has to the C preprocessor. They are powerful, but just like
> CPP, they can become pretty complicated and hard to read if you are
> doing something non-trivial.
> 
> The macro_rules! block is how you define a new declarative macro.

I'm sorry, but 30+ years of reading ! as NOT (or factorial) isn't going
to go away. So I'm reading your macros do NOT rule.

> The ($name:ident($($args:expr),* $(,)?)) part defines the arguments to
> the declarative macro. This syntax means:
> 
> 1. The input starts with any identifier, which we call $name.
> 2. Then there must be a ( token.

The above exaple fails, because the next token is :ident, whatever the
heck that might be. Also, extra points for line-noise due to lack of
whitespace.

> So for example, you might invoke the macro like this:
> 
> static_call!(tp_func_my_tracepoint(__data, &mut my_task_struct));

static_call NOT (blah dog blah);

> Inside the macro, you will see things such as:
> $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }
> 
> The Rust syntax for invoking a macro has an exclamation mark after the

Like I said before, the creator of Rust must've been an esoteric
language freak and must've wanted to make this unreadable on purpose :/

Also, why the white space beteen the :: scope operator and the [< thing?
that's just weird. I would then expect the output to be:

  ...::bindings:: __SCK__my_static_key

> name, so you know that $crate::macros::paste is a macro. The `paste`
> macro just emits its input unchanged, except that any identifiers
> between [< and >] are concatenated into a single identifier. So if $name
> is my_static_key, then the above invocation of paste! emits:
> 
> 	$crate::bindings::__SCK__my_static_key;

But it doesn't, so it isn't unmodified, it seems to strip whitespace.

> The $crate::bindings module is where the output of bindgen goes, so this
> should correspond to the C symbol called __SCK__my_static_key.
> 
> > > Is there something we could do to help here? I think Alice and others
> > > would be happy to explain how it works and/or help maintain it in the
> > > future if you prefer.
> > 
> > Write a new language that looks more like C -- pretty please ? :-)
> > 
> > Mostly I would just really like you to just use arm/jump_label.h,
> > they're inline functions and should be doable with IR, no weirdo CPP
> > involved in this case.
> 
> I assume that you're referring to static_key_false here? I don't think
> that function can be exposed using IR because it passes the function
> argument called key as an "i" argument to an inline assembly block. Any
> attempt to compile static_key_false without knowing the value of key at
> compile time will surely fail to compile with the
> 
> 	invalid operand for inline asm constraint 'i'
> 
> error.

You can have clang read the header files and compile them into
Intermediate-Representation, and have it splice the lot into the Rust
crap's IR and voila, compile time.

You just need to extend the rust thing to be able to consume C header
files.

