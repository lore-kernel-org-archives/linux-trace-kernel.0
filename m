Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941DE3242A9;
	Wed, 27 May 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890798; cv=none; b=YXt2YtXeZTNXHSNfYBoFMYtK1xEbF38r5GF1nUT45/Ha5vs5pYdP8C5OLNngOWhNzR9gGldOBLeZHNKiEUMMDsbAQ+x0t+9RE3+lh6qKRtOwQGvEwGQGnr2B9ATZuQZqpimMXYPmblbUMFdfxdym1EV/AjMzvulsFAcg5c2C3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890798; c=relaxed/simple;
	bh=2jCKYTQjoKuxxT2ozar3gAihqc+gFK+1/JJPsrGwdlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=teC6Cdo8NtMtHCzuFKZw3XwlH6r188VsGgZNmv/NlOmk4MolCgL8vu46pZDJ+sVKW9XDW0Ddyn7wnwfrtfbasIrSvSDxLjXxr/f6NhsJ8Db47FUmj9OEYmC9R+ABmvTlKiL78ZYUkMfRvieXfQb4lp02eUB88vqO67Sz4eQzF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C77Rwbr0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C77Rwbr0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kMARWeKKUnu5AW49H0a/tY2hHiXSjf7x6sDlYFbA0no=; b=C77Rwbr037HBrCPXLJGFa+WDPT
	9EwbR83ut5Hui0/kA13sm2MT/I/RcHKS8I8IeDzmAmexUl6s60YOHfmKBNS5YaVfQNFcMbVxQ2GtZ
	L76qZjTV4bR8a6Ttd852S4CzUfNb+dSztgtNC/Vwi+chw0eM1FL93k1RzEpSH8vAjU37It4Chcfae
	tC8aLk/gtct8uIc0yM02eX+p2Y0786Q9MuZgMrSyfxKPQ2EtNiYk9JKBCvFTrYNHgnsppzgaiqajR
	A4HxKb+Go2LgR0yeAHmSn4RoNgNzeDvgQ8p1LYlIY2wSpKsTwzkVE0NLkBH+PbYUUWJ4zzjqHLYru
	Me3edNvw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEts-003DSa-2P;
	Wed, 27 May 2026 14:06:26 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v8 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Date: Wed, 27 May 2026 07:06:13 -0700
Message-Id: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFX6FmoC/23QyWrDMBAG4FcxOmfKaLTGp75HKUXLKFEPdrBT0
 xLy7sXpITLucWC+f5abmHmqPIu+u4mJlzrXcRB95w+dSOcwnBhqFn0nCMmiIgWc0sclDDWBZu1
 U9Aq9S+LQicvEpX4/st7e/+r5K35yuq4Ba8e5ztdx+nkMW+Ta91/uIgHBUZBHko5sMq+ZYw3Dy
 zidxBq8UEOVbCkBwpE1ZixWFxd2VD2plpupChBkTjFSkRST3lHdUtNSDQiUkZwrvliUO2oaSrq
 lBhCCMkVHg5pM2lH7pEZubrXrwl6hpBhc1nFHXUs3tzpAiExsnGcr8/ZN9/v9FzUJaq4XAgAA
