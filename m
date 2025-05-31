Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655122259C;
	Sat, 31 May 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677789; cv=none; b=IJH1LmnM3yjiLmdKbhVTkL5eOnrFDlgZ6+C53q5WuPA2FceNDdCKoqndFV7zZh92GoF3tPdX74QQg2kfXzGnHCAu4QG24upU0Or9NKCX/AUZqogZAI1F3uDhA40jqtUCypXC9Of/pK6HGHmzk8xhx83BL7ZGWePSjSbT7CNRx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677789; c=relaxed/simple;
	bh=C23frJRaDHSQk3U93KLhYqeyYDN3gwDTYfOh2Q08BMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SPoPzG78EOx0kGaGsWA0K3MJtTUQyCQJ9c5YuPGgDSJXLEPDB9htLKh3EW2uvFjjEu4C8mfJcf4AWn4I57Qdl0vGyW7S9X1+LjIqDG1wFR3HSa78r2xxVxrkuDRmPEv+41rlN/gwJwNC+OFtbqdgTgKssb7xgOrU68vfdtSuB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPGZrbB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhpJQYvm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPGZrbB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhpJQYvm"
Date: Sat, 31 May 2025 07:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748677786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2dQZGZiVXbPX6pz1wr8QMCfnqgrExGw5IHm7j/528o=;
	b=EPGZrbB9WRIoJAoGQvQFvUpdp1H9UPL+tenrWldvjxu6E4MluSabhAnpQPpT0nXgaraxPs
	opki3EucJPYiprVCrVMiOaleIm3hP/r53JMOwatn3XZ9Q7WnrC1sY6cvvjbuGKOYULnsGA
	BExOb5OCsUSo1N4qOrrNaTERnOMsd5qhKzWITa99CyRNikjn4xctoEML6BUQt9ZdYg54bM
	J2cXfF5Zc3a6yMWftmp6QfCtvy3Dq9+bkTDe0/NFvguMB/QbgLzyFbLkofxx+cNH71+B1E
	GgziFh5lGS6B3JAYM76MVsBVthZuBr9F8xLJgD2pOxWlb06epQ/zKLoPHSOfqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748677786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2dQZGZiVXbPX6pz1wr8QMCfnqgrExGw5IHm7j/528o=;
	b=qhpJQYvmmQikMjGCrfSAr+fStSRmCX1gBaHWX+vPX4bi3tzkoBK6G+SVUKpB0douBSRz1J
	Pt6KWcaUwn0b5NDw==
From: "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Remove unused trace events
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250529131024.7c2ef96f@gandalf.local.home # x86 submission>
References: <20250529131024.7c2ef96f@gandalf.local.home # x86 submission>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174867778456.406.2535316646277526444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     99850a1c93fe7ca40ad9efddc00acec6e85c5e48
Gitweb:        https://git.kernel.org/tip/99850a1c93fe7ca40ad9efddc00acec6e85c5e48
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Thu, 29 May 2025 13:10:24 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 31 May 2025 09:40:40 +02:00

x86/fpu: Remove unused trace events

The following trace events are not used and defining them just wastes
memory:

  x86_fpu_before_restore
  x86_fpu_after_restore
  x86_fpu_init_state

Simply remove them.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home  # background
Link: https://lore.kernel.org/r/20250529131024.7c2ef96f@gandalf.local.home    # x86 submission
---
 arch/x86/include/asm/trace/fpu.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 0454d5e..721b408 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -44,16 +44,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_after_save,
 	TP_ARGS(fpu)
 );
 
-DEFINE_EVENT(x86_fpu, x86_fpu_before_restore,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
-DEFINE_EVENT(x86_fpu, x86_fpu_after_restore,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
 DEFINE_EVENT(x86_fpu, x86_fpu_regs_activated,
 	TP_PROTO(struct fpu *fpu),
 	TP_ARGS(fpu)
@@ -64,11 +54,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_regs_deactivated,
 	TP_ARGS(fpu)
 );
 
-DEFINE_EVENT(x86_fpu, x86_fpu_init_state,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
 DEFINE_EVENT(x86_fpu, x86_fpu_dropped,
 	TP_PROTO(struct fpu *fpu),
 	TP_ARGS(fpu)
