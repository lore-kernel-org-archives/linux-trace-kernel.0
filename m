Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6341E521;
	Fri,  6 Sep 2024 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593778; cv=none; b=u6plV7YJsfkMi5bYPbCukq00gmfpOBMxckR4Y9bc0clt6xZ3qdasefDR6jY68z/COW9t8I/gAF0odly+mZL7aK2tJTaYcQ771Qil0W19lQsVxNWDsgV9xWUvSniQwVa+gqCnkT1rMfV4kMrNMeJ8z8wr8aRtsAN9qrFJz2E63bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593778; c=relaxed/simple;
	bh=mP2/RwYvxNX+s1YwFpAbCoL5ef1jOp/MUfXtaAj7TTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv+/RE2azllqDugb91bCUspQQLn6zYRf3TFoz1eR/sQ1kDt/ujgITN3uHSD+r8Po4KS18eZEg2JKYsmSCNnUbhTF0sAHJ7uq/3ynP0XvKS12dRQKSFKLn/IJ3JhRI671a182eCYEZKmxM26OUBjVEOLihgzk9VLz7RsR8Q+GohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0MMJ6jlXz4f3kvf;
	Fri,  6 Sep 2024 11:35:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD74C1A08FC;
	Fri,  6 Sep 2024 11:36:12 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8ereNpmqQkaAg--.44260S3;
	Fri, 06 Sep 2024 11:36:12 +0800 (CST)
Message-ID: <69b78634-3295-c22e-c09c-e41aa4554df3@huaweicloud.com>
Date: Fri, 6 Sep 2024 11:36:11 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/7] tracing: add config option for print arguments in
 ftrace
Content-Language: en-US
To: Sven Schnelle <svens@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240904065908.1009086-1-svens@linux.ibm.com>
 <20240904065908.1009086-6-svens@linux.ibm.com>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240904065908.1009086-6-svens@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+8ereNpmqQkaAg--.44260S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw17JF4Utw45XF1rGFy7GFg_yoW8GF1kp3
	s3JF1xCr18JFW5K343GrWrCFy3Jr4kXFy3G34DGw15Z3yIywn29rZFvrsIq3Wqyr97ZrWx
	ZFy09Fyj9w4DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/9/4 14:58, Sven Schnelle wrote:
> Add a config option to disable/enable function argument
> printing support during runtime.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   kernel/trace/Kconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 721c3b221048..8b9b6cdf39ac 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -242,6 +242,18 @@ config FUNCTION_GRAPH_RETVAL
>   	  enable it via the trace option funcgraph-retval.
>   	  See Documentation/trace/ftrace.rst
>   
> +config FUNCTION_TRACE_ARGS
> +	bool "Kernel Function Tracer Arguments"
> +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> +	depends on DEBUG_INFO_BTF && BPF_SYSCALL

Nice feature!

Just a nit, DEBUG_INFO_BTF currently depends on BPF_SYSCALL,
so BPF_SYSCALL may not be necessary here. This feature
also doesn't seem to depend on bpf.

> +	default n
> +	help
> +	  Support recording and printing of function arguments when using
> +	  the function tracer or function graph tracer. This feature is off
> +	  by default, and can be enabled via the trace option func-args (for
> +	  the function tracer) and funcgraph-args (for the function graph
> +	  tracer).
> +
>   config DYNAMIC_FTRACE
>   	bool "enable/disable function tracing dynamically"
>   	depends on FUNCTION_TRACER

-- 
Thanks,
Zheng Yejian

