Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93802877D6;
	Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413440; cv=none; b=KcLIG1G3eYq6opCB8v52MSrsodvxApcAIIAUkd5qy8Ow90Hl7TeuXCLx6eM5hrONgbA6xFU9MsM9vYhxGcg6L8WFawl5FsR1zAXxkSEkNR1FKqhOizyZZfxCi/b9h/SmsUbc4pS9TfWLmUif0N+TJ4ke74DgPylrVc+7QDci5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413440; c=relaxed/simple;
	bh=nPb9r5xc48msrxBmpoagi+qom8Er+5KVlPdst7SNsto=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Zm6hjhfZQ5Pdk/lcxsteR+C7jwnzfDcfC2P33+3c8OtJdyFY85Ns9cxBirW/pg+etpY+cZslkn0teOg0VgHeFvTgemqE7AC5uvUn3CwCEgsf0kIlrTxwQp8ZGIi14ME4nAkJqsP7chmC9LQT+HDDg2g5+oHO4nVl5C0NOz5H+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Tg56tH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Tg56tH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F17C4CEEB;
	Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756413440;
	bh=nPb9r5xc48msrxBmpoagi+qom8Er+5KVlPdst7SNsto=;
	h=Date:From:To:Cc:Subject:From;
	b=J3Tg56tH/gP1+BJeR1dMNQg94rkArS6dXg7MsP9JC1c6J2mLuS8lJmO8wh5FDmsvJ
	 IOpjVkfYsu0BHLpgxkSV8Nwf/b7I8FTpdNBwBHiOdmiMYXOxLvCwB7IMN37igcG8pR
	 NGH5IyP5EjC3TZFXQS5U58p9kyNx06kG0XFqVCqe7j69vUEfHosak25ZBrk+s8POii
	 JyxOwomvg9EmTQMR6qKAvdzrT38F723Of6ZIr6x7ATwC9oLGJYCAnB9gYb7bxVvvf/
	 wayXKjqouE4+Io68ZV24MrvWUXaAbh0jS/5wid3rgI0vyWFTrvGcXqiNrRRu5JfX78
	 LEVr/Cco1euCw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urjNN-00000004JRl-0qhX;
	Thu, 28 Aug 2025 16:37:41 -0400
Message-ID: <20250828203555.783399758@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 16:35:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v8 0/3] tracepoints: Add warnings for unused tracepoints and trace events
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Every trace event can take up to 5K of memory in text and metadata regardless
if they are used or not. Trace events should not be created if they are not
used.  Currently there's several events in the kernel that are defined
but unused, either because their callers were removed without removing the
trace event with it, or a config hides the trace event caller but not the
trace event itself. And in some cases, trace events were simply added but were
never called for whatever reason. The number of unused trace events continues
to grow.

This patch series aims to fix this.

The first patch moves the elf parsing out of sorttable.c so that it can be
used by other tooling.

The second patch creates a new program to run during build called
tracepoint-update (note this may be extended to do other tracepoint
modifications in the future). It also creates a new section called
__tracepoint_check, where all callers of a tracepoint creates a variable
that is placed in this section with the name of the tracepoint they use.
The scripts/tracepoint-update.c is used to find tracepoints that are defined
but not used which would mean they would not be in the __tracepoint_check
section. It sorts the names from that section, and then reads the
__tracepoint_strings section that has all compiled in tracepoint names. It
makes sure that every tracepoint is found in the check section and if not, it
prints a warning message about it.  This lists the missing tracepoints at
build time.

The third patch adds EXPORT_TRACEPOINT() to the __tracepoint_check section as
well. There was several locations that adds tracepoints in the kernel proper
that are only used in modules. It was getting quite complex trying to move
things around that I just decided to make any tracepoint in a
EXPORT_TRACEPOINT "used". I'm using the analogy of static and global
functions. An unused static function gets a warning but an unused global one
does not.

Changes since v7: https://lore.kernel.org/all/20250825231301.433412523@kernel.org/

- Removed accidentally added .PRECIOUS from Makefile.vmlinux (Nicolas Schier)
    
- Fixed some comment issues (Randy Dunlap)

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/core

Head SHA1: d2bdb5b9bb9047849016b7862741282900665a08


Steven Rostedt (3):
      sorttable: Move ELF parsing into scripts/elf-parse.[ch]
      tracing: Add a tracepoint verification check at build time
      tracepoint: Do not warn for unused event that is exported

----
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/tracepoint.h        |  12 +
 kernel/trace/Kconfig              |  10 +
 scripts/Makefile                  |   6 +
 scripts/elf-parse.c               | 198 ++++++++++++++++
 scripts/elf-parse.h               | 305 ++++++++++++++++++++++++
 scripts/link-vmlinux.sh           |   4 +
 scripts/sorttable.c               | 477 +++-----------------------------------
 scripts/tracepoint-update.c       | 232 ++++++++++++++++++
 9 files changed, 802 insertions(+), 443 deletions(-)
 create mode 100644 scripts/elf-parse.c
 create mode 100644 scripts/elf-parse.h
 create mode 100644 scripts/tracepoint-update.c
