Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050593D3012;
	Tue, 20 Jan 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903223; cv=none; b=lW70We5p+jnN2YFqvKRw/edfK1852JrLn038zf2CW+iS1LDGd4iqzKd26OikEicP1TTafX9oeoCM62aaQm73vmKbhDLLG6RW6GzoyRIVjL8OBSFCj9AIG+NJqmpWQQQJWXEzIOtAYr/hRmeSQ8TnvSQfos+zlGH/ZuHzORtlSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903223; c=relaxed/simple;
	bh=6zfRESIDke8BZndaeYlW1uVMNFveRZt7eVHEeKwGhDA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Cbjw+CObpaUdSqlVAEN8GUI/KRvQlCJGp+n/PeXvLW2ynQkJUBaEZNOp89HEJyVsTeZnLCzZ6PoKSWNxn1/RTN03BlrvBM43aXhwGp/eXUw/qSXHiSmPMELzKOHMTHbeBaM1WtmuFuyp7u13IT8+1Nxz8E/RgOnKPsF1pOCdTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aPcZBmcO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aPcZBmcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768903208; x=1769508008; i=markus.elfring@web.de;
	bh=41UI/YKKYNTVnTc3PrJ24xl3iho3574waUecCV1wLz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aPcZBmcOETquHmG4O/BN2e5jDYKA8Efc5TN2m4KmGf+OkhD4j7tAV9xTpCyO98gP
	 zlSoNiHvOeiEE0BNoT6z1w+XEV9htNC2Cr7knWix3sCYh5RJ4/55vnWky8QlcVcTO
	 8x594u5nYdWcvNJDTXE3leEE6KPF20WuUOlfWQH4Coc/sGydvMBmU3eF4a89uxaPj
	 7a7knO5PD/DAcDCZ/Ddw8vn3N4RkdxpwhovpA7OdYhItcPr0AZphnSNv6haFNBouz
	 ZD2PHqEB5LQ773IOHjKv+V+KBj8NlTmofALbVuwS0D3wxZPJSpFbRPVAmgTeyQNmp
	 NsXC8LAfVw+qevAUUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1vixTp1qYP-00GicZ; Tue, 20
 Jan 2026 11:00:08 +0100
Message-ID: <b9254eb2-6cc0-447e-a324-d135ff39abd0@web.de>
Date: Tue, 20 Jan 2026 11:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weigang He <geoffreyhe2@gmail.com>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
Subject: Re: [PATCH v2] scripts/tracepoint-update: fix memory leak in
 add_string() on failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBH8FHyZ+77BjkpKUqQHiElbsFC7Y0F0No95WoCQQk4azBQKa/F
 UfgR5Zup2GCkzltRCwBDy/HC4TuDWzWBSkO1xu3QZw/znVIMCmRFr+jnXKAfdq1YoNhZ3n8
 6wOE7qCVDtE+Jxy7JgKW9Aas2QY5LWzO+qmF99fFC0bQuLjbyFoMn2jCpPf+AWjX5bklCSi
 8a1ZCZAsux13i+p6TUNRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bB1r8pY97y4=;3nqig1SbTeY9vvUb7pwQrz1WSEV
 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

=E2=80=A6
> This bug is found by my static analysis tool =E2=80=A6

Will any additional background information become more helpful here?


> ---
>  scripts/tracepoint-update.c | 2 ++
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc6#n310

Regards,
Markus


