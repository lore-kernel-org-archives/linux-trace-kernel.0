Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB351C07EA;
	Fri,  3 Jan 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945302; cv=none; b=jDOEEEM4YscDEoQV8fWkMUxL1cROScsLoERR3lagkp5AOsVK+KeY66BRWuVm5Q0GfkMyqEavbVYOjQ7LVeLYLUF+4cNDVn531vRTJwKXo3XZsL1kXCO4GLWnl5zJJeePXPfbXnblomqD/OIRuR9IXWuHJzpAFW+PdEd6AMwUL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945302; c=relaxed/simple;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMuPogPH59C6x8/qDaCR6bKEY23hGoQ+R+2VnDhhlrfx58om0mMUBPn1TXpldjF+/+K1dzaHqNUzXtwrKzgdpsLnawhIvh43XyQ8PpoOyetrPEMOAUQfJxsLcadUkumq+zBfZrvx6L05Zwz5lzOv9mpFC/WWEn7Eo35l+CZiSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2Vo6wI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2Vo6wI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164CBC4CEDD;
	Fri,  3 Jan 2025 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945302;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2Vo6wI/o/4FyczW/0eIxJl7gSDk3PiJ6e3i3FAhU8qQGmNhWTc1smzDviyK3+RV8
	 1GULX+Xr3uaZGLusvoGPvIwNq6f/Cc6WdKGHdqVoar/VVZAJAH9afA1KfjwBrwslbs
	 zJq/2RPqnBGgPriCbcYqlE1AZjfp/AH13eziQGgCxAmuixwE3QFg5iSX0P1DmM+yTX
	 VkGZBOao12QgPTrHKCTu/mb/Avi6tFxlOo2qI/c6ULJ9kt0eHKMOff0YuMX3nlYLQU
	 P2Rz07R8nlESJXuarEA71gvjS4x/2UVhMEX03Chx8hSz0zVALYuZj0LcsWQa8Y/gVN
	 HtWZteKGHDPbw==
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
Subject: [PATCH 1/6] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Sat,  4 Jan 2025 08:01:36 +0900
Message-ID: <173594529646.1055889.13864553873741821054.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173594528527.1055889.2175884987203674189.stgit@devnote2>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
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

In __trace_kprobe_create(), if something fails it must goto error block
to free objects. But when strdup() a symbol, it returns without that.
Fix it to goto the error block to free objects correctly.

Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index bae26eb14449..4c3e316454a0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -935,8 +935,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
-		if (!symbol)
-			return -ENOMEM;
+		if (!symbol) {
+			ret = -ENOMEM;
+			goto error;
+		}
 
 		tmp = strchr(symbol, '%');
 		if (tmp) {

