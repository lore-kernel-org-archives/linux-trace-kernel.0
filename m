Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560699;
	b=PaQynP1Klxj7dj9Av92gLMQAMB3ubdGdPLRF98TiMwgSP/rt8b/rg3VXHvsZlq2KRwZ7
	 72H0fSzD61jfJlMjziPw445eoh1kcv4hpMHJrXYl+V7YsT2rvDMMr8gLNHtsJSIKgqIAy
	 MjG7MD9S7fBjQFC4LgE4JdJEk/cZB1olunxG7n1CnU6Cdxw7VNJTiNFgN6cA2/iqiByHv
	 fE492gIGqMjF9JouglHkJ3FSPi3N0jGyNSzGUpd1c/JIiToc9MpH/NEEzAdxtkoV2sF3I
	 R/fNAo5mdU2WI+lwa2marI9r3VbihX9FjgHApELncYvMQdr/AWUgSCUX91Bd9DcH1pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ECWVDz4uWDGG3HIRoRbtYePnz4o73iDqInasMcSuczg=;
	b=EBWwz6vXAaTYST6n9buXmr0X7LjqrablOKY7y0ZlCCSzM1NFFPbzUtC7dx7MSIYyJ4uv
	 Q1ygj1AhSDS7dsYgG2ry4Y0MaG2+NcjXi7wm1sRZa2CBgSYwR93N1VnbSU1VEMedxWmOU
	 2MiSuhOhVszX2VGM9ZKrHHMPrfIq56RygSmHhf0DEO1lryv5kMkc3A7iITRieOkZdlbEG
	 TDimuZbZM1ywHvAKP4eUq2bhf14us5rX1bA8NTt/jLSE0JCRm0rS8rtIvBcX3pCla9Uyy
	 0k9okG0gsLmsPB6tZ5fzq7x0N5oUyoZdcirow0VNgQChcC1Q1C9Ehe8vdQkfzA0kd+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYflUxDi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9D606A323;
	Fri, 13 Nov 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYflUxDi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4161F000C4;
	Fri, 13 Nov 2026 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560699;
	bh=ECWVDz4uWDGG3HIRoRbtYePnz4o73iDqInasMcSuczg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYflUxDiGCfGTvv2/1TqWIJVU0BXlGKrfrU0aoW2tnfg42tpVsm3Ox12EZXjx/Kq4
	 DFsb4UgjtyTGqY7ehS4QyxIAn9IocdPBggUFtR6e8rrfO6QpFyPo652K5qOputcGVt
	 VZXhajBgV2W7Uf2dOFymB3jGqMLE20bCXmGD+v9lCKiyMrMzhanyURvLhBjdKbEqHl
	 qPcrDc6Lvumdc6NNnUj62V5WiV3usE8zGt3nrdbQEMhI1T/aHVmqJEyxz12Pl212dc
	 eDdPwqHR9WNiLW1ZRTO/EQAKXQX4ifGF3pxQFWH61wWBWxgxEn8sq+JL+n4cR/xtCy
	 d8sk+1cf7Tu3Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, naveen@kernel.org, davem@davemloft.net, pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org, linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] openrisc: Add support for KProbes and Kretprobes
Date: Fri, 13 Nov 2026 18:04:54 +0900
Message-ID: <undine-1794560694824423564-2986102e2a604795@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261026201240.107462-1-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com> <20261026201240.107462-1-sahilcdq0@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Sahil,

Can you update the series according to the Sashiko's comment[1]?

[1] https://sashiko.dev/#/patchset/20261026201240.107462-3-sahilcdq0%40gmail.com

Also, can you check your git email settings, so that the next
version does *NOT* reply to the previous version.

This mail has 

  Message-ID: <20261026201240.107462-1-sahilcdq0@gmail.com>
  X-Mailer: git-send-email 2.55.0
  In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
  References: <20260930202744.50489-1-sahilcdq0@gmail.com>

But I can not find "20260930202744.50489-1-sahilcdq0@gmail.com" in 
the LKML archive.

Also "[PATCH v3 2/4] openrisc: Add KProbes" has

  Message-ID: <20261026201240.107462-3-sahilcdq0@gmail.com>
  X-Mailer: git-send-email 2.55.0
  In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
  References: <20260930202744.50489-1-sahilcdq0@gmail.com>

This should be in reply to the cover mail 
"20261026201240.107462-1-sahilcdq0@gmail.com"

Thank you,

