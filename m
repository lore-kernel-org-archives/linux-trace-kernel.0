Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB044063A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164068; cv=none; b=b0DmdE+h7eiqRGHDDBrhMFdaGFHv8jgj6y/v57SnWMLL0RuBiBna64XlPObGEC2/lC8iaLDNQH1U9CBh4RDGw0o4mr7AO3sS115tIX6SzfWOpiEe/VsKOe2oDvYdPVkLvX4X0WVatjIZAbT5sTQ8Ieh4NI00Qy07X9j7pdQcRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164068; c=relaxed/simple;
	bh=KLG0hAkpQb/SiFn6LH3rdJhkrabVdRO4wCxhpx4hH0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jaz7tp91BJqs+f7j052welYYuQ1JBvQHWR8zHYTIEJngkmIDU9r0s4g1y0CyW2tj7FFJWICEZsSBDT7yLDw+v6SvVbfEvQY/QkbSeo6xVp5a12MYujOLYpA+0JVknL9kBCEjbj2ciVhI8aezFnDp7iO2bEUC8ir1CHS9s9Yw/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+ltdTrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+ltdTrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3D11F000E9;
	Wed, 19 Aug 2026 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164066;
	bh=ZyxgwCiq1HEsJBr3XqPO3R76d0S1KI1dA5s1CRPaVLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+ltdTrAvMCF+giRBfxzU3e69SaiAJeYZBtAI+/XPZQdr+MOn5L7mERHVp7rHLEMD
	 5FQuuVKX+ZgRIMkoWWLBM2h/F5YPWfMnkO/1fd3LtmMaLyennIh+x7xuU5TtPqb6gP
	 tQszFUDYEEATaHwLxBzoOmngKoP89cr3wTfifv4ev5M0aSg4UVxPPOeApNUjROyiYK
	 0rjAOGfbk/qpJdSatoD5Ho2ZdiogRVOSdpJLf9D4/FgWyi1BSABb9nMw5JohjUn9AK
	 +f8g6+8UY4G+u1EgYtGObrMOqKwjEsQUICdJJ9IpWbMgHQBsAmZhL9l7J5ORz2r843
	 QqFMlF41cbgeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] selftests/verification: Add tlob selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <dfac398d20478c739f1d7ce7d0289b132acc3a4f.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <dfac398d20478c739f1d7ce7d0289b132acc3a4f.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:27:46 +0000
Message-Id: <20260819182746.9C3D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The test `uprobe_detail_waiting.tc` spawns an unbounded SCHED_FIFO=
 priority-99 hog, causing a system-wide hard deadlock on single-CPU machine=
s.
- [Medium] Empty `noinline` uprobe target functions will be optimized away =
by the compiler, breaking the stop probe and causing tests to fail.
- [Medium] The test suite fails when run from an installed kselftest enviro=
nment due to relying on an unexported `VERIFICATIONTEST_BINDIR` environment=
 variable.
- [Medium] The test scripts hardcode absolute paths to `/sys/kernel/tracing=
/`, breaking portability on systems where `tracefs` is mounted at `/sys/ker=
nel/debug/tracing`.
- [Low] The `tlob_sym` ELF parser lacks bounds checking for the program hea=
ders offset (`e_phoff`), allowing out-of-bounds memory reads.
- [Low] The `run_tlob_tests.sh` standalone script relies on relative source=
 paths and `make`, making it non-functional in installed kselftest environm=
ents.
--

--- Patch [8]: [PATCH v5 8/9] selftests/verification: Add tlob selftests ---
commit 71ad2abd1a52a7f2eb279e47c07bd2822ab59ec5
Author: Wen Yang <wen.yang@linux.dev>

selftests/verification: Add tlob selftests

Add seven ftrace-style test scripts for the tlob RV monitor under
tools/testing/selftests/verification/test.d/tlob/.  The tests cover
uprobe binding management, budget violation detection, and per-state
time accounting.

> diff --git a/tools/testing/selftests/verification/Makefile b/tools/testin=
g/selftests/verification/Makefile
> index aa8790c22a71b..41445d15b86a0 100644
> --- a/tools/testing/selftests/verification/Makefile
> +++ b/tools/testing/selftests/verification/Makefile

[ ... ]

