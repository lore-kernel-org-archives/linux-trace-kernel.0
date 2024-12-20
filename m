Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B41993B9;
	Fri, 20 Dec 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714511; cv=none; b=SuVPst4kQz9SCrYhq5g2BIurA5rh6sh/UGIkDXE9N+P930w0H414aI15R3wmC9U36klcjU7IXaVLZnmbXmAwrVbXJMsyBEhX7x+URjjXWfNiXIH4fySYVbEKqvXQ7crb9hdrR7pLfYItN7/2k3HVF6PZ69V44KxLimIzrefber8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714511; c=relaxed/simple;
	bh=uIly6CkNCkoIAWgOBa6M4w05XfXnqJB+csbPujooBoo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oh/2Bf9jpP+BoF9cugY0mUlEDg4Kf7whj1AN0kn+B5o7/oOAgvRj/IM+1OLlUpkCl4nXsJS13X4IKGCTj4O3OYxoquTeeXhsnH9bAkhG8b25zpLk134bxja3KaiwZU7IPsnzOONcDCJEIH6PcffmsY41Z9XI7G5mEFktl2lxVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=F9HOFlCG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="F9HOFlCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734714489; x=1735319289; i=markus.elfring@web.de;
	bh=uIly6CkNCkoIAWgOBa6M4w05XfXnqJB+csbPujooBoo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F9HOFlCGJWhZ9YbMt9jiGtG2bpnzf/UWFgRiByrZBmmKdrKCEy4E0EQhBSusdQE2
	 Izo8tOIORw+IonmhwWTHdt/0yYK45YY33q7/mQzqP2WYzPSJnfX7oxO79k/KwCfHb
	 c8jotU3gisFtvYFDXlYSp1DTG5S5JJgq6a6F7TmRamaySf4d90P/pPYm4DNPnII1t
	 IWfFMow2Y8R2BvNYD3fTRvgKs0MaMtoT67fWVAL+KeyPRPZCiMNm9xVbEp1l7kTem
	 9J6FXO1wxm3N02/4NSf6HBx1MArzGP9YSwafkkh5V9t3OgJcUUkZGUuTL0nCzGS6m
	 mocU0vVKZMV8CIi2Zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14pS-1ta8od1PVC-00zepZ; Fri, 20
 Dec 2024 18:08:09 +0100
Message-ID: <c10682a7-b0a3-47be-ad61-ff94027f2cb0@web.de>
Date: Fri, 20 Dec 2024 18:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241219201346.533876847@goodmis.org>
Subject: Re: [PATCH 12/14] tracing: Switch trace_osnoise.c code over to use
 guard() and __free()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241219201346.533876847@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/TfpFRNCKrCLwkflpMKMkXTejehk0FwrpPuUyFPZL4+Pcth9sHt
 klfDdp9RuDn/VKNL0K9lxGZ8RNvPYd6y2qGwph2+YFCyU3lvdCVqFpFwxG4uQl4MQM/ohIN
 HjAHHfU9xMk8y4uuvgEc1dFxvz1QLy3KJFC0amSGpueUVNE/LsKo+R4BvzvDSCH85B842tq
 3GvQEydtD/Q+ndYnWITOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N0uGar0QZzQ=;eBcbpg4M1Rf6ZZzV59IDj67bMfR
 dhusFXLHUwQ0hPGgVlMOLi+r26iebPPWmWonsSEBZye2iFWAEqZD9PLrbSjWUN+tkJF2zJ5Da
 ISlzd6iPEafGdojuvPb413pUSUBs1a28AkudYZSjj8fsbx8UeXYahGxwf01rdOGOxxgihbA4w
 q8eC77NLIGA/I1mXbf/6Ru8PWZAefiOqj69qckERMlZqFB7IUsBi3doQ0MCXWXA4bKMFURe05
 LIV/feIoms/eW0DP8b/FsPTFwIlRvSO5ABRK8CZvt3SSI29rKZnkD/9C1MSQI46/Ij0L0kRHS
 Dt2IukkHH0Z5ksyuxIFc1165C4ZhJ787ClkzIa4R4pO7CcHLEIHRPfAFfzCpgZZk/ww8DP9vn
 4NKCJs9Skko+olh7rNS632YCUFart2s1XfNx/0i/QktgCinizAvT/1tjK1VEi9nxwziEyKMFs
 1JZ9EJLLQ7vNdg2uJQ0sDVHOyavg3Ul9xCcXD3585vpZG7jkwKGKEjhFQPkvDacbWW+CMHYwU
 +xHXZnZgSek7IY6MTzVO9CjXWDtfVH1y7Zjwldb//rmpbX96o2iqn/spz7XRN8bvp6QByNIgp
 KCTa26k4APaNpkZ5pmIkrktVb/QyU1gfzdcNtJrLWLRUOmhW66StncoLy6fkLuRtcVWANot15
 AUUyNTjNR903zqC9N2e0mk9N5BgJNVUzxMA334u8UvEThNuJ+WqkMtbxhm7M+FBWr1WdmpKRO
 L2Q913iiS/JESbfNeimzDCNJNA7yMSdySgYUJGixYufY1W328tC9TkLNv8YjZsmNzlYYLo04s
 RyVH7/lti1VgR6p80p4wPF89C1h59FVQzr9tTqAEpbJFoZSKocSUgXg4PyMv3SM2W8gyIpW3L
 SeEo1TDP0gZrEZ20yAG9ZO6pfxI8JrDx0uUjM+iMPaoooEwVq2m+GUxerCmTurM9Msy6ogx8X
 n/+Ed12kSSVUIkPXlxjvzADukDPjMIXcBm7lZNNYobHrAQqf6E875oiLwAsOTaoTYki/TnkBg
 QOnz6ojky3clmaMd0gyNhVrvWj+UycRWKdR9ztDl1VOC/oMDq86srnjfuuamQ4dD1OEe4k+B9
 vA+X5msTE=

> The osnoise_hotplug_workfn() grabs two mutexes and cpu_read_lock(). It h=
as
> various gotos to handle unlocking them. Switch them over to guard() and
> let the compiler worry about it.
>
> The osnoise_cpus_read() has a temporary mask_str allocated and there's
> some gotos to make sure it gets freed on error paths. Switch that over t=
o
> __free() to let the compiler worry about it.

I would find it safer and cleaner to separate adjustments for these progra=
mming interfaces.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n81

Regards,
Markus
