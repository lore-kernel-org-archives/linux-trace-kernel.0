Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD03FB30;
	Wed, 11 Sep 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062196; cv=none; b=PXopQqbq74wMBPUozaav93vaN7dQE9QCWg8Mg7RoVMdh1MZMDrh5L1NW0vlTRk0oBmxTrfTjjoFD6GMVV3bTufI19llYr+ioLx1Na8d+9EOpz5bnrjyH/Py1WZVCneimwhD0qxnOXtjoE9zAJsixcuuAtqZtIFqqcbuhZG7zGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062196; c=relaxed/simple;
	bh=rylJM/kWTJuBve67SD64BQ919ZZ7cpXnjlnMpL/fYF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9PxeOY4A+qE82ZJAj2VaYJR4K6HJjFBDk6rkKPxTn3Y/y38UxbbXuFwQTsumNSVZEP286KPQcvlfwHbsdy4RltFZHMz9BFGRP8B6VqjehamGynq6rJkLs26vyFJ4eMz3cen9PQGqPVOpdUzL6Tz78NAEZgfj5dJSHk9pNWMjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3636BC4CEC5;
	Wed, 11 Sep 2024 13:43:15 +0000 (UTC)
Date: Wed, 11 Sep 2024 09:43:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <20240911094317.4a28fc3b@gandalf.local.home>
In-Reply-To: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 14:40:56 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Hi Masami,
> 
> I am a little confused about config UPROBES and UPROBE_EVENTS.
> Uprobes is the user-space counterpart to kprobes, I want to do
> some small changes:
> 
> (1) since config KPROBES can be selectable, just make config UPROBES
>      selectable too.
> 
> (2) since config KPROBE_EVENTS depends on KPROBES rather than select
>      KPROBES, just make config UPROBE_EVENTS depends on UPROBES rather
>      than select UPROBES.
> 
> Could you please let me know are you OK with the following changes?
> If yes, I will send formal patches later.

The difference between uprobes and kprobes is that kprobes can be enabled
inside the kernel outside of kprobe events. Where as, uprobes is only
enabled by uprobe events, so why have the separate option? That is, is
there a reason to enable uprobes without enabling uprobe events?

If you make uprobe events depend on uprobes, that may confuse people about
how to enable uprobe events. Especially since it may break existing configs.

kprobes have been around much longer than kprobe events. That's not the
same with uprobes and uprobe events. They are much more coupled.

-- Steve
