Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com [198.54.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215DBA38;
	Fri,  6 Jun 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238968; cv=none; b=MW795NyJdH/18m8t/pMgrGrFFClkEa1Cb3OXAZ+v918W00drUBz4ISJIK6nq/7fYRlJge8rrL4jGhkrNlqlnDC9m1b9EhIpcGVFKOyHKK2PTe3ScqlnF3uzF8wsJQgIS0/6FTeOjZJ51HNIjDqbodFJ31hhl3g1XLAvhEtZuK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238968; c=relaxed/simple;
	bh=f/ZG7FzFsllKeCY4kWY41SHT1xEBrgdADFi7P3Tq+Y8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FHr7mt4huwj5gWiZ4VZ63EWFDoC3TGCN++L2DlLSEJ44BIZEuRuuPZG03cr3Og3Rb3EHKzTxpfIJDydaCSU1a2HdKwsCwMv+/AY042868sE63mEQZbumBIjd8HKw9nWy0kv2Sau5dGz/K/KnkDOkwBsBrBtwtV9C4KcX1YkjkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net; spf=pass smtp.mailfrom=mebeim.net; dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b=B9TYwjG8; arc=none smtp.client-ip=198.54.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mebeim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mebeim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mebeim.net header.i=@mebeim.net header.b="B9TYwjG8"
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
	by mta-13.privateemail.com (Postfix) with ESMTP id 4bDWtk1fWVz3hhhd;
	Fri,  6 Jun 2025 15:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
	t=1749238958; bh=f/ZG7FzFsllKeCY4kWY41SHT1xEBrgdADFi7P3Tq+Y8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B9TYwjG8CE3vwgX0/Lz90Hrtrhq9bCeXEavuCbkZ9jmcnkF9k9Y1am6Dir+rDCnUD
	 qxVkI9Fac5CpADN6kGrSxYdoU97UE2Ptx/8ubWWKj3ZdvBiDsQDQCNQw6xsAQDjUBD
	 tzuLmKwxVrZmvqyygCyvGAYRTzzVqJoiW5Af/VjmgewD8+PPpiHmpOyCZFFNL2SSrS
	 kl/LYS8qiOpixS+ScjVPIiL1H9cFl6VXa+w+X+ajJ71fthhOWcJh8KYRAGtD3XxNV/
	 7tStNop7MJQnxMg6qmRGpZl2GMqpqluKZOkJngalKlwcu35YmRt5LXa5Hdt41B98on
	 cLbzOrqlrwTSg==
Received: from APP-18 (unknown [10.50.14.242])
	by mta-13.privateemail.com (Postfix) with ESMTPA;
	Fri,  6 Jun 2025 15:42:27 -0400 (EDT)
Date: Fri, 6 Jun 2025 21:42:27 +0200 (CEST)
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
Message-ID: <191074362.1248877.1749238947947@privateemail.com>
In-Reply-To: <1338988468.1011577.1749045125350@privateemail.com>
References: <960240908.630790.1748641210849@privateemail.com>
 <1552795452.650306.1748692371190@privateemail.com>
 <c239ee1b-f201-4e7b-80f8-03a7fb02b666@ghiti.fr>
 <1338988468.1011577.1749045125350@privateemail.com>
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

I was able to also reproduce without ZSTD (i.e. both ZSTD_COMPRESS=n
and ZSTD_DECOMPRESS=n) like this:

	export ARCH=riscv CROSS_COMPILE=riscv32-linux-
	make distclean
	make defconfig
	make 32-bit.config
	./scripts/config \
		-e FTRACE \
		-e CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
		-d RD_ZSTD \
		-d SECURITY_APPARMOR_INTROSPECT_POLICY \
		-d BTRFS_FS
	make olddefconfig
	make -j vmlinux

Did another bisect run between v6.14 and v6.15 with the above commands
in a bash script and got:

	494e7fe591bf834d57c6607cdc26ab8873708aa7 Merge tag 'bpf_res_spin_lock' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next

This leaves me more puzzled than before honestly. Not sure whether it is
a real bug or a problem on my end at this point? The fact that I can repro
in a Docker makes me think of the former, but the fact that I was able to
bisect it down to two different commits depending on ZSTD vs no ZSTD is
weird.

Alex (or anyone else really): are you able to reproduce with my Dockerfile
or config I provided in my last mail by any chance?

--
Marco Bonelli
