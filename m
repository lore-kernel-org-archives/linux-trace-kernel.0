Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869D1F941;
	Mon, 17 Mar 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251666; cv=none; b=srzVKHa6E/ZIFR4rSpo8JStknjQYNHqjJPCcWsr2vq8Ii2fTdZYDzb0NQQX3Txw+1FSrtT8RzuRCma7Y9xYOMS28y9OVz6DmLLpxPBMA0S+BtmCzprKZg42coAqdOBYRtmIULQy1Eew1I8J60BhY5Z8GXY4MsUdGjkhkQJ6mZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251666; c=relaxed/simple;
	bh=7pGLlYwqFnVH5ubLC9+Fc3grydgjmhWeDX+NIdBHqgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWVdLrIi7RxH8slq1b79RjfCeO47l8Zg/x57vVhPeZyLxYpx9wE9w0cQiipC+3kDDGfWXfc8Sc8JlMnxVnybE+WXTilo9zt6e5XccUp6zVFksm0BGL5aHpmCpTPAop7vd301tGO6Qs5xO8rOE6NuX+AugDyhheXc6ZXGQ+sE64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bgpujGS7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bgpujGS7"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C36341061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742251662; bh=7pGLlYwqFnVH5ubLC9+Fc3grydgjmhWeDX+NIdBHqgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bgpujGS7/KosD742Bb37WalnTCUfFf/mZaNMKB+7f71XB+GbAUbtd96I56/x6Dc/R
	 wROT1/otuKwFGJK0qofdvRf30/AnWF8rybR1SSkRxJyOPIqQbe+YjlTErjVd6bKNRt
	 dr1pwK+IRO4IjIFgew2SKj6QC73Y/7QvoTRbNUxBEZCq8h4QFuV/DVBnhrPEIsfDBN
	 A47eiAEhmB6m8bxznkxPkMt5M4Ar1BWCB1x3CM+Ep15xPTUB7eChieh9tMHefp8ZQu
	 baq0IPLj7R74xWpHLNnx3mbQiE6AQg+nNm4JH5gAlskTVi3s3rGSWiyFUJDMTEnVj+
	 8+1etF4JHFxMQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3C36341061;
	Mon, 17 Mar 2025 22:47:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tomas Glozar <tglozar@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
In-Reply-To: <CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
References: <20250311114936.148012-1-tglozar@redhat.com>
 <20250311114936.148012-5-tglozar@redhat.com> <Z9A1oN_XdMguNgHy@uudg.org>
 <CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
Date: Mon, 17 Mar 2025 16:47:41 -0600
Message-ID: <87cyefe0ky.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tomas Glozar <tglozar@redhat.com> writes:

> =C3=BAt 11. 3. 2025 v 14:07 odes=C3=ADlatel Luis Claudio R. Goncalves
> <lgoncalv@redhat.com> napsal:
>>
>> In the last phrase, s/is/are/. So that "If either... or... are unavailab=
le".
>>
>> Luis
>>
>
> All references I found on this topic say the verb should be singular
> (since both "BPF" and "the osnoise:timerlat_sample tracepoint" are
> singular). Search for "either or subject verb agreement", e.g. [1].
>
> [1] https://www.englishgrammar.org/subjectverb-agreement-2/

I concur with that reasoning, FWIW.

What is the intended path to get this one upstream; should I take it?

Thanks,

jon
