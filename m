Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750311;
	b=1G8A7ThgrQUf0QepA0ZllCYSfxyFQbAS8WzUzM2Ua4YudnnemqMeOdbJ12HK0qCQwLI2
	 t5y4AYyqSCVL4D6TAnQpxYarxk5tjgKlGgBWBBpFp2tMQ90n7waII9BRvjL4rppXtH1/X
	 oqdh91flBZ6RhgxhOqRuXc0JT+gjQZIE2Snz8t7GSmt1b5adMfQJtw/yZG+vU3hq6vCS8
	 p7/dDaMt3+/OqRT6GhxmtT08ULEpsQAE89C/zeivSf5Ttzh45jEc6iOJ89UsxRCXxsO5W
	 a2oq/23dmnzLu+dqYALVpfK9yH1VCp/t3yVkp6I8CunpgRqRscLqbjoQ+VWHZRTs00g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtpMGXn6abTyMRryHDv190F6dfuF6J5qpum/vAejTmw=;
	b=0Z1gs534+Jb/vbbiznXbZP/3gKhs+5IJ6/DCMnDNoCQ4AsS7qQwnpp623C3bVbgCySF+
	 2d/k1XmIKIbtmhVcSbJL1c+RbNmkvSpsR0fE//Nj1mOjwxyNMbUmc7UXKfjSml5frBIKK
	 gPpMV5KG8tSOo3TfLR6xEi+4zzbwKzkIR4jDehzHB0f6yqDZw4oYoWUhmQc3rXxWoZ/KH
	 TCjO5sAg3e7cAWLwV/Y2dtpG4d7q06PZki080Ef8MeyGCgnvalcoNE1pGVYeL1RXdT5UY
	 JEwcQz0V2dktEC8WTRvGEeK3ffxPcXhDERmvQqjbyTi4StSGzzHKhRf5HJ3N39z48aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZYqLGoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CD606A31B;
	Tue,  3 Nov 2026 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZYqLGoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2C31F000C1;
	Tue,  3 Nov 2026 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750311;
	bh=JtpMGXn6abTyMRryHDv190F6dfuF6J5qpum/vAejTmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZYqLGoSfK/R7kmQaPdDQBQDh9nur37wJ1FSHvAbmjoPYqa8tgn19YBTnjowxLyPv
	 AjXlaWQc6/RwVEAVsNl+8ExU4K+H7CFZ1z/E/WcQyoAgZRaQyIZUepnZkn7hyVVvio
	 lHOXN8t00YIMtA/R22zSw/18Vj3yy26czmX7zEv8pfkJ+FytoxGuSI58JKevbpIC4J
	 1UPoyx3rCt4j0L7ZOqedm0W2pWZkFLUuFRRwLJ6AzUZIGkXV23xKDDfNmzHK6p3u6z
	 ByGHAUgfV7VUt1exXJfMoAyRILvHYgfzybdGhR95kUdZqlZqLUFkbMNVsFsMk9E3gD
	 sIgnO8zz3bryw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/8] kprobes: Fix error return and slot leak in __register_kprobe()
Date: Wed,  4 Nov 2026 08:58:27 +0900
Message-ID: <179375030756.247640.10859474201266455798.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When arm_kprobe() fails in __register_kprobe(), the probe is removed
from kprobe_table and synchronize_rcu() is executed, but the error code
ret was ignored and try_to_optimize_kprobe(p) was executed, returning 0.
Additionally, the instruction slot allocated by prepare_kprobe() was
leaked.

Fix this by releasing the instruction slot via arch_remove_kprobe(p)
and returning ret when arm_kprobe() fails.

Fixes: 587e8e6d640b ("kprobes: Adopt guard() and scoped_guard()")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2441b9e39343..10946658bb35 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1946,6 +1946,8 @@ static int __register_kprobe(struct kprobe *p)
 		if (ret) {
 			hlist_del_rcu(&p->hlist);
 			synchronize_rcu();
+			arch_remove_kprobe(p);
+			return ret;
 		}
 	}
 

