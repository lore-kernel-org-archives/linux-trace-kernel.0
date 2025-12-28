Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C533212562;
	Sun, 28 Dec 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766957512; cv=none; b=IZFDA6T78kkyBYTrXT7ON7qD2rM0RFUrSJDo7PYWq4xXyqN4vPBNs2RUVI+VMpvBJS6eQ9TVFBZGVYA7NR40z8XLwvGPy5OfKBbjOGkZo8MMlMW2nIIk4DwZgi1s11+uEcCmPO0C78JsLeD3sDhYQ9rmVG1KvsEa8oB6MHWoLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766957512; c=relaxed/simple;
	bh=RmuKLZ3sZCzDzTXc4AqK859HnGlXw2AUurpubxSNsXU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L43Cy16PGvobP4yi9jsR+JjdN4KttPK1R7djQZkeK5WX6I/bD2EFfXBpV3qFH8Mfw5DNxsX8HuaxB/lImXxGYKHztgvtBPMgUH/siq9PHFUm2Aa/cqfjNateVxmgmtbmO1PrucUdtRl5Bx6hwaOh5t0+kusGOFsnhOY+vdJpr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uJDfCTVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uJDfCTVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDFEC4CEFB;
	Sun, 28 Dec 2025 21:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766957511;
	bh=RmuKLZ3sZCzDzTXc4AqK859HnGlXw2AUurpubxSNsXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJDfCTVftVwMa2XsyOr5TGBpTc8L5ZEB0rtH29CWCovofEiPBEIxYtV/YGToTkYgM
	 /5OY5Kp1PwiaPQ6fHsd0tCWscNsnPAUY/S7G00WsSGg1y37ajSqI/E/v3NneOYHigM
	 teZo8kMbZXPvSc/pRwzu1e9k3k4yJXE1KJAaJb4Q=
Date: Sun, 28 Dec 2025 13:31:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christophe Leroy
 <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, David Laight
 <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti
 <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-Id: <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
In-Reply-To: <20251226115848.298465d4@gandalf.local.home>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
	<20251225170930.1151781-8-yury.norov@gmail.com>
	<20251226115848.298465d4@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Dec 2025 11:58:48 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 25 Dec 2025 12:09:29 -0500
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > The trace_printk.h header is debugging-only by nature, but now it's
> > included by almost every compilation unit via kernel.h.
> > 
> > Removing trace_printk.h saves 1.5-2% of compilation time on my
> > Ubuntu-derived x86_64/localyesconfig.
> > 
> > There's ~30 files in the codebase, requiring trace_printk.h for
> > non-debugging reasons: mostly to disable tracing on panic or under
> > similar conditions. Include the header for those explicitly.
> > 
> > This implicitly decouples linux/kernel.h and linux/instruction_pointer.h
> > as well, because it has been isolated to trace_printk.h early in the
> > series.
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> I'm still against this patch. It means every time someone adds
> trace_printk() they need to add the header for it.
> 
> trace_printk() should be as available to the kernel as printk() is.

um, why?  trace_printk is used 1% as often as is printk.  Seems
reasonable to include a header file to access such a rarely-used(!) and
specialized thing?
