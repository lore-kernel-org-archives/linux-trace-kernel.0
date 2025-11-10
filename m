Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5872277C9E;
	Mon, 10 Nov 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792924; cv=none; b=OQT5FvizOnOr18lozfjwFkv4gHgCSVWQmUboHBFmBihyY6cnyqQN342pgDxNtjwnP9XetwPuTa/qks4LXRtBV/yY6yuIt5bLPPAvQHsIdKslY4jSxJPYPwVpOrRSedNMEjPgrTK0VrSMtvrcDpXTmSswJoq0uG66Ec0+6KGbjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792924; c=relaxed/simple;
	bh=Wu3hyDcoCNBAir78rm/eQD4J5QxrK05qXhG7UwS70eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/pkEntqzWlxjlA1AwQF9lsxzYsjAqYFTjylVmFa4LEtu0ZUtxmTNk+lo1x4aiwXC/ICjSwwA9HJSnJadwB6PQQ+t5Edn6mpzU2BMHgx5Fcoq28eKgvr5gvel/a91E60PKa5aDj9sgrTsXDKcXgYbyF/9cw+g88AiTs44aQg/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D14961601E1;
	Mon, 10 Nov 2025 16:41:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id DC2A520;
	Mon, 10 Nov 2025 16:41:52 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:42:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] tracing: Use switch statement instead of ifs in
 set_tracer_flag()
Message-ID: <20251110114201.37d63a73@gandalf.local.home>
In-Reply-To: <20251110144826.8d92d83af67efebac2a3ecf5@kernel.org>
References: <20251106003324.964761749@kernel.org>
	<20251106003501.890298562@kernel.org>
	<20251110144826.8d92d83af67efebac2a3ecf5@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r6wwgsyuhw7h646ff8eo9qyy8nyj13s5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DC2A520
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aqCcam6KhNEy/Mv2Dfe3ocGMLzGhV1fI=
X-HE-Tag: 1762792912-438976
X-HE-Meta: U2FsdGVkX1/Fs2+z5P88IdvMnxSKDq/8MCsmhGzGHJiFcU2GsP+V3sUfyMCwTWCxT8IMpWiD47/MxWlBE6rUyhasGyC3W+B1UqSAeJ1oLHefGKKYfcNsgvDW2LDEATtTbFx8DIFMTktdaFspQ9tdQDohP1A+A1BdtZK9Tlmd9Jup2aOObVy/VvlIlstS/ezYW9XzoBkeB1Uap+0q5FfNWzFfJnDVVMUhoRX7G7AruMmnavKZ9avxxjP2bzwdKdxNGqJpj0w49BpBGzHBIuQ9nWuz+AE2JGTXHWbgA2fvVrJ9pxd1aLWp6m51QoYS8X/vy4hPuRMLeiTHSfxpEldVwlT/CRs9rlCI

On Mon, 10 Nov 2025 14:48:26 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, set_tracer_flag() seems to expect to modify only one bit.
> If we can count the number of its in @mask and reject if it is
> not 1, we can use bit-mask instead of the first switch()?
> 
> 	if (!mask ||	/* mask has no bit */
> 	    (mask & ~(1 << (ffs64(mask) - 1))))	/* mask has more than 2 bits */
> 		return -EINVAL;

Well, this has been around for over a decade without any issues. I don't
think a check would be of much use. Not to mention, invalid masks are OK to
pass in.

If anything, I would have liked to pass in the bit number and not a mask.
But that's something we could do another time.

-- Steve
