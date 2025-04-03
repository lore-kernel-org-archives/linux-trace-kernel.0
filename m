Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992A24EF61;
	Thu,  3 Apr 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700483; cv=none; b=bQ9BkdC4V/58+5pn8RpqFir6EHTHX60f8tS1MsFTyT5ujFVNDxG+WcmHJKTXCGtgW8n7FRt/nlYyHIg27xzIk5OfW7OHKQTqzTEk91jMidlujsaQj4xu6SNfK8g8F/kNrvMe7p9LY3gDb3UXUjFthh2l3Sv2YkfDYHGoOc2I2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700483; c=relaxed/simple;
	bh=gqwYvtEyH9bZc8SVi3WGRDr6dqRlGgOB/+RdusFlMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrPKmP5oQ9g0tx9uwhAY9PptzCpec6dtTFSEJ/MTwYPyqQJ2qmByiPFnbUc+kgO5zkbk2fJXOMt7dOjP67d70d80VKXWdKET1dMy44uEEKhFLLXRAjix/P3Cs0S4spXn97LLRzvwFTs5kVMdX19gQVWxaySPLFO/H3WRFE1hzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C357CC4CEE3;
	Thu,  3 Apr 2025 17:14:40 +0000 (UTC)
Date: Thu, 3 Apr 2025 13:15:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Tony
 Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250403131546.74596048@gandalf.local.home>
In-Reply-To: <CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<202504030941.E0AA2E023@keescook>
	<CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 09:51:51 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I *suspect* the history is simply that 'vmap()' predates 'vmap_page_range()'.
> 

Doing some git archeology, it appears vmap_page_range() was added last
year, to replace some ioremap_page_range() use cases, by Alexei.

In 2021, Christoph moved ioremap_page_range() to vmalloc.c replacing
vmap_range().

Also in 2021, Nick changed the ioremap_*range to vmap_*_range(), basically
making this full circle.

The ioremap_page_range() was introduced in 2006.

vmap() looks to have been there before you started git.

The vmap() usage in pstore was introduced in 2012.

-- Steve
