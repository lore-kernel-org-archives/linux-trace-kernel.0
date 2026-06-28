Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99503175A69
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665927; cv=none; b=O7N/qkoyPlaItZceIM/5v2y2TQonDvCvC6/XTCM2V7M69BMnR0KjHmpuYuXQKhMWiAxLXIkrGMU6FMq800D/8wmuxXuqm2zV/Vc9YoelGD/DQqGLPKFrUTWaqqwmD9Did1i8RjQ7SPUDwsCqs03rRt4DNFp0FVc3pSkzDaD9eb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665927; c=relaxed/simple;
	bh=I+JW7Xgh6wva88wNr7W+Hwn84kFCifHvze3rlIHjxy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBQxraLniqsxN8+/k8jxfF4pWqNtPvD/Ea8AY8s20ERsBeE6FUm0GNDopRsQhEb6Nw1uRmWSVIIyjm2vM8kYtMRh8fpGMALO3rUAldg219XcHMAXBCW4FDogOY/6M9DrqLcRK7U6iDZM+HGbhutTt6upp8KqxJyBEDwM/9/gWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TorGlB9i; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TorGlB9i"
Message-ID: <5ca104ab-cffb-4090-9af6-06d173e8069f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782665913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmf685DUmEukjJHRwKH+fFWXRVCKj+jIzM0foUW6Vh8=;
	b=TorGlB9iWyZIxFdfUWrx9/Pyp5gQHLhQ6sH0/9YQMS1T+8dSSQnEv6cJyekHd1soMUkMxo
	g/7l9Ise4N/ipQGpDg9YcyiP6Db0/6SkecS6T8mf4sU4rcLPwiWf+hIspQaUS61WpQsn98
	FAOsuFNYSGHBWg4UICZMK2/nnKotnkI=
Date: Mon, 29 Jun 2026 00:58:13 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 17/17] selftests/verification: Add selftests for
 deadline and stall monitors
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-18-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-18-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> Add selftests to verify deadline monitors don't fail under expected
> conditions and the stall monitor report violations only when expected.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   .../verification/test.d/rv_deadline.tc        | 21 ++++++++++++
>   .../selftests/verification/test.d/rv_stall.tc | 33 +++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
>   create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc
> 
> diff --git a/tools/testing/selftests/verification/test.d/rv_deadline.tc b/tools/testing/selftests/verification/test.d/rv_deadline.tc
> new file mode 100644
> index 0000000000..b583096bed
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/rv_deadline.tc
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test deadline monitors trigger no reaction
> +# requires: available_reactors deadline:monitor printk:reactor stress-ng:program
> +
> +load() { # returns true if there was a reaction
> +	local lines_before
> +	lines_before=$(dmesg | wc -l)
> +	stress-ng --cpu 2 --sched deadline --sched-period 100000000 --sched-deadline 100000000 --sched-runtime 20000000 -t 5 &
> +	stress-ng --cpu 2 --sched rr --sched-prio 50 --cyclic 1 --cyclic-policy rr --cyclic-prio 50 -t 5 &
> +	wait
> +	dmesg | tail -n +$((lines_before + 1)) | grep -q "rv: monitor [a-z]\+ does not allow event"
> +}
> +
> +echo 1 > monitors/deadline/enable
> +echo printk > monitors/deadline/reactors
> +
> +! load || false
> +
> +echo nop > monitors/deadline/reactors
> +echo 0 > monitors/deadline/enable
> diff --git a/tools/testing/selftests/verification/test.d/rv_stall.tc b/tools/testing/selftests/verification/test.d/rv_stall.tc
> new file mode 100644
> index 0000000000..8e9bcbb441
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/rv_stall.tc
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test stall monitor
> +# requires: available_reactors stall:monitor printk:reactor stress-ng:program
> +
> +THRESHOLD=/sys/module/stall/parameters/threshold_jiffies
> +
> +load() { # returns true if there was a reaction
> +	local lines_before cpu
> +	cpu=$(($(nproc) - 1))
> +	lines_before=$(dmesg | wc -l)
> +	stress-ng --cpu 1 --taskset "$cpu" --sched rr --sched-prio 1 -t 3 &
> +	stress-ng --cpu 5 --taskset "$cpu" -t 3 &
> +	wait
> +	dmesg | tail -n +$((lines_before + 1)) | grep -q "rv: monitor stall does not allow event"
> +}
> +
> +echo 5000 > $THRESHOLD
> +echo 1 > monitors/stall/enable
> +echo printk > monitors/stall/reactors
> +
> +! load || false
> +
> +echo 0 > monitors/stall/enable
> +echo 70 > $THRESHOLD
> +echo 1 > monitors/stall/enable
> +
> +load
> +
> +echo nop > monitors/stall/reactors
> +echo 0 > monitors/stall/enable
> +
> +echo 1000 > $THRESHOLD

A little worried:
If the system had a different value configured before the test ran,
this silently changes system state for anything running after it.


--
Best wishes,
Wen




