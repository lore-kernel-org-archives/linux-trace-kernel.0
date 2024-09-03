Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982420E3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401520; cv=none; b=jv7n4Iv+HA2r4vqY7i3Lt9j9z/CEupYGinpsGwVA7itqbzlSxfXfrsKCkOUFZWUIlUc5bXr0htxcIkHp+MD8+AYSv8Blehq802pxMOrVZPm1Cr6OEgpBN/PTuPJPVkrhw+lZo0zv4nmZLxnLvhWhK8mcX5uqjauToI0ocfo96Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401520; c=relaxed/simple;
	bh=Kazl5ijkrMlxfa3K1vrcKe9KDtcFNQuvy1kvlI9BKbM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cCyrmCHHYeSOR22xxKVZOQo0dBC8nZ9uPhv6JC65nCeN3p4f4M/Ve+DLsEOfadAZMgm1eCVLPHQVRGMp8ZPQIyURWU5D5JmvZTZRG9yUQaloOZp/wTRBd709ejJZ2mbQUc3cGqikgFZRgH8TjhgXxwuTH2uhYOxa/K+4Usxf/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMg+Z8Qt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMg+Z8Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE43C4CEC4;
	Tue,  3 Sep 2024 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401519;
	bh=Kazl5ijkrMlxfa3K1vrcKe9KDtcFNQuvy1kvlI9BKbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cMg+Z8QtILmKxyaD7KjCCQrrcovkibvKr7Sa/68bZlIfT5yTZ+ZCmHad9bpT5U8OE
	 eJO1Xut8VP31O3ztNH4uW0+7u9XIJ+JPSp145+uc4Zmnsoh+NpAy4YCWJZUiZp2VVw
	 VopvzmEjcSsrWHq4cxwXJ9DZXz8pnqdlLSM0sDVYI/Frw71KmrmSb4CsfkkgQO8+rk
	 HWbN/ZZkvooqzirpCklEBYfLMeeBq0/V9WO0/9x7kvPEK0QS/lV2MpJYejsEg+3RzD
	 LilZARp/4KvR6xOwmqUBaBr3hPMKeOPf0TBcjwki60VKn4jcoMKi1P1a9mXkP3sr4f
	 ceKU560fqdlWg==
Date: Wed, 4 Sep 2024 07:11:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] kprobes: Remove obsoleted declaration for
 init_test_probes
Message-Id: <20240904071156.d5525a818d9098102801e29d@kernel.org>
In-Reply-To: <20240826032552.4016314-1-cuigaosheng1@huawei.com>
References: <20240826032552.4016314-1-cuigaosheng1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 11:25:52 +0800
Gaosheng Cui <cuigaosheng1@huawei.com> wrote:

> The init_test_probes() have been removed since
> commit e44e81c5b90f ("kprobes: convert tests to kunit"), and now
> it is useless, so remove it.

Looks good to me. Let me pick it.

Thank you

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  include/linux/kprobes.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 5fcbc254d186..8c4f3bb24429 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -269,15 +269,6 @@ extern unsigned long __stop_kprobe_blacklist[];
>  
>  extern struct kretprobe_blackpoint kretprobe_blacklist[];
>  
> -#ifdef CONFIG_KPROBES_SANITY_TEST
> -extern int init_test_probes(void);
> -#else /* !CONFIG_KPROBES_SANITY_TEST */
> -static inline int init_test_probes(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_KPROBES_SANITY_TEST */
> -
>  extern int arch_prepare_kprobe(struct kprobe *p);
>  extern void arch_arm_kprobe(struct kprobe *p);
>  extern void arch_disarm_kprobe(struct kprobe *p);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
