Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1C246BCA;
	Tue, 10 Jun 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561840; cv=none; b=lHnk4GQzu8klqOCGbPZVxjaq4AmAwCYpcAiWU+7345GjgQe1rkPTldBuXujnBhWQTSd+QzuIqd/1PL+g19rua/S+hJbhs0BsPLlboMCQyVuJ9ryYY/SMSCvOOP4wsnbfsDBtupssxTb7smFuIpWd8xKSW7xBKySpnrRSV4Ajlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561840; c=relaxed/simple;
	bh=CaeYB2UPGRAWt9bGhDjrcL/C2j2B+8ir2cAE9BvW2Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6XuWGqknmNUIdhcsRkpXYdh8RzYVNABDMPgyaVMx1lek2/LfGr5M7NgCfoGNyfI2X1cGL0dCEOv9ZTSRctAKuT41l87zkgEk4rF+Znx4sA8v9S4t2l1MJuwxvESXQAlGrOXuDLo59awOpBlNP3h51OYK2pYdyz2JtkyTaJibGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3AB67C03AC;
	Tue, 10 Jun 2025 13:23:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 40FEF1C;
	Tue, 10 Jun 2025 13:23:53 +0000 (UTC)
Date: Tue, 10 Jun 2025 09:25:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250610092523.7be86d1d@gandalf.local.home>
In-Reply-To: <20250610174136.b88bd16959a4d7eff27cc3fa@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<20250610174136.b88bd16959a4d7eff27cc3fa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 40FEF1C
X-Stat-Signature: yy3yp473z18cpryn9xiadcf6fj58akb9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+X+C9JHk029v5O3Xw4RrIrgjwHbZbuJEU=
X-HE-Tag: 1749561833-452745
X-HE-Meta: U2FsdGVkX1+39sM9EJN/3QIu2ylaLJsYJH2Wvg0/zUF39/f8LuhQx5F49m+JXkzDhELqzPXQ5BVcI6dDtJGLNQqClc/KsAKTCCgvjFiPrRUq53K5iS5p20eQYKO8dnNtjnMiqxothTanZ0j7l/K2vhw2y8UBhmH25lQ7ywmTeRAjv4QG2M2+PacRf3T8bc5Ms8pUrN627kXGGEdpQQK087WXRVHVSW+SNDHcdc+3xRVt50K52M2SVmlPu7BUVvQ89vo9IvI8+wTPzGlsS56N9WDXwzBRI9Yx9ZDaGGNGX2jeQTauus8iUmfQZR9G3ZTIhqWrN1SyiGZu5gR4NAJG6qWYN7zachpW

On Tue, 10 Jun 2025 17:41:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> SERIALIZE instruction may flash pipeline, thus the processor needs
> to reload the instruction. But it is not ensured to reload it from
> memory because SERIALIZE does not invalidate the cache.

=46rom my understanding, an IPI on a CPU is equivalent to a smp_mb() on that
CPU. There shouldn't be any need for flushing the cache.

>=20
> If that hypotheses is correct, we need to invalidate the cache
> (flush TLB) in the third step, before the do_sync_core().

I'm not sure how the TLB would be affected.

-- Steve

>=20
> Or, if it is unsure, we can just evacuate the kernel from die("int3")
> by retrying the new instruction, when the INT3 is disappeared.

