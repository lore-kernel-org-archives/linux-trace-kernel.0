Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125006;
	b=zNG7KHM+V1FkXGCx7cj1PQmBqD8Nf0NWKldIsxy/jw9gSaEU3dXoxOvtPCl77gTNn9q4
	 V2AlzNiwmjbUEfvrPn3UNJnIfHZlMn2u1ekjqZRZEXp5ncvFKvSJXKLBWDZMCCo3bAG6R
	 EViWGT7A+AvFgIT9GgjhKIgn/CSJotT8jddZERTh4yOA5sx1P8h+H0aCVl7nNTmUecRGl
	 XdHJB9Nml11dsZmaMK36aryPGDXaJm5xBXKWqDmD5xYwOWm0Ob0kkAL3lW7vVnRkEvvWo
	 kWIXgvuTve/j83f8EHNjyh7eaYje4LS+S/mn57H14Lw9ac6TCIeGNQr0wReYwjUzBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fAj+PQF4DhPbJju2nUJ6sKmnMGHnLxMygMvekucBWDU=;
	b=Cp3aeDNBZaNJa7lswJkW7D5Hipq02yR1tt760ohP2uQ+Xm6A+3/R5hfR+9IzfX7J+2j7
	 Ln5JmK6vaTLl1tWL62znO4w9yy1vgYPdTSZfuoYQFWfDbsatA9NyukOzmSPAYcY7ti7dO
	 VyDL16bAkdyeKmtmLRDsz24Co61bBLAfF56Mf1BGH76AbBlJpLr1R8qnVckeS+ic5grxB
	 vOZI0nqt2omGMU494OI8aVahzr31MkMLL8V7rGQ8NtENEqNlG4ln8imL5uZr6kum79xK2
	 vOVAMPv0fgVcB7vk9BCHd9XZ7gfVLlahVqjLZhsWUGX0vf9tq84lSbWp3MJI9ZpxcNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoJBR1qm;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B1606A321
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 08:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D0B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoJBR1qm
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c1d337d8so129787f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Nov 2026 00:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794125005; x=1794729805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fAj+PQF4DhPbJju2nUJ6sKmnMGHnLxMygMvekucBWDU=;
        b=QoJBR1qmsTIXxmUvFfSgDo/VGHz66Y7zMDG4SH/unkeBlqtj7QK2SpMo155KfrclQ1
         O18rX8xaz61cwZKiscvVT5PqZJTfAZ4ENVmcEiMXq5SUC3SFmIbbGjha50mtveZUAZ25
         YDc2uMmjNIzvhpnoULYHe0LlCHM75DEgQuu3zdgWuMcKVyqU6dwVNfOW7qzVxq6iys8D
         gIWDhTlXdAfTFAavmrhSwDLgyajZ/hMuvzIHX63WCsFXmJrf9WHv3HaRWAaUYP2BAIE9
         ukKFigrE1eusPO6+o/m+i2Dradr3AZzOesu8Yq1WHG8ylKfrdD1nrTrmC8GBS6O9TXuM
         8qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794125005; x=1794729805;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAj+PQF4DhPbJju2nUJ6sKmnMGHnLxMygMvekucBWDU=;
        b=yk/FjVBSCW4SB0joLs7i4ELBFOcjurw571ZfQ84HyRjttqAtFkB8JBvT31ql3Dp7Va
         dqTRWaqSF6jawG9p0qlVSKkgDGYOk0PLlxbC/OFA0kSw8I+IJbq/jl5nrt0/FuFiEbfU
         x+OG2BCU4aTKVA2O9MIvZ8VCdC5XqB+bnQlDBeKmze++Q3e1RfvV8ONuLAlS883cwMyP
         34BL0Kv5LrlSSXLGiuBizpzTV0Bn2F1fYkPm1OAa/SwfVNru30cSNKBbfkBQ4NDuPoz9
         9z7/r9CoO6OsaLndsFL53UE9OZaYAt9xCy46VyhsL25eJrRxDPwJpFtUpBnsvM1I4Yo2
         0h5Q==
X-Forwarded-Encrypted: i=1; AL+hErG8GjNqusunNNtJwbekta+HQePVT/7FjtQT3Gf08ngt+mPvL1WWh9lvUaor1St2618ynv6IhwtZsh79Uo+lHNItV+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LEWcgVoeqzAMani1rtgND2lywQCCNpGdmgzn8tmj35kqhgeEu
	DxYSbqKmZwY2Xg1G9gIIMmlFQLS1KxjDt/tK9yTf/MolS3VgOg099VuV
