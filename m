Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83675298CAB;
	Fri,  3 Jul 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106464; cv=none; b=Hs/fHm0978ZhN/CglY/a4iRzmbAluLERN0J75nw6ef91gK82rmyVXfzKHfgUkjsreB1qsaJMpDY1KILCqvEONaZ5ROTn89VHBldvvVm7Ibx82MQcpTttqFtIs7A8fDtiJ7Jp6IxOu6CtZHh32qpvdmw0cxrWRvv3HuF38AIEVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106464; c=relaxed/simple;
	bh=sWmnfGVpLZ9vcC/nCD9SD3MfYYgNz4X722VdZq/6vWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3tHU2z7aRNjr1M7URIbpzOLvBCdDEqOL5qVYjRv7wpZOYaAKInIjpxtTikaCYNKShbhmZd2PPydSK/sTLJRt8A+NnKaQuR1MrxiF1u5ekn00rNJk3uvHxoZB8bsCu09u/fHYsOgQ26WVzdCf45i7gwzwdXCgQjx4Bm7Dx+DG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GpvMXLxM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GpvMXLxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783106449; x=1783711249; i=markus.elfring@web.de;
	bh=sWmnfGVpLZ9vcC/nCD9SD3MfYYgNz4X722VdZq/6vWE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GpvMXLxMPvQkSz9goNKUwEQQjPCbpF4HZBiC6zvuFxFQdrChupEKmUmm78AlY77D
	 OgLvxofmox30qa2hvNPLIcMB0KWMqBXmlocGd4DuF+rNBUddPX+VwhE+4AOzy1iwn
	 e8KIMbuKUFNIiyvyVp9bgSEg32a+vImSAMwyEaygaZIX2UiDbQccgckaWjmrCgC/q
	 ZL8zub66a0QzVv0JEOTmErgyKyXhdwh/UOSRM1CyyF1OQ5HOUcjTe1gqUNhvX2ynR
	 sPZFr9Uacfc+dxIaWVl2Gi6mphTKYS4MKrxch+t1G95KJq04uOJPErK7EdSXGPJSW
	 8KvSK7yN1K6GkliphA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1wbS8e44Z6-00WWnN; Fri, 03
 Jul 2026 21:20:49 +0200
Message-ID: <bc9627b8-90fe-42f4-82f1-541bd96866aa@web.de>
Date: Fri, 3 Jul 2026 21:20:46 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: Cleanup event_enable_trigger_parse() by using __free()
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260701174829.67ab8a33@gandalf.local.home>
 <79106214-b341-46ab-8810-a206ce8fad29@web.de>
 <20260702165346.035f8eef@gandalf.local.home>
 <d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
 <20260703114233.56f0c864@gandalf.local.home>
 <360ba00d-352b-4fc1-9bfc-56d29b317f61@web.de>
 <20260703150933.3ce014b0@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260703150933.3ce014b0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CufxkT2s98+Pg/49FzrOvzJ4O6eA6g2Ia3bwkX8kaMSd7C8CZad
 SU1T3YsfrQJZFLxpfzGRl+OMkyGXkTHEuVRFGfkddSP4ihaa9DTYadWTWVLmqtOlZL9k/TP
 oKVAeezKz+EY1tR5plMUdg1Klh+LpBbMMBHnaEQFcbhRBib3/plt2LhK535yte//RVQ/Yyb
 MdlzEmbhXaVxiQgln7r+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FCAsR9vtxfc=;nWpgiCmDZxWSjVb9KwzymGaBiIs
 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

> That example uses the variable in a specific block whereas this variable is
> used in most of the function, which makes it appropriate where it lies.

What does hinder you to apply scope reductions for selected local variables
more often?

Regards,
Markus
