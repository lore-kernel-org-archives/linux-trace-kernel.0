Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5932F6925;
	Tue, 13 Jan 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284301; cv=none; b=dxQTxD/x/iBj94eKs7uwy7FEXs4BWodHLpyqcMGF2PH0RcDdvY2Z9FXvi+AGi9OQXwBqWdgSTPanZARkXFLs7pUfBdrcf3F1HdmqO98qz+W1qnh4iux/TzO5TDEyor/42EUeogSb2rkT0nPkU3jUuor7WY8ukVi2znFotHg7Vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284301; c=relaxed/simple;
	bh=So/I7dcnXA8geV0rv4KIVzrTgNQT/4ud956Kf+nGjS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hSDwugoarjVfsg69DI2Asps7t0JqgoeY0EeKycKJdvO3EAeQ0gktMYHj2Mj7a25g5135SMFv1zyu9Bsq9Ny9Jsoy0fDvXGvr8IVE7G0IqhT2x8+5tbl0YM+CsLQCTcgIJJF70iWmDSVsuPKT0g7YErDU5HCjdiBer/sLJajAtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUEuRuKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUEuRuKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8891C116C6;
	Tue, 13 Jan 2026 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284300;
	bh=So/I7dcnXA8geV0rv4KIVzrTgNQT/4ud956Kf+nGjS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUEuRuKNa1TOR8rV+EU6jHiJD+eQdpJoMXcjzlTDesqHaVcjdjF/fotjnLtnKc69N
	 ediP4M3o2fxhRQiRy6vdf0fsnlhOkbaB/eINNvTbfJdpwMPlwu2i8XAalnCcNCvHsB
	 jB4yTm24PDM+N4cvxt2IWdHuIFEc62gHAPksf5xoewNh42fGysoOS2KEMQUJuDOMf1
	 0KKRkKAzBd+JXwfhOBUA22i0n5s85/JpT7BmUYKUExiaGxlWgm6qOHcxBWcvu1yBoZ
	 NO7PNhykMYG/fp4weYVuRQn3FKzrPImJv1I3DMnqstCfSzXi29pmUICsmn3ruMazz1
	 FDxc8nN2VoFmg==
Date: Tue, 13 Jan 2026 15:04:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Make the backup instance readonly
Message-Id: <20260113150458.8633891cf9f377565642124b@kernel.org>
In-Reply-To: <20260112194722.19164ca7@gandalf.local.home>
References: <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
	<176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
	<20260113093100.e91c5be8b8fa5f1e64899ba4@kernel.org>
	<20260112194551.2446d041@gandalf.local.home>
	<20260112194722.19164ca7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 19:47:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 12 Jan 2026 19:45:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Let's not add any flags to the eventfs_entry. That is created for every
> > event, and events are already too big in size. I don't want to increase the
> > size of each event for this feature.
> 
> Actually, there's not many of these. But they are all static variables. How
> are you going to differentiate them?

Since the format/id files are always readonly, so we can put a mode flag on
each entry.

Anyway, I will just share the readonly entries in the same array, but
put them at the beginning of it.

Let me update it to v3.

Thanks, 

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
