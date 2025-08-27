Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF22D481D;
	Wed, 27 Aug 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323490; cv=none; b=PjuEiBOlLQJrR/hFUNwvoUcO1ka2eXq9mLeNH8Aq3UKJdeMLip58VIsIr9AJhYh3T7d5JlewDqklu6+p4HDGqYHDKqw5ujfu8E9xrmM1HJoIYlIs0HBzOT1E+RkZDODn6EBz5UewS9Au6Gt1OiSQJxOp0GS3St/tsI3DsaHHYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323490; c=relaxed/simple;
	bh=ZImEaWvq1/Y6zubm2SDsVXejBSlaS+jZK0Km2/7ysSo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=SQydDGnN5edSAUziXohJVskT5CizMjAtNpinZfbx7WoWInT2csdeEk9wETZHH8jB9TtMvvDgGcyxTnENVuTltXLgze4nxUl/X9H4puRs/r0SFC8RIKbal+0eA0mPXEU+rMqsEvbM9Q+xxk2wmRK16F+bdqOr1535Kz4RCDPe7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN4D6+OC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN4D6+OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A33C4CEEB;
	Wed, 27 Aug 2025 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323489;
	bh=ZImEaWvq1/Y6zubm2SDsVXejBSlaS+jZK0Km2/7ysSo=;
	h=Date:From:To:Cc:Subject:From;
	b=JN4D6+OCqwZoK6/MoMpia8m7QeQg+QUFqYKjlP6DqVkD3KaXVIx7ju1ng9HRAuIwp
	 6LxSo+DaUkqk9KFHnVa6yV+ljHZ9M9CpBJ8jvIJQtQU4O6HvG/6VKxvXG5L2VQfI9L
	 GiPriCpG7OLfEO4ZoUxf8fzWSFtK1srGSzBGxqQvEPvsop3fPGHuojyvX6rDcg/1fJ
	 /zzsrLAWCIMGcbgV/6Webtp4k6RYBH7gMOqXYlZ/pmsE2VANKmrptlqfbG5JBtscR2
	 Tk2xHFjR9esZ5X4+qVM8MNh8HtIpHT3YrBZ+n1TlvHcARRiO/TMHCRsDqJyR4WBOKK
	 510Ya+fm/Q2+g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urLyW-00000003jGL-1M5E;
	Wed, 27 Aug 2025 15:38:28 -0400
Message-ID: <20250827193644.527334838@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 15:36:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v2 0/2] x86: Enable the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

This enables deferred unwinding for x86.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250820190546.172023727@kernel.org

- Added #include <linux/compat.h> to use user_64bit_mode() in
  unwind_user.h. When adding this to the ftrace code, it failed to build
  due to the missing header.

Josh Poimboeuf (1):
      unwind_user/x86: Enable frame pointer unwinding on x86

Steven Rostedt (1):
      unwind deferred/x86: Do not defer stack tracing for compat tasks

----
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 23 +++++++++++++++++++++++
 include/linux/unwind_deferred.h    |  5 +++++
 kernel/unwind/deferred.c           |  3 +++
 4 files changed, 32 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h
