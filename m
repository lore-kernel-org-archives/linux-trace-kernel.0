Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707575;
	b=YczeE53oYSZzVtWfMfK+theEdlG5xuZBNEnLrAaw/xppN9SkHdiCjH9eYb9IbjDe3DYQ
	 r/vQd1tkKvmEu7oZ6oVlQgssVuS3ADyxsxtv6qbRduhtlh6Qu29m8Y/gUs0Q8qZSeXbwB
	 nLJBPAR7MvA+cuVzTIFCeoPp025P2t1LefT8G83DsWY374xj/l3+HYscyLpJT4VjXVg8+
	 N+OCuvRw13VTZxKxkCVdG2spa9mDBhQjxuEJsT0DSQ46BelrJhqG9xCN3tqD6HcfTfV9a
	 NU3yD3Yz051XUA+qBpENlVw1FSbEmNMCy1K3m1oaNb6tAt84KTD+n9lI8hjtLEZ0iSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
	b=GMZ1FHH8A4OI0T6aGF+/BK8anlZvS15MqdNxKVMas4q0+FV64ngHj2fjMkJMz+IJnbqu
	 kANMZ2TaTgKQRseshrUzgLInoSCoqMkrrlfFPO65BgOu08K6XFR6JEW3Ffbrqsi2G4tn3
	 rcsf3aMMfIcD/Ucozp+ua/bMA0VjNdKtlXb3kUlHHr7atrX4O/auB6cMIb+JTNGGIJuDk
	 4nzjckxdempN0mJThfLob7k3m+XsUYkqEUzQ3g0WG5WUEIX+4XFO/r5zh9r9uv01faVVh
	 kyT+bvw3bJvv3WrwE25uWlrmzVMnC2bNDkQDfqpsGIQbIeGdasMNs/YNi3fniToRKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krssnxES;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E44606A327
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 01:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E44606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krssnxES
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so12945385e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707572; x=1795312372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
        b=krssnxESzo9GaRXDH2qg++cHod8q/wIiofiMVhzU6IM3OLpyAG/Ozby9mU9ASLrBcV
         WU3+jLr5T9C3o4JT0i0nKRudNXDOVRei2ySxN8WhWT6FFXFj2ioddNtAhcn4tGqqi/jR
         K1w8K3GFcprQVHipESSL5qtuDsyG0u1KqIwjABdAk+NWFEVJOtsOOBeEDSab+HeCsETo
         XvXmZ2NczFJNZdBJ+3H1m5zPe2TY8BOAXyv8ukeiqOW4zhwIgLLl3C+9xtc2b/2wQJkh
         SLdhhZ+02lc24gwX5TQ0Y0a/SEnHNlNfODITC2y3BbjZL9gz8l86BRaxv7FuqGRKA5Mf
         k9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707572; x=1795312372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
        b=mBsdTCM22DwY+yr6Zo7x2mT2PVymF6iJi+oIsbSyujqO1HFXeH0bayovX+kAcZSfL2
         tydZqpmE4tw5AmlUIyGrAw41Ps4x8foxvuvP7JxmvgXHfz7te+BAebKQ5Td+1vCfe8s3
         oHP0IhdQ3a3dhnpyylRopwz3aY5nJYnPWmy1KV7niGPESVNi4VYFasw7/OSkW++qNW1p
         2XLCTDtffBYdvqXlaDOfKCKgoQfpV781grmz1Qxwa1BLEZMzNfovVH3Kd9rkfJ2pw68/
         YkN0y7XUqvwp2xjFErtMZn42ujDOka28ehtILftQ86xZhetDaxo9DZWE964oWmgGN7pd
         7Jtw==
X-Forwarded-Encrypted: i=1; AL+hErHYMicG9QvMY4UklaLyByuMmysKbXMfSkFEBc0pq/UdeBV4K2Amox6tQb1uTCnlCdrz5jTsfn6d26ewQhOHzp3+E6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DWhN1j/b8RZStU/XwTWOhomhUXbcScmHKI3AocrUo+LjNBWpu
	gOKdfKm1ZcMKtkh/b8UNhAwe2sol1AWU61tagYn4KOASeFgxsW/DnXSM