X-Change-ID: 20260323-ecc_panic-4e473b83087c
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=8604; i=leitao@debian.org;
 h=from:subject:message-id; bh=2jCKYTQjoKuxxT2ozar3gAihqc+gFK+1/JJPsrGwdlY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvpbglPkMusQgxkazyuCvti8qWt9bG/4PfTrp
 RSqR5ICdNaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb6WwAKCRA1o5Of/Hh3
 baMUD/9gwdHPys6imhPmurHFc/W3OtkS1wf6kvREznCJqeTA6jqwKCBChTbWFmPZ1BjBlAzhVK2
 fBlYDm0Ast271fYcq9j2pczdE0eJGsQjT4qiuhgPvmjBFb0D5YECz47fgVJkQH+wU8dtSK1r9KD
 ENVj/M5otrDy81tn9SE82BGhd7nIZsZb7aM+GRPLyvZyi9kVvR4rstd5HRRadzn68GnFCtDB93l
 VdTe9ImE2PatUhoJa4jKr4umVy4hvNW7oADNYFmqxoYQhY4V9nGmdG+TEMEmxw3smwGZW60yUrI
 v7QIeVMwTUTFIRTzvTDBFzrbXl5FWV0UDPtjCJA/x29OPdYTgXfCuPlYLAcjsxvfFwjo5Ic3Tn0
 Zg6pCMqbK1KtBuHEfOslgIxYVgDCJzztBeu/BtkantgV52ijn4s9OinEEKCmSMM9hWx98zD0jXi
 8GqkWMv+wZrpSgsSh1WS5t3QJj0dlGDtaaeBd+rNJenQS952H1oYHoXdwpu5R7j/uij4zav1FWv
 29/QgcUoK0G0sd5n60o4qGGL2OSwBdSB1rqzJGgixujOyVkoBzRWXx0AzCJHS0snHB/FHXI0SXc
 aJWjSodLQmkBmZVaeWVzy1IFjy2qWM47uJCLSGRYu5mcI7+690EDOtv0Ao1pCvx5891pWCMPTN0
 XEJIGMhWm0unMrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A multi-bit ECC error on a kernel-owned page that the memory failure
handler cannot recover is currently swallowed: PG_hwpoison is set, the
event is logged, and the kernel keeps running.  The corrupted memory
remains accessible to the kernel and either drives silent data
corruption or surfaces seconds-to-minutes later as an apparently
unrelated crash.  In a large fleet that delayed, unattributable crash
turns into significant engineering effort to root-cause; in a kdump
configuration, by the time the crash happens the original error
context (faulting PFN, MCE/GHES record, page state) is long gone.

This series adds an opt-in sysctl,
vm.panic_on_unrecoverable_memory_failure, that converts an
unrecoverable kernel-page hwpoison event into an immediate panic with
a clean dmesg/vmcore that still contains the original failure
context.  The default is disabled so existing workloads see no
change.

There is a selftest that test different cases, and I tested it using
the following variants:

  ┌─────────┬──────────┬───────────────────────────────────────────────────────────┐
  │ Variant │   PFN    │                          Result                           │
  ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
  │ rodata  │ 0x2600   │ Panic with "Memory failure: 0x2600: unrecoverable page"   │
  ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
  │ slab    │ 0x100032 │ Panic with "Memory failure: 0x100032: unrecoverable page" │
  ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
  │ pgtable │ 0x100000 │ Panic with "Memory failure: 0x100000: unrecoverable page" │
  └─────────┴──────────┴───────────────────────────────────────────────────────────┘

Each one shows the same call trace, exactly the path the series builds:

  hard_offline_page_store
    → memory_failure
      → action_result
        → panic("Memory failure: %#lx: unrecoverable page")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v8:
- Commit message rewording (David)
- Add HWPoisonKernelOwned() helper (Lance)
- Removed patch "mm/memory-failure: short-circuit PG_reserved before get_hwpoison_page()"
- Broaden the selftest (Lance)
- Link to v7: https://patch.msgid.link/20260513-ecc_panic-v7-0-be2e578e61da@debian.org

Changes in v7:
- Move the PG_reserved / unhandlable-kernel-page classification into
  get_any_page() and surface it via -ENOTRECOVERABLE, per David
  Hildenbrand's and Lance Yang's review of v6.  This drops the
  is_reserved snapshot in memory_failure() and the mf_get_page_status
  enum / out-parameter introduced in v6.
- Restructure the post-call branch in memory_failure() as a switch
  over the get_hwpoison_page() return code (David).
- Drop the "reserved" qualifier from the MF_MSG_KERNEL label and the
  matching tracepoint string; the enum now covers both PG_reserved
  pages and other unhandlable kernel pages.
- Squash the former patches 1/4 ("MF_MSG_KERNEL for reserved pages")
  and 2/4 ("classify get_any_page() failures by reason") into a
  single classification patch; the series is now 3 patches.
- Simplify panic_on_unrecoverable_mf() to a single return statement
  (David).
- Link to v6: https://patch.msgid.link/20260511-ecc_panic-v6-0-183012ba7d4b@debian.org

