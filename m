Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43B3AC23
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asOOEPbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A3C433C8;
	Wed, 18 Oct 2023 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697656465;
	bh=ey2GKZ006LXRzxCMSwHSeWZL7CH0Hr9cB5YCPXl3VXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=asOOEPbQwFYIC8jx1HRf2cqsEethzzyQPVKXN3W7Fs1T7zrtzy1vIBcpocGamRzu1
	 RxN0eDW9jda1UiLATlMLCcr21mbPKdF1IbzyrzG7/W1p7SjrZZe2LNXD7jvwqPjFHC
	 OosfIgm1ZV0aBKmPDVvpdfm8TzsNS9T2Bg4GOK+tf2m/dYPaHxCVtk4bqCfCHdtSIf
	 EWbk3Ks6kURi49aZdxMIcFfrIbhbYyMzvJr81bRj/lLHGaapcB9Wx9pjfv2GoTiRAQ
	 TviMjk2x/vT9SPsjwsIYog0TCkXYtTX4JU6Vwm4BfyZdWxoBI93tg07SW0OkIsYfy0
	 d48MNiT/i6/TQ==
Message-ID: <a802bb07-b7d3-4c8b-b0ff-77da021e63fa@kernel.org>
Date: Wed, 18 Oct 2023 13:14:08 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/2] add loongarch and riscv support for kprobe
 args test
Content-Language: en-US
To: Yu Liao <liaoyu15@huawei.com>, skhan@linuxfoundation.org
Cc: liwei391@huawei.com, rostedt@goodmis.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, mhiramat@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231018020858.1304218-1-liaoyu15@huawei.com>
From: Shuah <shuah@kernel.org>
In-Reply-To: <20231018020858.1304218-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/23 20:08, Yu Liao wrote:
> Yu Liao (2):
>    selftests/ftrace: add loongarch support for kprobe args char tests
>    selftests/ftrace: Add riscv support for kprobe arg tests
> 
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>   3 files changed, 13 insertions(+)
> 

Applied these two patches to linux-kselftest next for Linux 6.7-rc1.

thanks,
-- Shuah
