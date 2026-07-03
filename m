Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232C31355D;
	Fri,  3 Jul 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104212; cv=none; b=dXX8F4u3GFGJCxaYyhrcwg6M4O5p215zhWHehjd8ruT2YTnriP0+jKsa6rckEfVpcQQxgjBd1z42SMpeQA7nMTGuWj3QKPWbBtJMG4OeQkFGUCePtkebAnrSvp1vX8lbv+zVkWJHltS8ptYsPViJqMQsnnV5VVL1pCObSeT1OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104212; c=relaxed/simple;
	bh=QyVIHr1jiFGG62c6aJCDpdZGdydCYxcdiJ3Byjss7xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSP9OptQx1GoxyPO71S1vbFfz+h1ksY0Hcq78LZ8lqYUxV1ZZNbKSuv+KTWz7HIb5etXM1aLL46f0R4b++NGry0deILBUrr41F/95kIFL+NqcrwGxaSKkMVz/qrT4e6hgmEPY6PuqY572XDGPtV6K1BnqG4cj+OygzZ+2ovffgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oL4P2Co7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oL4P2Co7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783104209; x=1783709009; i=markus.elfring@web.de;
	bh=5zA8L+2uyLRjH4sXvnULGiQcM/W4FgFHaBPpEtuK15k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oL4P2Co7vS75D7G9tL5uuP/zXy2vZDe9q5FeWLFlfiD4ys0ZQDEFCGzVLM0EKyhC
	 yTd+GU1XTZeoRK01NUCbHsIcu7E4bll9wAsEZ66lssVfnOulH+JqN65L+0W91Ej2H
	 ikEBa+HFzTuqALAyAdTcu4g4c1fW9GFytRMVk9UxDacehwVNsrFbSc1PGOSmOqXSE
	 hD7S/Tk/wMxO77dJstH3K2G4dp5SeaFWxEyNodJzSEGODnvMnh6dpmTh2WtZ/+qC8
	 DYeiYMsTFHtUE5qBhp6xtROtn4MukXVEm0ay6qMUWyb13W/FLSDwySowYmmVYjtum
	 9RyGrXMGJqKSHpalig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1xI6mB0jWd-00hLN5; Fri, 03
 Jul 2026 20:37:12 +0200
Message-ID: <360ba00d-352b-4fc1-9bfc-56d29b317f61@web.de>
Date: Fri, 3 Jul 2026 20:37:09 +0200
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260701174829.67ab8a33@gandalf.local.home>
 <79106214-b341-46ab-8810-a206ce8fad29@web.de>
 <20260702165346.035f8eef@gandalf.local.home>
 <d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
 <20260703114233.56f0c864@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260703114233.56f0c864@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GahtyZZpf6HSvwdGrU/znG2b8hc6IKowXss4+nW+0Lc49yslfz9
 /wjXGhx1JEBfr7ZzYA58x97WW2qc3uXzaEM2KIMDP3JP0eloRDradasSMckmtFkmtYNr2N6
 aur5pzlflKOb5IqdKhyoS++03WvGOhFZh/SPygIkLw6Kp6oWgy7+vpMDoqkwG3xcAihk7cW
 benu4p5OGg0M0FHxMzM0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OmvNMkqDRMs=;cY4nQjrIZboppzRDp895+fCT5Qi
 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
 jIzm3g==

>>  * Given that the "__free(...) =3D NULL" pattern for variables defined =
at
>>  * the top of the function poses this potential interdependency problem
>>  * the recommendation is to always define and assign variables in one
>>  * statement and not group variable definitions at the top of the
>>  * function when __free() is used.
>=20
> This is really just a guideline.
Do any contributors care a bit more for involved technical details?
https://lore.kernel.org/arm-scmi/20251208020907.5476-4-krzysztof.kozlowski=
@oss.qualcomm.com/

Regards,
Markus
