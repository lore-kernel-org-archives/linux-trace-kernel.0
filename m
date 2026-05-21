Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACE3C4167;
	Thu, 21 May 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366233; cv=none; b=l1p5o21NuwPhEDA+sQ3U5qOT9vXfa9phNrmz5V/93ljvgV/tJFRg8s+Szqd8ZlljMzNzZrGmYoBN5Y4TJIRTJQ6lGj+SA6VgyR5yYKt8qVCTAXb8AdSzNnYJTBGpXqotO32XxhgF8RTKJnH1vqPn9/MBleaUZWri/pIjWIYtFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366233; c=relaxed/simple;
	bh=I9+Ynw16fIylSO6R/ZNo72hbFe48Rp2TFnl7ERT8hWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVOv4ckxJiQpUmE0cqKNxGzrx8g4G9FCp1+JCyfneS7pvCNJD+32Ab705M/rjDURy0+Q8l/bA5aEw/jdekgjdfXtOACnIjVaAfqt4aLk2kMGpB5dHwoZdgU1AUlPjvm+/ewwzNOm1k0kASTlQQJENzp8pm/uIBS/hW3q+zxjgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LruiWHk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LruiWHk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA451F000E9;
	Thu, 21 May 2026 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779366232;
	bh=kAiGmj8XTBbvBy4vhbzbn5wg1Z+WZxv4kbJ8ByilKoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LruiWHk+2rCX0gwc3OfWpgTZA1617Q2UEw8OWSxB/wiTzHx5ZqMttQGvGsSnLzdOW
	 JaF4muUX9yOOlKc6S9orjrDn7sLWU5yff2GlE1UfaUzKoKf56zaMJT33ozV8FH3lUw
	 ZQWTWLJYx/iDm9MO/+PXUlG3ixNcrjB8zA6XNtoUsmSV+cyAdLxvpEXMAZGl8/2iIE
	 GZVMJhStwfFO17T1VEOs7/W5J9SKQWjklG61Wl5ToOtk6qEo7Kr/Mzp5nG2pEbnJix
	 fZjPw6MA27aItTIezxkFq2vWdEn1wI7516aS3pBbSdJ6kYx2Iswa65TILLdr7XoW5l
	 9jvBdNxjQyiQA==
Date: Thu, 21 May 2026 08:24:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 00/10] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260521082412.548f1ebb@gandalf.local.home>
In-Reply-To: <20260521081740.31194131@gandalf.local.home>
References: <20260520184938.749337513@kernel.org>
	<20260521171353.74e66d117b0809418c8822d4@kernel.org>
	<20260521081740.31194131@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 08:17:40 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Thu, 21 May 2026 17:13:53 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Thanks for updating.
> > 
> > BTW, it seems Sashiko is stopping review this series. 
> > https://sashiko.dev/#/patchset/20260520184938.749337513%40kernel.org
> > 
> > Not sure why.  
> 
> Yeah, I noticed that too. And it never did your v19 either.

Looking now, it did finish v19. It wasn't finished yesterday. Maybe it just
took a lot longer for this series.

-- Steve

