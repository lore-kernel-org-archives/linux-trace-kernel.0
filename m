Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781118FC85;
	Wed, 26 Jun 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427398; cv=none; b=F5f6maByOAseQDUvHS28WPy7vBsU0qCC0AKozG6Rf38MLNhARzArY5c34qgZBxO294Q3KMqtGr6VraozIea0UoTUGtjKnk1wfj+3iK7SWk2NRiXLauAreK+xD4Ir7tuog6B+6/o8JjqRM/PSNR+HSXbv6lLTKLOVFnxc4c5NnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427398; c=relaxed/simple;
	bh=le/+nw/Qzup/+krmq6I3s9Mx1o6B4hej1yo/g5Nb2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/52ROgF55y9F0X3BDFEomc1eqawSs6VTA+VcNKxcracZeMNxIB0+kGEHiezJfW1uPsQcz/AA5Bk+VTw91LlttkW0KDWrsBIlHiRJotXXK2deybKJXpWPTs/uXCbvQ3VP9PLVQGRGzfvOe3eRF71p6v9I/WoEmLupYsX+h9s8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F6C116B1;
	Wed, 26 Jun 2024 18:43:15 +0000 (UTC)
Date: Wed, 26 Jun 2024 14:43:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, linux-trace-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
Message-ID: <20240626144313.3f1e8277@rorschach.local.home>
In-Reply-To: <CAH5fLgiG5hdh1JJgjH94E=ZwJo6ERkuZUFDpkrrJ6ErQhTvCrg@mail.gmail.com>
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
	<20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
	<CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
	<ZnsIJ6ejNX_dAc8f@boqun-archlinux>
	<CAH5fLgiG5hdh1JJgjH94E=ZwJo6ERkuZUFDpkrrJ6ErQhTvCrg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 10:48:23 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> >
> > Because your hooks/rust_binder.h and events/rust_binder.h use the same
> > TRACE_SYSTEM name? Could you try something like:
> >
> >         #define TRACE_SYSTEM rust_binder_hook
> >
> > in your hooks/rust_binder.h?  
> 
> I was able to get it to work by moving the includes into two different
> .c files. I don't think changing TRACE_SYSTEM works because it must
> match the filename.

Try to use:

 #define TRACE_SYSTEM_VAR rust_binder_hook_other_name

in one. Then that is used as the variable for that file.

-- Steve