X-Gm-Gg: AYBFou3UY3Gv2m6EC8+pXdOS9dtmOrdvkrVh+CXSke8+GPtk7pDx9cIxx23dMxA116U
	BhqD3+2e+/Ugdwf2cb2XOedhIj7p8FD+HEV7FpqzKZhxUT/j8hY4FoEBBYR7UiCkHiDF5jeWEB6
	UdSfdDF3EjkZaofm5mXkKZvHehPGBSQahlkfFbQrMZMfPRiO2zm5O2V/lrSLtfg/ez5l48DWbX3
	r6AD9HbYS9ndGKxHQHt00OkQl4nsqpSp9GorLfTTUseYLgc1T5uBRoMhAAqVLdBIaTz7SXC3Bsn
	Ni3WesAUVJ1ETbGNHhiD2tJa2aWdSEJSdQRQ90SdN/hJB/2O9Zf7NfjBsHUN90PJWWwXwQwOhnE
	u8Bpu6WRw5YQ5nNrexboskCVqr+LoNP2Xa9Vjd2Voqdrn5nT/xQqxooXlafIRPFdzTvCYzUoAng
	OFxH0p5Vq01hYdV4Rp4vduPB/QlcZl0sZQPP3GBVBxvge6cFS3xLrEY173CZN/K9Gi54uIfDUQq
	wzDIhqSjXKfGPZfa+dmCvitsUCZw+9i5BGp+y16vEqPVU358Dgj/nb8s3yeNd/F4U67vUgV6TpG
	LEJnk8kyznxLvrB/En9CxQDY3r+PUirP8glTYCLzT+eZI9Jp/Niz2nJnWyVelrKHlURBIkPZBds
	g6RuDRw==
X-Received: by 2002:adf:e199:0:b0:48e:84e8:88c3 with SMTP id ffacd0b85a97d-49580830930mr1444729f8f.5.1794125004381;
        Sun, 08 Nov 2026 00:03:24 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597e00d75sm2560903f8f.58.2026.11.08.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:03:23 -0800 (PST)
Date: Sun, 8 Nov 2026 08:03:23 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
Message-ID: <avAsy43KVO-7Nm9z@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com>
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
In-Reply-To: <20261026201240.107462-4-sahilcdq0@gmail.com>

