Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07443B1A4;
	Mon, 19 Aug 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081318; cv=none; b=W4ycbS02WGx+wleDFKfKIOAL4kHSwmLF9be/dhtiBwO6HJ6geur9Dh+uCsfXDa6MPf+tlpUBqSkoT4gKM+dIa+9TsoEDoO+w4aVTY/YwdUMSjHQlqAe/TGaqWfo6xP/+KjT4gCcMNLf91vn1GqkUbY3DdFLZRh6rZNmY4boCWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081318; c=relaxed/simple;
	bh=1Plmwt2lxvwUUalNlLSbcn/LfFjDS60xqI0sC8pyCAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgT0PyxQxG+Oo3Xxegvu46Nzkgvh+cmwuNReLKSrKdy13mtOoOB+JW5PtJ60YAGQ/hyqmu3Ms7frMeu5e8x6HOGTv2jDGehnYJIR1LczuI8gW376KGuFZkRSs2L5Hd/2LLcohGjb5thXDNBjE4/IxI8y+C8oYY1UZqNUFR56sIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17267C32782;
	Mon, 19 Aug 2024 15:28:37 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:29:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240819112902.11451fe8@gandalf.local.home>
In-Reply-To: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 17:11:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> CONFIG_LTO=y
> CONFIG_LTO_CLANG=y

Hi Masami,

Does it still fail if you disable the above?

I wonder if that causes functions to not be part of the available filter
functions that the ftrace filter test is using :-/

We may need to add "noinline" or something to make sure those functions
don't get inlined for LTO.

-- Steve
