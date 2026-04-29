Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129D1C84A6;
	Wed, 29 Apr 2026 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433526; cv=none; b=m7xqRQDf+13zxo+sTInmoXEYajo8RMt+VPe9cy8xJtiV3/r8EoUOlZLc6qtmZL41I/R83imgQN0Jt+bYJd+617JNoe3KvkMR1ImZPvQmsNDY/6aSNvqOaiFqnuCSyy4xcKK0vRCoryOc53zjDmW8UAfKXhe5gIFi7qTAP3cYq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433526; c=relaxed/simple;
	bh=3jHDHOMfGUaLJeNyd8AGnvQsgJYSoBnA0Hacsg+XNBA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ilZt24CLfpcglVeHQTbBbvv1s8O1qd1z8oQjvIpPTusOrufuGmFM018kU+JLXEsPh+2Vo+hNct3IkG6xS91mJVc2ONlIUbDlIk9/Y9bQBj13h9Vsf6ia8n+chNM6KqOb5QUqLg9D+vBCw10rD+5iMTgwu8NkVTPQSMZi0E4hZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=XmwAK8XQ; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="XmwAK8XQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1777433515;
	bh=3jHDHOMfGUaLJeNyd8AGnvQsgJYSoBnA0Hacsg+XNBA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XmwAK8XQSISth0tOijGltJaSz9+ZC9hVRSIMSlRDfRV+D/Jfuzpu3ycfyPx+embyF
	 X0uyror0u5ADZPc+aoOw/GE0sqR2Ce0eflfNthorf2etLEEqMsgIhbm8jHCgCpikt2
	 qoL8XQaDAgzHgkijOqREANnzGVI/MeMQzYbmQbON19fwrevd843kmHiIEvVje/KZGn
	 dh6cFjOQG6I1BUS8mP7QLWFOt18ZJ23PotT0v1wXoboV0eaGc/0B3t4EyWocLlIKeR
	 mSgTzRy+ql3tiFi9uieT7rDAHKgCaR/CBCZiPVH3BsVLJkPuFmqfE6ECMQFDEt1zOx
	 o112qzo0hmzlA==
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 23BE72FF4E5;
	Wed, 29 Apr 2026 03:31:55 +0000 (UTC)
Received: from mstore137.sjtu.edu.cn (unknown [10.118.0.137])
	by mta91.sjtu.edu.cn (Postfix) with ESMTP id A3E4037CA5F;
	Wed, 29 Apr 2026 11:31:54 +0800 (CST)
Date: Wed, 29 Apr 2026 11:31:53 +0800 (CST)
From: SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm <akpm@linux-foundation.org>, vbabka <vbabka@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, mhiramat <mhiramat@kernel.org>, 
	mathieu desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	surenb <surenb@google.com>, mhocko <mhocko@suse.com>, 
	jackmanb <jackmanb@google.com>, hannes <hannes@cmpxchg.org>, 
	ziy <ziy@nvidia.com>, david <david@kernel.org>, 
	vishal moola <vishal.moola@gmail.com>, corbet <corbet@lwn.net>, 
	skhan <skhan@linuxfoundation.org>, 
	linux-doc <linux-doc@vger.kernel.org>
Message-ID: <1453063691.2584758.1777433513691.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <20260428142335.3bca0166@gandalf.local.home>
References: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn> <20260427060142.131055-1-b.suvonov@sjtu.edu.cn> <20260428142335.3bca0166@gandalf.local.home>
Subject: Re: [PATCH v2] mm/page_alloc: trace PCP refills and PCP zone lock
 usage
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.18_GA_4835 (ZimbraWebClient - FF149 (Linux)/10.0.18_GA_4828)
Thread-Topic: mm/page_alloc: trace PCP refills and PCP zone lock usage
Thread-Index: SvFI4TNgE4VbTb6G/aV24V6dHLhS6w==

Thanks for reviewing Steven,

>Why this change? It makes it much harder to understand.
>
>The above is not a normal macro. Ignore any checkpatch warnings about it.
>The proper way to do the TP_STRUCT__entry() is to make it just like a struct:
>
>struct {
>	unsigned long		pfn;
>	unsigned int		order;
>	int			migratetype;
>};
>
>Thus, the macro should be:
>
>	TP_STRUCT__entry(
>		__field(	unsigned long,	pfn		)
>		__field(	unsigned int,	order		)
>		__field(	int,		migratetype	)
>		),


Yeah sorry for the formatting issue, will fix in v3. Any other concerns?
What do you think about the introduction of those tracepoints themselves?

-- Bunyod

