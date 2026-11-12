Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794511809;
	b=JLtuio20yhlN6zHu8Xzjbdx+Hv0j+jwdsZb0qQac1ycSnbtR8zo5fjWhDjornhyx4dcT
	 lob5M7t/TJmc0kPdEChMKjPj50Wp2fzrlpjcEX00nkPK+6zzEe+IAfbj6ueqgci8d0Nz3
	 JLX9YFLZD2BH1Kxs9fUFkG2a5mvo9UoI2bH4cmu8UkPTaJzCEzP9r41Ih3F11UD6pAOP3
	 oIZfn9CkoALX7vpf289btFxk0+4HSadNGmH471FyNOtzqgf3ThfJnESaf16mnV6fPA0UL
	 fhtwwS6BBgWsLXJNAEI8xWQUjE8ZGlGiCrdZ2cWCeHRS+mgRfeDLlPrSlfh0PogsiqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
	b=wQTSp2iAMUxeswR2bzFt3WA8ChHgfk8v1rgf/Hyncmg3i+/aCGnu2uiTB/Q8OPuuFANq
	 /riVoUJMPaBXwsJpiI+dri8OiTRhtjXdVyo4C0mjFKoofVqWeRUqAolSdhsi7/7BK4CA0
	 Eo1ta6c0tfyXUuT4TGbLstMG8tWFBukStLNtASfbRRFJy1Le+zXp34YHWJdGeVE7sEm1/
	 GicAtl+ZWN5sdZeWJ+484gi1VwDuYC4CuZ/QsiO+JumkIL8UWHuQ/iCbZFDHYa/qZVwsK
	 jtZ2c6za9/esGUtJHcW2WFASB2DtylgGWlGHqvOIFlQ/A5N0kR3WbGOKjycenoyupug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=rKO8AWay;
	arc=fail smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26427606A884
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 19:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26427606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=rKO8AWay
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89d3a4c9fe6so19274b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 11:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511808; cv=none;
        d=google.com; s=arc-20260327;
        b=DktIHhd4byCukyUcuGSGf8ghTS+Oe7d7ME9KulzfOXicmA5nCPbvr7lySDxULZyXQ7
         Hx6dov0EwwVYPub4uwEeE7mowlgAmotOtWPWsEDjiwZZQCThZXFuUUvD+QRt+qCLdxQB
         BwnbXZTUwUqh2ZvRnbCaZufqDY339v43aA6bGSBhIr+g2uetRmqkFDnwTHyTw0sOWFnb
         vXASysLhe6n+wNzVMaewMwJzjf9P4J3A6aqlda0NnsvuRquhCjpGeo9r+duohU1A3Oza
         RVSdj24/+Uc1fDOj3JymBMGvspBFwuZG5WIf0D0JJhz8kBvSLjH9DBnY96NEM6VFkgqP
         xaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        fh=VAlzcp+U3Kg/kx3LwTpGHSb6eBLhiBex3durKHo8blY=;
        b=fMjqjemu4lr0LmDKSRrsO9fKJ5q9arFGrvOXfDnw1wdtv9GvK4DlkfTi5rFe6iUZDL
         r6U/TIY/XjCO2PWdZP3F/pbi7Ph1ZerBWDgP/K6VH+yJUoc1g0caMa9YDu3vt2ec+9+k
         q8EMXo2Xmg8TwU9N7OWDaA1srJnzGz9fCtBVzvOY5a6eH3RnfBN1jcrdwRLFMCp/FUcf
         xZxFZXGLbfEb23IOhoEeRiGcwCeyEfdTagPMLspPv2S1RlRooMJEhc7BBP8ESXW/+k23
         QUUdNs9CfZk4bjzsPtNvAkknuW8ExQ/EX5jkxhr/5i68arGGnUKtbeInu12NfgLskRyK
         APpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794511808; x=1795116608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        b=rKO8AWayB+bZ8jG8zMMhbLMXHR8XzxlJO+5tmgHNbwAYW1D3i9CKl52JuvrAf8o/qC
         yNYDUMDiVTMcYsV6uxs0FSLy/ZSMGdoyQUZHREhCBNJ2ocNg6OjMJIZDsd+6tkV6OG8l
         Py0qF6INBfeW1uYrA/v+HcEa28dSpm6yW62XcU+SkvKs5a6NmAOChnPv34lmZXTg7B/1
         1XBJL/4DfPNyi68pi1mFDUOtIxjVQjUOx7gwsYzj6F+ydaZ6DTOclMVsesr9Nnpestxz
         k7c5m238p6wDTmMgs3KR3emyHg9Z/eiU03PJkFXgpkNzGdXfQ735t7q6TjmVg06k1lcq
         pTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511808; x=1795116608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        b=rZUuvO+T466A+cqfryHVI7i++F6AMdO+u7UHNvYJf7pmCB0iIFJD5gv+kZFeJAmwDR
         gbWPWuze7i4cJRhFTpZsuXosif55C/m2jMVN7xCJ6hPer41S8GEj2V1XVl9tR8zcC7ie
         w5w7oFVRizgO7MZ+3yR9tI7NAOpqg7GM/TU1O1Q2xNRnTqQjNMGOyC7fPNM/9gFRca/l
         vQaabGlBa/Jy6FCBDot0lsb0Aq6THNgA62rK9+sTXjLjgpIsxm4ViVR02NJ680+lBhKX
         zppyQAenqwsqtwSJAvHsy5DdFaqg2j8/0cpbZOFrQ0b9JKg9T35dQWyMy0ybftOUDDHQ
         QtzA==
