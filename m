Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEE15A5;
	Sun,  2 Jun 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295423; cv=none; b=p4Lxre+1WenRhq5oJcFxptdRZIfR8jnEaS8SBrGdKkMyibfCKqAMJEL/dpM9ZH1IQJRRmQSZ3PZvfd9c2WgYgNkzktU1Dv7wxsfyQN3E+DM8b0wd6jK2CNvDplZLHo6pNyDBnMXhkWETd/6X/S8B9XyhL9CkDP2chb5CC25g9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295423; c=relaxed/simple;
	bh=Q8AdSr1763igBtiPbv1oDsgkW6kA1BrMNzTsklnYWUI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aRyHNrO9To+yUfAkAPSzhIhASkgPulBff9b+/i4+LKhF7MJsVOrMtfTMJcA0sAmq2q4xIDFyniZhPENEZqpckS3jmjjWylR7nJYIzO4iV8k9lkrx6uTPyprT/MpBwYqUr1Ij0isf6sTyiOJVlDby4NTLY3F1p2ABos0Movy/i6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwbaPxo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwbaPxo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0E3C116B1;
	Sun,  2 Jun 2024 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717295422;
	bh=Q8AdSr1763igBtiPbv1oDsgkW6kA1BrMNzTsklnYWUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GwbaPxo7rP3jOFHeu0n9LEAascOGpMyZ23uKGhMfYsvSf5ZM8QMwgQerJCnIueyCL
	 EJBO8oTq2mWsB1ocYr69oY1/cUJ8QXgQZBewaBmEVrPmfzNig656RPjdqnt/IB5B2R
	 hnmULCZTne9KSUaZ7tltST9tPSU+QkHnm2YVMOGbUKQ1sp4wYadHHh/5wrs3Oh/xhc
	 vO736mtGi6GK2XkHRoYxMdQdGa/T3StL98HTlLrT+4c7FSUZenoqK9WD3gPNgjsgS0
	 tlm9XMdR038ymLyWd5ce9+NITd88OK08SanBPxYUIYJISZziI3kavw63vsogYlr6q8
	 1uXtZsVoquy0w==
Date: Sun, 2 Jun 2024 11:30:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] samples: kprobes: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <20240602113018.4771521d3651150422919cef@kernel.org>
In-Reply-To: <20240601-md-samples-kprobes-v1-1-b6a772353893@quicinc.com>
References: <20240601-md-samples-kprobes-v1-1-b6a772353893@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 18:31:55 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kprobe_example.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kretprobe_example.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 

OK, these are also good to me too.

Thanks,

> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  samples/kprobes/kprobe_example.c    | 1 +
>  samples/kprobes/kretprobe_example.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index ef44c614c6d9..53ec6c8b8c40 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -125,4 +125,5 @@ static void __exit kprobe_exit(void)
>  
>  module_init(kprobe_init)
>  module_exit(kprobe_exit)
> +MODULE_DESCRIPTION("sample kernel module showing the use of kprobes");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> index ed79fd3d48fb..65d6dcafd742 100644
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -104,4 +104,5 @@ static void __exit kretprobe_exit(void)
>  
>  module_init(kretprobe_init)
>  module_exit(kretprobe_exit)
> +MODULE_DESCRIPTION("sample kernel module showing the use of return probes");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240601-md-samples-kprobes-efb32cbcc8dd
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
