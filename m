Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFA8F4A;
	Fri, 16 Jan 2026 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579369; cv=none; b=lPrnS16SeZZq0F7BObwOZ67AJVRZkgVwN/uw9bUev+Kzmhcn1l8c6GZZQVh6Sk85XGdfPSC44FVxiRBTg5jvfIzmQYDjZOYCTQNndV4aHaj3VyTC7E58kNCDEf4lAQio9m8Yuqls/An/8PWJ7WfgfzPvLIXsRjpPxHr9tkttj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579369; c=relaxed/simple;
	bh=mQjjBgHaxyIhHcS3H6xxws4vC3O+oyUSUxtA+52E5jY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Yv+Mj1wHjqakde0y1vDHKvh972TSt5g1k+sqhy6AL/mx8G9nx9Kslwj1LgPQ+psNjVIPKSlBDT1eFQwC6gc5XQ1A+OumjjD38ybY0pmwBZBBa29Q+pqa14hwuI2MdbYBlU6FUeHGjvW/p10ak9UPqpGbDxBl4YdKR9EJ5jvo7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g7pqTYzt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g7pqTYzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768579358; x=1769184158; i=markus.elfring@web.de;
	bh=RahEOyQwJocIFS646Fn0CzFq9Wit2v7YAMI5BK2dUO4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g7pqTYztp3NBU9Bx3x4gxHX5baHreRr01dpwB8X+5cImdscHij6muD1ydkMKdb50
	 zOuXXAzAsToJgjEjRwH2c1F7DuW4DdjuL6q64xeaaN3nkxuz9CZ4nbem6fq7Iz27Q
	 qczMCRwesJum/oueMRNG0OxC48DzwmHqvphn/g+yK9jF4KPNtlFLvDRK8j+bdIad3
	 BS6y7Bahw/q4dP3Qit5ff+YRXnKMq+G2e5r/UIqEWlY1OfVsdqq+MXouuaXQoC+bJ
	 UfzlVWdGFABm6+bgOmkEy90uZK/m8mZB6ws3PfVqYn8HI0OOWrGZhAs3Ni1Y3+IcA
	 ew29h6tpdrUl3sYOhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1vc5SH1gpv-00E5Ui; Fri, 16
 Jan 2026 17:02:38 +0100
Message-ID: <fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de>
Date: Fri, 16 Jan 2026 17:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Thompson <daniel@riscstar.com>,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
Subject: Re: [PATCH] iommu: Fix NULL pointer deref when io_page_fault
 tracepoint fires
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FTKJkaMi8gpomCx5H3xe7LEvwBiTrFaijdUx2Aj7gfs0+co6kF
 OydeSJM2HuFgj0Tr6tNwq1E6UHJGg9hJ/MJI1TDJUSIYxb/MMR201BNVS8i1IzpFUXSlNmW
 B+U2QaEwExvNA3gutCzn9nh+uDvt4Igc4qRMzlAmsfWOa9O5XvUd6iBHfxZEp/pHh/rC/5q
 LbYIQroeVg7U90mJh8qLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mk6c8yA1AIw=;6vyQr/06AjdgiVjaW9favKvfSoR
 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
 r73MTZ9iVPuTmmV7wcnXV40pvXQBme99h3qwzT

=E2=80=A6
> Fix this by adding logic to the tracepoint to safely propagate NULL.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Would a summary phrase like =E2=80=9CPrevent null pointer dereference fo=
r a tracepoint=E2=80=9D
  be a bit nicer?


Regards,
Markus
