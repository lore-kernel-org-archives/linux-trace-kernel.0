Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD116A94A;
	Tue, 29 Jul 2025 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752401; cv=none; b=tfT9+NwtD92nZz7toEn29lknQ58/qEOYNx1943RYHL3weOxij1V9AW2aIyklkHGBcyy2fQ1Lo8s7Ep1SaAIATwWJNO9qdum/xGs0skAPWBc4lmI0lRfcV6Qrvh2WkaHe/KSdIiIqzambekq42DcD+miMnxPqo5DxOIr0I/Tvqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752401; c=relaxed/simple;
	bh=AlK0rmaizb0Qu3szybRB7RrQ8xRaclMecsdPl07+WSM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nkdbASTleWdLfwQE+GH892cUHqOAn6nRxoQvx6s0mPr2SFuLUolZGBtp6KO0rkEncn2qdeKzmdNTbXoUOqPozREKnZRiwKEtWSYTJnM1nNISWnx1qlfhgcPWar/F8VHTNQAEL+fl91zh2V5UNbtju6GOHmqCk0xSUhQuJUCklaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aijiz0tH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aijiz0tH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC28C4CEE7;
	Tue, 29 Jul 2025 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753752401;
	bh=AlK0rmaizb0Qu3szybRB7RrQ8xRaclMecsdPl07+WSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aijiz0tH51LfkyJZWt6f2kO9J+42hoEan2sbTOooXTkRP56EsMwVmT+pKvvYa9XIs
	 gHg3EwjOHzVvUp9teh8Ap1T1RI22WCiSOarBXrUZeiB3PyD8lYS2prZVLjbcN8+hBc
	 RPmRp5SK7cG5QP87X0tdVtP5X0O6A7rF+Mi7R1sW4PWVPnh3KfgfWWd2TZ5yCQUtd2
	 PhEex/reRr7GMEL1KbCYQWqmJlriiHWGmvJA9uu+HPXaUN0CFmzCIWhP60ft2sQdAd
	 Q9xYWFAmNSJ9x+ouQ0siF0MDhO4ve4yzTN6cDLGkECae0gjJXBXtwYyGVf5jtLDJyN
	 TJ9T3whDK/0tw==
Date: Tue, 29 Jul 2025 10:26:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim
 <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tracing: Add documentation about eprobes
Message-Id: <20250729102636.b7cce553e7cc263722b12365@kernel.org>
In-Reply-To: <20250728171522.7d54e116@batman.local.home>
References: <20250728171522.7d54e116@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 17:15:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Eprobes was added back in 5.15, but was never documented. It became a
> "secret" interface even though it has been a topic of several
> presentations. For some reason, when eprobes was added, documenting it
> never became a priority, until now.
> 

Thanks for the document!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/eprobes.rst | 268 ++++++++++++++++++++++++++++++++
>  Documentation/trace/index.rst   |   1 +
>  2 files changed, 269 insertions(+)
>  create mode 100644 Documentation/trace/eprobes.rst
> 
> diff --git a/Documentation/trace/eprobes.rst b/Documentation/trace/eprobes.rst
> new file mode 100644
> index 000000000000..c7aa7c867e9e
> --- /dev/null
> +++ b/Documentation/trace/eprobes.rst

BTW, can't you rename it as 'eprobetrace.rst' as same as others?
I usually name the doc of "a probe feature which provides only in-kernel
APIs" as '*probe.rst' and the doc of "a probe *event* feature which can
controlled via tracefs interface" as '*probetrace.rst'.

> @@ -0,0 +1,268 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Eprobe - Event probes

What about below title?

 Eprobe - Event-based Probe Tracing

> +=====================
> +
> +:Author: Steven Rostedt <rostedt@goodmis.org>
> +
> +- Written for v6.17
> +
> +Overview
> +========
> +
> +Eprobes are dynamic events that are placed on existing events to eiter
> +dereference a field that is a pointer, or simply to limit what fields get
> +recorded in the trace event.
> +
> +Eprobes depend on kprobe events so to enable this feature, build your kernel
> +with CONFIG_KPROBE_EVENTS=y.

Is this correct? It seems that eprobe event only depends on event trigger
(by implementation. Actually we should fix the kernel/trace/Kconfig.)

https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/tree/kernel/trace/trace_eprobe.c?h=trace-v6.16-rc5#n576


Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
