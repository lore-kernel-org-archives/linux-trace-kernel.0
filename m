Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069442C3260;
	Wed, 18 Mar 2026 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865358; cv=none; b=FqTrodEhZOcQOb7agllWbDheuq++xQKAZWWGjJrKKfFuWY783Mtw2VzC1RGpGyluxsEFSavXNprJp5U18Zt6Nul/SZ3ZywnDo5+0NtYaBfRQN1LFUGA/BNKLkLqGr19+FbU0N+EtuU7gIEmbpLDCPIbMuuHAvxGehRU/cC/RZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865358; c=relaxed/simple;
	bh=DEpngH8xjKpDPwdtmABwA56IRnmYIXM6pcFaW56HXKA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=q/0GM1d85cvRx0Nro3B2wBIb3V6IElwM9NJHLR9oibf4iOKyH/9+X1Qo9sVnCSd9OLuozXgKqmbD1tOIr2O4MiMNVvx5KkWUdfhsLRGnTKq1wg8vvTawC2mHKqhKvmHN8eUol09h50b0zav59LG/KK3ZUedLq9J8xQig7rDuk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jYg29Cs3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jYg29Cs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773865353; x=1774470153; i=markus.elfring@web.de;
	bh=F5PkJAMx5t9VqFdkGIbvQj6CbB9ZV2iwFH4oS50QZdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jYg29Cs339wsLu/Xf2ViTF9hrItuBrX35M9dXvh3XXg4ZhHCbx6KMJxH5IMoSkCp
	 OAcI3MgDpjBoyMoo3CPAY2Ll7vLCBQwvvKzlg8IDxBXhfHs0LhfXM4mBM5eQDoIjO
	 3HlsNSIz2QDgUlDrhOM+ukzrlNYFqF/6Ri3VgrendMiHKQj5vfbSMw3aXtd9ThB4P
	 euGWoYnd02uyEeSLcGwd9P0c59ug0HfHF5xKcMHqedz2FAJ/7tV6ZuNjBOVFUo8Au
	 2qobpJfAppgvQEACq6MK3joIIkxiihxrvZV5ycVTfO5LxyrG2MQgn4o+gW7VavgmA
	 BIdkQRtycQxdlXhtjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMzM-1vukU30NeQ-00Ec8F; Wed, 18
 Mar 2026 21:22:33 +0100
Message-ID: <026f4ec4-8436-4fa5-bd69-f194cdf7a93f@web.de>
Date: Wed, 18 Mar 2026 21:22:31 +0100
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
References: <20260318155919.78168-6-objecting@objecting.org>
Subject: Re: [PATCH v8 05/13] lib/bootconfig: drop redundant memset of
 xbc_nodes
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260318155919.78168-6-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nHx38gY65DJOPxeNP5yUqXk+XGXVsq2Y6MLEDwhnJMglBEjehno
 Lv6g3msVXm1XDRPpiXyRm7o5W2eQHPD9OqFiqfw1BB9I+AeQUVoT6a4MEmUwdaZyA/VE/M0
 M+AFdEA9vjtHe/4XflhiimEGHQhIbUz0jIe3sfwKJ0b82VhLrIbgGw4kA8mvpuXUkbGwD2l
 xkkqp/mVd9EgSY1D/UNWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6XEoKy1CyCo=;WbNkUvxtJVHQVyuBj55cR+sNvLn
 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

> memblock_alloc() already returns zeroed memory,

Interesting =E2=80=A6


>                                                 so the explicit memset
> in xbc_init() is redundant. =E2=80=A6

Would you like to reconsider this conclusion for the mentioned function im=
plementation
in more detail?
https://elixir.bootlin.com/linux/v7.0-rc4/source/lib/bootconfig.c#L932-L99=
8

Regards,
Markus
