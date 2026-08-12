Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34090430CDC;
	Wed, 12 Aug 2026 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577962; cv=none; b=Jik4/7Hr3tcLr2wBOT2Wgf6s1iB9gHA0/pahXn3rrFcyLXCpI7MiTKhPw0bVfCV2Wempez4/ROhfbEZ6kUNHucJfMANeuJWTWvIemRZjuNA/4RbBgMBmv9dFUPlYxY2JsEoLd6j1T4BUycDWj6ydGgDAly7i6Imejz44FkmsOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577962; c=relaxed/simple;
	bh=avumzkLO0nZN8ddbyezPBTLrfLpNZIAA3NDzvznBZfo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iel0YwnVITBd/FKFNX/i4Y3qqO4URysPXHngrp/3zZ5pfsPNC6T4gi5N3AxOACKX20aQO5AWrt13CjWOEgpe6h4aH3A6BWA5b5ucb2LyiUKfJEwoOim502LTDjoX6lsS6RA4UNrJHH9aOdFklZckV5bCbJryVxW/MPnDyEtv0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epuncTyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epuncTyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD481F000E9;
	Wed, 12 Aug 2026 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786577960;
	bh=cz8Ol6N3ilwM/2lcPOc6cNlIh/iPQ/8t/venZSH7Hkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=epuncTyqw24GATpotoftUkAgEYCEglVa6REXGfQ3NnheBG/nD0pvbHtp3S2EY+5yV
	 qOpehvLKUaOtqzVsrl5WFWkba46NJMheIoZUBbX/yCv86kh1xZbvoffg+qy12xqbp6
	 l9EcAMOz5UsYlDKQ+WOTF6EobX1JMy6mTH1EEEBR9tix8cS/DZ6YqVjl+0J786UMf9
	 6+i0Lg3jnoyjLbX0GXf4DwqztKj8XcRcird8KPMDu3b4JAyqTKLgqWPIPItM0/SmyS
	 AA/zwSIlsdvRmK4dQtwMYekUw/AlnmIzKZgOOCOa8rNsgyBPcCJzAbxb/GtHvqEMJs
	 4GjA8HVxBe5gg==
Date: Thu, 13 Aug 2026 08:39:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, "Vincent Donnefort" <vdonnefort@google.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resizing
 a subbuf
Message-Id: <20260813083916.7113e424e6cc4158ff72fcac@kernel.org>
In-Reply-To: <20260812154659.3E3081F00A3F@smtp.kernel.org>
References: <20260812153311.2328812-1-vdonnefort@google.com>
	<20260812153311.2328812-3-vdonnefort@google.com>
	<20260812154659.3E3081F00A3F@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 15:46:58 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> This is also a pre-existing issue, but does adding this unconditional
> arch_spin_lock() widen an NMI deadlock window?
> 
> If an NMI (such as a watchdog or an Oops triggering ftrace_dump_on_oops)
> fires on the same CPU while this lock is held, the NMI handler may attempt
> to read the ring buffer.
> 
> The read path via __rb_get_reader_page() unconditionally acquires the same
> cpu_buffer->lock using arch_spin_lock() without an NMI-safe trylock
> fallback.
> 
> Because the interrupted context holds the lock, will the NMI handler spin
> forever, causing a hard lockup?

Ah, just a comment. The reader side is using rb_reader_lock(), which checks
in_nmi() and use trylock. Since this ring_buffer_subbuf_order_set() is
never be used from NMI, we don't need to care about this.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
