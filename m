Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7181EB5B;
	Mon, 24 Mar 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826754; cv=none; b=euX65KX0ojx2+WyPnQuZm+7badytukQLHbrbDIn8LC3J4EeqXWU18BseB8cq9/R8wSyFWP8gsladNSoUO1THqk0eZAVS761qldU+//kX+S0eZObkDkIj+QdaLHS5Oce68cgbkqz239ytEvpUmbxh1BrorYVijl7N2OpZBDNYsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826754; c=relaxed/simple;
	bh=DRSt5j+F27HQd1X54zZJkgOXg8YawHNNEGWO0XKoaJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arzZy8iv/0MHPbfRABaJYxXoCknXmNQBaOAB+9TPOKySdKya2AbcY+nFhxJhrTZGN9wCOlVHx30QLYpi7vT8BMTx5umV5YC7tCwk12pd9hjudYmVr15Nf7Mw44cCZjLibyS2vr5szcLVOZn922LxdGFGBFcaCRS2J59pswl/1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F147AC4CEDD;
	Mon, 24 Mar 2025 14:32:31 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:33:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: next-20250319: arm shmobile_defconfig trace.c undefined type
 'struct module'
Message-ID: <20250324103313.2bc42730@gandalf.local.home>
In-Reply-To: <CA+G9fYu54p6zQpX3Kw4dy+Yy3BM66r_iawvLchPvsB_Sq_wCNQ@mail.gmail.com>
References: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
	<CA+G9fYu54p6zQpX3Kw4dy+Yy3BM66r_iawvLchPvsB_Sq_wCNQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 19:42:42 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> On Wed, 19 Mar 2025 at 17:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13
> >
> > First seen on the next-20250312
> >  Good: next-20250311
> >  Bad:  next-20250312 .. next-20250319
> >
> > Regressions found on arm:
> >  - gcc-13-shmobile_defconfig
> >  - gcc-8-shmobile_defconfig
> >  - clang-20-shmobile_defconfig
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Yes
> >
> > Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>  
> 
> Anders bisected this build regression to the following commit,
> 
> # first bad commit:
>    [dca91c1c54686914dec4dabea8bae4f365c02007]
>    tracing: Have persistent trace instances save module addresses
> 
> Lore link,
>  - https://lore.kernel.org/all/CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com/

The fix should have been pushed to linux-next already.

Could you test the latest linux-next?

-- Steve
