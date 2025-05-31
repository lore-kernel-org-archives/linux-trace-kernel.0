Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86807260A;
	Sat, 31 May 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748693052; cv=none; b=Ghhyx/EhRWl+nOzbMfoLyo44932mjSMlAf4KgmmU4/edqmGBVvXXvGtT+4o/bZdsKYL1Wdxr9CkYOGDGAwzTH26xLf4bHqrk+QOUL9HA+feB4JFPw6xe7jo4rcmY/HIUzl7sQjnj7qc4XtTzSfjhtKfw3q171BUeUY06RdrC72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748693052; c=relaxed/simple;
	bh=ZqEA3lY58sHUP6hm3TaLzmg215uhz+4IvCjcFgwxtJY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dfKu7okpqwkF8wRzm93ZIsQqVsO4+h4j9JmgCFD5Ve8P3E8MXVqw7rQDNXMXiX2Hq0XLzbBUtGtPXmy9lh7XHbJxtPLcaS7I4CeoXEgCT+rsEKg6Ef0sReAA1q8FiMgYg7rblb8LR8paq2bWeLS8myN3ymE69IQXCekiSoT68SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net; spf=pass smtp.mailfrom=mebeim.net; dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b=eiCQzkLO; arc=none smtp.client-ip=162.0.218.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mebeim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b="eiCQzkLO"
Received: from MTA-05-3.privateemail.com (mta-05.privateemail.com [198.54.127.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4b8dlm2pTQz2xj0;
	Sat, 31 May 2025 07:53:08 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 4b8dlc38sqz3hhVV;
	Sat, 31 May 2025 07:53:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
	t=1748692380; bh=ZqEA3lY58sHUP6hm3TaLzmg215uhz+4IvCjcFgwxtJY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eiCQzkLOYvvS70DtlQVbO/wXbYTrj0ctl3ppfNKdpA+bEm4ZCwuvQe0h9YFWkKXit
	 B7OQF+zim8XVzkUWUqKb3LJMjbN7U1P3OhqL/a0RrpaRwD0mg+XIl/8VrmBQu7MCxp
	 oFY0wTYju1Ay7P7rTpM6BMsamF2GQ8xVFZX7UYHBI7vMsHus8s5Kw6lQRv6XEL868u
	 oPuiKmtc3ecg0lTjEfnREV1XxYcIlXaJaFOJm6d/7btzKKeMas0aK7Ue5Bg0/w6H8l
	 kSdguuoaGjr+xpAQ7wZQzpGvsYA1LLEuIxXUP+FovHDvV1TxZmLmPYGlHZtTsVDnWD
	 QnyFKtx69CORA==
Received: from APP-18 (unknown [10.50.14.242])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Sat, 31 May 2025 07:52:51 -0400 (EDT)
Date: Sat, 31 May 2025 13:52:51 +0200 (CEST)
From: Marco Bonelli <marco@mebeim.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "terrelln@fb.com" <terrelln@fb.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Message-ID: <1552795452.650306.1748692371190@privateemail.com>
In-Reply-To: <960240908.630790.1748641210849@privateemail.com>
References: <960240908.630790.1748641210849@privateemail.com>
Subject: Re: Broken 32-bit riscv debug build with ZSTD and FTRACE
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP

> Steps to reproduce:
> 
>     export ARCH=riscv CROSS_COMPILE=riscv32-linux-
>     make distclean
>     make defconfig
>     make 32-bit.config
>     ./scripts/config \
>         -e DEBUG_KERNEL \
>         -e DEBUG_INFO \
>         -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
>         -d DEBUG_INFO_NONE \
>         -d DEBUG_INFO_REDUCED
>     make olddefconfig
>     make -j vmlinux

Sorry, forgot to add "-e FTRACE" to the steps above. Here it is:

	export ARCH=riscv CROSS_COMPILE=riscv32-linux-
	make distclean
	make defconfig
	make 32-bit.config
	./scripts/config \
		-e DEBUG_KERNEL \
		-e DEBUG_INFO \
		-e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
		-d DEBUG_INFO_NONE \
		-d DEBUG_INFO_REDUCED \
		-e FTRACE
	make olddefconfig
	make -j vmlinux

Everything else still applies.

--
Marco Bonelli
