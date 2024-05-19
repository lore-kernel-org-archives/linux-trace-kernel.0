Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A91870;
	Sun, 19 May 2024 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716087268; cv=none; b=LSkPnZAnuPtM5iGM+OS6PhhboYDS9ZIjsFxoqDRAdttH3wOfdnFqdMujYqXUw/R1d9cNWDS2r7aQMvI7KsIrd/On3FlvXdsvCh63IsNxTxR0uGLKa1DSJE2BE2WUI/+4aL/Cvtvg5Nc29VB9vDjvP1RKT3SRF86oau20hxcuFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716087268; c=relaxed/simple;
	bh=WunisLTOGe0gk918aPPfVny/lzuRRrtQfgukDSsiixU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UxePob2YrsqX7DW0PZ2LqRKyTBAoQnlLRGPOddE4lj68uW5DCV+JkhdGhIt5yfu4nx58a5wTXnvSQVLaIY5Uw4/vwyyf80q5pkd1KUpNEeS8MbA4wdrYQ6y/mtksr6UPBW/5oeVj4f8t9M3rsekiFlU4JD1J/ak0euVbg/Vldyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSrsl+dL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSrsl+dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4777C113CC;
	Sun, 19 May 2024 02:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716087267;
	bh=WunisLTOGe0gk918aPPfVny/lzuRRrtQfgukDSsiixU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TSrsl+dLVpbXo7/vEIpXQYd7IQJjMUdjR6IXtvvW7q7JCOlvHvPMB7Xnfom5Dx2tN
	 wLqoCXEY2gCrF4ufVt+RGZGnaZ4n1Dnq2bTBOC3qej/Dme6NMoh4fkSOtJv0nWNFvB
	 UnWH3sAqfl7gBVp8nf6fS2kcgiHWRVJoCe/skARm8upFE6oygrt/Mt4tgyNwxcXr0J
	 HqEtYon9Gatzuob2Np7j7MiNA7WVkSEgfcct5QTYzQr9frjfvNFnrMUm2BQ6JHSYDH
	 rgWvZx7zKYGRYZ2BYtKPyUgH5jiYbTk+ydLmjmpSekSNg+QSk5gWcpGXBZhBmMHgCz
	 GDutcCq1IBmbw==
Date: Sun, 19 May 2024 11:54:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] kernel: trace: preemptirq_delay_test: add
 MODULE_DESCRIPTION()
Message-Id: <20240519115423.f89db5ecf2fb336dc2f4ecb1@kernel.org>
In-Reply-To: <20240518-md-preemptirq_delay_test-v1-1-387d11b30d85@quicinc.com>
References: <20240518-md-preemptirq_delay_test-v1-1-387d11b30d85@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 May 2024 15:54:49 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Fix the 'make W=1' warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/trace/preemptirq_delay_test.o
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fixes: f96e8577da10 ("lib: Add module for testing preemptoff/irqsoff latency tracers")

Thanks,

> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  kernel/trace/preemptirq_delay_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 8c4ffd076162..cb0871fbdb07 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -215,4 +215,5 @@ static void __exit preemptirq_delay_exit(void)
>  
>  module_init(preemptirq_delay_init)
>  module_exit(preemptirq_delay_exit)
> +MODULE_DESCRIPTION("Preempt / IRQ disable delay thread to test latency tracers");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
> change-id: 20240518-md-preemptirq_delay_test-552cd20e7b0b
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