Changes in v6:
- Dropped the selftest given the value was not clear
- Get the status of the failure from get_any_page()
- Small nits from different people/AIs.
- Link to v5: https://patch.msgid.link/20260424-ecc_panic-v5-0-a35f4b50425c@debian.org

Changes in v5:
- Add vm.panic_on_unrecoverable_memory_failure sysctl to panic on
  unrecoverable kernel page hwpoison events (reserved pages, refcount-0
  non-buddy pages, unknown state), with a recheck to avoid racing with
  concurrent buddy allocations. (Miaohe)
- Distinguish reserved pages as MF_MSG_KERNEL in memory_failure(),
  document the new sysctl in Documentation/admin-guide/sysctl/vm.rst,
  and add a selftest verifying SIGBUS recovery on userspace pages still
  works when the sysctl is enabled. (Miaohe)
- Added a selftest
- Link to v4:
  https://patch.msgid.link/20260415-ecc_panic-v4-0-2d0277f8f601@debian.org

Changes in v4:
- Drop CONFIG_BOOTPARAM_MEMORY_FAILURE_PANIC kernel configuration option.
- Split the reserved page classification (MF_MSG_KERNEL) into its own
  patch, separate from the panic mechanism.
- Document why the buddy allocator TOCTOU race (between
  get_hwpoison_page() and is_free_buddy_page()) cannot cause false
  positives: PG_hwpoison is set beforehand and check_new_page() in the
  page allocator rejects hwpoisoned pages.
- Document the narrow LRU isolation race window for MF_MSG_UNKNOWN and
  its mitigation via identify_page_state()'s two-pass design.
- Explicitly document why MF_MSG_GET_HWPOISON is excluded from the
  panic conditions (shared path with transient races and non-reserved
  kernel memory).
- Link to v3: https://patch.msgid.link/20260413-ecc_panic-v3-0-1dcbb2f12bc4@debian.org

Changes in v3:
- Rename is_unrecoverable_memory_failure() to panic_on_unrecoverable_mf()
  as suggested by maintainer.
- Add CONFIG_BOOTPARAM_MEMORY_FAILURE_PANIC kernel configuration option,
  similar to CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
- Add documentation for the sysctl and CONFIG option.
- Add code comments documenting the panic condition design rationale and
  how the retry mechanism mitigates false positives from buddy allocator
  races.
- Link to v2: https://patch.msgid.link/20260331-ecc_panic-v2-0-9e40d0f64f7a@debian.org

Changes in v2:
- Panic on MF_MSG_KERNEL, MF_MSG_KERNEL_HIGH_ORDER and MF_MSG_UNKNOWN
  instead of MF_MSG_GET_HWPOISON.
- Report MF_MSG_KERNEL for reserved pages when get_hwpoison_page() fails
  instead of MF_MSG_GET_HWPOISON.
- Link to v1: https://patch.msgid.link/20260323-ecc_panic-v1-0-72a1921726c5@debian.org

To: Miaohe Lin <linmiaohe@huawei.com>
To: Naoya Horiguchi <nao.horiguchi@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Breno Leitao (6):
      mm/memory-failure: drop dead error_states[] entry for reserved pages
      mm/memory-failure: surface unhandlable kernel pages as -ENOTRECOVERABLE
      mm/memory-failure: report MF_MSG_KERNEL for unrecoverable kernel pages
      mm/memory-failure: add panic option for unrecoverable pages
      Documentation: document panic_on_unrecoverable_memory_failure sysctl
      selftests/mm: add hwpoison-panic destructive test

 Documentation/admin-guide/sysctl/vm.rst      |  85 ++++++++++++
 mm/memory-failure.c                          |  96 ++++++++++---
 tools/testing/selftests/mm/Makefile          |   1 +
 tools/testing/selftests/mm/hwpoison-panic.sh | 193 +++++++++++++++++++++++++++
 4 files changed, 357 insertions(+), 18 deletions(-)
---
base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
change-id: 20260323-ecc_panic-4e473b83087c

Best regards,
--  
Breno Leitao <leitao@debian.org>

