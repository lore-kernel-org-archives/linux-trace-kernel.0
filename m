Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049251DE8AE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737485; cv=none; b=lfRq8tv7ttwURn9Ju2fFuN0vON6tzMq4PpjBcLKRjy1mdVaPDk8Wm5++k1PXX/NKxfkWI7pX87IQYVw7fyZZuw70G5aJv6SdX4L13aTAJxzAAubtxqLSXjup/8+RxEiURHjVCU9ccEiYPbvfpD6LZ/m6xyMgBGpEgRPLYFRMriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737485; c=relaxed/simple;
	bh=WiIlKvmIpyOXrITnWXzSQhvtf7dT/8TsxUtA865DwjQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FE67EQndlGuuIwnWHD9luJix5IP7pOe21ZRR/nhhlsMkbIW/WOKv8of823Ai/1oQCTSnk4UtxZA5MhsY78XjtSfDhVIrx8oV014uDZWTklBf2HiBoGXe26ZhFFTKcFNHtGfU4N7yc4NW3GR603HZgY7kG8gqe/ms/8sD+7PxHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoHoFoeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoHoFoeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E75C4CEFB;
	Wed,  3 Dec 2025 04:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764737484;
	bh=WiIlKvmIpyOXrITnWXzSQhvtf7dT/8TsxUtA865DwjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IoHoFoeLoBFdcndLdmoIfW98/9ymQCfp/PoL3TChsPadmQu2P2pLdoANd/QAytf4O
	 siISQSUKjUmMpc2eddZGJOygTyF+2h9NQnTSAJ4VLnVP51m1HHecvO1gMaUjBUp5xf
	 ZaH87u4oZ8ONAdrv19upNFqFgZyzltuvvn/u/0JePTKtQ9o/nxbF2VskePmebrD2+s
	 z8rsasIb9W8Bb/Siw7BW0UuY3Mkti31KWVDpVR9wHydgDFmqTSh1l/wo45ebsCZrN9
	 cUXWMLElWVWhkoc8BWcgZYAp1ZrgKezHbszBOJDFCDdOLQVQFwhzZY4FJ/XnHFfn+s
	 pMpgVNcQf689A==
Date: Wed, 3 Dec 2025 13:51:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: yebin <yebin@huaweicloud.com>
Cc: naveen@kernel.org, davem@davemloft.net,
 linux-trace-kernel@vger.kernel.org, yebin10@huawei.com, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod modules after
 ftrace_disabled
Message-Id: <20251203135121.8a12719caaa96af9fad5f8ca@kernel.org>
In-Reply-To: <692FA251.3080100@huaweicloud.com>
References: <20251125020536.2484381-1-yebin@huaweicloud.com>
	<20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
	<20251127131820.152fd7651ece26139778cc25@kernel.org>
	<6929089E.10706@huaweicloud.com>
	<20251202113248.e9e2e7c665bd3ee07b83e399@kernel.org>
	<692FA251.3080100@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Dec 2025 10:37:05 +0800
yebin <yebin@huaweicloud.com> wrote:

> >>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> >>> index ab8f9fc1f0d1..17d451553389 100644
> >>> --- a/kernel/kprobes.c
> >>> +++ b/kernel/kprobes.c
> >>> @@ -1104,6 +1104,10 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
> >>>    	int ret;
> >>>
> >>>    	lockdep_assert_held(&kprobe_mutex);
> >>> +	if (unlikely(kprobe_ftrace_disabled)) {
> >>> +		/* Now ftrace is disabled forever, disarm is already done. */
> >>> +		return 0;
> >>> +	}
> >>>
> >>>    	if (*cnt == 1) {
> >>>    		ret = unregister_ftrace_function(ops);
> >>>
> >
> > This one, it should fix simply.
> >
> I tested it and it can solve the problem. This is indeed a good solution 
> that reuses the original code.
> Do you want me to send a new patch version according to your proposal?

OK, I'll send it with some tags which is required for this fix.
Please add your tested-by on that.

Thank you,

> > Thank you,
> >
> >>>
> >>
> >
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
