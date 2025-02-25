Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F71993B2;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507615; cv=none; b=W+vnFNLVzN1XCyJDHf1APbbYrrdLI6apW/l4SxTl5xfhpn4p+bxJMOqrpAM9HguASuJrJyP0LLLlQ4z1l08sES/jSYiQ6sRxUxXKg4zZ+gBmUkv+YdFXg8YjWlFYdqUP9zGx5vjgLXLzoJCoqG/tIE51M37cy98kad1g7nGc5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507615; c=relaxed/simple;
	bh=mawHT+XCFiZ2E8sUhLd3IyCVPgu+SmxgXKOIoYUw0VE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DuOFF5s6E8wgFk0gHN9dqYrWrKjJOJ9YtJu9P0NK9/UD+LIwcGvSftrXHh6XxUEXoahyaqhKVHEzQBciqKLbJCVLl0LIyPFpayQaKbEdJ5C8LiqoOdkpAhUlZvq/8dip2DZHz2/xv98Oame2o/S+a1jJ7OlTnlKQmZOAAnv1ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DA3C4CEDD;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tmzY6-000000095Xv-1qYA;
	Tue, 25 Feb 2025 13:20:54 -0500
Message-ID: <20250225182054.290128736@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 13:20:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ftrace: Test mcount_loc addr before calling ftrace_call_addr()
References: <20250225182004.473875894@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The addresses in the mcount_loc can be zeroed and then moved by KASLR
making them invalid addresses. ftrace_call_addr() for ARM 64 expects a
valid address to kernel text. If the addr read from the mcount_loc section
is invalid, it must not call ftrace_call_addr(). Move the addr check
before calling ftrace_call_addr() in ftrace_process_locs().

Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250225025631.GA271248@ax162/
Closes: https://lore.kernel.org/all/91523154-072b-437b-bbdc-0b70e9783fd0@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 27c8def2139d..183f72cf15ed 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7063,7 +7063,9 @@ static int ftrace_process_locs(struct module *mod,
 	pg = start_pg;
 	while (p < end) {
 		unsigned long end_offset;
-		addr = ftrace_call_adjust(*p++);
+
+		addr = *p++;
+
 		/*
 		 * Some architecture linkers will pad between
 		 * the different mcount_loc sections of different
@@ -7075,6 +7077,8 @@ static int ftrace_process_locs(struct module *mod,
 			continue;
 		}
 
+		addr = ftrace_call_adjust(addr);
+
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
-- 
2.47.2


