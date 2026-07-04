Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C041AC45D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Jul 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783171730; cv=none; b=JOUs2LMybyxXKbij7XrBLmoAvltCcZE8qWhDw5duQwLfPthpkTG2c7rUeGnXs9vfCfcNcfLpztKW4kP9AXtkwk8GibqPRpchcVrRcVDxcNvr4RHP3aG3463GasEwzgBy4gxjZQvxN1cVZpW51AQx4QtWdJOTH79s9+9WcMRqNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783171730; c=relaxed/simple;
	bh=k0K06vKwyQw3fWCt/Wz07XfXY9ixM9oTAZwy7Pg0p6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T00NUCHlYNpNjH661CmVMGjrU99PfPpgvo1vcWzvTbePhVYNu3tTT69RqmN9CmEMyZyWpFFwuek1/mDyvi0R2MgBdbL0ceqyvfzdJvadATF41ycvM9LsnMcElaHsHZR1z2WVaV1jeNG7W+T15+yzGxzSekEm/IGVPPVXGJZGmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BaSpW3Aq; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BaSpW3Aq"
Message-ID: <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783171724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR3dxjgK7pL4YTT2MquE2rbdmcrJvmHTMmrgvUy8wrY=;
	b=BaSpW3Aqg8mn3WJD0OGNvHXRbfG7moyF5TyeLfnuG7qfH6aDfOLJHqEofbRNAFZFc51lOw
	lpyaTwJ0PEwEQY5tctIDoLdvo88YTw6dSJu87T6SRMTu7RLlQv5ZBPanCky4tiIVkkSx3M
	T0p7Kvfi+eONeb75NuoGD0IyWTr+Pio=
Date: Sat, 4 Jul 2026 21:28:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed
 tracepoint
To: Masashi Honma <masashi.honma@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
 <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Pls do not top-post.

See
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions.

On 2026/7/4 13:50, Masashi Honma wrote:
> Thank you Leon. I think this is a much better direction than my RFC, so I'll
> drop my tracepoint proposal and support your approach instead.
> 
> Since a user-space dependency on the existing tracepoint would make it hard
> for you to retire it, I'll make sure the Cilium PR doesn't rely on the
> tracepoint either.


Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
kprobe+kretprobe or kprobe.session, if the extack is not NULL.

> 
> Is there anything I can help with on the new approach?


You are welcome to review the series in the future.

Thanks,
Leon

[...]

