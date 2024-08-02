Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FA481AA;
	Fri,  2 Aug 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606801; cv=none; b=UC0Br7WnacSepI/i1pgq8hh/v6TvAB1B8MyyMiFVtefug/RaIKPpgLjuLQr91myBDquW7tC7NfPC6vbuZ6kDjiYeRaxDC1qVDxRQE8ISmMayaEy2HLlYg4UHKLbkEJX7eaeLNFAlLgkp+QpXH4ECcDBZEIuFhaLf2l9hD0xmU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606801; c=relaxed/simple;
	bh=3n2ya+jbdyzLK+mzTm9yAnai5QBP4v/XnqKgRzqFLBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AWujMQa4KvcGvRaDg8ZPnci1MQN9Xf7MSXm3WrgN3igQDWjYru3kt5c6w0qEmeUoBC6R019QJ+6v9ao1elWavRbRrro5GYkoEG9AmPcuRvIvgCFOWLmrbreJVx3GPW8kI8rdQV2gbHW4mXfcFz25D8cOtTQDu5ABhPvxXBI0dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNbwF4jw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNbwF4jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC77C32782;
	Fri,  2 Aug 2024 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722606800;
	bh=3n2ya+jbdyzLK+mzTm9yAnai5QBP4v/XnqKgRzqFLBg=;
	h=From:To:Cc:Subject:Date:From;
	b=SNbwF4jw4HRYQqK6fxYm0qSpsPTmC4K2HhmL7UrvMaq3kji9sRjkV6s5S/6c5/LX+
	 P7ZV+A9X6SdC6mqwtS6jlJfmWbFBuiMLdM+8jyQOGxWN4cHeDYGNk/nreDjDl8iykd
	 krKv6ZV9Ixw74MTwg6p5doFbJNJGUZ4VjuKfd5N0/nmUoiCP4M455dU6o2pcwM8FeN
	 7wsBS3ACbcTreQnWDH+NexYMSDry275ZI6gd49eS6KRjkYTh47DykgTK1RF4+blQVj
	 7gBfvK2GK06XcW5hOYRhdY+b4Q2jpg7fyHkoPGRfU30sx4tcx00l/IfIdwaIHkOQ5o
	 J68DEkSgX6FnA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Fix to check symbol prefixes correctly
Date: Fri,  2 Aug 2024 22:53:15 +0900
Message-Id: <172260679559.362040.7360872132937227206.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since str_has_prefix() takes the prefix as the 2nd argument and the string
as the first, is_cfi_preamble_symbol() always fails to check the prefix.
Fix the function parameter order so that it correctly check the prefix.

Fixes: de02f2ac5d8c ("kprobes: Prohibit probing on CFI preamble symbol")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e85de37d9e1e..da59c68df841 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1557,8 +1557,8 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 	if (lookup_symbol_name(addr, symbuf))
 		return false;
 
-	return str_has_prefix("__cfi_", symbuf) ||
-		str_has_prefix("__pfx_", symbuf);
+	return str_has_prefix(symbuf, "__cfi_") ||
+		str_has_prefix(symbuf, "__pfx_");
 }
 
 static int check_kprobe_address_safe(struct kprobe *p,

