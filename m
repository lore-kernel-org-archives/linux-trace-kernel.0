Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7381367;
	Sun, 13 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391060; cv=none; b=D6hHvmRSw+OmJIr4/2qwQORe3f6JCvooJ573AL1cP0Jwcc2ffBhu/S+5XE4jI5GtbU354yI6haoY+EeNj2Ksx0ccptSfn+zp44kEt1KzVk7fBGcm4vXpHtQ+Q7zjyvkgeemG3KFJKP1yzsz5ZmOcLIfWZLE5d8HkuKtoeQUoiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391060; c=relaxed/simple;
	bh=sCEGchPk57A1a1Hap+1jxUD6UZPcz9tgIrKQpcRxyis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZSEnUgXIKjy2GoNvKrcFo3c9TdEfHMUjdFKIMPDKOpZCGRr2H2sCo8F9YU7HA/D7MdGZFXsxs/nHEIcs1m+ug1D/YwioysX+XIygYn0wRjT7ZwvgVc2rz3vKyBXDHfqBdNoJxjN+iUJAo7SR3B5eNifWOjLXGv/mGbzrDXrOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj9wKHy2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj9wKHy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD38C4CEE3;
	Sun, 13 Jul 2025 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391060;
	bh=sCEGchPk57A1a1Hap+1jxUD6UZPcz9tgIrKQpcRxyis=;
	h=From:To:Cc:Subject:Date:From;
	b=cj9wKHy2Rk4JCQgZuB6e4IvnTq8AWaZ5Wv+qxuR6VlwQZDx/jsCQJshf1KNE6q/0A
	 xUM/vTsiWCZ7I0YPS4Z5bk4U1XOGx2oNlFKlS2ZCH/Wqa5A9svaIolJbcbAtRx8o3r
	 E5V0MfYYueJdleQO242WfkDTZDVAD0fjyJftWT+d7SQsz055+uKD2YjArZckuBocUH
	 3mC+KHG33IHdCqRtu96zmTulgn3n6vgKjjJG5O7QtjN9zxAkq9+ZddYDRgTn+MxkrV
	 vnOScBdoJJ7/dYe5ed+B+a1YP4yrc9Oq+OmmLSfYuYbmwMt4+S4K8Bm1kbt9p6MQx1
	 FAy2EghCCyEeQ==
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
Subject: [PATCH v3 0/8] x86: enable EXECMEM_ROX_CACHE for ftrace and kprobes
Date: Sun, 13 Jul 2025 10:17:22 +0300
Message-ID: <20250713071730.4117334-1-rppt@kernel.org>
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

https://git.kernel.org/rppt/h/execmem/x86-rox/ftrace%2bkprobes/v3

v3:
* Fix spelling (Petr)
* Add ack and review tags, thanks all!

v2: https://lore.kernel.org/all/20250709134933.3848895-1-rppt@kernel.org
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
