Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB8276057
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966476; cv=none; b=YBDp6CRMH3NR2TsUn+UaEvHtzVmPSbyc4y6W+klvV77gI8NzDM84GknYLK8dwV1bc1LDmF1rTSP92IaLPjN5zbd1cr7dhI195TFGj8b37VJ2fBbqHnMu018lvUsCFOGgPVuupm/+XC0C0oRfOY3OXPe+PwanobxI5HGKD9eV5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966476; c=relaxed/simple;
	bh=wo11me8IvGPk3B/veYfd20GY2IMBfNKQXpcWMJs4yG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnW2x19fgBn1axRpeTMgFHoa9qTI5LVoe63uSA7nFQiPMXZU4E4Gi58OKxGiKwTXIrz5rK1kNHHVEBhLSAh2/+HOWhe8ugCcVQWAU//5u4p/0LgOyvXYPpBadRJl3tFl6RaD7iRb32hvP7vGejKXCjVKjNY89PlPOgByoLr+gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 63A3A43FC1;
	Sat, 27 Sep 2025 09:47:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id DB68D20027;
	Sat, 27 Sep 2025 09:47:43 +0000 (UTC)
Date: Sat, 27 Sep 2025 05:47:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-trace-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise
 actions
Message-ID: <20250927054741.10e22942@batman.local.home>
In-Reply-To: <20250927044454.0525d39c@batman.local.home>
References: <20250907022325.243930-1-crwood@redhat.com>
	<CAP4=nvQR3YDNVhka9QCNQVB=QEytxLPdFrx_nNJbNm7-r9ujDg@mail.gmail.com>
	<20250927044454.0525d39c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: roy6f39wbf37md3fr9e4t93r11fd3w73
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DB68D20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+uTmHywEPSVwN97WxlfhVs+ovHxXr06HE=
X-HE-Tag: 1758966463-672091
X-HE-Meta: U2FsdGVkX18AAotAgOkswXrX0sIK1OLvODXqe9yPtXX6b2N7qUAOd4ZQS7Xo4AF+4OXSeAVgxkX9+kitLnvjxsYO6RqppR7VgWneW1Ksm4l4WN2wV+yhTnquvIKGwDXYDmbkmOzfneXdk2yJA0cgUWdy/uR5/Bm9W+fqIlj++V95ZHTN/mHOBfCL8Zy0Oy4g/oMpoqu5S6Iig2v+8yOf8BBjU+WH4nqAAIktPY6L8jtUx1URbI553uVWno+wqaBNEJEJXDE2gm7Sf744/e44fIdWNws8K+/ieZ1Lcgoxw4AATDP3W7NstjcNOg1CjAEzWtJiIlEk30wTTbczSdUdiGSkOg8TLB5Ju2ZaSn1OU/z2jmwtgKmPHrZxSK0zesY6

On Sat, 27 Sep 2025 04:44:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Normally, new code now would be a bit late for the merge window, but
> code in the tools directory isn't as strict. Thus, this is fine to push
> for the next merge window. I'll pull it in and send it to linux-next.
> 

I applied the patches and then ran "make check" and triggered this:

