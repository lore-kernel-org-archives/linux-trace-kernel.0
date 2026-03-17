Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FF371072;
	Tue, 17 Mar 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740188; cv=none; b=LXA0IUU69ZhwI7a3srFFQUCpoItdxVamUewgghNoyEH6jBJ4XysFltbfWSGa1fORxprmZuyB5H18I7tQseQg8MvFNxATcPmBcHyg/4yx49oVgg91ZElPq642KrcHCt65Lw2BZqAYdESsQaWmxF0emqwgSheMy8PDnYRkNuV5UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740188; c=relaxed/simple;
	bh=dnkb6p/eQabzlKwOsghBnbUtdqt485jhvOonh5ntruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia4KSUYmpTFY4J2XuPmOoGGxas0sARX0XWLDoMsONxv/pulqI5zZJQrNM2CdgCKyjyBISVUOgwQss0glnEDOTVuxjmsRNE0n+wrLxKs6MGl05bbFs8fkZDZIwh/2C7kntp2KUn74Hq74LKQChrbSIFQ7NxzDKHQ2YhT2yhJU9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkNCI6KC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkNCI6KC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DBFC4CEF7;
	Tue, 17 Mar 2026 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740188;
	bh=dnkb6p/eQabzlKwOsghBnbUtdqt485jhvOonh5ntruY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkNCI6KCcoSbIGE35yWrT+la6Q49tptr7+dkvUP6rJZY+XkXdKqhFK5Czo6s37+kI
	 pBZQ+YL3c7YKwMi9SARLtsnDMysC8poX/CpruZTxBRpCDTl2lT6aUXxNyZsJn6Y/HH
	 fP8FmxS9bCMT7vep7SCDKfFgHlOIP7j0zfiAWUxxbafhNmQ6crC1xH4/dG5aD8VlKr
	 zqFIOgojExK68PXtT9kmLIFfmpeeaJuM8uHTVbtvdvcIFFJzBpvQEE6Si3J0aikVN2
	 YzagfKw1nlQcrWmPPYMVe72aEsmlF/7hFlqAk5ViTibvl555eD96TR6vfrDim62Ang
	 GZYjh9cxeOFog==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v10 1/5] ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
Date: Tue, 17 Mar 2026 18:36:25 +0900
Message-ID:  <177374018573.2358053.10088271720776923412.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To:  <177374017536.2358053.12341235939816794384.stgit@mhiramat.tok.corp.google.com>
References:  <177374017536.2358053.12341235939816794384.stgit@mhiramat.tok.corp.google.com>
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

Since the validation loop in rb_meta_validate_events() updates
the same cpu_buffer->head_page->entries, the other subbuf entries
are not updated.
Fix to use head_page to update the entries field, since it is the
cursor in this loop.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 96e0d80d492b..d6bebb782efc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2024,7 +2024,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+		local_set(&head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
 			break;

