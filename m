Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208021E98E3
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Jul 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260976; cv=none; b=A6XlvKZavdAI4SsYh/C002n+gGMUTCKYt2i3k+YtcXxOwNjlKFnklVi2SDAs/fFhsl0ADFo6fpJqC2vWEjzIGYXUIGP0UHdcV8XXk9mftExz54Yqlyf8N83lcM2sX8o+zc4R0dmlvm1P7i/FHXhqqVHcm6jdYuN/QnWmOXubBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260976; c=relaxed/simple;
	bh=haTkynxAOqe/YfGduuTTUWMreuoLlTQ2Qu07vsVgaVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiUcN1563+rMCF6eDBk9RLzm4r/TjsJRphn/eh2/aNSbyn7x3W3WYpuvT3Ms6JQOQ7KW9IFXPYdEeb+If4fE9+q/RDeZapJEwd/fB9SnD7Eac3VsBFdqFghK4igXSQGEMBqXCO8nxstGDAUTwIw2IpSPzAXav7pZtTEfmV5eoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKtiTnIs; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CKtiTnIs"
Message-ID: <4e1ac57e-a127-4c43-a719-08b9d99cade6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783260971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLkErmE5LgOSLdN9cPaDzpscqqSBslDD7mRQkdPcKZg=;
	b=CKtiTnIsNMbFTCC/IwVzzLgel+PWyMryRne98J8WBkLGvzY3mugyFz2NFqwOz1cQf4no0y
	y0KuQRSVTvuJYAYcScwRqG290A8n8NJydayFdTT0YM9Wayi5CWBEXARWygcsKr0NNN+O8a
	YOmyeI4qN5BLqKpKl0WyLrZ4tT8ptTk=
Date: Sun, 5 Jul 2026 22:15:51 +0800
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
 <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
 <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/5 10:11, Masashi Honma wrote:
> 2026年7月4日(土) 22:28 Leon Hwang <leon.hwang@linux.dev>:
>> Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
>> kprobe+kretprobe or kprobe.session, if the extack is not NULL.
> 
> Thanks, that's a nice pointer -- dev_xdp_attach() has both the net_device
> (so the ifindex, which lets us correlate a failure to a specific attach)
> and the extack, and it avoids depending on the tracepoint you want to
> retire.
> 
> The tradeoff is that dev_xdp_attach() is a static internal function, so a
> probe on it can break across kernels (inlining/signature changes). For a
> best-effort error message that's tolerable with a graceful fallback, but
> it's a maintenance cost on our side.
> 
> Since this is ultimately just an error-message improvement, and your
> in-band BPF_LINK_CREATE work would solve it cleanly for all link types, I
> think we'd lean toward waiting for that rather than adding an internal
> kprobe to Cilium. Do you have a rough timeline for the BPF_LINK_CREATE
> series? That would help us decide whether a stopgap is worth it.


I will post the RFC around October.

Thanks,
Leon

