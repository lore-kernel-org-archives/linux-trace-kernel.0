Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148348;
	b=YomqZPMrLde3LCv94tTQJhwMGnlqpVRhbd3DJC5LGdkIpIoR1KiePzfHFfcUfKggwMgp
	 +W5Jw079UopP34wvP10U1/jZ7tM1LmboffwKLHZEfslhfvV9idDIrqfeM/kLQlcn9YVGi
	 wJe7gxAohIhpZ/0t4IxXDmorKYZXDgmREVU66gdLAie8OUyF5NoKjT1XEmMW9jrgU7YTv
	 vxEMB29FSh4srq9zEY53xCLBnNcxyiBSMZIy55dw71Y7ZTK4yELhdXVpABfkyiFpoC320
	 BcKK27/Ur5CDaQMtduaIfGBbaVZkNymKM0dhMb6O7ZxtPqgItXtOImTCSdN+9x5EOIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Jnkd04CEyP0dWSx09HnzluUFZrxOekFX/gIfNQsPrc=;
	b=4r4wyiyOH0XfIFnWNSfR9nEAFeya1xPSyaCnS4dsyTJTCwNNdBmJi4wp6tSkOExiGJtn
	 xuiprW6ssxMzTtKXffEoQifoPZu5vqOX3oHqos/bXfSl4+9VOBom0SP8Di4P/vVmrC/NW
	 z3BnCi2wZlwjEU0wT1DMIAjtcdSzUY3nDE9iW+nqU4dNvlUp5Zv2NlsSRNn19ZPmhIF/Q
	 jJhZeJuRVnRKV/xopwz9Ji4CK+mHjsFmCng4twaJ1ZAlZ8TNFmoE2Sp0RbZ4DryF88+oD
	 xPSQUOz6FAXu9RGUEX7xBYkyB1DGDexnENOiYO1BhPq3BxactJfxGOYwCK26DMKxHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAHu6Igz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E0606A324;
	Wed, 28 Oct 2026 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAHu6Igz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB911F01828;
	Wed, 28 Oct 2026 00:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148347;
	bh=3Jnkd04CEyP0dWSx09HnzluUFZrxOekFX/gIfNQsPrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAHu6IgzfOcVwy1P/x02iVIC7/BY/x3VYyOjvVfVVJ9mK674WSw2jHHlqqlpZWfm/
	 4RWN9iJ9gcbCULHXGdVSkm2kUawY2gtdR881bfSoollEg3RsRrDaDSCW7FSzekCHzJ
	 HhE9ZclNfU84nsAdRJxFvoyWW7naDlR0f4aZYwOOoskKpp9efLzqyL3PphnmY4qLFy
	 n6/sWpxbWO9gfQMBQOxLTEBAycvsaIwp9xi97c6tm7NePr3VTkf6StD6qdaPRbdu0r
	 Q8fV2/pHa7yU85rkP6bVMhM2rl96z87hlD4MT1ckEDUN52xIoYvZcqNfdkXpn7fauN
	 vOtbZPkbBc2uw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 15/16] tracing/filters: Fix error position for within filter operator check
Date: Wed, 28 Oct 2026 09:45:44 +0900
Message-ID: <179314834404.684037.11531560120132558147.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
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

In parse_pred(), when the '~' operator is used with a 'within' filter,
'pos + i' points to the closing quote of the operand rather than to
the unsupported '~' operator.

Pass 'pos + op_pos' so the error caret points to the invalid operator.

Fixes: 7884b0bf098c ("tracing: Add "within" filter for call-stack-based event filtering")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Newly added to fix error position for within filter operator check.
---
 kernel/trace/trace_events_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 291c9805e119..bd54fa6e58ee 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2096,7 +2096,7 @@ static int parse_pred(const char *str, void *data,
 			unsigned long func;
 
 			if (op == OP_GLOB) {
-				parse_error(pe, FILT_ERR_GLOB_WITHIN, pos + i);
+				parse_error(pe, FILT_ERR_GLOB_WITHIN, pos + op_pos);
 				goto err_free;
 			}
 

