Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59625371071;
	Thu, 30 Apr 2026 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519731; cv=none; b=KN7VJbIGFxvWuVgxArT1hJciD3PK82tb4wCBv/nCi2+r0dv7NDmDkoeW22oqbH072Jhmlv01TUlXosrNFrsUsTyEGl97CE3h2U4HQQyMIlq7BJtKVXg5B7yIgfyvHN1/F9GD5do8LArZtuBNsm8zh6fQUx4IXlURmD+BS9gCAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519731; c=relaxed/simple;
	bh=Wz6RdrD5t8KH7Q+otfYxrLoXyFQWTLtIM5Olk/l6sa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRT0rXu3eXsixWEPxVKQZdAI0CaTpu8Gx3u+UgkazA1GRBzsueF7rPvMV0U+EBzYtGLXLS/rlunsoK1t++BO33CzcGtdszGe/up+dkLrub79n9d9cr18pldUDSn54RlIY+k6h8p49rneqQ8Gq8DbamidCBG23trHADovpqJTMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4pUhk2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4pUhk2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17143C2BCB8;
	Thu, 30 Apr 2026 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519731;
	bh=Wz6RdrD5t8KH7Q+otfYxrLoXyFQWTLtIM5Olk/l6sa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4pUhk2TP0voqb2Yxu9CEomvG3ReUSZSVhHkVK5BRORXZHeLFfbEQ7FIWGRMv24ks
	 0v6HmhA8Spd0MqwiTJn58cideSEAJnHFoojYyJVNPUV2yjlozf3hPZ9bY9vkMUrfpF
	 2ezcUgyfr0LRtXvI7niMMBSWegFD5wAbN5snHcstRJcRfNQe6hnmzdQ/WqvNByj0UY
	 VHjOVJOEe6pfPe3LaqW3BtAPZoR5dMd4/QlVxbQrxyOuCkmFkkXZnfCU8UlyexqUKm
	 SnJP5lFiIAFojzbjl0dN8PzdrggYUmvIEBefyhZfsgO0uj6PYw4/UTprh38Q+x/+Ka
	 zOzVtMjsU6a1g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v19 5/7] ring-buffer: Show commit numbers in buffer_meta file
Date: Thu, 30 Apr 2026 12:28:48 +0900
Message-ID:  <177751972838.2136606.1618809923544417134.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To:  <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
References:  <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
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

In addition to the index number, show the commit numbers of
each data page in the per_cpu buffer_meta file.
This is useful for understanding the current status of the
persistent ring buffer. (Note that this file is shown
only for persistent ring buffer and its backup instance)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v17:
 - Added NULL check for dpage in rbm_show in ring_buffer.c.
 Changes in v16:
  - update description.
---
 kernel/trace/ring_buffer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c7cd93b66e0a..2654315c1b7c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2224,6 +2224,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
+	struct buffer_data_page *dpage;
 
 	if (val == 1) {
 		seq_printf(m, "head_buffer:   %d\n",
@@ -2236,7 +2237,9 @@ static int rbm_show(struct seq_file *m, void *v)
 	}
 
 	val -= 2;
-	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+	dpage = rb_range_buffer(cpu_buffer, val);
+	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
+		   val, meta->buffers[val], dpage ? local_read(&dpage->commit) : -1);
 
 	return 0;
 }

