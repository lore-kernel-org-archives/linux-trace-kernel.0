Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32D3793C2;
	Tue, 30 Jun 2026 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852922; cv=none; b=bXRRh2m2UQuPOm2JJG/JztukbhDdV1/pXYeWPFCslIuvu+tfTcATNilO4qVkscepNvyPBw5qGl/pxJk+VB3UWlG0/y3Ee4ZwGM4f6Q7qwzvsdykQ/A3hDo7f7g2aiV0Hs6xz5OrfHxqLetrLehp0m3PT3v9h+EO9yP798rfbFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852922; c=relaxed/simple;
	bh=7sJKF/xH/OZnhgj123YyTtu81KiJuyu6J7CCCg5dllM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k1AKXtn9zwWXNY8j7dojtzKEM0+ni9dhBtsFA/xz3D1zveSiooHSpPGjY4qihKH500Licf57j7LRSirPCF6L0rOYdZ6U4nBghdvlwL1touRxM97Rq8Z5Y5NjZXP2W6BI42d1QRJ7paHLrioEIkGEWMI2Ant2WALk+03cAHlOLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nIdg9WVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nIdg9WVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C2A1F000E9;
	Tue, 30 Jun 2026 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782852920;
	bh=PqXMviszUJ70wdko7x9w/HLJnkvQD9s/VmU8YDU8zkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nIdg9WVcgKuztuJWZsgQgB8qhrK7N0juK0z53//izV+A18lotNu+7Pz/5jMQGMLFy
	 kVKPTUdFinPIsjTZAmG634V62nO9lUIJFNJsmgFSOE7zu2L0AlpVuQSpq2gCxmhvzG
	 /hh3A1WHx/9z1qQaUHx9JqA99cUwh+egfdsAqxGA=
Date: Tue, 30 Jun 2026 13:55:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 lance.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v10 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Message-Id: <20260630135519.404f3be5cb3850a0208f1791@linux-foundation.org>
In-Reply-To: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 05:46:03 -0700 Breno Leitao <leitao@debian.org> wrote:

> A multi-bit ECC error on a kernel-owned page that the memory failure
> handler cannot recover is currently swallowed: PG_hwpoison is set, the
> event is logged, and the kernel keeps running.  The corrupted memory
> remains accessible to the kernel and either drives silent data
> corruption or surfaces seconds-to-minutes later as an apparently
> unrelated crash.  In a large fleet that delayed, unattributable crash
> turns into significant engineering effort to root-cause; in a kdump
> configuration, by the time the crash happens the original error
> context (faulting PFN, MCE/GHES record, page state) is long gone.
> 
> This series adds an opt-in sysctl,
> vm.panic_on_unrecoverable_memory_failure, that converts an
> unrecoverable kernel-page hwpoison event into an immediate panic with
> a clean dmesg/vmcore that still contains the original failure
> context.  The default is disabled so existing workloads see no
> change.

Updated, thanks.

Sashiko said things:
	https://sashiko.dev/#/patchset/20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org


> Changes in v10:
> - Reuse kselftest declarations
> - Residual race harmless documentation
> - Link to v9: https://lore.kernel.org/r/20260609-ecc_panic-v9-0-432a74002e74@debian.org

Here's how v10 altered mm.git:


 mm/memory-failure.c                          |    6 +-
 tools/testing/selftests/mm/hwpoison-panic.sh |   42 +++++++++--------
 2 files changed, 28 insertions(+), 20 deletions(-)

