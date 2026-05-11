Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924533F5BA;
	Mon, 11 May 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513969; cv=none; b=hlmtZ1+lPEEgtkPdckClc41DnD/nURte0nMwwJyg/cTLA9C7evdQ6JvrgQ2Dgxpa2V7OAZvBywIs9riFlxFWpCx+QVpzooMMYaG+Yno0u/4OwEaYyuLwH+zScd3tLwBJw7hJtmxAUBUuGurMxUFICFXzjcBF7rDOiJslta35gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513969; c=relaxed/simple;
	bh=K4UG75VqQ77yZouQJXp5unsCJO6Fps8D3EaL3qmcbCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S9UG6y4CvebEJBw9FxSBrsz0nFiCTyR7ZmmD/kHPjVpwqk6FEPQDmsY0br4ZAGt/Dx6h6xV/GypG4emtydXt21TS+bYhY/zLoJYNTnWbpw8DXh4YL/xqkd1CVVXnB90ZhU3DSK9yUwSE7IoHgRs9LmBj9gP7tqTAcfIi1VEt1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DUfeJ/FN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DUfeJ/FN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=pbmPpE8mMnjAgIXWDDbElp5ASlmrXM0LtksVRy1a5J4=; b=DUfeJ/FNYq8l4J/Jr0ryzimdQ8
	bJMHLZUr0dAK3ivmblDNAwmh8Po3iRWC4J3F1HHXuDFnN7wczU9BcDffGRO6usXB2VHgvU86pfJfE
	QWYBVQKpCbbM/IKofO3YAc8dE0wVaXe/Pmjze2wS0szFr1YEzcgjTYabMeR8z/jyykpwOIlfDo0dD
	+5Oetz3cjT3CTnM97nZ4PdmUTESgvcDbgX8YFjQuSNML2plCVOG94dgiaxe9mSQGfO6EpWkL/zSI/
	VtjE/luTmieqEAv/ar+PpvGXRV2y46NGWk9MARaaTeqUwm5Y9xQ3YUeCmh97+eMLzabpwP4oMrute
	VPgLdZxw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMSj0-001hUt-0e;
	Mon, 11 May 2026 15:39:19 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v6 0/4] mm/memory-failure: add panic option for
 unrecoverable pages
Date: Mon, 11 May 2026 08:38:34 -0700
Message-Id: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPv3AWoC/23NTWrDMBCG4asYrTNlNBpJjle5RylFv4m6sIOVm
 pbguxeniyq4y4HveecuappLqmLo7mJOS6llGsXQmUMnwsWN5wQliqEThGRQkYIUwvvVjSUAJ7b
 K9wp7G8ShE9c55fL1aL2+/d7103+kcNsC2+JS6m2avx/PFrnt/usuEhAsOXkkackEfYrJFze+T
 PNZbOGFGqpkSwkQjokxYjacrdtR9UdZPn1VgCBj8J6yJB94R7mluqUMCBSRrM19Nih3VDeUuKU
 aEJzSmb1GJh2e6LquP0R+mv+hAQAA
X-Change-ID: 20260323-ecc_panic-4e473b83087c
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4526; i=leitao@debian.org;
 h=from:subject:message-id; bh=K4UG75VqQ77yZouQJXp5unsCJO6Fps8D3EaL3qmcbCE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAfgfB2h2hSNGXKc5NXlYfVt3zK+lfErW3UxZ4
 fkBNJSbQ2aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagH4HwAKCRA1o5Of/Hh3
 bfoREACe9gf/vSU64Kie4JbjnMqkS5yPRCDzhi7HZbSYFHj2Amh9jgYk6w8REpIE7BDisf1BDFT
 q6+R+Re+AmA6JfB/yZc9QjhMSHpqjVc1SMkCC0Hm7ELNim+pm0KtCqhHLx19mVs3gtEhxPeggfR
 X6kepvv9CNmxWt0il/f0Nzcw0cJdJ196ZZb8A2utfxfQOphvgfgSjoE89Q0KWxO8pVm1qU1aJcK
 z0Y/6UOodWZw0C+5Bfatr5W2k5theRfg4z8T0hYOhvO5G+AlF/MklErfjEcCOkhxr1isMh2AqHh
 7N6C/iTER4DRITrIEXzgjSDMg1suecnIW/UuVPn3nFC05URTK+/jCn8YzJOrfXJdiqAMG4qTN3E
 YGVY/aEGgCdqN9qTUTQ6+X5xZbI18d1kUWHU7cpHMYCvwqdPiHPA4UDgB+TxcCzWuh6xR6UxJl2
 WmudQ70fvcc27WUb/+mH0Eoea3IOnDg9VPpLla4j9YxmUYrnLnX6I2skxyz0sWrNFxk2eqfiX4S
 ++2eKUZeTAo0YKlUvbbf6kaqzLG684nFqB3b6gSOABwrXW8pR/gw6KJ13oQj4K6mHRc7TGqh3Y6
 wLlzakHlQYzzFL2gE8e8PlYNka63itR8BMvl6sMxv2shNlGmSWUQximeHx83U/eqpHf6/th9G9/
 NqA1DqKdxWWs8DQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Changes from previouis version

* Replaced the late, action-time recheck for MF_MSG_KERNEL_HIGH_ORDER
  with early failure classification inside get_any_page() (new patch
  2/4).

* David Hildenbrand pointed out that the recheck inspected refcount and
  folio mapping without holding a folio reference, which is unsafe
  (concurrent split can trigger VM_WARN_ON_FOLIO).

* Lance Yang suggested moving the disambiguation to the call site that
  still knows *why* the page reference could not be taken, which is what
  this version does via a new enum mf_get_page_status (MF_GET_PAGE_OK
  / RACE / UNHANDLABLE) plumbed out through get_hwpoison_page().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
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
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

---
Breno Leitao (4):
      mm/memory-failure: report MF_MSG_KERNEL for reserved pages
      mm/memory-failure: classify get_any_page() failures by reason
      mm/memory-failure: add panic option for unrecoverable pages
      Documentation: document panic_on_unrecoverable_memory_failure sysctl

 Documentation/admin-guide/sysctl/vm.rst | 70 ++++++++++++++++++++++++++
 include/trace/events/memory-failure.h   |  2 +-
 mm/memory-failure.c                     | 89 ++++++++++++++++++++++++++++++---
 3 files changed, 152 insertions(+), 9 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260323-ecc_panic-4e473b83087c

Best regards,
--  
Breno Leitao <leitao@debian.org>