On Tue, 27 Oct 2026 01:42:36 +0530, Sahil Siddiq <sahilcdq0@gmail.com> wrote:
> Hi,
>
> This is v3 of the patch series to add KProbe and Kretprobe support for
> OpenRISC. KProbes was introduced in v1 [1] while Kretprobes was introduced
> in v2 [2].
>
> In order to build the kernel with Kprobes and Kretprobes enabled, the
> following config options are required:
> 1. CONFIG_HAVE_KPROBES=y
> 2. CONFIG_KPROBES=y
> 3. CONFIG_RETHOOK=y
> 4. CONFIG_KRETPROBES=y
>
> I tested the generic functionality of Kprobes and Kretprobes using the
> tests located at "lib/tests" [3], samples located at "samples/kprobes" [4],
> as well as a few test modules that I have published here [5]. The following
> options are required to build the samples and tests:
> 1. CONFIG_SAMPLES=y
> 2. CONFIG_SAMPLE_KPROBES=m
> 3. CONFIG_SAMPLE_KRETPROBES=m
> 4. CONFIG_KPROBES_SANITY_TEST=m
>
> I have also added unit tests at "arch/openrisc/kernel/tests" to verify
> that Kprobes work properly when inserted at branch instructions, and
> that delay slots are handled correctly. The tests are based on the Kprobe
> testsuite added for RISC-V. The following options need to be enabled to
> build the tests:
> 1. CONFIG_KUNIT=y
> 2. CONFIG_RUNTIME_KERNEL_TESTING_MENU=y
> 3. CONFIG_OR_KPROBES_KUNIT=m
>
> Below are the results of the tests and sample modules when run in my
> environment.
>
> - kretprobe_example:
>
> /home # insmod kretprobe_example.ko 
> Planted return probe at kernel_clone: (ptrval)
> /home # ls >/dev/null
> kernel_clone returned 35 and took 1302450 ns to execute
> /home # rmmod kretprobe_example.ko 
> kernel_clone returned 36 and took 1121200 ns to execute
> kretprobe at (ptrval) unregistered
> Missed probing 0 instances of kernel_clone
>
> - test_kprobes:
>
> /home # insmod test_kprobes.ko 
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: kprobes_test
>     # module: test_kprobes
>     1..5
>     ok 1 test_kprobe
>     ok 2 test_kprobes
>     ok 3 test_kprobe_missed
>     ok 4 test_kretprobe
>     ok 5 test_kretprobes
> # kprobes_test: pass:5 fail:0 skip:0 total:5
> # Totals: pass:5 fail:0 skip:0 total:5
> ok 1 kprobes_test
>
> - openrisc_test_kprobes:
>
> /home # insmod openrisc_test_kprobes.ko 
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: kprobes_openrisc
>     # module: openrisc_test_kprobes
>     1..1
>     ok 1 test_kprobe_openrisc
> ok 1 kprobes_openrisc
>
> v3 adds a few fixes to the patch series based on Sachiko's review comments [6]. I
> have listed out the differences introduced in each iteration in the following emails.
>
> Thanks,
> Sahil
>
> [1] https://lkml.org/lkml/2026/4/8/21
> [2] https://lkml.org/lkml/2026/10/1/28
> [3] https://github.com/torvalds/linux/tree/master/lib/tests
> [4] https://github.com/torvalds/linux/tree/master/samples/kprobes
> [5] https://github.com/valdaarhun/or-dev
> [6] https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com
>
> Sahil Siddiq (4):
>   openrisc: Add utilities and clean up simulation of instructions
>   openrisc: Add KProbes
>   openrisc: Add unit tests for KProbes on branch instructions
>   openrisc: Add Kretprobes
>
>  arch/openrisc/Kconfig                         |   3 +
>  arch/openrisc/Kconfig.debug                   |  30 +-
>  arch/openrisc/configs/or1ksim_defconfig       |   2 +
>  arch/openrisc/configs/virt_defconfig          |   2 +
>  arch/openrisc/include/asm/asm.h               |  22 +
>  arch/openrisc/include/asm/break.h             |  19 +
>  arch/openrisc/include/asm/cpuinfo.h           |   3 +
>  arch/openrisc/include/asm/insn-def.h          |  64 ++-
>  arch/openrisc/include/asm/kprobes.h           |  77 ++++
>  arch/openrisc/include/asm/spr_defs.h          |   1 +
>  arch/openrisc/kernel/Makefile                 |   5 +-
>  arch/openrisc/kernel/entry.S                  |  16 +
>  arch/openrisc/kernel/insn.c                   |  88 ++++
>  arch/openrisc/kernel/kprobes.c                | 426 ++++++++++++++++++
>  arch/openrisc/kernel/rethook.c                |  32 ++
>  arch/openrisc/kernel/rethook.h                |   8 +
>  arch/openrisc/kernel/rethook_trampoline.S     | 111 +++++
>  arch/openrisc/kernel/setup.c                  |   4 +
>  arch/openrisc/kernel/tests/Makefile           |   3 +
>  arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++
>  arch/openrisc/kernel/tests/test_kprobes.h     |  24 +
>  arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 +++++++
>  arch/openrisc/kernel/traps.c                  |  82 ++--
>  arch/openrisc/lib/memcpy.c                    |   2 +
>  arch/openrisc/lib/memset.S                    |   4 +
>  arch/openrisc/mm/fault.c                      |   5 +
>  samples/kprobes/kprobe_example.c              |   8 +
>  27 files changed, 1206 insertions(+), 51 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/asm.h
>  create mode 100644 arch/openrisc/include/asm/break.h
>  create mode 100644 arch/openrisc/include/asm/kprobes.h
>  create mode 100644 arch/openrisc/kernel/insn.c
>  create mode 100644 arch/openrisc/kernel/kprobes.c
>  create mode 100644 arch/openrisc/kernel/rethook.c
>  create mode 100644 arch/openrisc/kernel/rethook.h
>  create mode 100644 arch/openrisc/kernel/rethook_trampoline.S
>  create mode 100644 arch/openrisc/kernel/tests/Makefile
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
>  create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
>
> -- 
> 2.55.0
>
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