--- a/mm/memory-failure.c~b
+++ a/mm/memory-failure.c
@@ -1366,8 +1366,10 @@ static inline bool is_kernel_owned_page(
 	 * Page-type bits live only on the head page, so resolve any tail
 	 * first.  The check takes no refcount; recheck the head afterwards
 	 * so a concurrent split or compound free cannot leave us trusting
-	 * a stale view.  A free->alloc->free in the same window is still
-	 * possible but closing it would require taking a reference here.
+	 * a stale view.  A residual free->alloc->free cannot be closed here
+	 * (frozen slab and large-kmalloc pages cannot be pinned), but is
+	 * harmless: where a wrong verdict could panic, memory_failure() has
+	 * already set PageHWPoison, which bars the page from the allocator.
 	 */
 retry:
 	head = compound_head(page);
--- a/tools/testing/selftests/mm/hwpoison-panic.sh~b
+++ a/tools/testing/selftests/mm/hwpoison-panic.sh
@@ -35,7 +35,11 @@
 
 set -u
 
-ksft_skip=4
+# KTAP output helpers (ktap_print_msg, ktap_skip_all, ktap_exit_fail_msg, ...).
+DIR="$(dirname "$(readlink -f "$0")")"
+# shellcheck source=../kselftest/ktap_helpers.sh
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
 sysctl_path=/proc/sys/vm/panic_on_unrecoverable_memory_failure
 inject_path=/sys/devices/system/memory/hard_offline_page
 kpageflags_path=/proc/kpageflags
@@ -53,24 +57,24 @@ pagesize=$(getconf PAGE_SIZE)
 
 kind=${1:-rodata}
 
-ksft_print() { echo "# $*"; }
-ksft_exit_skip() { ksft_print "$*"; exit "$ksft_skip"; }
-ksft_exit_fail() { echo "not ok 1 $*"; exit 1; }
-
 if [ "$(id -u)" -ne 0 ]; then
-	ksft_exit_skip "must run as root"
+	ktap_skip_all "must run as root"
+	exit "$KSFT_SKIP"
 fi
 
 if [ ! -w "$sysctl_path" ]; then
-	ksft_exit_skip "$sysctl_path not present (kernel without the sysctl?)"
+	ktap_skip_all "$sysctl_path not present (kernel without the sysctl?)"
+	exit "$KSFT_SKIP"
 fi
 
 if [ ! -w "$inject_path" ]; then
-	ksft_exit_skip "$inject_path not present (no MEMORY_HOTPLUG?)"
+	ktap_skip_all "$inject_path not present (no MEMORY_HOTPLUG?)"
+	exit "$KSFT_SKIP"
 fi
 
 if [ "${RUN_DESTRUCTIVE:-0}" != "1" ]; then
-	ksft_exit_skip "destructive test; re-run with RUN_DESTRUCTIVE=1 inside a disposable VM"
+	ktap_skip_all "destructive test; re-run with RUN_DESTRUCTIVE=1 inside a disposable VM"
+	exit "$KSFT_SKIP"
 fi
 
 # Pick a PFN inside the kernel image rodata region of /proc/iomem.
@@ -208,21 +212,22 @@ pgtable)
 	missing_msg="no usable page-table PFN found in $kpageflags_path"
 	;;
 *)
-	ksft_exit_fail "unknown kind '$kind' (expected: rodata|slab|pgtable)"
+	ktap_exit_fail_msg "unknown kind '$kind' (expected: rodata|slab|pgtable)"
 	;;
 esac
 
 if [ -z "$phys_addr" ]; then
-	ksft_exit_skip "$missing_msg"
+	ktap_skip_all "$missing_msg"
+	exit "$KSFT_SKIP"
 fi
 
-ksft_print "enabling $sysctl_path"
+ktap_print_msg "enabling $sysctl_path"
 prior=$(cat "$sysctl_path")
-echo 1 > "$sysctl_path" || ksft_exit_fail "failed to enable sysctl"
+echo 1 > "$sysctl_path" || ktap_exit_fail_msg "failed to enable sysctl"
 
 pfn=$((phys_addr / pagesize))
-ksft_print "injecting hwpoison at phys 0x$(printf '%x' "$phys_addr") (pfn 0x$(printf '%x' "$pfn"), kind=$kind)"
-ksft_print "expecting kernel panic: 'Memory failure: <pfn>: unrecoverable page'"
+ktap_print_msg "injecting hwpoison at phys 0x$(printf '%x' "$phys_addr") (pfn 0x$(printf '%x' "$pfn"), kind=$kind)"
+ktap_print_msg "expecting kernel panic: 'Memory failure: <pfn>: unrecoverable page'"
 
 # A successful run never returns from the inject -- it panics the kernel.
 # Reaching the code below therefore means no panic fired.  Note whether
@@ -243,7 +248,8 @@ try_unpoison "$pfn"
 # if it raced to another type the run is inconclusive, so skip instead.
 kpageflags_bit_set "$pfn" "$recheck_bit"
 case $? in
-0)	ksft_exit_fail "$verdict (page still $kind)" ;;
-1)	ksft_exit_skip "target PFN no longer $kind; raced before inject, inconclusive" ;;
-*)	ksft_exit_fail "$verdict (could not reconfirm page type via $kpageflags_path)" ;;
+0)	ktap_exit_fail_msg "$verdict (page still $kind)" ;;
+1)	ktap_skip_all "target PFN no longer $kind; raced before inject, inconclusive"
+	exit "$KSFT_SKIP" ;;
+*)	ktap_exit_fail_msg "$verdict (could not reconfirm page type via $kpageflags_path)" ;;
 esac
_

