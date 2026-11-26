Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665172;
	b=wxOYrFOsV619l4rsQZ9qW4JStkK+PKSOyNrDo1bRdvPkDQbkOIxg/SMBFgAXrMuAuZ1j
	 xHle74hy4189TB/mB55DwLRProOqUhnChVa1zM6Wyix9c+hxQXQ3Rz4M1ZB/+Z5IimbSW
	 0DMgs3xImK5dU+byJ/Ix5zcyBUK8xAHUkxHZdi/jGCaFDB6OmU0Db5iLH3wITb7Cre2c4
	 VohahUzOE2VSxOB1tlO6BT4PEP+DDz5ZDRp5S/OFwmAfC++UT9QVa1S6NoVdo0V23cuWU
	 /DZ3iOEGDGDs0l5S8ls6EEadED1kgPEu8JnLGdzJBKQKom7CFSnBbgOfeNLLnYiv6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665172;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Subject:To:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KDCLSzPGHV1bb4qxAnbaTvdmphyaQVZ1rIY3nt74rCo=;
	b=c1+l1iYD+17ki6yGHOzXO5tp+jVQ1zIOdju3PpvM5OH33HWP1BqsvocAoDkFocC3hgzt
	 E6XcpWCMgwKXCPIPQACjFPEzA8rxbBsGYohbvduxHyWZhV1DGOADVi4/GcHBuiiNAeQHt
	 rjUi9KUIzbjiQEEUAsEp31TqSPsSb9XCJu1YPWpnwej1y7jLF6dP99nDevotRqqWjKB6o
	 6M0kxfC1UxoPdOHyYWeuqvBtoZ5ogLDY6XxPUf8JJFyKJnjnCC203wK+BDL0Jn9JQ35y1
	 Ct8iiUc4Xoprp4OTX3EQc2Td9xl6X+7z7NJHd6xUulwki4XNbc5v2HkdxqEAwFoWiOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A86606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 03:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08146215|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0390669-0.0354742-0.925459;FP=17974743885019383266|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=likunyu@open-hieco.net;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.kAQDt2N_1795665159;
Received: from 172.18.25.145(mailfrom:likunyu@open-hieco.net fp:SMTPD_---.kAQDt2N_1795665159 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 11:52:40 +0800
Subject: Re: [PATCH v2 1/3] arm64: Always inline raw preempt count updates
To: linux-trace-kernel@vger.kernel.org
References: <cover.1795631277.git.kmehltretter@gmail.com>
 <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
From: Li kunyu <likunyu@open-hieco.net>
Message-ID: <3e63ffbe-270f-4f56-6ca6-bd73deb1c048@open-hieco.net>
Date: Thu, 26 Nov 2026 11:52:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 2026/11/26 10:30, Karl Mehltretter wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> Raw preempt count updates can be emitted out of line by the compiler.
> For a noinstr caller, that puts the update in ordinary instrumentable
> text. Force __preempt_count_add() and __preempt_count_sub() inline so
> their code stays in the caller's section.
> 
> Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> [kmehltretter: split out the arm64 preempt.h hunk and rewrite the changelog]
> Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/arm64/include/asm/preempt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 75a592b7f47..f3a5c2cd193 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)
>  	return !current_thread_info()->preempt.need_resched;
>  }
>  
> -static inline void __preempt_count_add(int val)
> +static __always_inline void __preempt_count_add(int val)
>  {
>  	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
>  	pc += val;
>  	WRITE_ONCE(current_thread_info()->preempt.count, pc);
>  }
>  
> -static inline void __preempt_count_sub(int val)
> +static __always_inline void __preempt_count_sub(int val)
>  {
>  	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
>  	pc -= val;
> 

It took me a while to understand these changes (and I learned something new
along the way). I verified that x86 does the same thing, so this looks correct
to me.

Reviewed-by: Li kunyu <likunyu@open-hieco.net>

-- 
thanks,
kunyu
