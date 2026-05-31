Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902703446CB
	for <linux-trace-kernel@vger.kernel.org>; Sun, 31 May 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240703; cv=none; b=c6ljZ0c9m6rtjy1hKCg3UkuvIhceJqdGFA1t5dELvCu3Gxl61b3Ezg5sHUaWw2+6XaCGSoAZ68ZBCNbBFOzkL62h4FAZi+Bl3MFJH9+ROwMP7lUp33IRUY/iKRFRTQwBHwZ603t0WH/hNr3ClcUhPek7JRgpWCRLSCp+sGc7RTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240703; c=relaxed/simple;
	bh=AauZxJitFYzVBLPuVDN7oSbe5zYvCjPLPfOSjQFjdPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXPFTkWZjZ4CBMN7xLJtDUv0ZzSPSPjGJhphC9SCeCxLPOOmmWsEGzg5jjXJ1uS1F+qUPnDnPMc/Xjtk/cdqDTkJZehN9cTYfuPj24KA/eNBfPEgmCf04b1SdszMTvLUnAVFkusdE79ogHto8lLS52jJrK+xVJTFDNAUxfdGxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZenvqLbu; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZenvqLbu"
Message-ID: <55cf5315-88fc-42ca-b858-82aff5fee42a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780240698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9a0CcQnJlae6R2aoxRUEE1yESzNQ7AJFR8Rcvc1MspE=;
	b=ZenvqLbuWdTxFNS2jQCPk9ppukJIOYy9BemwG6VrJC7L+4CImV9iQCfhO9z21TofbRlp7C
	mpGDIT4XJQTsSpEN6+zaGzanfrZpqqVfuNKpiJqWMZRbwHyMLjRjyFFF560+RkiDko/G1T
	MYt/lgPDssNfmSz3/8sOs1CpIK+qqNo=
Date: Sun, 31 May 2026 23:17:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] rv: Fixes on Deterministic and Hybrid Automata
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260530141652.58084-1-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Thank you for this series -- it addresses several issues in the RV 
framework. Our pending series [PATCH v3 tlob] also depends on it; we 
would appreciate if it could be picked up for the next merge window.


--
Best wishes,
Wen


On 5/30/26 22:16, Gabriele Monaco wrote:
> Fix issues that were reported by bots or visible only after integration:
>   * Make sure timers are always terminated and waited for when disabling
>     the monitor or when the target terminates
>   * Run per-cpu monitors with migration disabled since preemption is now
>     enabled from tracepoints
>   * Fix a wrong __user specifier in a helper function
>   * Other cleanup and concurrency issues
> 
> Differences since V2 [1]:
> * Applied from reviews changes to commit messages
> * Rearranged order to put non-fixes and not-reviewed patches in the end
> * Synchronise monitors before resetting them to avoid rearming
> * Protect against racing timer callbacks during destruction
> 
> Differences since V1 [2]:
> * Fix memory consistency with timer callbacks racing with resets
> * Add per-obj deallocation hook in rvgen generated code
> * Do not rely on clean monitor when initialising HA
> * Add tracepoint synchronisation before returning per-task slots
> * Fix suffix strip in dot2k
> * Generate stub deallocation hooks instead of failing build when per-obj
>    miss those
> 
> [1] - https://lore.kernel.org/lkml/20260527062313.39908-1-gmonaco@redhat.com
> [2] - https://lore.kernel.org/lkml/20260512140250.262190-1-gmonaco@redhat.com
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Wen Yang <wen.yang@linux.dev>
> Cc: linux-trace-kernel@vger.kernel.org
> 
> Gabriele Monaco (12):
>    rv: Fix __user specifier usage in extract_params()
>    rv: Reset per-task DA monitors before releasing the slot
>    rv: Prevent in-flight per-task handlers from using invalid slots
>    rv: Ensure all pending probes terminate on per-obj monitor destroy
>    rv: Do not rely on clean monitor when initialising HA
>    rv: Add automatic cleanup handlers for per-task HA monitors
>    rv: Ensure synchronous cleanup for HA monitors
>    rv: Prevent task migration while handling per-CPU events
>    rv: Use 0 to check preemption enabled in opid
>    verification/rvgen: Fix suffix strip in dot2k
>    rv: Fix read_lock scope in per-task DA cleanup
>    verification/rvgen: Generate cleanup hook for per-obj monitor
> 
> Wen Yang (1):
>    rv: Fix monitor start ordering and memory ordering for monitoring flag
> 
>   include/rv/da_monitor.h                       |  67 ++++++++---
>   include/rv/ha_monitor.h                       | 104 +++++++++++++++++-
>   include/rv/ltl_monitor.h                      |   1 +
>   kernel/trace/rv/monitors/deadline/deadline.h  |   3 +-
>   kernel/trace/rv/monitors/nomiss/nomiss.c      |   4 +-
>   kernel/trace/rv/monitors/opid/opid.c          |  12 +-
>   kernel/trace/rv/monitors/stall/stall.c        |   4 +-
>   tools/verification/rvgen/rvgen/dot2k.py       |  19 +++-
>   .../rvgen/rvgen/templates/dot2k/main.c        |   4 +-
>   9 files changed, 180 insertions(+), 38 deletions(-)
> 
> 
> base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
