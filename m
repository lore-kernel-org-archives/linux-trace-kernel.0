Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221134405F;
	Wed, 18 Feb 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443781; cv=none; b=ZEjeSE9Nj5rkVOmT6Jo19N+PJsL4GoS6CTcOUjm+n1hmYZi/0yV3VmDtgQGYHk3h+/lpVav5U9WB6kz/cqe+DPCn98vunCjXnvL4SFSGF6aUlV6mHC02h7ZDIXjb2F5xRxd9hz85FvILQUwWKqiFKq45alkoiib8/PAF6CkpnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443781; c=relaxed/simple;
	bh=csnvR2a4vAxtNCf3C3hPz6BT32bYG1rCNxKWAcOoTD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FoM+5T/Of07IPM6M09dp2oJ99V606DdwrjQ89NvELLbOtKB/xogn6scrNrWBeNtXINjr0SfHv8Oo/yMZl3JW6J51s3L//cV6TJ/1OQNwQcDbrVr73SEzsAQTaLVqI4WfSvm8Ck32OgxI+iEG4Y5qdxlcGioakznV9gN7bI6fevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dBGKc86l; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dBGKc86l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=H1oe80lyaA/AIBDbfZcCJugSSWCnfK2krWyRBbB4+Lw=; b=dBGKc86lecVCOrHtoTtGKwgFd9
	gZjta3QL+Au2wOnIrhuSyEohGMMz7olYNc7mwGzLayoChBnXFJseDGg/K6R16bRENK5mizhkOVGBu
	k4lxvZnGhGQyC2bVMFvVDqBbMXICSXL5y7HlVMjpyvJLvin2vW+2vxvzarAgv66m1SoAPYqwnv4Qx
	2K0yVZCuycX6LGrO75+XVvXHT6YL2PBtfaZ0WREAQt38N0BsPVVUeFoPKqcDZ5Bo5mR3vY2mM4XdJ
	WEtn1MNL4Fy3ssBWDWcNlmCpmIzVr7kgECh5ZTsT9VFR78DWbu+G2IWgzQkstSXU7PvYevprmv2iQ
	hKrZq2fg==;
Received: from [177.45.213.208] (helo=[192.168.1.53])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vsnRk-002BhK-RW; Wed, 18 Feb 2026 20:42:53 +0100
Message-ID: <e3a5b0dd-4119-2b92-a70f-89c3e91a2533@igalia.com>
Date: Wed, 18 Feb 2026 16:42:48 -0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore: fix ftrace dump, when ECC is enabled
Content-Language: en-US
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
References: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-trace-kernel@vger.kernel.org
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2026 15:51, Andrey Skvortsov wrote:
> total_size is sum of record->size and record->ecc_notice_size (ECC: No
> errors detected). When ECC is not used, then there is no problem.
> When ECC is enabled, then ftrace dump is decoded incorrectly after
> restart.
> 
> First this affects starting offset calculation, that breaks
> reading of all ftrace records.
> 
>   CPU:66 ts:51646260179894273 3818ffff80008002  fe00ffff800080f0  0x3818ffff80008002 <- 0xfe00ffff800080f0
>   CPU:66 ts:56589664458375169 3818ffff80008002  ff02ffff800080f0  0x3818ffff80008002 <- 0xff02ffff800080f0
>   CPU:67 ts:13194139533313 afe4ffff80008002  1ffff800080f0  0xafe4ffff80008002 <- 0x1ffff800080f0
>   CPU:67 ts:13194139533313 b7d0ffff80008001  100ffff80008002  0xb7d0ffff80008001 <- 0x100ffff80008002
>   CPU:67 ts:51646260179894273 8de0ffff80008001  202ffff80008002  0x8de0ffff80008001 <- 0x202ffff80008002
> 
> Second ECC notice message is printed like ftrace record and as a
> result couple of last records are completely wrong.
> 
> For example, when the starting offset is fixed:
> 
>  CPU:0 ts:113 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
>  CPU:0 ts:114 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
>  CPU:100 ts:28259048229270629 6f4e203a4343450a  2073726f72726520  0x6f4e203a4343450a <- 0x2073726f72726520
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>


Thanks for noticing that!

I've managed to reproduce it here and your patch indeed fixes the issue
- I've tested on 6.19 with ramoops.

Feel free to add my:
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Cheers,


Guilherme