On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
> Tests already exist lib/tests to verify the generic functionality of
> KProbes. Add unit tests to verify that KProbes work on instructions
> that require simulation in the OpenRISC ISA, and that the corresponding
> delay slots are handled correctly.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> ---
> Changes v2 -> v3:
> - arch/openrisc/kernel/tests/test_kprobes_asm.S:
>   - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
>   - (test_kprobes_adrp):
>     Place function at page-aligned address
>     Use PAGE_SIZE macro instead of magic number
>     Move value in r13 to r11 before exiting
> 
> Changes v1 -> v2: New commit
> 
>  arch/openrisc/Kconfig.debug                   |  30 +++-
>  arch/openrisc/kernel/Makefile                 |   1 +
>  arch/openrisc/kernel/tests/Makefile           |   3 +
>  arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
>  arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
>  arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
>  6 files changed, 273 insertions(+), 1 deletion(-)
>  create mode 100644 arch/openrisc/kernel/tests/Makefile
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
> 
> diff --git a/arch/openrisc/Kconfig.debug b/arch/openrisc/Kconfig.debug
> index 295942fe3fd5..54110f3a111f 100644
> --- a/arch/openrisc/Kconfig.debug
> +++ b/arch/openrisc/Kconfig.debug
> @@ -1,2 +1,30 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -# dummy file, do not delete
> +menu "openrisc Testing"
> +
> +menuconfig RUNTIME_KERNEL_TESTING_MENU
> +    bool "openrisc kernel runtime testing"
> +    default y
> +    help
> +      Enable openrisc kernel runtime testing. With this option, one can
> +      build and run tests to verify the correctness of relevant components
> +      in the kernel at runtime.
> +
> +if RUNTIME_KERNEL_TESTING_MENU
> +
> +config OR_KPROBES_KUNIT
> +    tristate "KUnit test for kprobes on openrisc"
> +    depends on KUNIT
> +    depends on KPROBES
> +    default KUNIT_ALL_TESTS
> +    help
> +      Enable testing of KProbes in OpenRISC for instructions that
> +      require simulation. When further changes related to probes or
> +      tracing are added to OpenRISC's port, these tests can help
> +      verify that instruction simulation and processing of delay slots
> +      continue to work as expected.
> +
> +      If unsure, say N
> +
> +endif # RUNTIME_KERNEL_TESTING_MENU
> +
> +endmenu # "openrisc Testing"
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 2ac824867963..0c1cade09e0c 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_OF)		+= prom.o
>  obj-$(CONFIG_KPROBES)		+= kprobes.o
> +obj-$(CONFIG_OR_KPROBES_KUNIT)	+= tests/
>  obj-y	+= patching.o
>  
>  clean:
> diff --git a/arch/openrisc/kernel/tests/Makefile b/arch/openrisc/kernel/tests/Makefile
> new file mode 100644
> index 000000000000..9e9693fd3550
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_OR_KPROBES_KUNIT)	+= openrisc_test_kprobes.o
> +
> +openrisc_test_kprobes-objs := test_kprobes.o test_kprobes_asm.o
> diff --git a/arch/openrisc/kernel/tests/test_kprobes.c b/arch/openrisc/kernel/tests/test_kprobes.c
> new file mode 100644
> index 000000000000..a41bdec662e1
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/test_kprobes.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * KProbe unit tests for OpenRISC
> + *
> + * Unit tests borrowed liberally from similar work of RISC-V. All
> + * original copyrights apply as per the original source declaration.
> + */
> +
> +// #include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <kunit/test.h>
> +#include "test_kprobes.h"
> +
> +static void test_kprobe_openrisc(struct kunit *test)
> +{
> +	unsigned int num_kprobe = 0;
> +	unsigned long (*func)(void);
> +	struct kprobe *kp;
> +	int i;
> +
> +	while (test_kprobes_addresses[num_kprobe])
> +		num_kprobe++;
> +
> +	kp = kcalloc(num_kprobe, sizeof(struct kprobe), GFP_KERNEL);
> +	KUNIT_EXPECT_TRUE(test, kp);
> +	if (!kp)
> +		return;
> +
> +	for (i = 0; i < num_kprobe; ++i) {
> +		kp[i].addr = test_kprobes_addresses[i];
> +		KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp[i]));
> +	}
> +
> +	for (i = 0;; ++i) {
> +		func = test_kprobes_functions[i];
> +		if (!func)
> +			break;
> +		KUNIT_EXPECT_EQ_MSG(test, KPROBE_TEST_MAGIC, func(), "function %d broken", i);
> +	}
> +
> +	for (i = 0; i < num_kprobe; ++i)
> +		unregister_kprobe(&kp[i]);
> +	kfree(kp);
> +}
> +
> +static struct kunit_case kprobes_testcases[] = {
> +	KUNIT_CASE(test_kprobe_openrisc),
> +	{}
> +};
> +
> +static struct kunit_suite kprobes_test_suite = {
> +	.name = "kprobes_openrisc",
> +	.test_cases = kprobes_testcases,
> +};
> +
> +kunit_test_suites(&kprobes_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit test for OpenRISC KProbes");
> diff --git a/arch/openrisc/kernel/tests/test_kprobes.h b/arch/openrisc/kernel/tests/test_kprobes.h
> new file mode 100644
> index 000000000000..26c26920d430
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/test_kprobes.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Unit tests borrowed liberally from similar work of RISC-V. All
> + * original copyrights apply as per the original source declaration.
> + */
> +
> +#ifndef TEST_KPROBES_H
> +#define TEST_KPROBES_H
> +
> +#define KPROBE_TEST_MAGIC          0xDEADC0DE
> +#define KPROBE_TEST_MAGIC_LOWER    0x0000C0DE
> +#define KPROBE_TEST_MAGIC_UPPER    0x0000DEAD
> +
> +#ifndef __ASSEMBLER__
> +
> +/* array of addresses to install kprobes */
> +extern void *test_kprobes_addresses[];
> +
> +/* array of functions that return KPROBE_TEST_MAGIC */
> +extern unsigned long (*test_kprobes_functions[])(void);
> +
> +#endif /* __ASSEMBLER__ */
> +
> +#endif /* TEST_KPROBES_H */
> diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> new file mode 100644
> index 000000000000..bc87a5fb00d5
> --- /dev/null
> +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> @@ -0,0 +1,157 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * KProbes unit tests for OpenRISC
> + *
> + * Unit tests borrowed liberally from similar work of RISC-V. All
> + * original copyrights apply as per the original source declaration.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/page.h>
> +
> +#include "test_kprobes.h"
> +
> +SYM_FUNC_START(test_kprobes_j)
> +test_kprobes_j_addr1:
> +	l.addi	r11,r0,0
> +	l.j	2f
> +	l.nop

Just a tiny comment here about indenting the delay slots.

You could also use the delayslots here, for example:

	l.j	2f
	 l.addi	r11,r0,0

> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +test_kprobes_j_addr2:
> +	l.j	1b
> +	l.nop
> +SYM_FUNC_END(test_kprobes_j)
> +
> +SYM_FUNC_START(test_kprobes_jal)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r9,0
> +test_kprobes_jal_addr1:
> +	l.jal	2f
> +	l.nop
> +1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.jr	r9
> +	l.nop
> +test_kprobes_jal_addr2:
> +2:	l.jal	1b
> +	l.nop
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.addi	r9,r15,0
> +	l.jr	r9
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jal)
> +
> +SYM_FUNC_START(test_kprobes_jr)
> +	l.addi	r11,r0,0
> +	l.movhi	r15,hi(2f)
> +	l.ori	r15,r15,lo(2f)
> +test_kprobes_jr_addr1:
> +	l.jr	r15
> +	l.nop
> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.movhi	r15,hi(1b)
> +	l.ori	r15,r15,lo(1b)
> +test_kprobes_jr_addr2:
> +	l.jr	r15
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jr)
> +
> +SYM_FUNC_START(test_kprobes_jalr)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r9,0
> +	l.movhi	r17,hi(2f)
> +	l.ori	r17,r17,lo(2f)
> +test_kprobes_jalr_addr1:
> +	l.jalr	r17
> +	l.nop
> +1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r17,hi(1b)
> +	l.ori	r17,r17,lo(1b)
> +test_kprobes_jalr_addr2:
> +	l.jalr	r17
> +	l.nop
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.addi	r9,r15,0
> +	l.jr	r9
> +	l.nop
> +SYM_FUNC_END(test_kprobes_jalr)
> +
> +SYM_FUNC_START(test_kprobes_branch)
> +	l.addi	r11,r0,0
> +	l.addi	r15,r0,1
> +	l.addi	r17,r0,0
> +	l.sfgts	r15,r17
> +test_kprobes_branch_addr1:
> +	l.bf	2f
> +	l.nop
> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +	l.jr	r9
> +	l.nop
> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.sfeq	r15,r17
> +test_kprobes_branch_addr2:
> +	l.bnf	1b
> +	l.nop
> +SYM_FUNC_END(test_kprobes_branch)
> +
> +	.align	PAGE_SIZE
> +SYM_FUNC_START(test_kprobes_adrp)
> +	l.addi	r11,r0,0
> +	l.addi	r13,r0,0
> +	l.addi	r15,r9,0
> +	l.addi	r17,r0,-PAGE_SIZE
> +	l.jal	1f
> +	l.nop
> +1:	l.and	r19,r9,r17
> +test_kprobes_adrp_addr:
> +	l.adrp	r21,0
> +	l.sfeq	r21,r19
> +	l.bnf	2f
> +	l.nop
> +	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> +	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> +	l.addi	r11,r13,0
> +2:	l.addi	r9,r15,0
> +	l.jr	r9
> +	l.nop
> +SYM_FUNC_END(test_kprobes_adrp)
> +
> +    .section .rodata
> +SYM_DATA_START(test_kprobes_addresses)
> +	.word test_kprobes_j_addr1
> +	.word test_kprobes_j_addr2
> +	.word test_kprobes_jal_addr1
> +	.word test_kprobes_jal_addr2
> +	.word test_kprobes_jr_addr1
> +	.word test_kprobes_jr_addr2
> +	.word test_kprobes_jalr_addr1
> +	.word test_kprobes_jalr_addr2
> +	.word test_kprobes_branch_addr1
> +	.word test_kprobes_branch_addr2
> +	.word test_kprobes_adrp_addr
> +	.word 0
> +SYM_DATA_END(test_kprobes_addresses)
> +
> +    .section .rodata
> +SYM_DATA_START(test_kprobes_functions)
> +	.word test_kprobes_j
> +	.word test_kprobes_jal
> +	.word test_kprobes_jr
> +	.word test_kprobes_jalr
> +	.word test_kprobes_branch
> +	.word test_kprobes_adrp
> +	.word 0
> +SYM_DATA_END(test_kprobes_functions)
> -- 
> 2.55.0
> 
