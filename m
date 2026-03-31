Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1A24A067;
	Tue, 31 Mar 2026 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916953; cv=none; b=ECe6gjdeWhxHiwnDCERk8mYiR2rId7j7k8SKFW3EX76fZJgr5XgbRvIcnRiMMvlIFvx8vczIP1ah3RKqK07dBCLcXzkPU85PYHfhbtWiy/666BWesKZ9Is3jkgCFhCuNeE6eF8hZbq4n2nZBcfEIsNj5X0ru0aVqh3koE/qnppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916953; c=relaxed/simple;
	bh=ThIoBL+FtK2I1zr3RdCUEjl7aiEAYlPso6MdM7tUkyE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f8e9DDq01XQiqE/HiCh0J8NnhTKLZbiCB73q6S4blUtQwhGm9gdmyNEMPxvcBDGknTUDc4cx620YJfPFnb0OWLS7sa4M5mZwBf3/qoeKIpW2VWZJjKBWqIXe04pe8PQcwL1oicV1RslE6wKgEPE826AgJFhFef1a9D1C1F59KTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+iTcwuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+iTcwuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1450C4CEF7;
	Tue, 31 Mar 2026 00:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774916952;
	bh=ThIoBL+FtK2I1zr3RdCUEjl7aiEAYlPso6MdM7tUkyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b+iTcwuDV/Tt4kTXRRyOCxHIkvI4zEl+S30cX7KYDlrJrZ7DH+j2MlPlddvwJkFsG
	 UCVIhcaCz3p9ns2mJmA1Ft+6fjWDFjtRjQfuMIs6dRJ6rqQJncby8eATNZ+sfwhPTZ
	 MvthKeBm60wEknuokPE03OFJWj4Elne/diVLeQqomCg4ishXBO/laOhhONVwNeEZyy
	 GhdFnd8uNb7tBnshl3GWRW9dAgK4M1dPq6kj2ILg2kZ9mYkECqes10UsmMrLZX9b3H
	 C1IJ6iZ5Cur8fXSOQATrg+Kcrqj9gMjb3pzAlmdp69T2nmupemizxxJlhfydCxRxln
	 Gnqj9mMVr2Y9w==
Date: Tue, 31 Mar 2026 09:29:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 1/5] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-Id: <20260331092910.0ddb1d190e41cea00f6cb1ee@kernel.org>
In-Reply-To: <20260330135447.423bc070@gandalf.local.home>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487499643.3463592.15413057950716995168.stgit@mhiramat.tok.corp.google.com>
	<20260330135447.423bc070@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 13:54:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 21:49:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
> > new file mode 100644
> > index 000000000000..62316c406888
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/ring_buffer.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _ASM_ARM64_RING_BUFFER_H
> > +#define _ASM_ARM64_RING_BUFFER_H
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +/* Flush D-cache on persistent ring buffer */
> > +#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
> > +
> > +#endif /* _ASM_ARM64_RING_BUFFER_H */
> 
> You probably need to get an ack from the arm64 folks.

OK, I will add them in loop.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
