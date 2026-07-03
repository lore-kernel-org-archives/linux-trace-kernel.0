Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DC28506C;
	Fri,  3 Jul 2026 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054839; cv=none; b=Y5UwStquNE+eKRmEh2vsGGBFX24Xu9/dVtKqZdu0JovmSrZfh0G9Al0/bCjSf9Ov4dzFiiz6bjzOBywK38Hq8S/vpMdRaRat+A2qSArlWFglR8WE4a+c0SJeclRO5y0qY4Eta8fHCy3vzFUxnXieMkStB3XcLrb7tQ8VkYPIo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054839; c=relaxed/simple;
	bh=zadYaq2LzRW+vv4qxPyBLkyvi5Gx+STgn8Ji/BTeGfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QREZ7ckHyy5gZsuHRApHmOmeRx8eFktufyndmW06uM5K9BO7dba5SJSEcbIoxXIMfx1SmE/iwjaqPlxYnLGbOYUQU6LyyXZ/Xq43geHO0glfny3cn/DauX52t0y1rW8f5zs+WD/b4r02k9ZbjgV/sCBrY2rJvjUMDGDxWKVk1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mWTlfjsU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mWTlfjsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783054820; x=1783659620; i=markus.elfring@web.de;
	bh=f1DJUQuA5Td9c/IO3a87A43hYa1Tzc/5OFLAnjdWGS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mWTlfjsUckNnPCbooq9pJE/uNJOtUa6VA1ic9PLgUH5WGXnY4EXkR60OoQEj4zaU
	 1WFyMOgOs8gmqqM7WwTUpMgra/IBxxFMGh7hPjO6y7jKJGTQSzrAuO6+XA/4+UQQh
	 roCkok5U91oPfxc9Q+CKOBVsqFjdxhmPLbv8xR5pHUDSOcwxyUAYZ5orgkdQ+A0/O
	 MJ5SSKxlAVEVl2gjyMarQ6hx9qw6YlE77R3z3/d7UmBDnaa4KXiIkRy+PNOekgZEX
	 eE/+4YrC4K3jDAFDOcRw/ZiShvGGdo3OkeMV/8aABX7V+k5ZPxkuye+E6loucELFv
	 4k1bxb1vyw1Ssnjz2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1waH3v1XrX-00WFWN; Fri, 03
 Jul 2026 07:00:20 +0200
Message-ID: <d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
Date: Fri, 3 Jul 2026 07:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260701174829.67ab8a33@gandalf.local.home>
 <79106214-b341-46ab-8810-a206ce8fad29@web.de>
 <20260702165346.035f8eef@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260702165346.035f8eef@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e7JJeHnhJobvki8SyJUQWoVxBd4ls6Oxz3DcmDe25C97tRbaMlA
 RFhQA0OR/JjS1JwUvnzA6lM1CsAtfsMji7F4iZgtmKbH5Mqw78AbN2o/BpT/jyAoTbKJQpW
 ag+XydxOFRQHnW/F4ufPfcPQX5HMP0Po7SLtUJ3eDiGyfUlQQ/+5mAkcvN6g8ShLiVqULyu
 ByOP1oB51iuk5K8VsH/9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ka1m0zWIwr4=;MD4CyKxh4n1tM71rGTXzGaQy9ay
 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

>> =E2=80=A6
>>> +++ b/kernel/trace/trace_events_trigger.c
>>> @@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_comm=
and *cmd_ops,
>>>  			       char *glob, char *cmd, char *param_and_filter)
>>>  {
>>>  	struct trace_event_file *event_enable_file;
>>> -	struct enable_trigger_data *enable_data;
>>> +	struct enable_trigger_data *enable_data __free(kfree) =3D NULL; =20
>> =E2=80=A6
>>
>> How do you think about to reduce the scope for this local variable?
>>
>=20
> No, it's fine as is.
Does this feedback mean that you disagree to an essential development requ=
irement
according to such a programming interface?
https://elixir.bootlin.com/linux/v7.1.2/source/include/linux/cleanup.h#L14=
2-L153

Regards,
Markus
