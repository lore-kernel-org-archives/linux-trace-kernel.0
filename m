Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F3EACE;
	Tue, 17 Mar 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748002; cv=none; b=Au+2mskXFdQtLXAczvtrezD+eLzMTXfMm0zisEYvoLD1SdxPW4KXTmCmc8i0sXxZyf9Ze3jZ+gns2dg1QL+rPSN8J88LGptdkzSsg1FuCx9Irxy3TJYiTnb2gsNWcoqtyNQfP463oi6vMMNOUIUUX1wSDq4/cHvS+rEE2AKwJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748002; c=relaxed/simple;
	bh=TmElFE4FVlwJCuqAbIyKNDuqK+aLRtlxbNCjNNiwyFQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rfc856p5ApAiLX5HJQEkFebEoJcgzcI7dR51Cjd5F2Jg8yUXoavVBVqNP1Gu0QE+dDRAgwUW52uJUMvBySSNIJWLDNuGjUvq1SoG5qC5oT7GRA0a3OLR2Dj2wZTCtOo660rkXaMTaTs2glJfWjSHM3UDDRDTWTWlUQ0iEjjIUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tVZqDLdt; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tVZqDLdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773747990; x=1774352790; i=markus.elfring@web.de;
	bh=dhX94rvK54ktbv+WazpRhOmRuEGGxjCVadosu0r7CGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tVZqDLdtYa1UNsKP5+LIG7/OE2vkruly02L/SXr3HzmW4FBs+suj7L5ePaqTA0Qz
	 M14f3Vvh/XT8vGJmQPW0hH1ZbVDEbQFmorH+7JMK9iEXfbxtJqdKAYMoPRy9QLN7p
	 HwpNoyAI6bn417A8tSBmHjPGEu3YGGiSDHM9INC0rJEpze7zH3XH7uVd5IXmvR3Qq
	 uAYO41i0eFCJ5Fjw/YHODq/c6WDEmvrjPBk7d6bFiYkU0/Zuqqc68W0NVkQm2En4k
	 /1KYmg83ZUPNvyUPxn4JZBDu23tbEGbCfskgqHSaucZJ97O8dlKVnUly5qs+mbf8d
	 j17Ch+pXcZk9v34t+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1w7QiC1H50-00Hwmo; Tue, 17
 Mar 2026 12:46:30 +0100
Message-ID: <bbf3be88-4c40-4bf0-bde3-38685d209e22@web.de>
Date: Tue, 17 Mar 2026 12:46:28 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Josh Law <objecting@objecting.org>, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260315122015.55965-7-objecting@objecting.org>
Subject: Re: [PATCH v6 06/17] lib/bootconfig: drop redundant memset of
 xbc_nodes
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260315122015.55965-7-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W7hvRfJJbWpyrKzJcxib8HgIcGwDLC68vFXZ3fJh6YQWP7IXAi7
 ZpiegaeIxQLGofJL2U7wxrnerXMsxJsL0xhawWjQbDQ5OlHfC/g72lLANKUvDf9oQk2afvk
 FSeMYr2dUsg3/WvquiU4DVjhLFCgQgmPP2TOAM9K4+z30NVN5WgPDfDjqyyBPQSTCf/HXOB
 wx3AZ0ErWlIc+xv6AH5bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o+ovdmvJDf0=;WARPMCuarXPOp/JBjjJEawUAs2T
 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

> memblock_alloc() already returns zeroed memory,

Interesting =E2=80=A6


>                                                 so the explicit memset
> in xbc_init() is redundant. =E2=80=A6

How is this conclusion appropriate for the mentioned function implementati=
on?
https://elixir.bootlin.com/linux/v7.0-rc4/source/lib/bootconfig.c#L932-L99=
8

Regards,
Markus
