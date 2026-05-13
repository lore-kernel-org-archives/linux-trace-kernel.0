Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB34949FF;
	Wed, 13 May 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686797; cv=none; b=KsOG0LJhyE42cNcxb6ZmkliuRfR03Fn9yTz5v6uNkdoahWDrjYtPQ7mXOVvcCEKIG5FYK+wGB75ikYU7iYJSCXhS0/oroA9l5SGE1YKokzT4kSgJC/tkVCLFKjv1QDIvMFAugHLoip9Dc5qFNlxos+PoCfMw7EmB+2IXibhy/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686797; c=relaxed/simple;
	bh=bbxp1Gsl0J70OpOgud3HV52mLKTRxVimVS/VK6IaNXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rZJ2yWA9DWmVo5Xa7kFdC/sBRvCpoU7HPLbyYeK6jV5Rw69iC5naYjC0dmF2aJy8w28n0JmpY3EDijbXYIiGOzTN7d+L9kwDY5+nO4sSKJ6Ss2Bpje1DqwBh5D8Sc9LNASkdi1BXF58wHTgm/Irv7dvhNEr8cmLpDudk5Jqr1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BB7ChYnN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BB7ChYnN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZHMWqcUJvGieXh74sNoEmf+K/vMRbAU66tA5tncTCoI=; b=BB7ChYnNfVz4Y0o78c5eZvaY/o
	V+tf+IQz3nn12YbLXu2xaasSjduuXENB87/gymyUaKYfHtOkrpq4CADG0i6Idr7IOPCu2nda+c1iE
	BMv8X7hB/RMyHLqYW8yblubckKopLTLV53zzdxi+7bkyB6cqEL9n8rZZh6FascvhAVgid/LazKtim
	EXMIX+iNaFSkqJJ8JaTmhEb+aS2LZRSrMH3IyTwz2fK3zUYEIMMUtazgqJgsNL0+/dN11zmreEtqj
	phNlOjqYHeSlV+vSHwwTCNvZPxrydEb8Nb87OQbnF0r7et/4E6BdqgiwFD6P1XXtHou3XeHzysW2Z
	2bTlsyHQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBgW-003GTi-2w;
	Wed, 13 May 2026 15:39:46 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v7 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Date: Wed, 13 May 2026 08:39:31 -0700
Message-Id: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADObBGoC/23Pz2rDMAwG8FcJPldDlmU7zWnvMUbx39Y7JCXpw
 kbJu5d0hzpkR4F+3yfdxZTGkibRNXcxprlMZehF19hDI8LF9ecEJYquEYRkUJGCFMLp6voSgBN
 b5VuFrQ3i0IjrmHL5eWZ9fP7N07f/SuG2BqwblzLdhvH3WTbLde+/3FkCgiUnjyQtmaDfY/LF9
 W/DeBZr8EwVVbKmBAjHxBgxG87W7ah6UZabVgUIMgbvKUvygXeUa6pryoBAEcna3GaDckd1RYl
 rqgHBKZ3Za2TSYUfNi2q5+dWsB7cKJXlnI/sNXZblAbQRg7PcAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6267; i=leitao@debian.org;
 h=from:subject:message-id; bh=bbxp1Gsl0J70OpOgud3HV52mLKTRxVimVS/VK6IaNXs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBJs6+Aj/VQHB/ziZBcEMP8ajQ/fSuRJCu4CP3
 7TC2W7J5Y+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagSbOgAKCRA1o5Of/Hh3
 baopD/9k+b8ymfJoBaS1v7ItIZSwHeHYjah61HeZoCf674mQyx+QLSU6b0HFyU9MfGxz82804sq
 voMcSWl/GywgJjbnDZAK8Of7zSgy9Y41uNbxjEnxV7DVwPeBv/2EzQQAMmIqYlQ5rnDh2UY467v
 8QxfcT/36Zxos/wdARZw0QOkMBjuFwpgsRr4R/jLlK+0QcFUN8uBJRwBIiz4xcMVa7peJfrAF4P
 hEOhQa/rUrkgX3TlMV+f/uCivJYgZgK8JIn5Fl7/uY2T+vCTCuDMdg2kFOOeSfSOIG9XHYTvK4L
 I8dci+eRfSoPwoZtSHKt35Cc/vbREb31mUWQLT6xdEbJ92jUEJNk4yUSe0u2GNrynVhy6/qPIxb
 JBYyxGItHmeBiloxA4siFgOZumsi71VvZDGCgW3qx+kjYA4RVL1CxVJhabJlFzP+R4BYcKdbuh3
 eJgpgACKRv9BQ1exr+mQ7wqvqjwZqEyHZkWe8++/7pDe7DGjyJzfWGd/TL6iZoCRFOdmqtkZmKs
 oJyJE+Oh0cKhER9uA1dGqD5Dh0iODnEEjwlGAe4aXOC0Y12NlZSKcGv0PexgLJBwm7QY6m+1XPA
 ed/w4g/Xj58jZJGL3cPGihdXUmrlRd5Kltjh47qdK38FiGt7VFvs155XDtvimwKW/uupbq60Bml
 qPs5Ec5qhouAiCQ==
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

Signed-off-by: Breno Leitao <leitao@debian.org>
---
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
      mm/memory-failure: short-circuit PG_reserved before get_hwpoison_page()
      mm/memory-failure: add panic option for unrecoverable pages
      Documentation: document panic_on_unrecoverable_memory_failure sysctl

 Documentation/admin-guide/sysctl/vm.rst | 80 +++++++++++++++++++++++++++++++
 mm/memory-failure.c                     | 85 +++++++++++++++++++++++++--------
 2 files changed, 146 insertions(+), 19 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260323-ecc_panic-4e473b83087c

Best regards,
--  
Breno Leitao <leitao@debian.org>

