Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F03D3D09;
	Wed, 18 Mar 2026 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864504; cv=none; b=TEWQuYwtesNzKerq0OfZTTW7hgxPliwEMKN3OcM0I0hiVt6Ai69AuniqzNbRWnhH2lFa8UbI+tmw2hYAQF0CpXO8f7OTHdIlTi7hC1pW6twmYNT7Kc7iG8iD8cvdiAwLRhJxEV+bYyCs5O40tIwERTicFCFa4xTr9L7cQ/fRvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864504; c=relaxed/simple;
	bh=PZzrj0NKAjigqh0F1Dn//kHvLRjAs1fgY1mPBH8JzTo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aC7CCqeKNKXM3No1mV4wGSLzYEd0Qf2od3vt1glRUr4PoVt4zmEFw8EKmGBz3NghL/Goia2PPHTZNnwsdH2oEE2n8TsWlyaA7Wg0lKdss7WPOgfG62lHtOIoMv7CDaE9MyKVykplUrpqk/dUbBzlZJSlXQzYmSLcpidn/2UeycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kb0YbX8A; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kb0YbX8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773864500; x=1774469300; i=markus.elfring@web.de;
	bh=PZzrj0NKAjigqh0F1Dn//kHvLRjAs1fgY1mPBH8JzTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kb0YbX8AM+nCLnKI6VMvTT3lFeOGGBCDg6ocmAGa1Kc31SewNF2ILzrBzOApaWnn
	 Gki4/xAkt5/hvLU1qZPrKesJ0YdkJ7TAeEgrPD5kFAutS66BdXtJA/jdOLCcPikYg
	 ld7OEnnNiv7HfLLZei/XBaJGQ/nxKZbgp7whK4NRew9bwEuhMEr73CuA4e9l1k564
	 dc2CV4Ns4PWG0idGqtiiuE5TJ/0i4f1FeaQKqiXsBLJBwO+Tm7OqMMqx+y7fBkv1J
	 1PfPTkyMlKkIDQ3EUi9NAZFnjKmhrBjXh025siZxuTWTCUWzwXtFo9+vhOXzrag3J
	 GDCFgzaYsfmMOxkVjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LsH-1vZmSX2NAp-016Rmg; Wed, 18
 Mar 2026 21:02:50 +0100
Message-ID: <72b44223-5c7d-474b-ad98-adab69700ec9@web.de>
Date: Wed, 18 Mar 2026 21:02:48 +0100
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
References: <20260318155847.78065-3-objecting@objecting.org>
Subject: Re: [PATCH v8 2/2] tools/bootconfig: fix fd leak in load_xbc_file()
 on fstat failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260318155847.78065-3-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0R1zchZFIDORISsMLvcN+dqpj9RiLIu2/KRzsUiTeya+HqHr9e1
 EDujlwFe0LKwGjmkJFFpvgDQB7llK0zQa7UmX7IIOqYY8xmemJ6mauOjPTZB4DgtmiR0Mn8
 If04MlDzxwfetXqJ17fJD8VM5KkLPAkJ/tQUMeYN6iKm8CR3cQaebh9v9jhEP3aD1cj1c0i
 UnS8xPfjP63yIprJldkYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v1ptT8imtb0=;3BAjaXeNzFyJdveI8xRk9uLtr/5
 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

> If fstat() fails after open() succeeds, the function returns without
> closing the file descriptor. Also preserve errno across close(), since
> close() may overwrite it before the error is returned.

I find such a change description improvable.

Did anything hinder to use a corresponding goto chain?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.0-rc4#n526
https://elixir.bootlin.com/linux/v7.0-rc4/source/tools/bootconfig/main.c#L155-L173

Regards,
Markus
