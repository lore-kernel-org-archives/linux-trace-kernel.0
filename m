Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62142A87;
	Wed,  4 Jun 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045154; cv=none; b=hL8AoYrAjHit090uLNIgrvEUGh5NJywLe4BDPK/+WiqsbCEeSC00QiX4X8ZRCRaaBNHZrA6olHl9TKPo+AAv+JWJWzGRO/GldPHWpUbkEbgS54BLKxxu/ko6n/fPp/w15QUqm3cacwb4Fq/pZnBBSdzx1q546fezF7cF8sWc/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045154; c=relaxed/simple;
	bh=J79gwTBZarVe0RuxSdrktqBoJC5jYm4za3pkIZqUA8w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F/OsAOukoiq96E0PMTeRYfJ3yhXIvjKzWixgZQKrZ1vr93KXjeiUvsehHYXXFuC9+L6JBc6MVQYACbP70u6FF+2/QGuy+wjOHKFm6lxXD9MWOsVWhuTx/zgaWZYS8B8TH/bJZEQnA268nY+NO7O4DYM0caLYp5wV5mmNrgMOYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net; spf=pass smtp.mailfrom=mebeim.net; dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b=gAGNm8sf; arc=none smtp.client-ip=162.0.218.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mebeim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b="gAGNm8sf"
Received: from MTA-07-3.privateemail.com (mta-07.privateemail.com [198.54.127.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4bC8CW49Fzz2xk0;
	Wed,  4 Jun 2025 09:52:23 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4bC8CM4Y08z3hhTq;
	Wed,  4 Jun 2025 09:52:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
	t=1749045135; bh=J79gwTBZarVe0RuxSdrktqBoJC5jYm4za3pkIZqUA8w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gAGNm8sfyCZCVI3cvBf7RX5tqhyDmGogOAEXGIrCUSCP5SgSzND30lWdyj1ucoiAI
	 VYV8MYuA6qUWmAet9oMgPLc3adBB4iQ6xCjHD8xwHIHK+rqlzlPw9yueg4J3mHB8Ut
	 BFYyTqhQhJgBLTq72/Z1EP6L2Pqb9mV+fzew4SQAFQMf6B5GqJUKNwE+B2qaHNExFY
	 vkHdwrdkGJCOLR84zy+RUZOecV89LFRsEgbVgUzuaa8SxuiXo1bfrMSCbPncYpxnMn
	 xree7zyxKjXjX0jETNiYgnyYrLvv8J8M0fK6O3xvFDT418BkT2DUiKzoxYWrC72haZ
	 sV8T7x+CG7MIA==
Received: from APP-18 (unknown [10.50.14.242])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Wed,  4 Jun 2025 09:52:05 -0400 (EDT)
Date: Wed, 4 Jun 2025 15:52:05 +0200 (CEST)
From: Marco Bonelli <marco@mebeim.net>
To: Alexandre Ghiti <alex@ghiti.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "terrelln@fb.com" <terrelln@fb.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Message-ID: <1338988468.1011577.1749045125350@privateemail.com>
In-Reply-To: <c239ee1b-f201-4e7b-80f8-03a7fb02b666@ghiti.fr>
References: <960240908.630790.1748641210849@privateemail.com>
 <1552795452.650306.1748692371190@privateemail.com>
 <c239ee1b-f201-4e7b-80f8-03a7fb02b666@ghiti.fr>
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

> Can you attach your full config?

Here it is: https://pastebin.com/raw/wL2Q38g0 - uploaded to pastebin to
avoid clogging everyone's inbox.

> I unfortunately cannot reproduce this issue locally, I tried on both 
> v6.15 and latest linus master, with gcc 13.1.0 and gcc 14.2.0 . I made 
> sure that I have FTRACE, ZSTD_COMPRESS and DEBUG_INFO enabled.

Are you building on a x86-64 host? Maybe something in my build environment
is relevant (not sure what it could be). I am building on x86-64 Debian 12
with host GCC 12.2.0, target cross GCC 14.2.0 [1]. 

Here is a minimal Dockerfile that reproduces the issue (docker build should
fail on the last command when it gets to MODPOST vmlinux.symvers):

	# docker build --progress=plain .
	FROM debian:12

	ENV DEBIAN_FRONTEND=noninteractive
	RUN apt-get update && \
		apt-get install -y \
			build-essential git make gcc-12 binutils util-linux bc gawk flex \
			bison dwarves tar wget

	WORKDIR /work
	RUN git clone --depth 1 --single-branch --branch v6.15 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	RUN wget 'https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-riscv32-linux.tar.xz'
	RUN tar xf x86_64-gcc-14.2.0-nolibc-riscv32-linux.tar.xz

	WORKDIR /work/linux
	ENV PATH=/work/gcc-14.2.0-nolibc/riscv32-linux/bin:$PATH
	ENV CROSS_COMPILE=riscv32-linux-
	ENV ARCH=riscv
	RUN make distclean && \
		make defconfig && \
		make 32-bit.config && \
		./scripts/config \
			-e DEBUG_KERNEL \
			-e DEBUG_INFO \
			-e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
			-d DEBUG_INFO_NONE \
			-d DEBUG_INFO_REDUCED \
			-e FTRACE && \
		make olddefconfig

	RUN make -j19 vmlinux

Hope this helps. Let me know if you need any additional info or test.

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/x86_64-gcc-14.2.0-nolibc-riscv32-linux.tar.xz

--
Marco Bonelli
