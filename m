Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795844194;
	b=1LE2vJ2VJiwwGUA8esv3xJRa+me1ryUgC9BTosTG9Mwdq6E1jYD0vvyM+UOSQMeAtRFN
	 12KpYFKewdBZ9UfLwJzmDGajIlo8SpDz2S9FN4JS/etrd4Ki7p6j8RR6AIHNlwFhnETse
	 E78Qm6O1wgvUbWcO3k5Trj99WQPvk4wxAsqYrtjndAjijbVua51LoSst1ZXJ6FE7T0J32
	 nnsoKBdJloJbJHi3ZL+Ip8tK9LDwCtuOYfmFWZ/3Cu9ILTj0qWp/Fo7YsISLdcjw+Gic+
	 XNkpfO2UDBkEJlsYr3vC9AyddV12Z+32N5CTUAAK0Q0e7SF3z6+T+aisHkCMMcBjFQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795844194;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=RMYHGY6d6gHBvlKyo+gYuBlX2+YK0xRmMlJIq1Gx00c=;
	b=eoLllRSU4w1xV7Jt4v6WrWZjj7JhgmX1TzEVb0OlHWBCv4i5gdXghfb5XTQ19ejjjYYZ
	 0S+oLPzSTvBydgyQ8SrdRSIk33SXNlgN2ePgWA8mFLvv7EDVH6LmWj6ZPKHDhQXD+wvKD
	 3E6nLZJspcgE/2eqOpJZcQqRPNMEUfJuWv/M2VveAa4jfGza1+jcHvwDt4aIVcg1QOsLF
	 xA5eoJz0m0zVudZwCpb2/KGT1mnn9UkMVW3DcR6HwPJlozKbpiDmFCZqPwTLLXXbfVBjx
	 EZlNDUep8g4e1Fc1CK9rwkuEbJX9Q75pJoZrbaTFQFz9YQsKe/263Q14wny5ZrLFK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="GGt/CsIh";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AF606A31C;
	Sat, 28 Nov 2026 05:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GGt/CsIh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=RMYHGY6d6gHBvlKyo+gYuBlX2+YK0xRmMlJIq1Gx00c=;
	b=GGt/CsIhjA8rmBBfHqb/d+uzDvwrwOO3gEgrjZTsh2nqXjCnRCBvpPOIHZefio
	8nm5VkzXBZZzGCOBro14WVPLTAtaX34bvdgYRZEvhRFSJNsCNyThqGQXr7uMJR9y
	tNX1OjXOSz5sLcbWkdL3AhuWVIYXegSuS7+RmasXCSHew=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: reject -e, --filter and --trigger without --trace
Date: Sat, 28 Nov 2026 13:30:20 +0800
Message-ID: <1795843820.20995.223872494152340@163.com>
In-Reply-To: <CAP4=nvS-iHK1aFiwvdLtSf4sCYcfFvqj6cKjkSb0eJs-O=qfmw@mail.gmail.com>
References: <179360289114.124676.5863600854966859222@163.com> <CAP4=nvS-iHK1aFiwvdLtSf4sCYcfFvqj6cKjkSb0eJs-O=qfmw@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P09DaAprnljSKw--.19110S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RANVkDUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wSI-WsKaESx2AAA32

No, and the compatibility argument settles it.  common_options.txt already
says the option is only active with -t/-a, so the silent no-op I objected to
is documented behaviour, and rejecting the combination would break
invocations that always pass -e and only add -t when they want a trace.

I am withdrawing the patch; there will be no v2.

Thanks,
Chaosheng

