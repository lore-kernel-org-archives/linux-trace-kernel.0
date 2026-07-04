Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5539D3DA;
	Sat,  4 Jul 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783157498; cv=none; b=UVl2tTz+plRXKu4TbcwZTkyqvB3Tt+f3DCU+LNSjplbBZo/mERHWWT7MurvTa6Bd3Ckc8LHF7dY7TMUM8UBGxyPM0ffTK83eFb4em/RCCv541eUEtLMlaO2/NesdSO11kKzglJEFiUgO+2il7O2O3RpNdAs7maKl8yAfqPeX+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783157498; c=relaxed/simple;
	bh=VbX6NacYvLE2FJCi58V0medyBvA0ZGJMYN4yv7QEMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1+P2xoi+QhczhTcqvqISYjNKlLrVFnQQ2VIX6+IMpd7zT6A4A8234F2YxXyPFKt/ra2+6eHULyrVRE1rRoaqGJ6y4GeRRxY35U2h6Y3mp6SSYOmaN69is1eCtrh6sYAquTmk4Um5eE0/z3Au/Zso6dRfkPkPd8O611bAYUuHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsoaTYMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsoaTYMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423E1F000E9;
	Sat,  4 Jul 2026 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783157496;
	bh=p1NRWPeXH4Cx6+cby7q1IV9WGoYMUGRxotRm9lK8E8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QsoaTYMI8AZ1KC7mXmN8STYCDOr7HqJLnj+iE5TUu8webmH8x7cy2/kCISGvaXK2U
	 3HyagT7YzPamqCEVFNflmhXIh1lNh9NognRS8tUPfRVIf6pqeucxu47zEJnaGgoKuE
	 cjySlsga79nNUVGvxyL5k4YvCTm9VK37KRPOEuDbsf2Y4Q85TlNrH6s1l34WDDqhNW
	 j+87m5nrHbt3FLm1m9AbfhNky17N1jvno7Cbp0JvZzn8MYEs+qQVi7z9NX2tlqaW3q
	 0JPzWcWB98LclBK5Uz7mUgLsVQd2/RenbKnTxOjQpKkng5tRTzij55mKWppOCYuxEk
	 FCKzcu182tT0A==
Date: Sat, 4 Jul 2026 12:31:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <akjS7kiGjVwWaWEz@kernel.org>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>

Hi Breno,

