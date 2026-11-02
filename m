Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651049;
	b=VS8WL/MT9QLoXmP01zxWTVSEZXU+f1uXamOOIw/q73QfnRcYB2EH5x356dnC611gy796
	 aOxAySsK7FZump2YE1vndACFSYr/aMUNuI7zicg+KLnzKEJ1XIHgLbtAWhr4zXC3kobVQ
	 bLxyn43IR9fiHdzqg3GO9cAgadj6fH2WkLsTsWFYj35P8TjzJ9A2+IfWGB9G4dLrZiUnM
	 28XtzEVo00VkqGcqS4VcuGBQ6zUerifOyxb/gIyLlO7ZcSBxQrQh2eY6v0AR1W5ATQKVX
	 VLuGGwu2K8FGtCTn4B7raYRJwnykg3woNnSrjyQBlaWiZ8IaxE0VCvhQ99hu6m+6CFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651049;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=Zl2jd+cm1rVMPqCUIoL2/mpY+VvXeaqiLBHQmalyFJU=;
	b=xBLuIDnxQY3GFn746gU3XEx+PdzWtcRyjmq8KfKXrGM/ECOCGHxmtcnwJJx5U0IrGP1t
	 5QNQR9vtZQV7ydURl8Gftjwqi27Q5g7wIEqOX97P7UbRryHHUcwuLI/DmO9oDBzeAsIM6
	 SUXRzmenbs7jkng+Px46uKPn2KFN3mfs3sJeU8oKGyKOFQVgOEelb1WGY9N8dtE9/g2YL
	 w0XQ8FU6NyWi5YaYaDeilNPXT7Sq375OEbHahVLxPLKHlxUjPloQ12GkzI9NhS5Bj4wzk
	 ByIOS9pKqpMLl9hP/W65fdSMOs0BHUmElm2cgyRjqD4smLQCVghn4P1mJR9EqQvVmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb9os9z0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD9606A32C;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb9os9z0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2764A1F00A17;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651048;
	bh=Zl2jd+cm1rVMPqCUIoL2/mpY+VvXeaqiLBHQmalyFJU=;
	h=Date:From:To:Cc:Subject:References;
	b=Bb9os9z0n4DyB4e6AEbbc6LOArDemgHcFrtkQDdGbqVtrYb/DufA6hUKCVtXAUsVy
	 q7tNgCa1IQrT3c5iNl+q1MRUuH7JsB75xgaHq2gveedEyV/4nFeL6qovToZO+xUgf2
	 kMYAgF8Q0XLaLE/6mmj6CQDdnZMutq3lmm1aTG1KlBKPXsy9ckLdvGuNJf2PanWIot
	 wuXe5c63jHpMkji0v0Sws6yXy0NquHB9LS2jwhcSyshsqiwZP+5lg/w0bCk2afWa4u
	 YYM/ueH6gT76bteUCmld9M4CRJznOCSR2pnxKU00343ngNRVR6EQFbE05Bn29XQxW7
	 hCrzJz3vT4hTQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xNyZb-0000000DJsn-26Gi;
	Mon, 02 Nov 2026 15:24:07 -0500
Message-ID: <20261102202407.305916932@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 02 Nov 2026 15:23:21 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 1/3] lockdep: Add #include <linux/instruction_pointer.h> to lockdep.h
References: <20261102202320.574701415@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
included into lockdep.h via kernel.h pulling in trace_printk.h which
includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
does not.

In order to remove trace_printk.h from kernel.h, have lockdep.h include
instruction_pointer.h directly.

Reviewed-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/lockdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a6451ecbbe9a..c6b0168f5fc9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -22,6 +22,7 @@ struct task_struct;
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
+#include <linux/instruction_pointer.h> /* In case _THIS_IP_ isn't defined */
 
 static inline void lockdep_copy_map(struct lockdep_map *to,
 				    struct lockdep_map *from)
-- 
2.53.0
