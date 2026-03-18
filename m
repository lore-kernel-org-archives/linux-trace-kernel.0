Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E935DA7F;
	Wed, 18 Mar 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819081; cv=none; b=i04K5bGVn3MGXKHE7aNDnxmo4Ruqn+vPvpsvOyqQClZEUy4GddqJKIqo7aLIFYBpo5KyXPEXSnF4iXQcZ4tsTyFNJrE64mfRgx8MnGZEg8gqU7x+FbFJ3+CQnTrIBuP1mYD2myGZAIUQHpzrwwE0WsrVptMq3aj4wWC0amaVEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819081; c=relaxed/simple;
	bh=lOEcWkjFxU7fNlEkM/0+vUz9L9B8bB+MNvW1TRsHqd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWOL8xKR76OHZoCDKqBim+rMNd8g71P3ItktMp+aOIGL3fElDFjLm2+5wDuVFMMdytTKegFmt7BHovJRhox4WkiN+rzxAWRdlV6GhOoYxClZcCqlZe1ZaLyWUeRl2pr3p1GVF2M0ZpCCdQiw825ge1iK2hOsguWJI73l4mi96cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D7WqZYli; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D7WqZYli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773819052; x=1774423852; i=markus.elfring@web.de;
	bh=lOEcWkjFxU7fNlEkM/0+vUz9L9B8bB+MNvW1TRsHqd4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D7WqZYliKHRHoGd1/NN2enRy1Le0SF8o5rYgANp2r9RERDBOAM1p3BS4q0hNLzvt
	 w4xQHGp/uX0wbbIHssKoxIW3/xlDeZM5Md1k7eWFPm+5mOAPyCarP4ac1ADqb9Wbi
	 OpeAeJIUI8G412p/gy6Q0PcvLaLj+3o/9hs/Fkgqd9PIA+6Z4d0o6tJTK9lVYAATw
	 pCDbkIaZwF5kKxSQwQdKyyJoNU3JojYQTzRqamdAKbaliA3F4ySAAgnSxTMstpcuh
	 d5keiJTyQgNYL6VZcyhXUENehNFjPqU3CE9ZUD43Zptwln82YNeGurt/OABY16NGc
	 FqZyeWvomdujFPo+Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXZh-1vtj4a3zgR-00DQml; Wed, 18
 Mar 2026 08:30:52 +0100
Message-ID: <9daaff08-df65-4dd5-9b26-937616836825@web.de>
Date: Wed, 18 Mar 2026 08:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Coding style consequences for multi-line statements?
To: Steven Rostedt <rostedt@goodmis.org>, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Josh Law <objecting@objecting.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260315122015.55965-10-objecting@objecting.org>
 <fbe3dbdd-61a4-47e7-90a1-1042caa71129@web.de>
 <20260317111026.62345f9e@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260317111026.62345f9e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YkaB4Xb/WD0MGQXL8kGGHiMHpKdtCXOB/zL+xDhVSBX7BfyNq/W
 qfY9llY+VXBQI1OlHIq7E/Aiaj7AaAzvre6aQNKy3cRkPtc1JVkkwlgzJRqjAf6FK6Mqhjm
 JCXi06S5vgoS92enHFZc8Ax9ir5qSBaceTZaA/d99M/G+8No4Jzw5vCgclkZPU2Jk8AbhDz
 sKMLUXw5vwdQBGwz9dJ+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lk0domHyxUo=;FTAQDXoN2Y3qR3dTg65xzNC5ugQ
 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

> The brackets *are* appropriate. The rule of omitting the brackets is for
> *single line* statements. The above return statement is long and there's a
> line break, which means, curly brackets *are* required for visibility reasons.

Would any contributors like to clarify and adjust development documentation accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.0-rc4#n197

Regards,
Markus
