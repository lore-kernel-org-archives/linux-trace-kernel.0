Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F539AD2A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616921; cv=none; b=EqMfpEF7I1sujzJ248LJ6AhJMYMDlkBwrtaFZXm1qzDpwcZA9+1Eo6/WJT43suFGUHINeEK67daFnjGyrxsuDCZM2y9VsG9ZBiEKPgyUliiJbSB4Elf+qiMDW21HuccBrYuC+lE65jd6af1tyxI+Kvm2D7SQv8+itSFQDYw7LSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616921; c=relaxed/simple;
	bh=Tc4Cjqf1HiSK1Qa/FoMnQO2n3edRUeyX/DxX02s7Nyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTY1UCms4hrYY4oLtBkE2x6eT4gZdouN4xHmlxflR2oczYPwGl9Toj7BD3KL3R+2UvxXLdKkQiJtx9eUuR39oLysT7+A2wzg/xDS1pIL6pT9N05fb7T+4O2TsdeMIxoAd0i71/jo73E756aftwzerxJg2LjUhBydj9/07E+MB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=spodLv5k; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="spodLv5k"
Message-ID: <cd0a678b-1eec-42d8-b027-0d27b9c804a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783616907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HelTUO9OXDkSGYNwLi7hjDF9zbGVYpTrvUapcIhNbC8=;
	b=spodLv5k2gZn5QAYTrcUFb5Rb2syHI2IKF8Kz4krXv7NaRL6WS/PZGOQRNGrHgqqMCpLJf
	hpqhDfxNDz2H9p5BCTv36PTs9Ub8+nJ2PVW1t45f1LuK1gbsuZkxGK4dsN2FIn0KSVcGc0
	XHGRCqQ0jOMeXJz+7HHZRmCFINGcH5A=
Date: Fri, 10 Jul 2026 01:08:18 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 16/17] selftests/verification: Rearrange the
 wwnr_printk test
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-17-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-17-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> The wwnr_printk test expects no reactions in some situations, after
> fixing the bash assertion, the test is failing because expecting no
> reaction after a previous step had reactions is flaky without making
> sure all buffers are flushed.
> 
> Simplify the test and run the steps expecting no reaction before the one
> expecting reactions. Also simplify the load function to stop loads as
> soon as a reaction occurs, this limits the number of lines to flush and
> makes tests overall more stable.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   .../verification/test.d/rv_wwnr_printk.tc       | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> index 96de95edb5..a23d22f6ec 100644
> --- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> +++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> @@ -4,27 +4,30 @@
>   # requires: available_reactors wwnr:monitor printk:reactor stress-ng:program
>   
>   load() { # returns true if there was a reaction
> -	local lines_before num
> +	local lines_before num load_pid ret
>   	num=$((($(nproc) + 1) / 2))
>   	lines_before=$(dmesg | wc -l)
> -	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
> -	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr does not allow event"
> +	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q &
> +	load_pid=$!
> +	timeout 5 dmesg -w | tail -n +$((lines_before + 1)) | grep -m 1 -q "rv: monitor wwnr does not allow event"


Minor nit: could we add a small delay (e.g., sleep 0.1) before dmesg?

Reviewed-by: Wen Yang <wen.yang@linux.dev>

> +	ret=$?
> +	kill "$load_pid"
> +	wait "$load_pid"
> +	return $ret
>   }
>   
>   echo 1 > monitors/wwnr/enable
>   echo printk > monitors/wwnr/reactors
>   
> -load
> -
>   echo 0 > monitoring_on
>   ! load || false
>   echo 1 > monitoring_on
>   
> -load
> -
>   echo 0 > reacting_on
>   ! load || false
>   echo 1 > reacting_on
>   
> +load
> +
>   echo nop > monitors/wwnr/reactors
>   echo 0 > monitors/wwnr/enable
