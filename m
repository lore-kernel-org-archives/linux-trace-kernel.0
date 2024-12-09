Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97805487A5;
	Mon,  9 Dec 2024 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712081; cv=none; b=uQ3dgRmjB+G8OqeQBC0yuvmi/MVwaurMm5kbayzaY0UVnnHvJHqtR+IexsAAxnRDOMt4/MDd4/T3BF40aCGF7GVLN0uvKo5YZzvRBLRDBMTI6R/Ro3Uue1HvBFmKxM7Ex2Xs6KewpElvY1+nNW8zfI8MexbPr9HqXqUVj/LuvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712081; c=relaxed/simple;
	bh=HKISBZfln6I7KM8OMFNC3uKPwof/poz/+cHr+oNkTF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzI3ILOP91OyKsNPnmREiB0ID26PMhub63AqhYHmdF5xpdyFlsp65cP9SHTd0rt50yMY7/9i8nirspod3sWCrBA/R8i67Mfwft9zwKgJt9CmiUSs8NjA8p5Cmzvzxs5ob4A1QFTPB2hi5xXL/zFNVmIulso3+UO8PLHVGnGC+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNccMC2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNccMC2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCAFC4CED2;
	Mon,  9 Dec 2024 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712081;
	bh=HKISBZfln6I7KM8OMFNC3uKPwof/poz/+cHr+oNkTF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNccMC2Rd7bKnI0DGnw4V7/PuE8jBNZOqBbc0bsspSH2WfRAKYXuxuXj341UEO/tM
	 2PzOeI1jSXnANb7top3admU9KF56xSrn8qtkSgsNNSW+UHMhHSl3t0jDYfjgm4Th+9
	 9jh8ayCcPXi/1J/8YioVmEQQNAkyhQlLyOvFe6e9BqQDo4y6S6nsTGMARQ+x74TcjJ
	 6Ls6ui1kcQLBcifgNxADd+qdvAAJ74nh4VYVaEi5BlsDR2AdaN4dTZfYWL/43/l4Re
	 xigjTvETwixiA/A5ZKTryPJiwiXa4Ndmv7wEPYBsn9TFrLdwLbJHh58uvTzKRr4zDb
	 CrMSxECIEHIFg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/5] jump_label: Define guard() for jump_label_lock
Date: Mon,  9 Dec 2024 11:41:11 +0900
Message-ID: <173371207108.480397.12818384744149153972.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173371205755.480397.7893311565254712194.stgit@devnote2>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
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

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/jump_label.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f5a2727ca4a9..fdb79dd1ebd8 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -75,6 +75,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 
 extern bool static_key_initialized;
 
@@ -347,6 +348,8 @@ static inline void static_key_disable(struct static_key *key)
 
 #endif	/* CONFIG_JUMP_LABEL */
 
+DEFINE_LOCK_GUARD_0(jump_label_lock, jump_label_lock(), jump_label_unlock())
+
 #define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
 #define jump_label_enabled static_key_enabled
 

