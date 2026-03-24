Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2473CA4B1;
	Tue, 24 Mar 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396608; cv=none; b=IwN3T105MZyP9Vl/vsceBmUqfT9DqooPOEN8K8lQ9anoLTIukNyM2YE2DtWtvdzGh4dCMgfAo7asn2JLoDVg6knIyTobzJhLMT6aiqdGcBvH3dWMrHi9X1EydAOYchryXbkm4D/8t3q5+VC36L3zCHfrcvFdbNvAxyRfxRuKyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396608; c=relaxed/simple;
	bh=Vs4kKuGXc9xv+xPt22nhesOw6E3PxI7V8Dqx2M7LJG4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hpoI4NcjBd1nFIFROu/4Noc9zu9vavD2GJ0cnI1X2POXaGJbuT22uJmfOS53GZg3m9H+BCD+lbSa323+9dGRAOqc028Cze2QSklj5rCfDzvuJ4zxeJvgyPpXMn4mzNUrChA7WBPgbt8DwM1vHZVzH0F1IG3VToLtzoHN+ElM6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsJIDk6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsJIDk6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F96C19424;
	Tue, 24 Mar 2026 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774396607;
	bh=Vs4kKuGXc9xv+xPt22nhesOw6E3PxI7V8Dqx2M7LJG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsJIDk6K3IZ/ghn37abrfDDaMct3F4BuL694XJR4pP8kLololdIi6SMwghM4kh53R
	 pY/Lrr8VxMKI/NIxz4ZG1FjM/y9OsbVlxBDu0UfnvCRuEE7/oNjZ/cAicF38pSZCoH
	 xn6iL1LGca5Vq9w7krmf73ERdT7o2aMWRbEXxus6iCntmua/KdFghevs2ya2Owm7zo
	 kJPaFx28IJhJLfDmB9WVcGUkVH/rggW4ZU48+ggsBiXM0ch00TriGSXCC3KXpJUOsb
	 jk3CIAoD1q6kZqNEfMGpUzct+fXaQD5kFDlQnqq0ew43MY8NtXpN3ZXFOidd/CWsm4
	 r8U1UJOJ10DLA==
Date: Wed, 25 Mar 2026 08:56:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260325085644.4310a1295b0b962ed87b5b60@kernel.org>
In-Reply-To: <20260324172557.04cfc2a9@gandalf.local.home>
References: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
	<20260324172557.04cfc2a9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 17:25:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Mar 2026 09:00:03 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the 12th version of improvement patches for making persistent
> > ring buffers robust to failures.
> > The previous version is here:
> > 
> > https://lore.kernel.org/all/177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com/
> > 
> > 
> > In this version, I rebased it on tracing/fixes branch (thus
> > the first fix patch has been removed) and fixed
> > a build error which came from a copy-paste mistake.
> > 
> 
> Hi Masami,
> 
> Can you rebase this on the ring-buffer/for-next branch?
> 
> It has the remote updates for pkvm tracing, and there's some conflicts.
> That branch is also used by the ARM tree so it can't be rebased.

OK, let me rebase the series on it.

Thanks!

> 
> Thanks,
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
