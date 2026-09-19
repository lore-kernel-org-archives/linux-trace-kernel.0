Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1449620
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789789079; cv=none; b=VevXbI05Myt+I67hVMfk1xrTo/gf50emyYkOw+i5AAvvpZ4NiBosWfhPKmztUgSuBl8kN4xGKiG4yNE1kNrqY24EvpCtH/7p7XKuvtmqiQP6ntKtAq7YU1oKG3PV0bEpM6a1SmrIFQ1wE9YYJPrk1u6h0VgkVFlw8VPMTae6dZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789789079; c=relaxed/simple;
	bh=Ae8JSmFXzu2xPCKgoOVtXk9lHBZXVRotM4Ep+vNNIKU=;
	h=Cc:Message-Id:Date:Mime-Version:Content-Type:To:From:Subject; b=CEcuw5p/08uaqqLKtYXh3VLnweYdcgVBgFUrrm9Go72KXbzbvqPsxamBviV+8q1d6wQ/DxvOm22T1L6GDjtY8wgdXyZbKIHEWB6z+O2lGiMJImYCZ4x9T2+qE7IvQcnn2Y3mguNAFxO49uycQFnw9MZZktMVUEOrtEwHKLmHIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CTyfb2m7; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CTyfb2m7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789789067; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tITefMGqaFRIFOyQ8G6JxHpJ8JHWEXlXUu5h2s/nSBo=;
 b=CTyfb2m7IkMzLj27iHtTKxQq3349EKzYBps+tEpHqDioDL7pZyMurycIqyK8o5f+o9xrJj
 Aeb+P3F2HhO+vSss4wKnkzb9aCRBb7bKrFlF3jF9vhi2xS47TypmmlWsdERiYharekfajb
 W7IMDAIIrYvc+WSdE6einjD6EoYOxQDx6T+N4AqzkwtON6Y8et/697q8WxW54MocWsSWIG
 x9IdxmJIWT6ZZ+9Gc0XpJvaHarFLsxQw4RmcTezABrXRP+avDWPKtjQ6E1FWspuCvUmjVu
 8rzLPNz6lQjOOYVxzEW7XwajukcmzMncR2AS2vz8F13Ov319ESgAp0aP3OWGmg==
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aae0389+5feafa+vger.kernel.org+qirui.001@bytedance.com>
Cc: "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	=?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
	"Chunyan Zhang" <zhangchunyan@iscas.ac.cn>, 
	"Guo Ren" <guoren@kernel.org>, "Jiakai Xu" <xujiakai2025@iscas.ac.cn>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>, 
	"Song Shuai" <suagrfillet@gmail.com>
Message-Id: <20260919033726.1361382-1-qirui.001@bytedance.com>
Date: Sat, 19 Sep 2026 11:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
To: <rostedt@goodmis.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH 0/2] riscv: ftrace: use frame CFA as the function graph retp identity
X-Original-From: Rui Qi <qirui.001@bytedance.com>

RISC-V dynamic function graph tracing currently saves &fregs->ra as the
graph retp -- the lookup key that ftrace_graph_ret_addr() matches against
shadow stack entries. That address points into ftrace_caller's temporary
fregs frame, which disappears once ftrace_caller returns. Later stack
unwinding finds return_to_handler in the traced function's own frame and
looks it up with the frame CFA, so the saved entry can never match. The
same mismatch breaks function_get_true_parent_ip(), which looks up the
original parent with the saved entry SP rather than &fregs->ra.

Patch 1 clarifies the ftrace_graph_ret_addr() documentation: retp is
compared, not dereferenced, and may be any stable frame identity as long
as the graph entry path and the unwinder use the same value. 

Patch 2 makes RISC-V use the frame CFA for that identity: the static _mcount
path derives it from &frame->ra, the dynamic ftrace path uses the saved
entry SP, and the frame-pointer unwinder tracks the same CFA when
recovering graph return addresses.

Build-tested for rv64 with gcc and clang (full vmlinux).

Rui Qi (2):
  ftrace: Clarify function graph retp identity
  riscv: ftrace: Use frame CFA for function graph retp

 arch/riscv/kernel/ftrace.c     | 10 ++++++++--
 arch/riscv/kernel/stacktrace.c |  2 +-
 kernel/trace/fgraph.c          |  7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.20.1
