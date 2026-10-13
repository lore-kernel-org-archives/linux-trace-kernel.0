Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F33374E5A;
	Tue, 13 Oct 2026 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865379; cv=none; b=fs9cAuEC0atfXjqTb9hYhNbPRCi4ET1lxwv5eM0PRI5ZyVQpSUvGpotFFYVtjSS2qsdjwOJ19iZGySd7tNJFPVSYZcwJQR9Et8WVxSFV229+WLGuyBxvLo4p9gIxZzsQucnWsfpg7maMN/oX0KlwZ94U+pO1l/+fSbxhlYJUrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865379; c=relaxed/simple;
	bh=X2sZIgOPoxJAshfgtlGi+6FNBf3UR5OoE4stvkbrqtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=m8qj95tkhr7NnhiqyVEJ+ViRCFwrWluPXOAkpzG3H5HnDLtBBDQ66BEM0slUnClDa9uFdbqxUvqBKN2sf3w2RBxB0icEjxf6R860psdI1IVakamruOpKEdH+ZnlYzk5Mp3d1PCeszM9EpdcFtrVA0WQHtOuzJqvLYDn+BAON2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCd3v7LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCd3v7LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF701F000FF;
	Tue, 13 Oct 2026 04:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791865378;
	bh=xVIPYhPZae7SQs6ev46TrORj9udq4yV2dLyzfICNJ+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCd3v7LCSnjksIzhtvR44b+IKlOvuuFDKN7TBeIdt40T200QjJ9d7kK9iHJiiAD/8
	 WIo5irqcHALxdHeLWPBkKhDIuJlAXUDs+qRFudEaKR6jq0UtW15fZMPYkaEY8JqXz6
	 wXxrgCsmXmgGTCKljTqWEOed4QZL50cyCRAz6GCUh2zB69XhPNAmK4OXY96aVKAqID
	 TLgYse4g2mGG5MP5hEQgjGY+Jb0GqzzNliguQJnAVejv4HE02riGU2Sxcyha7krVyu
	 LqcK8N0uBwtMtJGjb0OL85LpACS7A8lmJVC7vdo6SqieFYADYqyqLUGdDbFfwqnWHa
	 8oNFyXaJh67Vw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sahilcdq0@gmail.com
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org, tytso@mit.edu,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, pjw@kernel.org,
 kees@kernel.org, linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq0@gmail.com>
Subject: Re: [PATCH v2 0/4] openrisc: Add support for KProbes
Date: Tue, 13 Oct 2026 04:22:53 +0000
X-Mailer: UndineD 0.1
In-Reply-To: <20260930203129.51048-1-sahilcdq0@gmail.com>
References: 20260407185650.79816-2-sahilcdq0@gmail.com
 20260930203129.51048-1-sahilcdq0@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013042255.7DF701F000FF@smtp.kernel.org>

Hi Sahil,

Thanks for updating! Could you check Sashiko's comments on the series?

https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com

I need OpenRISC maintainer's review for this series too.

Thank you,

On Thu, 01 Oct 2026 02:01:25 +0530, Sahil Siddiq <sahilcdq0@gmail.com> wrote:
> Hi,
>
> Apologies for the delay. This is v2 of the patch series to add KProbe
> support for OpenRISC.
>
> The series also adds support for Kretprobes (which depends on the rethook
> framework [1]). Kretprobes are fired on function return.
>
> In order to build the kernel with Kprobes and Kretprobes enabled, the
> following config options are required:
> 1. CONFIG_HAVE_KPROBES=y
> 2. CONFIG_KPROBES=y
> 3. CONFIG_RETHOOK=y
> 4. CONFIG_KRETPROBES=y
>
> I tested the generic functionality of Kprobes and Kretprobes using the
> tests located at "lib/tests" [2], samples located at "samples/kprobes" [3],
> as well as a few test modules that I have published here [4]. The following
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
> I have also made changes based on the review comments I received for
> v1 [5] including several of Sachiko's comments [6]. I chose not to make
> changes in a few places. I'll send emails as a reply to this thread
> explaining my reasoning inline.
>
> Thanks,
> Sahil
>
> [1] https://lkml.rescloud.iu.edu/2203.0/05974.html
> [2] https://github.com/torvalds/linux/tree/master/lib/tests
> [3] https://github.com/torvalds/linux/tree/master/samples/kprobes
> [4] https://github.com/valdaarhun/or-dev
> [5] https://lwn.net/ml/all/20260407185650.79816-1-sahilcdq0@gmail.com/
> [6] https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com
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
>  arch/openrisc/kernel/insn.c                   |  84 ++++
>  arch/openrisc/kernel/kprobes.c                | 400 ++++++++++++++++++
>  arch/openrisc/kernel/rethook.c                |  32 ++
>  arch/openrisc/kernel/rethook.h                |   8 +
>  arch/openrisc/kernel/rethook_trampoline.S     |  97 +++++
>  arch/openrisc/kernel/setup.c                  |   4 +
>  arch/openrisc/kernel/tests/Makefile           |   3 +
>  arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++
>  arch/openrisc/kernel/tests/test_kprobes.h     |  24 ++
>  arch/openrisc/kernel/tests/test_kprobes_asm.S | 147 +++++++
>  arch/openrisc/kernel/traps.c                  |  82 ++--
>  arch/openrisc/lib/memcpy.c                    |   2 +
>  arch/openrisc/lib/memset.S                    |   4 +
>  arch/openrisc/mm/fault.c                      |   5 +
>  samples/kprobes/kprobe_example.c              |   8 +
>  27 files changed, 1152 insertions(+), 51 deletions(-)
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

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