tests/osnoise.t ... 13/17 
not ok 13 - top stop at failed action
# Output match failed: "^abc"
# Output non-match failed: "defgh"
# Timer Latency
# 0 00:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
# CPU COUNT      |      cur     min       avg       max |      cur       min       avg       max |      cur       min       avg       max
# 0 #1         |     3401      3401      3401      3401 |        -         -         -         - |        -         -         -         -
# 1 #1         |     2361      2361      2361      2361 |     2414      2414      2414      2414 |        -         -         -         -
# 2 #1         |     3079      3079      3079      3079 |        -         -         -         - |        -         -         -         -
# 3 #1         |     3538      3538      3538      3538 |     3586      3586      3586      3586 |        -         -         -         -
# 4 #1         |     3771      3771      3771      3771 |     3816      3816      3816      3816 |        -         -         -         -
# 5 #1         |     3487      3487      3487      3487 |     3536      3536      3536      3536 |        -         -         -         -
# 6 #1         |     3060      3060      3060      3060 |     3108      3108      3108      3108 |        -         -         -         -
# 7 #1         |     3677      3677      3677      3677 |     3723      3723      3723      3723 |        -         -         -         -
# ---------------|----------------------------------------|----------------------------------------|---------------------------------------
# defghALL #8    e0 |               2361      3296      3771 |               2414      3363      3816 |                  -         -         - |                                     Timer Latency
# 0 00:00:02   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
# CPU COUNT      |      cur     min       avg       max |      cur       min       avg       max |      cur       min       avg       max
# 0 #1         |     3401      3401      3401      3401 |        -         -         -         - |        -         -         -         -
# 1 #1         |     2361      2361      2361      2361 |     2414      2414      2414      2414 |        -         -         -         -
# 2 #1         |     3079      3079      3079      3079 |        -         -         -         - |        -         -         -         -
# 3 #1         |     3538      3538      3538      3538 |     3586      3586      3586      3586 |        -         -         -         -
# 4 #1         |     3771      3771      3771      3771 |     3816      3816      3816      3816 |        -         -         -         -
# 5 #1         |     3487      3487      3487      3487 |     3536      3536      3536      3536 |        -         -         -         -
# 6 #1         |     3060      3060      3060      3060 |     3108      3108      3108      3108 |        -         -         -         -
# 7 #1         |     3677      3677      3677      3677 |     3723      3723      3723      3723 |        -         -         -         -
# ---------------|----------------------------------------|----------------------------------------|---------------------------------------
# ALL #8            e0 |               2361      3296      3771 |               2414      3363      3816 |                  -         -         - |timerlat hit stop tracing
# ## CPU 1 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    2353.51 us (97.47 %)
# IRQ latency:                                            2361.99 us
# Timerlat IRQ duration:                                    29.36 us (1.22 %)
# Blocking thread:                                           8.87 us (0.37 %)
# swapper/1:0                        8.87 us
# Softirq interference                                       9.90 us (0.41 %)
# SCHED:7                                    5.28 us
# RCU:9                              4.62 us
# ------------------------------------------------------------------------
# Thread latency:                                         2414.68 us (100%)
# ## CPU 3 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    3528.33 us (98.39 %)
# IRQ latency:                                            3538.74 us
# Timerlat IRQ duration:                                    27.43 us (0.76 %)
# Blocking thread:                                          16.54 us (0.46 %)
# swapper/3:0                       16.54 us
# ------------------------------------------------------------------------
# Thread latency:                                         3586.07 us (100%)
# ## CPU 4 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    3761.22 us (98.56 %)
# IRQ latency:                                            3771.21 us
# Timerlat IRQ duration:                                    25.32 us (0.66 %)
# Blocking thread:                                          16.38 us (0.43 %)
# swapper/4:0                       16.38 us
# ------------------------------------------------------------------------
# Thread latency:                                         3816.32 us (100%)
# ## CPU 5 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    3475.39 us (98.28 %)
# IRQ latency:                                            3487.59 us
# Timerlat IRQ duration:                                    28.35 us (0.80 %)
# Blocking thread:                                          17.70 us (0.50 %)
# swapper/5:0                       17.70 us
# ------------------------------------------------------------------------
# Thread latency:                                         3536.22 us (100%)
# ## CPU 6 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    3049.27 us (98.10 %)
# IRQ latency:                                            3060.32 us
# Timerlat IRQ duration:                                    27.52 us (0.89 %)
# Blocking thread:                                          17.06 us (0.55 %)
# swapper/6:0                       17.06 us
# ------------------------------------------------------------------------
# Thread latency:                                         3108.31 us (100%)
# ## CPU 7 hit stop tracing, analyzing it ##
# IRQ handler delay:                  (exit from idle)    3667.57 us (98.49 %)
# IRQ latency:                                            3677.37 us
# Timerlat IRQ duration:                                    25.59 us (0.69 %)
# Blocking thread:                                          16.84 us (0.45 %)
# swapper/7:0                       16.84 us
# ------------------------------------------------------------------------
# Thread latency:                                         3723.75 us (100%)
#
# Max timerlat IRQ latency from idle: 3771.21 us in cpu 4
#
# exit code 2

Is this expected?

-- Steve