>  TEST_PROGS :=3D verificationtest-ktap
>  TEST_FILES :=3D test.d settings
>  EXTRA_CLEAN :=3D $(OUTPUT)/logs/*
> =20
> +TEST_GEN_FILES :=3D tlob_sym tlob_target
> +
>  include ../lib.mk
> +
> +export VERIFICATIONTEST_BINDIR :=3D $(OUTPUT)

[Severity: Medium]
Will this environment variable be available when the tests are run from an
installed kselftest environment? Since the underlying runner doesn't invoke
make during installed test execution, this might leave the variable
undefined.

> diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_te=
sts.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> new file mode 100755
> index 0000000000000..13adf1eec9a26
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh

[ ... ]

> +FTRACETEST=3D"$SCRIPT_DIR/../../../ftrace/ftracetest"
> +
> +# Build test helpers
> +echo "Building tlob test helpers..."
> +make -C "$SCRIPT_DIR/../.." all

[Severity: Low]
Does this script work in an installed kselftest environment? The source
Makefile and .c files won't be present there, which could cause this make
command to fail.

> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind=
.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> new file mode 100644
> index 0000000000000..baa6c5fa0ff2a
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob monitor uprobe binding (visible in monitor file=
, removable, duplicate rejected)
> +# requires: tlob:monitor
> +
> +UPROBE_TARGET=3D"${VERIFICATIONTEST_BINDIR}/tlob_target"

[Severity: Medium]
Could this lead to path resolution errors? If VERIFICATIONTEST_BINDIR is
empty during installed test execution, it tries to execute /tlob_target
from the root directory.

> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_deta=
il_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_det=
ail_running.tc
> new file mode 100644
> index 0000000000000..f9a412930cda4
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_runn=
ing.tc

[ ... ]

> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace

[Severity: Medium]
Could hardcoding absolute paths to /sys/kernel/tracing/ cause issues on
systems where tracefs is mounted at /sys/kernel/debug/tracing? ftracetest
handles dynamically locating the mount point, so relative paths might be
more portable.

> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_deta=
il_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_det=
ail_waiting.tc
> new file mode 100644
> index 0000000000000..68aeb1fa2172f
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_wait=
ing.tc

[ ... ]

> +# Pick the last CPU to avoid cpu0 which is used by vng infrastructure.
> +cpu=3D$(($(nproc) - 1))

[ ... ]

> +# Start the RT hog BEFORE the target so the target is immediately preemp=
ted
> +# when it calls tlob_preempt_work() (start probe fires), minimising runn=
ing_ns.
> +chrt -f 99 taskset -c "$cpu" sh -c 'while true; do :; done' 2>/dev/null &
> +hog_pid=3D$!

[Severity: High]
Can this script cause a system-wide hard deadlock on single-CPU machines?

On a single core, cpu evaluates to 0, and spawning an unbounded SCHED_FIFO
priority-99 loop will permanently monopolize the CPU. With ftracetest
disabling RT throttling, the test script is starved and cannot proceed to
teardown the process.

> diff --git a/tools/testing/selftests/verification/tlob_sym.c b/tools/test=
ing/selftests/verification/tlob_sym.c
> new file mode 100644
> index 0000000000000..a92fc49d13043
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob_sym.c

[ ... ]

> +		Elf64_Phdr *phdrs =3D (Elf64_Phdr *)((char *)map + ehdr->e_phoff);
> +		int pi;
> +
> +		for (pi =3D 0; pi < ehdr->e_phnum; pi++) {
> +			Elf64_Phdr *ph =3D &phdrs[pi];
> +
> +			if (ph->p_type !=3D PT_LOAD)

[Severity: Low]
Is it possible for this parser to perform an out-of-bounds memory read?

The parser verifies the section header offsets against the file size,
but it looks like the program header offset e_phoff and e_phnum are not
similarly validated before casting and reading ph->p_type.

> diff --git a/tools/testing/selftests/verification/tlob_target.c b/tools/t=
esting/selftests/verification/tlob_target.c
> new file mode 100644
> index 0000000000000..adf4c2397fb37
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob_target.c

[ ... ]

> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_busy_work_done(void)
> +{
> +	/* empty: uprobe fires on entry */
> +}
> +
> +/* start probe; busy-spin so running_ns dominates */
> +noinline void tlob_busy_work(unsigned long duration_ms)
> +{

[ ... ]

> +	tlob_busy_work_done();
> +}

[Severity: Medium]
Will the compiler optimize away the call to tlob_busy_work_done()?

Since the function is empty and returns void, interprocedural analysis might
determine it has no side effects and remove the call from tlob_busy_work(),
which would prevent the uprobe stop event from firing. Could an empty
volatile asm statement prevent it from being optimized out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D8
