Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87FFBE8;
	Mon, 15 Jul 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071014; cv=none; b=rY4lkTyFWBAelP+okJBa5g9TI3NolW/jzGC6cZS4A6CKHs3aBDhO3UIq4YeY2XGd7Y2UI9EOhmuLRhoLswsvAMocapqaCf9zQKrOdo4Vpt/tb7UcY1s3cv8gK+EvrWpWzrynltQFWfJoleLywwbN/oPZMLux7/+ILhQZkucUdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071014; c=relaxed/simple;
	bh=GFxceldEaJt+bbACqStNRhIkSO7F3RPs/e0VDTktiNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoYTST3Z9+8n7jP1XQgAS4ZzOyfN3HrZkI1LONVeY2Zj2jlhVX9bByoyhIX8rLys08YU0ewq1axswmdEUAdyloQJpTcsyFgBI23gmGiZy03UC8OV6ndOZLMMi1BDy0/xp/SDpzzt0h1Xdwx7UUucRVCqu4afoxjAzxyQsiRazDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SkcUyi5B; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SkcUyi5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721071011;
	bh=GFxceldEaJt+bbACqStNRhIkSO7F3RPs/e0VDTktiNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SkcUyi5BTxr76fWqRR52Ka8kUAms1ONWI7p45ft7+OAftwwfSrolNZFqqFPfo3ubE
	 04M1EKw5A6/QsF+RvKZXnUeiornrVzHwoScNM9HKmky1Zr52q/ixIoh3hSIXPFnDSf
	 inP7fj0bTDl0qckdxhVDnBHp5eyLacBwy7Ju38/3rl2GvEOANd3AvHgQWgY5W8joko
	 CZFNPGXNe97qq25oypX0LCrMtEYjz+ewpB+Ni9xgUdPnWbgWRHJzJ6T1CUYi/3726U
	 L+NlJCutcRbXtVSClManvZKVRuKjc4NwASDrU4+8Ug1CJVM2J653Hv5vD3FOd16q5z
	 y7NIZorc+nIuw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WNBlQ48Hgz1B5p;
	Mon, 15 Jul 2024 15:16:50 -0400 (EDT)
Message-ID: <1c4375a2-f383-446e-9a21-edd768ded659@efficios.com>
Date: Mon, 15 Jul 2024 15:16:50 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Update MAINTAINERS file
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
 John Kacur <jkacur@redhat.com>
References: <20240715144745.51d887a9@rorschach.local.home>
 <11fe922b-ffd4-4173-b1ff-d49745431fb0@efficios.com>
 <20240715151337.2d47d003@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240715151337.2d47d003@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-15 15:13, Steven Rostedt wrote:
> On Mon, 15 Jul 2024 15:10:17 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-07-15 14:47, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> Gone but never forgotten.
>>>
>>> [ Also moved Daniel's name to be consistent with the alphabetical order ]
>>
>> Hi Steven,
>>
>> You appear to have missed this entry from SCHEDULER:
>>
>> R:      Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
>>
>> Should it be done in a separate commit or folded in this one ?
> 
> That has already been done:
> 
>    https://lore.kernel.org/all/20240708075752.GF11386@noisy.programming.kicks-ass.net/
> 
> This patch is actually on top of that one.

Sorry I missed that.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

