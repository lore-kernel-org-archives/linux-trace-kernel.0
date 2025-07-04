Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D332877C7;
	Fri,  4 Jul 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636993; cv=none; b=Mjw/QJb+HLWKMI0jXfuVGDDDwIlpHsBDw/b8fs93XCs3No49gidp1I2H58dkwbF8aYk6LzV29ZJODKshE4tmwLNkvO8c5Sb8b6XQO5Nz/IotOPu4X8kmfoPWXcgOBh57TA60AT3HBqRMkTo2Tw1Bb8Rc6wlE2DfHMlVFs0cSwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636993; c=relaxed/simple;
	bh=RPKWI41dVFPie/nu06bres1q6kZy+kb86c66f3Y/tZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAoyDLQmUhQGiHVODN4iZuLSs23Fr33kFNFErf5JO8THuBbDwNhe9qGloL+GoWSaP6cu7GgzbIXPu9RkKkEeSxgOPTuX8zFd7xCoWTd3W/pAmqyfXOrUnlZu49dQGSJoTs3GX26vsPMuJbQuacB9g1d1G5TpVjhAWu7BE0sdLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjlGXGnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjlGXGnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF03C4CEE3;
	Fri,  4 Jul 2025 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751636992;
	bh=RPKWI41dVFPie/nu06bres1q6kZy+kb86c66f3Y/tZA=;
	h=From:To:Cc:Subject:Date:From;
	b=CjlGXGnZNUQ09Q2dji8FQ4JJtKPMwHPnjkuQdDJ/5x1ilkHQHVqrdaHScxCFQSZRj
	 FbOcjmD1SAI9b7K9+sfxm6JzxFvXfSnDREJPOF8/MiEttxvj6DlttNTHGmvu2IidWG
	 6waL6vHe26+TtUx6cWEGc498MtOWmzzt4Wz9FVORUUINvHGDbtINdXjBqGnIpOw9Cj
	 9dKFEkT0gQBlpxOEpA1KYgaLL5FV0SdNmljhBVJn/dcFTr1DE7Yidcl1J/ORN54oXq
	 dG/QtNlMlHEiUtWAlnQuCwS32P9KW3stTlCADhLh4VZ3k8nq5mlGqQn2YMpuiNwxv3
	 2lMuvwHCWzZpg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/8] x86: enable EXECMEM_ROX_CACHE for ftrace and kprobes
Date: Fri,  4 Jul 2025 16:49:35 +0300
Message-ID: <20250704134943.3524829-1-rppt@kernel.org>
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

https://git.kernel.org/rppt/h/execmem/x86-rox/ftrace%2bkprobes

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
 mm/execmem.c                   | 193 +++++++++++++++++++++++++--------
 7 files changed, 189 insertions(+), 118 deletions(-)


base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.47.2