X-Forwarded-Encrypted: i=1; AL+hErHFzANPNpyoXjsVq/yU4uE39vnJH1lNji6UX04DYWIZ0iApSN7KjtrUs4DqL8tHvVt7xV+POgYnMdA5qF2VrVjqjxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WO6fG7dcbjuttsdQOF6JgoRB8D7OzH0pBKAxAFYc1ra+tgG31
	QKk5jSo8XCPqwNpa4/cznGUwVGvXBCp5Zk1qgqzXUY/RXjYFiwKuWsY/rAyJHOo1Elxxq/iSDs5
	XH8/G5QPsSgVSRHYynAwOifTTupQxXQ2KjUkL2gkNgg==
X-Gm-Gg: AYBFou23q5aOhyCDo4YTJeWzLLRo28upoXAKaXk4x+oz7ZO7jkmsE8PPWfbMAkr+U8v
	hD/zt8vtidZV/2OrHwdvQRg7YUb5ukIAgsCZkMCIAW9lDEKAPPfyymkP0Bs0N+RUEfC+PuTIBwi
	wQ5z8fM5H4LRyx7k0bCv29e6zxHBgPnuK/E4cY7Wvx15TmsArxCaHbP5UycmTMy9HxqDR4vLI2K
	nhi/sVYXGosAY7ZE2NF22uxbUGmEirb+C1IZPUeoVswz1LNIDWG58eddAyPa9ruZK2jCa1nxtNx
	qYq6GvgDeOVUEGei7Wd8XHg/IlufXXiQ3nkrPKP+OQQt23olJDLA4yQqh5X7l0DEfeGdAh8N/ld
	gSbGoO+XIqKtSjOq7VNiIECDb01ouzD6IkuGl4CidekFgcODWiBMlu0I=
X-Received: by 2002:a05:6300:6d94:20b0:3e2:86b6:9c03 with SMTP id
 adf61e73a8af0-3f7a71a6831mr168905637.2.1794511808209; Thu, 12 Nov 2026
 11:30:08 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
 <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com> <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
In-Reply-To: <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 12 Nov 2026 21:30:12 +0200
X-Gm-Features: AclHuK_9VqK3YuMSfLM4sy6-SrFdHB6b2EbD_ZgdfLZ2b3zUmDfAu99epYN-nG4
Message-ID: <CAPnbwjopkQo2vp07xyPyk+bMYVbCNy3+y_sU_Ot4B6GhHcwuAw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v2 2/5] bpf: Check program
 recursion per task via bpf_ctx
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is an existing bug. Today it takes two or more progs.
> With this patch A, B and C can be in one prog.
> Doesn't hold the series, but I had to mention.

Thanks. I will note in the commit message that the series makes this
reachable with a single program.

> I don't think we will be sending them to stable soon.
> This is a big behavior change.
> Backports only after next merge window.

Understood.

Thanks,
Mike
