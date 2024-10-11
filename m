Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29519FA9D;
	Fri, 11 Oct 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689438; cv=none; b=elNE5rvvNEzTJWQtbcRB2qP2LdhhuuXkESq4eqlwsFtDilwjUVCOBvJAsnIW2XHAkbpWj6lTAOW9xH4UM7QLeYVk4g+F4CZN/mMC5rDux8CiXFt47RghandNBd9eu2JVvUvwfTvpz5fKrX0MqCbrLUgrBgSeN6CT0BTMItWS6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689438; c=relaxed/simple;
	bh=ywC9U5usRMP6Bmn4nQvhyDISop98R8kxxHCvohK3BjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9P9wAyPSjfOaO6bLtIEiEw7LoZA3vRNoHjNvdcZ6hzngvvS+Ndr4znawfbB6QeyObELl3jYfU07qJE6XTSav713o+UGpTOPZBm4I8TTRNVNWLVDQo+B4cs6KSZaKCpRopWmM8qgfPBcMOeWv8dI/vkmnelBqtucSlBIqg2674c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3BCC4CEC3;
	Fri, 11 Oct 2024 23:30:36 +0000 (UTC)
Date: Fri, 11 Oct 2024 19:30:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees
 Cook <kees@kernel.org>
Subject: Re: [PATCH] tracing: replace multiple deprecated strncpy with
 strscpy
Message-ID: <20241011193047.0b788145@gandalf.local.home>
In-Reply-To: <CAFhGd8pGaMxXpsk5gMS98223FW5wq-vQPyt1srVCrP_Fg6Ex9g@mail.gmail.com>
References: <20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com>
	<20241008211257.6c9c9f88@rorschach.local.home>
	<CAFhGd8pGaMxXpsk5gMS98223FW5wq-vQPyt1srVCrP_Fg6Ex9g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 14:59:16 -0700
Justin Stitt <justinstitt@google.com> wrote:

> So, assuming I haven't lost your faith, I can send a v2 along the lines of:

Not yet ;-)

> 
> 1)
>   strscpy(num_buf, str + s, len + 1);
> 
>   ... or
> 2)
>   memcpy(num_buf, str + s, len);
>   num_buf[len] = 0;
> 
> And if you're wondering about option 3: "Don't change anything because
> the code works". I'd reiterate that I think it's important to replace
> bad ambiguous APIs. There are many cases where folks use strncpy() as
> a glorified memcpy because they want the padding behavior, or they use
> it on non-null terminated destinations or tons of other "misuses".
> Ambiguous code like that poses a real danger to the maintainability of
> the codebase and opens threat vectors.

I use it as a string memcpy, where it doesn't copy more than source. But I
don't care about the padding. So option 2 is fine with me.

-- Steve