On Tue, Jun 30, 2026 at 05:46:09AM -0700, Breno Leitao wrote:
> Add a destructive selftest that verifies
> vm.panic_on_unrecoverable_memory_failure actually panics when a
> hwpoison error hits a kernel-owned page.
> 
> Three "kinds" of kernel-owned page can be targeted, selectable via
> the script's first positional argument (default: rodata):
> 
>   rodata  - a PG_reserved page in the kernel rodata range, sourced
>             from the "Kernel rodata" sub-resource of "System RAM" in
>             /proc/iomem.  That entry is reported on every major
>             architecture and guarantees the chosen PFN is backed by
>             struct page (an online System RAM range, not a firmware
>             hole), is PG_reserved, and is read-only -- so even if
>             the panic fails to fire for some reason, the resulting
>             PG_hwpoison marker on rodata does not corrupt writable
>             kernel state.
> 
>   slab    - a slab page found by walking /proc/kpageflags for the
>             first PFN with KPF_SLAB set (and KPF_HWPOISON / KPF_NOPAGE
>             / KPF_COMPOUND_TAIL clear).  Exercises the get_any_page()
>             path on a non PG_reserved kernel-owned page and so
>             catches regressions where get_any_page() collapses
>             kernel-owned pages into a transient -EIO instead of
>             -ENOTRECOVERABLE.
> 
>   pgtable - same as slab, but the PFN is selected via KPF_PGTABLE.
> 
> PageLargeKmalloc, the fourth page type matched by
> is_kernel_owned_page(), is intentionally not covered: it is a
> PAGE_TYPE_OPS flag with no /proc/kpageflags bit, so selecting such
> a PFN from userspace is not feasible.  The slab and pgtable
> variants already exercise the same get_any_page() positive-check
> branch.
> 
> The script enables the sysctl and writes the selected physical
> address to /sys/devices/system/memory/hard_offline_page.  A
> successful run crashes the kernel with
> 
>   Memory failure: <pfn>: unrecoverable page
> 
> A return from the inject means no panic fired.  Before reporting, the
> script restores the sysctl and best-effort unpoisons the target PFN
> through the hwpoison debugfs interface (hard_offline_page() injects
> with MF_SW_SIMULATED, so the page stays unpoisonable), then re-reads
> /proc/kpageflags: a PFN that is still the kernel-owned type it selected
> is a genuine failure, while one that raced to a different type before
> the inject is skipped as inconclusive.  Test outcome is therefore
> observed externally (serial console, kdump) rather than from the
> script's own exit code.
> 
> The script is intentionally NOT wired into run_vmtests.sh: every
> successful run panics the kernel, which is incompatible with the
> sequential "run each category in the same VM" model that
> run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
> ksft_* wrapper so a default kselftest run does not opt itself into
> a panic.  The script is meant to be executed manually inside a
> disposable VM (e.g. virtme-ng), one variant per VM boot, and
> requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/mm/Makefile          |   4 +
>  tools/testing/selftests/mm/hwpoison-panic.sh | 255 +++++++++++++++++++++++++++
>  2 files changed, 259 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index e6df968f0971c..ed321ae709dac 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -174,6 +174,10 @@ TEST_PROGS += ksft_userfaultfd.sh
>  TEST_PROGS += ksft_vma_merge.sh
>  TEST_PROGS += ksft_vmalloc.sh
>  
> +# Destructive: every successful run panics the kernel.  Installed and
> +# kept executable, but not run from a default kselftest invocation.
> +TEST_PROGS_EXTENDED += hwpoison-panic.sh
> +
>  TEST_FILES := test_vmalloc.sh
>  TEST_FILES += test_hmm.sh
>  TEST_FILES += va_high_addr_switch.sh
> diff --git a/tools/testing/selftests/mm/hwpoison-panic.sh b/tools/testing/selftests/mm/hwpoison-panic.sh
> new file mode 100755
> index 0000000000000..d953d13673324
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hwpoison-panic.sh
> @@ -0,0 +1,255 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Verify vm.panic_on_unrecoverable_memory_failure by injecting a hwpoison
> +# error on a kernel-owned page and confirming the kernel panics.
> +#
> +# Three "kinds" of kernel-owned page can be targeted, selectable via the
> +# first positional argument (default: rodata):
> +#
> +#   rodata  - a PG_reserved page in the kernel rodata range
> +#             (sourced from /proc/iomem "Kernel rodata").  Exercises
> +#             memory_failure() -> get_any_page() on a PageReserved page.
> +#
> +#   slab    - a slab page found via /proc/kpageflags (KPF_SLAB).
> +#             Exercises memory_failure() -> get_any_page() on a non
> +#             PG_reserved kernel-owned page.  This path is what catches
> +#             regressions where get_any_page() collapses kernel-owned
> +#             pages into a transient -EIO instead of -ENOTRECOVERABLE.
> +#
> +#   pgtable - a page-table page found via /proc/kpageflags (KPF_PGTABLE).
> +#             Same path as slab, different page type.
> +#
> +# This test is DESTRUCTIVE: a successful run crashes the kernel.  It is
> +# meant to be executed inside a disposable VM (e.g. virtme-ng) with a
> +# serial console captured by the harness.  It is skipped unless the
> +# caller opts in via RUN_DESTRUCTIVE=1.
> +#
> +# Test passes externally: the kernel must panic with
> +#   "Memory failure: <pfn>: unrecoverable page"
> +# A return from the inject means no panic fired: that is a failure,
> +# unless the target PFN raced to a different page type before injection,
> +# in which case the run is inconclusive and is skipped.
> +#
> +# Author: Breno Leitao <leitao@debian.org>
> +
> +set -u
> +
> +# KTAP output helpers (ktap_print_msg, ktap_skip_all, ktap_exit_fail_msg, ...).
> +DIR="$(dirname "$(readlink -f "$0")")"
> +# shellcheck source=../kselftest/ktap_helpers.sh
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +sysctl_path=/proc/sys/vm/panic_on_unrecoverable_memory_failure
> +inject_path=/sys/devices/system/memory/hard_offline_page
> +kpageflags_path=/proc/kpageflags
> +unpoison_path=/sys/kernel/debug/hwpoison/unpoison-pfn
> +
> +# /proc/kpageflags bit positions (see include/uapi/linux/kernel-page-flags.h)
> +KPF_SLAB=7
> +KPF_COMPOUND_TAIL=16
> +KPF_HWPOISON=19
> +KPF_NOPAGE=20
> +KPF_PGTABLE=26
> +KPF_RESERVED=32
> +
> +pagesize=$(getconf PAGE_SIZE)
> +
> +kind=${1:-rodata}
> +
> +if [ "$(id -u)" -ne 0 ]; then
> +	ktap_skip_all "must run as root"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +if [ ! -w "$sysctl_path" ]; then
> +	ktap_skip_all "$sysctl_path not present (kernel without the sysctl?)"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +if [ ! -w "$inject_path" ]; then
> +	ktap_skip_all "$inject_path not present (no MEMORY_HOTPLUG?)"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +if [ "${RUN_DESTRUCTIVE:-0}" != "1" ]; then
> +	ktap_skip_all "destructive test; re-run with RUN_DESTRUCTIVE=1 inside a disposable VM"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +# Pick a PFN inside the kernel image rodata region of /proc/iomem.
> +# This is preferred over a top-level "Reserved" entry because top-level
> +# Reserved ranges are often firmware holes that have no backing struct
> +# page; pfn_to_online_page() returns NULL on those and memory_failure()
> +# bails out with -ENXIO before reaching the panic path.
> +#
> +# "Kernel rodata" is reported as a sub-resource of "System RAM" on every
> +# major architecture, which guarantees:
> +#   - the PFN is backed by struct page (within an online memory range);
> +#   - PG_reserved is set on the page (kernel image area);
> +#   - the memory is read-only, so setting PG_hwpoison on it does not
> +#     corrupt writable kernel state if the panic somehow does not fire.
> +#
> +# /proc/iomem entries look like (indented for sub-resources):
> +#     "  02500000-02ffffff : Kernel rodata"
> +pick_rodata_phys_addr() {
> +	awk -v pagesize="$(getconf PAGE_SIZE)" '
> +	# Convert a hex string to a number without relying on the gawk-only
> +	# strtonum().  mawk lacks it and would otherwise spuriously skip
> +	# this test on distros that ship mawk as /usr/bin/awk.
> +	function hex2num(s,   n, i, c, v) {
> +		n = 0
> +		for (i = 1; i <= length(s); i++) {
> +			c = tolower(substr(s, i, 1))
> +			v = index("0123456789abcdef", c) - 1
> +			if (v < 0)
> +				return -1
> +			n = n * 16 + v
> +		}
> +		return n
> +	}
> +	/: Kernel rodata[[:space:]]*$/ {
> +		sub(/^[[:space:]]+/, "")
> +		n = split($0, a, /[- ]/)
> +		start = hex2num(a[1])
> +		end   = hex2num(a[2])
> +		if (end <= start)
> +			next
> +		# Page-align upward and emit the first byte of that page.
> +		pfn = int((start + pagesize - 1) / pagesize)
> +		printf "0x%x\n", pfn * pagesize
> +		exit 0
> +	}
> +	' /proc/iomem
> +}
> +
> +# Walk /proc/kpageflags and return the phys addr of the first PFN that
> +# has bit $1 set, with KPF_HWPOISON, KPF_NOPAGE and KPF_COMPOUND_TAIL
> +# all clear (so we attack a real, non-tail, not-already-poisoned page).
> +#
> +# We skip the first 16 MiB of PFNs to step past low-memory special
> +# ranges (BIOS/EFI/ACPI/etc.) that often are PG_reserved and would not
> +# exhibit the slab/pgtable type we are looking for.
> +pick_kpageflags_phys_addr() {
> +	local want_bit=$1
> +	local pagesize skip_pfn
> +
> +	[ -r "$kpageflags_path" ] || return
> +
> +	pagesize=$(getconf PAGE_SIZE)
> +	skip_pfn=$(((16 * 1024 * 1024) / pagesize))
> +
> +	od -An -tx8 -v -w8 -j "$((skip_pfn * 8))" "$kpageflags_path" 2>/dev/null | \
> +	awk -v want_bit="$want_bit" \
> +	    -v hwp_bit="$KPF_HWPOISON" \
> +	    -v nopage_bit="$KPF_NOPAGE" \
> +	    -v tail_bit="$KPF_COMPOUND_TAIL" \
> +	    -v base_pfn="$skip_pfn" \
> +	    -v pagesize="$pagesize" '
> +	# Test whether bit "b" is set in the 16-hex-digit value "hex".
> +	# Done with substring + per-digit lookup so we never rely on awk
> +	# bitwise operators (mawk lacks them), 64-bit FP precision or the
> +	# gawk-only strtonum().
> +	function bit_set(hex, b,    di, bi, c, v) {
> +		di = int(b / 4)
> +		bi = b - di * 4
> +		c = substr(hex, length(hex) - di, 1)
> +		v = index("0123456789abcdef", tolower(c)) - 1
> +		if (bi == 0) return (v % 2) == 1
> +		if (bi == 1) return int(v / 2) % 2 == 1
> +		if (bi == 2) return int(v / 4) % 2 == 1
> +		return int(v / 8) % 2 == 1
> +	}
> +	{
> +		gsub(/^[[:space:]]+/, "")
> +		h = $1
> +		if (bit_set(h, want_bit) &&
> +		    !bit_set(h, hwp_bit) &&
> +		    !bit_set(h, nopage_bit) &&
> +		    !bit_set(h, tail_bit)) {
> +			pfn = base_pfn + NR - 1
> +			printf "0x%x\n", pfn * pagesize
> +			exit 0
> +		}
> +	}

I'm looking at these awk scripts and od encodings and I wonder if wasn't it
simpler to write the test in C.

We have a bunch of helpers in tools/testing/selftests/mm/vm_utils.h for
accessing /proc files and there is already /proc/iomem parser in
tools/testing/selftests/mm/pfnmap.c that also could be lifter to vm_util

-- 
Sincerely yours,
Mike.
