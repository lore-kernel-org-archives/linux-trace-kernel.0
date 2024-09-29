Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036114F9F5;
	Sun, 29 Sep 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653223; cv=none; b=l63Nc7NfqMN1TziHB9L/6ej+KS0uKVKqhvQGyeZl8tHtYV6bqSIQ+oGWhqQSbXn2XINAnv40KoTuVCteoged5JwT2nzW7C0ntaHvRpuy8sm8xwidQe1yr5K6AjVoUgKrCgWFQrE1p325a/dgQEKmdqT8FXcxDSaJPQ7Ll0yR3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653223; c=relaxed/simple;
	bh=EWdi/ePhiEvIbhcL9U8ESVXQns+INgkuvYaHma20RLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=utEDhY/QEkGhD4vhgFCAH6+PLyt8pikWPMKzaOqdTRw3h+wlweSKdLvQfXr3lSciF0heJvg7WkRIMHA3LSZCtZWfFI9hLvD4jTwlFptqrJUey6/c1EmyiufDJQQlawpr0UgvQzyPvhxdgBgmEj+b2dLU/pkME4+vyleOzDUFU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuhSA0XD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuhSA0XD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0AC4CEC5;
	Sun, 29 Sep 2024 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727653222;
	bh=EWdi/ePhiEvIbhcL9U8ESVXQns+INgkuvYaHma20RLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IuhSA0XDPpPCcIx8brcq5G4U1BOOHnUNahHfBrJTkw7VPyGoSEDlycpi6lYBty6S4
	 2xmKfpLFFsKZ/GJJUD5Rp/j1Guy6J7MoiViQPdyMriHb5W4yg90SBswac2s9yQR4cK
	 CtlRqijj8+V+ggd4prvUpj+xvcFdsYqYgoBpUyAOWflZUyJ1h+JavKsxkHU8kuSIAD
	 bXt0BAXd8cKrsrYPkF1YHmx6udfw16/ZIsyQvACEH9XqMDS1xKcEmPMFrUbU6HJi30
	 KNBfTXDBvj6JnklCIy/O0p2eY+g96hcIgN3n1LVaOWmmyjSrbv2km8pr3Zn1iDrP9U
	 TcGu7PtM1Qjjw==
Date: Mon, 30 Sep 2024 08:40:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mikel Rychliski <mikel@mikelr.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Message-Id: <20240930084018.a725f6e59a3be7be3e356e27@kernel.org>
In-Reply-To: <20240929200939.162524-1-mikel@mikelr.com>
References: <20240929200939.162524-1-mikel@mikelr.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 16:09:37 -0400
Mikel Rychliski <mikel@mikelr.com> wrote:

> When creating a trace_probe we would set nr_args prior to truncating the
> arguments to MAX_TRACE_ARGS. However, we would only initialize arguments
> up to the limit.
> 
> This caused invalid memory access when attempting to set up probes with
> more than 128 fetchargs.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000020
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 1769 Comm: cat Not tainted 6.11.0-rc7+ #8
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
>   RIP: 0010:__set_print_fmt+0x134/0x330
> 
> Resolve the issue by applying the MAX_TRACE_ARGS limit earlier. This
> restores the prior behaviour of silently ignoring excess arguments.

Good catch! But this silently drop the arguments after MAX_TRACE_ARGS.
I rather like to reject such input with an error (-E2BIG) as below.
(Hmm, and I also need a new ftracetest test case for this.)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39877c80d6cb..3f6654127d8c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2194,6 +2194,9 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 	if (!argv)
 		return -ENOMEM;
 
+	if (argc > MAX_TRACE_ARGS + 2)
+		return -E2BIG;
+
 	if (argc)
 		ret = createfn(argc, (const char **)argv);
 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
