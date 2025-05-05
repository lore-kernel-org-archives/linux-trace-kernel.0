Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241817B425;
	Mon,  5 May 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461545; cv=none; b=JwM9fbS5EZwVDe5Vk3R+nRLSbSEgcaIqL3QfcqBRDzRKQGyrP49LdDsCkGketZ3aRyY32gsJi5/Yq2r7MkhOQQQ5FdGvEf5Q0I0YouWg4DDl6VS8ckSWnPODHeK98acx8DEosplXorQUdnXnpGpYSgaFu6LfeSYQIj50nthvjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461545; c=relaxed/simple;
	bh=oFaC13gOuDM6KBgAYrQRD/CZapZ/j1SPusKyFwJ/0us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdckcMKM7Hb0ObU0jN138w/i/S7i1W6teXA+yDrXDk62z6KLnsUrB/6UNGQyRsAVQ+5hHd5aZALofrnT3efjLx3cdaw2K/wauc6hmoTF/TH5n5z2g/kT60Wb6N6MLwB7xjf76NWzNIEOEffROZHOjYDRilSZY8YBOB5gF4yO5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CCDC4CEE4;
	Mon,  5 May 2025 16:12:23 +0000 (UTC)
Date: Mon, 5 May 2025 12:12:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, Douglas
 Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] tracing: kdb: Use tracer_tracing_on/off() instead of
 setting per CPU disabled
Message-ID: <20250505121229.644df42b@gandalf.local.home>
In-Reply-To: <20250505114849.1a9237d5@gandalf.local.home>
References: <20250505114849.1a9237d5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 11:48:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The per CPU "disabled" value was the original way to disable tracing when
> the tracing subsystem was first created. Today, the ring buffer
> infrastructure has its own way to disable tracing. In fact, things have
> changed so much since 2008 that many things ignore the disable flag.
> 
> The kdb_ftdump() function iterates over all the current tracing CPUs and
> increments the "disabled" counter before doing the dump, and decrements it
> afterward.
> 
> As the disabled flag can be ignored, doing this today is not reliable.
> Instead, simply call tracer_tracing_off() and then tracer_tracing_on() to
> disable and then enabled the entire ring buffer in one go!
> 
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250502205348.643055437@goodmis.org
> 
> - Remove unused "int cpu;" (kernel test robot)

Ignore this patch, I'll send out a full series of v2 again, but this time
adding a tracer_tracing_disable/enable() functions.

-- Steve
