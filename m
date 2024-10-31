Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47A1A255A;
	Thu, 31 Oct 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387635; cv=none; b=VHGXcfqTu02tSQmzgs5TzD9cQn51tGG2k+AMH80M2gsW4t46lh4J+ZQlnvWHmsrudwrxzymCpCu7AEkaulsAl/oTeAccmpmbZF34QkyyctyERQDz++7bDC98Ggn4eEKnBXlF6BOUmfh052tiodo6tjr1QXSwGDgWsG3WfUo67xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387635; c=relaxed/simple;
	bh=e0FDu4Y/8lp/oWKK7nJK2wIx82ihYbOXtJFCGfy7B8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R601bRK09iw84jPUPaW+AoTCva8MLA65aeoJ8OuKKCJ+vcmA1x9GPqnF3AYV7spyH2hgf+0yPrsPzERxXti5vgUjwITuIYOR14YVWhC6XAjFx+qllVZLjqUkJy2zia+bYbcYEg9f/AoJncaphDshye+aPq4PFwEQJQtSa2AGCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FTAMcCF7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FTAMcCF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730387622;
	bh=e0FDu4Y/8lp/oWKK7nJK2wIx82ihYbOXtJFCGfy7B8M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FTAMcCF7fZw9Q7lsj8e9USFwapKJyOtSgaSg4m+HSN54jfPYrzzddFRLVqfyQRLxD
	 vLfIGco5bqELXbSb3ylxin6dZ+2Hak1b5AVcF5XJPrKiGrnOivofYS2MDqq3azYrPQ
	 xnAE8m1qwGOzvO1EK8WxqzaKL8xRllTlrW56UggO5UnKWVYun+iHwuzLQlDj4Oqp6H
	 VwqQBlKGAraGXWEzNaktyy7ertNxOeQGSh9d7thVnUoP2bVCaCNRj2XwR5PjQirdiS
	 HezT1V9iJzEdVNpQSyZ0v5Vx0ebblXEVeVCnCBBf8CKb+cNL1b/tfl8/RuPss8p+NK
	 IHw0xBCY10/kw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSF25RZyzZ3T;
	Thu, 31 Oct 2024 11:13:42 -0400 (EDT)
Message-ID: <af478335-d0ad-40d8-a827-eeb06c1f4e70@efficios.com>
Date: Thu, 31 Oct 2024 11:12:06 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Replace strncpy() with strscpy() when copying
 comm
To: Jinjie Ruan <ruanjinjie@huawei.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241031120139.1343025-1-ruanjinjie@huawei.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241031120139.1343025-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-31 08:01, Jinjie Ruan wrote:
> Replace the depreciated[1] strncpy() calls with strscpy()
> when copying comm.
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Fix the trace_events_hist.c build problem.
> ---
>   kernel/trace/trace.c              | 2 +-
>   kernel/trace/trace_events_hist.c  | 4 ++--
>   kernel/trace/trace_sched_switch.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a8f52b6527ca..cb2c66554212 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1934,7 +1934,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>   	max_data->critical_start = data->critical_start;
>   	max_data->critical_end = data->critical_end;
>   
> -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
> +	strscpy(max_data->comm, tsk->comm);

make allyesconfig + make please ?

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

