Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406443;
	b=F9bksPc4UiUhwRSu4+dWHmT152V/sKyWAg5l/OK4cENw6X0xJP2zPcdBNi5fXbVNaPSD
	 jUUFs2Sfnwlqd8AuzXg9taw2mLkFMIIWLRQuMwt2OgVYWftOxjkJlrFGkcfnQOCcFq3BZ
	 VZpzDu7Xg1yPpkjtrnJnV5ZziGmDhGJNMK596JX4JdF2J75pWF1we6aSAg8Q5P9tlViC2
	 MLbOMYgGcfob4tzGR72czVVg+6ayW/uzFeWdfQVZexyVmyuDcQrTMAr5TAtw0Gn4N6mmv
	 y6RupxiI7vxgc5uJul2sDn6WwbsZjTva7/muzpbukZDXjC+mQwKhUAJjjeK2Nksxvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bbGKxr+cl67rKx9iZhegs4AoBqLzF7hCjAD3RMcuPgs=;
	b=d94iza/jjanSnwhqF5GACnpshFI1UVIWxAzAr+uv5OMQKYOfNKtySSOW9vFQOrk+mbOe
	 Ia/zmw5/OJEYltisgX5NaTqX/9TCPQINcKaCZbmqHIJI+HoIcPFyswuCKtTxtPQT70lVL
	 2zX7mTTfMDDxrXHb0rwzHTQ/ejGv4yNrBVF/tKRVYO7RKfbxI4zanuSdKcQJQ76Ht639/
	 3LCz72FjXaiLyQyNqULhx5RVk8NMQruMn9GMVjyo3M5kGrR0T7d9jo9Xw+GaGtWWdvzwk
	 gzjThFB5XU/DVCiFsczlVbvnt2++68JeKop0xfUhBODo8OlJCvR9TZvcrjrwYYY6T4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz7l0Gur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358B606A882;
	Wed, 11 Nov 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz7l0Gur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EFB1F00A11;
	Wed, 11 Nov 2026 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406443;
	bh=bbGKxr+cl67rKx9iZhegs4AoBqLzF7hCjAD3RMcuPgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gz7l0GurPOtCywDIJCq63vtHHkaSEC0x2VUgE9DdjRWMAj5UEoPekibgPZ2X5UygK
	 SCjKBPJF8RQW795gJO8ngv9xi61YFaVPAZLmOtz0QSOvKyqJO8O8TLfzCHPbpnwsPi
	 X6fnLKbRkedC+Jm+qnAuDsEf3qsKD+DNVeXqGpYvdoLDWCR5Vgti+1rHNkdgeDiv4k
	 5T1ehvnuXzSiTV8Uqy7hcmgmMdlxP22q941xpWmGRCYF1hdIpSQmbL4vY3/NzziMTq
	 5wsBBHCWisGp3UUUiZA0nsfQNXawpjiu71I8vhoLXO/rnXFaOf2sOHjHYeotcAvMC0
	 CHj5FOQnpMP5g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 4/5] kprobes: Re-optimize blocked sibling probe when cooling finishes
Date: Wed, 11 Nov 2026 23:13:59 +0900
Message-ID: <179440643954.328088.8524265330405527243.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179440640176.328088.17106877243326801914.stgit@devnote2>
References: <179440640176.328088.17106877243326801914.stgit@devnote2>
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

When an optimized kprobe is disabled (for example, to arm a new kprobe
in its jump-optimized instruction range), its jump is replaced with a
breakpoint (or disarmed) and the probe is placed on the cooling list
until the Tasks RCU grace period completes. While the disabled probe is
still on the cooling list, any sibling probe whose jump range covers
this probe's address cannot be optimized because can_optimize() sees the
not-yet-disarmed probe via get_kprobe().

In optprobe_finalize_generation(), when a disabled probe on cooling_list
finishes cooling and transitions to safely disarmed (list_del_init()),
check whether an optimized sibling probe covers op->kp.addr via
get_optimized_kprobe() and re-queue it for optimization, matching the
freeing_list path in do_free_cleaned_kprobes().

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Drop the unoptimize_kprobe() and reuse_unused_kprobe() hunks which
   were superseded by commits 0be7a931c5e4 and 1ffd6efb1b58 in
   probes/fixes.
 - Drop the kill_optimized_kprobe() cooling deferral since kill_kprobe()
   runs at MODULE_STATE_GOING when no tasks execute the module text.
---
 kernel/kprobes.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f7cf77ca70de..f14f7ff45961 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -729,10 +729,17 @@ static void optprobe_finalize_generation(struct optprobe_generation *gen)
 			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
 			kick_kprobe_optimizer();
 		} else {
+			struct kprobe *_p;
+
 			/* Still in use; now safely disarmed */
 			list_del_init(&op->list);
-			if (!kprobe_disabled(&op->kp))
+			if (!kprobe_disabled(&op->kp)) {
 				optimize_kprobe(&op->kp);
+			} else {
+				_p = get_optimized_kprobe(op->kp.addr);
+				if (unlikely(_p))
+					optimize_kprobe(_p);
+			}
 		}
 	}
 

