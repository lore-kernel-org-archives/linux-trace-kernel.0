Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73B275B03;
	Sat, 22 Aug 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787371185; cv=none; b=UBfIpbSE60/+chG+n6qmoXlw3Ckv2pmX45tPfI5UuFv31QpsyPAIpR+4k9NrcIM1JUoI6kxOhH7bsr8KXuIawC7XkjPZYXBI++LjBgiS0cdD1Bus7N+uvkj/EyZ7i0Be7I3oBYBmsLZEKpeyqNTh2pDwKyjocJWx1zTj6brUPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787371185; c=relaxed/simple;
	bh=WOtnTIQyBUtUjogvNDn96QQXCzQb2XNNCtggZkv/VnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjaHzYewzMkdg4T31VxmcgPFeJPVBVbOsnuF5YkhI888T2F5MaxvXmOQ20MjOIIth5hNbW4jiNxVZz5AHYFnYDet8b9QMnqPbtY4OovZNq7gHtByU983+a+uJJk1o5ki3WJ9m8P7/4XRfLzwZyufm35Q4NKfPFLfAeFHYYc8YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jch0w6Io; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jch0w6Io"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A5EAFC02DE;
	Sat, 22 Aug 2026 03:51:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 01B5817;
	Sat, 22 Aug 2026 03:51:31 +0000 (UTC)
Date: Fri, 21 Aug 2026 23:51:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangbo56@xiaomi.com, lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack
 trace deduplication
Message-ID: <20260821235129.078dd489@fedora>
In-Reply-To: <20260715031245.2571869-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
	<20260616064119.438063-2-lipengfei28@xiaomi.com>
	<20260714171144.4537f163@gandalf.local.home>
	<20260715031245.2571869-1-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 01B5817
X-Stat-Signature: jcg9dakrt1umcszz1qc18aeesij8j15f
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6h+gXxyvTm++AlqTXDOw4R1i6gaiG1As=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ltstLTxn2DV/4vatN7JV2fbcjeDHbbGsBNDW2fUkZ8g=; b=jch0w6IoIzNUG1iQ6/iABzaDPjijnaRzH2Ko1R98E6mE1zE8yFtwOI0Gazj5HcFE+q3LOTzhjNrwHJIV9NuNIfrYtMMytGwuYVeRT5dF3zEDkjpHqJSpztCdAmyX4CoedTxcbu4s/m0eDmT5+RAltECEx3/XH9X1nGMmD0rgIyk=
X-HE-Tag: 1787370691-261953
X-HE-Meta: U2FsdGVkX1/G9RxboLGG1ORvtXdmAw/ojHWSnvqVV207kFbrt9c1xToeF428o/VBGY8GyuiEbshztkRVxDIialkAu8cPdvy5cTDu1Xu6SurCeBWTZnE1A23g8ax8FK66oI3KRlMU0/NstB5AfH4HZeURypjXJk1kadAflewVTIZYNVK8SUaw/N850E7gooj4uzc0BuX7KGkYCA/iYmlF99Jzk3wjLjBMNmzw3jLfTeJWRqxu/HERmCFpJtgz5H0X5492zSHJGLozWbPOti6F4utH02dZ5zsTUrz5S0+JbS/nGFatM75w71Q8Fhqy7OmZDPUN9ompP14dezHN+R8KglxDgcaE3MEQ

On Wed, 15 Jul 2026 11:12:45 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

Sorry for the late reply, I haven't had the time to look deeply at this
series.

> 
> One design point I'd like your steer on before respinning: reset
> checks tracer_tracing_is_on() once under trace_types_lock, but
> traceon triggers (ftrace_traceon / traceon_trigger) can re-enable
> tracing without that lock during reset's clear phase. As far as I
> can tell this is a semantic-contract issue, not a memory-safety
> one: the map is protected by the resetting flag (get_id bails with
> -EINVAL and synchronize_rcu() drains in-flight callers), and the
> ring buffer pages aren't freed by reset, so the worst case is a
> non-empty / inconsistent buffer after reset rather than corruption.
> So I'm leaning toward documenting reset as best-effort ("stop
> tracing, including traceon triggers, before reset") rather than
> adding machinery to block the window. Does that match your view, or
> is there a ring-buffer-state hazard I'm missing that would justify
> blocking it explicitly?

Honestly, I don't think we need to be as strict on reset as you are
trying to be. What is the worse thing that happens if a reset happens
while the buffer is not cleared and the trace still exists?

-- Steve
