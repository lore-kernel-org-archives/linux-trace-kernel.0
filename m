Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281636C0BE;
	Thu, 26 Feb 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113134; cv=none; b=fIfKGO8D/LmdEStoThPX6ozN0YoaWMCaAz2OJcMuU1r27pHsgdPHT3PJUfsaM79khKbb41KkKe7UMfYRHetXxuopzaGxqXEVwDUstB70CflZ12gVpaioS5C0ihrTUrHUSiy47yE9dRnQYXKhYEomkejKWUnj36C3Doo6J7ITVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113134; c=relaxed/simple;
	bh=Grz+va2dx3OEHfYda/aWVdwrIxRxbJLjBcQHQoMMrQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCS29RtQI4mqhiEEw4WQn4rQi2TDp5ol5k7NsTEKg1FHBSaIMqVDHakzWyAPvDC8BEAoNfNgIp1L8e+iei8p+oASBhEQR1BSuGuTsvxnRJGUnEpEotwV3DXLNgn3O0VDVJe28jm41M8fhqEmAE30c52FnLsDg2bHFOP9sZFql9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy0pOlgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy0pOlgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED819C19422;
	Thu, 26 Feb 2026 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113133;
	bh=Grz+va2dx3OEHfYda/aWVdwrIxRxbJLjBcQHQoMMrQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cy0pOlgp3PEauRGzL04yIcRTcVDUN02G5mExTp8EMeCmVOOX+Se08tzGMrzgDfOTZ
	 frw3Wtraba76TkFd0mHKHHZF9P6rnKQOX+a09oewlooQThG87Djn1mYG1prom31Fku
	 fETgtfkO1JPgAUcRnqmLZ6N5S+btF6LuwDURkalzmWh9P8jJrAm7b03Z2c/6IsXuzE
	 NdKMI+m4kmvdVKPub0Q7JZpn6v1+k753wxxtZC1c8c4gb2fL7Sqtt1+NV1hw5LVkaS
	 duAFvhgq+wD64oL3btKK+UmOy+eYVA8crQVDsE64RraF/L0XBvzp3cTT9Zqa8MdMT3
	 FdFPA0QiAIMjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Thu, 26 Feb 2026 22:38:51 +0900
Message-ID:  <177211313130.419230.16617033664882679312.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
References:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
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

Skip invalid sub-buffers when validating the persistent ring buffer
instead of discarding the entire ring buffer. Also, mark there are
missed events on the discarded buffer.

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data. Only discard the
subbuffersa that ar found to be corrupted.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v5:
  - Instead of showing errors for each page, just show the number
    of discarded pages at last.
  Changes in v3:
  - Record missed data event on commit.
---
 kernel/trace/ring_buffer.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2e9b8ce6b4dc..cfe1e15f1a93 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1927,6 +1927,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	int discarded = 0;
 	int ret;
 	u64 ts;
 	int i;
@@ -2053,19 +2054,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
 		if (ret < 0) {
-			pr_info("Ring buffer meta [%d] invalid buffer page\n",
-				cpu_buffer->cpu);
-			goto invalid;
-		}
-
-		/* If the buffer has content, update pages_touched */
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-
-		entries += ret;
-		entry_bytes += rb_page_size(head_page);
-		local_set(&cpu_buffer->head_page->entries, ret);
+			discarded++;
+			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, RB_MISSED_EVENTS);
+		} else {
+			/* If the buffer has content, update pages_touched */
+			if (ret)
+				local_inc(&cpu_buffer->pages_touched);
 
+			entries += ret;
+			entry_bytes += rb_page_size(head_page);
+			local_set(&cpu_buffer->head_page->entries, ret);
+		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
 	}
@@ -2079,7 +2080,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, entries);
 	local_set(&cpu_buffer->entries_bytes, entry_bytes);
 
-	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
+		cpu_buffer->cpu, discarded);
 	return;
 
  invalid:

