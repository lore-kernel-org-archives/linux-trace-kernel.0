Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A82E265E;
	Wed,  9 Jul 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068984; cv=none; b=NZx7MQ0QlhpWVdolJTa2BPOFw3hJ9DuiZZu3EynZ/oocDAgnWG6kLfAWtfFpAzhnzbRFD3dA4OTJT4gMf07zKVtHFbZb5E2WiNGtrcAU+YwSMB3+B5nqIdkj8xuDU2NnuUQVe7kLsEeykggQbJ0NE5DVn1MGRpNx/P6HxVGcs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068984; c=relaxed/simple;
	bh=VN2woUV36uKtPWLPulMKBWZsAUaYBos7bihIOQt7JRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr472A+u2q3OEKVRK75byOhL0Ldh8yjaBDWAMSCBATauiIdgZ7nSoOaZ5Kv3qArG109AHnk4CJIULTVysRIRVpPW0JhegrSL2ePCDrhaMzeYGKHXwKPVO8yUNkhnVREdbNCLRuoaTDBSelXkIelL3S02YHLo7mPDgoOxOSC9nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8+3b0yC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8+3b0yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803AC4CEEF;
	Wed,  9 Jul 2025 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068982;
	bh=VN2woUV36uKtPWLPulMKBWZsAUaYBos7bihIOQt7JRk=;
	h=From:To:Cc:Subject:Date:From;
	b=h8+3b0yCvh/DCn7BroIAnU6+Ecnmx08FcxAgL7q/b90kZCN17GNfESOsQbawusi1P
	 7ouY11jmMuVbl2o0w7fI7IJb8VN+945vVYRXlY2WkwhKK2nUD2WMKzmtgDCtuKJDeM
	 Z2Kkd6fqWBvGYhDf0f+En/dIFSuGkJyLyjpfHX+lBzjILmJJ8ZwwarOG/moK/SGJsR
	 Sdk5cwcEOtCPzLy/JX4k9VcXSERJpaRUI0y1XrpcNVatww1Ivo1q526DYND3P1+Cg6
	 9k/t+ujYo9y6j4ZPVI6kXKZLVFP6bFLM9zu3+RqWUhEwwAoeW5BHl143owx7lginPa
	 bYNXCQmM52/Qg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 0/8] x86: enable EXECMEM_ROX_CACHE for ftrace and kprobes
Date: Wed,  9 Jul 2025 16:49:25 +0300
Message-ID: <20250709134933.3848895-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches enable use of EXECMEM_ROX_CACHE for ftrace and kprobes
allocations on x86.

They also include some ground work in execmem.

Since the execmem model for caching large ROX pages changed from the
initial assumption that the memory that is allocated from ROX cache is
always ROX to the current state where memory can be temporarily made RW and
then restored to ROX, we can stop using text poking to update it. This also
saves the hassle of trying lock text_mutex in execmem_cache_free() when
kprobes already hold that mutex.

The patches 1-6 update and cleanup execmem ROX cache management,
patch 7 enables EXECMEM_ROX_CACHE for kprobes and
patch 8 enables EXECMEM_ROX_CACHE for frace.

The patches are also available at git:

https://git.kernel.org/rppt/h/execmem/x86-rox/ftrace%2bkprobes/v2

v2 changes:
* Fix setting and clearing pending_free for an area (Yann)
* Reorder execmem_cache_free() to avoid error goto (Peter)
* Add comment why mas_store_gfp() cannot fail in execmem_cache_free() (Peter)

Mike Rapoport (Microsoft) (8):
  execmem: drop unused execmem_update_copy()
  execmem: introduce execmem_alloc_rw()
  execmem: rework execmem_cache_free()
  execmem: move execmem_force_rw() and execmem_restore_rox() before use
  execmem: add fallback for failures in vmalloc(VM_ALLOW_HUGE_VMAP)
  execmem: drop writable parameter from execmem_fill_trapping_insns()
  x86/kprobes: enable EXECMEM_ROX_CACHE for kprobes allocations
  x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations

 arch/x86/kernel/alternative.c  |   3 +-
 arch/x86/kernel/ftrace.c       |   2 +-
 arch/x86/kernel/kprobes/core.c |  18 ---
 arch/x86/mm/init.c             |  24 ++--
 include/linux/execmem.h        |  54 ++++-----
 kernel/module/main.c           |  13 +--
 mm/execmem.c                   | 198 +++++++++++++++++++++++++--------
 7 files changed, 194 insertions(+), 118 deletions(-)


base-commit: 86731a2a651e58953fc949573895f2fa6d456841
--
2.47.2
