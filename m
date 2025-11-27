Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFEF1F9F47;
	Thu, 27 Nov 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764215965; cv=none; b=YQGwkkPnHEhbkinfR4IuiCOSaNFpWQv2ZQbc4VsQnL+sAbiqnr9RaKoR1EEwbOla7ySjBcF33gJ+SZY1Et29Idby87WaAaSrcl3wEFm1IXqMUaSEv6Ss64a2RBLqOIlGAJBrX8eoM4kApAvVVsuPSwGa+1HnCJU9r2kx28pfYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764215965; c=relaxed/simple;
	bh=aYDhmVEOub+vSgMjcsWiVgPlZTMfTDvI0Onx7M2nKwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ+312sbttqzMQQT/PBRWMU66pTI1+3KpVLGTWP0tzpZ6hDjCDUYCBm8t3/wywKZLA2LoiNdC1qrzwHdoBJjEDSOU55Do9Rcv69QWT6sP++jdvrWv/RXNY5RROsxzGPN5xmGD2xC24STm8cPVE9l2QhTBnliqeU0moevRFs8gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A7E21570;
	Wed, 26 Nov 2025 19:59:14 -0800 (PST)
Received: from [10.163.48.177] (unknown [10.163.48.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1563F3F6A8;
	Wed, 26 Nov 2025 19:59:18 -0800 (PST)
Message-ID: <34b20d6a-c5ee-4670-acd7-688d6b7f8732@arm.com>
Date: Thu, 27 Nov 2025 09:29:15 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: simplify arch_uprobe_xol_was_trapped return
To: Osama Abdelkader <osama.abdelkader@gmail.com>, mhiramat@kernel.org,
 oleg@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
 will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251126223130.216302-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251126223130.216302-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/11/25 4:01 AM, Osama Abdelkader wrote:
> convert arch_uprobe_xol_was_trapped() from explicit if/return true
> return false pattern to direct boolean expression return in
> arch/arm64/kernel/probes/uprobes.c
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/probes/uprobes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index 2799bdb2fb82..b38c1dab7eb4 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -103,10 +103,7 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
>  	 * insn itself is trapped, then detect the case with the help of
>  	 * invalid fault code which is being set in arch_uprobe_pre_xol
>  	 */
> -	if (t->thread.fault_code != UPROBE_INV_FAULT_CODE)
> -		return true;
> -
> -	return false;
> +	return t->thread.fault_code != UPROBE_INV_FAULT_CODE;
>  }
>  
>  bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)