X-Gm-Gg: AYBFou0Ee5DaySlJyxhvnLwDraDEh/5mcVGJBGQ67O7QUIMGvTaxVO+C7Y14uKoa+dG
	CJsV2rTlH0K6sKf7knIlwPj2pLqRpI/8VLLXiAAQs5dz2UzfyZS1ehocdpv1SEF0I+xCRJtb4P0
	F6DrII20DPcp2+yIEf7WKhaPZ7chmEl7wihQ53as/kmdtqKCevadko6qhEzfoaWkrVfQSyv8TiQ
	8Amn08IwnajwmypEBVcsxqEPNi/eEp2KorrbvILeP5nG0sOQzNefhVBrkHuEtSQ3YZuYwDPYuGp
	7d7seBLJXpJfH0FSe8DFJnMruxe6wnbDacv7mQJQn4XvXn7JJdG52WaA7U5TkvmHwdbhp/1L+w1
	jG/ohvUL3ajCEAVKB54TIoSpiLZu05/iepAavdWKMTPoep71Abt4Cmpg3/pOYoWnSJDQxriPAPZ
	X+VJxdzlwRNGMf+lkZFXJI1xdyKPjtBnEvSu5Q3HkpI397XinC9RGLHZxHXSB6OROx/TaphDD54
	X6qMhJTMGAyT3q2n3hglv1nL5v5XmcsD1Czra7jYMciAu+nkGNuAl5Eik/BSYSHPT9hTBIe2O8k
	Oa/D+fdgSO4ZsfD/aFvHkKlHrPBNNoZJdpYtNIOhstQLgNdQo4rlHi01az/4CYYGEgkzPhb7eSj
	3MxfdiKIJUtBdjOS32a+XepebDrmJ
X-Received: by 2002:a05:600c:548e:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb5c92cedemr107415355e9.17.1794707572354;
        Sat, 14 Nov 2026 17:52:52 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb679b7e1asm112112405e9.6.2026.11.14.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:52:51 -0800 (PST)
Date: Sun, 15 Nov 2026 01:52:50 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
Message-ID: <avkQctt0CKt3YcsH@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com>
 <avAsy43KVO-7Nm9z@antec>
 <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>

On Fri, Nov 13, 2026 at 10:45:03PM +0530, Sahil wrote:
> On 11/8/26 1:33 PM, Stafford Horne wrote:
> > On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
> > > Tests already exist lib/tests to verify the generic functionality of
> > > KProbes. Add unit tests to verify that KProbes work on instructions
> > > that require simulation in the OpenRISC ISA, and that the corresponding
> > > delay slots are handled correctly.
> > > 
> > > Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> > > ---
> > > Changes v2 -> v3:
> > > - arch/openrisc/kernel/tests/test_kprobes_asm.S:
> > >    - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
> > >    - (test_kprobes_adrp):
> > >      Place function at page-aligned address
> > >      Use PAGE_SIZE macro instead of magic number
> > >      Move value in r13 to r11 before exiting
> > > 
> > > Changes v1 -> v2: New commit
> > > 
> > >   arch/openrisc/Kconfig.debug                   |  30 +++-
> > >   arch/openrisc/kernel/Makefile                 |   1 +
> > >   arch/openrisc/kernel/tests/Makefile           |   3 +
> > >   arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
> > >   arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
> > >   arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
> > >   6 files changed, 273 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/openrisc/kernel/tests/Makefile
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > 
> > > [...]
> > > diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > new file mode 100644
> > > index 000000000000..bc87a5fb00d5
> > > --- /dev/null
> > > +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > @@ -0,0 +1,157 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * KProbes unit tests for OpenRISC
> > > + *
> > > + * Unit tests borrowed liberally from similar work of RISC-V. All
> > > + * original copyrights apply as per the original source declaration.
> > > + */
> > > +
> > > +#include <linux/linkage.h>
> > > +#include <asm/asm.h>
> > > +#include <asm/page.h>
> > > +
> > > +#include "test_kprobes.h"
> > > +
> > > +SYM_FUNC_START(test_kprobes_j)
> > > +test_kprobes_j_addr1:
> > > +	l.addi	r11,r0,0
> > > +	l.j	2f
> > > +	l.nop
> > 
> > Just a tiny comment here about indenting the delay slots.
> 
> Got it, I'll indent this.
> 
> > You could also use the delayslots here, for example:
> > 
> > 	l.j	2f
> > 	 l.addi	r11,r0,0
> 
> I initially thought of that too. But then I thought by keeping l.addi
> before l.j, I would also be able to test this for the case when
> there are no delay slots. I can reshuffle the instructions if that
> test isn't required. Please let me know what your thoughts are.

I don't think it matters either way since these are tests.  But, it would be good
to note that in a comment at the top of the files where you want to maintain
that convention.

However, thinking a bit further that may be hard to enforce down the line just
for a handful of files.  We should assume the kernel code uses delayslots.

-Stafford

> > > +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> > > +	l.addi	r11,r13,0
> > > +	l.jr	r9
> > > +	l.nop
> > > +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> > > +test_kprobes_j_addr2:
> > > +	l.j	1b
> > > +	l.nop
> > > +SYM_FUNC_END(test_kprobes_j)
> > > [...]
> > > -- 
> > > 2.55.0
> > > 
> 
> Regards,
> Sahil
