Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF93D16EE;
	Mon, 30 Mar 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875022; cv=none; b=doL5/IrcnKebxVaccn4W0N/RFN32wyu1fsN7ZyQSvoqOvXU3fiB12mZQMZ4qAHA09cllOQiCIYbvh7Xyj1gUGpMcVl13Y93n0JoogS5DdSOmC1b5AzzVupNPz6Zz53ILGMHFSDI8w7pc/HmwG9K33coFhsxr7SmbRkjxSKxBADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875022; c=relaxed/simple;
	bh=KiXl6D4P1qHHuBke+upWrE3oVkO09pvTUZyEhv/Ilqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJaXv6g77Y5hcujga2YznRqH7hPmrCc862539Ch5w/2GK5dYNqPlLEAtSrjmbYNUFbm0iNiR9I53mdlfawnIaeRv9ZoVlVoiJNIrOMnkfaHHbXvRTaJxAerMCo3qgjgzRdn5SySh7f/7roGGBG17TbI5nQd/qg++c+onuBjMPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx0EAp1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx0EAp1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E85C4CEF7;
	Mon, 30 Mar 2026 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875022;
	bh=KiXl6D4P1qHHuBke+upWrE3oVkO09pvTUZyEhv/Ilqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vx0EAp1OeUUAZQGlogE7revZaYEgSvB6uimIC9RAhZqHtZLZad4k/mxcc7gO/irOE
	 0muZUh/W6ymuzQLavPF9uU1iqMNsrtsFGXesFDuuqsZev+NlhRkkHxsDjVXPEnaucL
	 WEFprh8m8lzwli72l4JcS9RAqCe5kYr/Hf0elKCmSzyJb0KIeLtu3hm/4ttBDiCTrY
	 lMxEh7kNf6seopX4a9FUOFpM18PvgZrPFKGvjWzkVN9LX6bTvgamWxRHeZbnqK4bSa
	 8LOMbRHGzMS3B4u8oYGn3VXQUKGb/rhsGLxhpbrghgkxiMh8rQzc5cwYydEwAhY+AA
	 qgWWCm8PRyekQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v14 4/5] ring-buffer: Reset RB_MISSED_* flags on persistent ring buffer
Date: Mon, 30 Mar 2026 21:50:20 +0900
Message-ID:  <177487501981.3463592.2886576368556755178.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To:  <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
References:  <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
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

Reset RB_MISSED_* flags when the persistent ring buffer is
validated at boot. Since these flags are used only in reading
process, such process should be stopped when reboot and never
be restarted. Thus, these flags are meaningless in the next
boot. Moreover, it can confuse the read process after reboot.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v14:
   - Newly added.
---
 kernel/trace/ring_buffer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e5178239f2f9..5049cf13021e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1903,6 +1903,7 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
 		local_set(&bpage->page->commit, 0);
 	} else {
 		local_set(&bpage->entries, ret);
+		local_set(&bpage->page->commit, tail);
 	}
 
 	return ret;

