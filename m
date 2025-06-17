Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A22295D95;
	Tue, 17 Jun 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156923; cv=none; b=bp9HeU/uE5x2A4u8arTjt0LhzRBQQjJt01iBK28gVU/GGMNuqEp4JmZ09dRiI7ci/9KiUl2BL/9fAsLIfo3fYu/lncjC5ck7qor/naffeq8puqBYJEfld+WiOYIA4AEpn+lCW7xinnCia0R8ay934QMbyExY7RfSIWVgVNE+O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156923; c=relaxed/simple;
	bh=suYcoi9WlXcs+rNEnI+XI1gUSFuSSFi2TYAJHTlinac=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pmk7erUBmIgY/ShtazgWXaTncSZc0m589yNUPhawWpXqEvT3AaeCxZsL5FxwSu2cPdgJMbO0UseKL82avKhPuiz44x8ASM4UyvI49UA9g/Um6kGZUTo3TiHajEwoxfofu56Ar2mptJDZxaBB/+kLMjwT8CsQVU9vcu5qP4KjsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3ZoD/rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3ZoD/rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DF9C4CEE3;
	Tue, 17 Jun 2025 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750156922;
	bh=suYcoi9WlXcs+rNEnI+XI1gUSFuSSFi2TYAJHTlinac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3ZoD/rNHOmhSBJxwh1BugXmf1EK6ToMs9y4fmNBazH8dMbxii/Pt4S49hG19S+Hi
	 7fsopWtGxr6VND+MK4lXV3ekl+y4EAx+YPdDc0mJIjnaPGo9kc0AkIMvI5Adzj9Jxb
	 lkZ2V4ycVEODNk7SGVhIWMRh5unyqno8cagmrVZyNXwO6T/Hm0+8WowoxOeHJaeoHw
	 1sOtZCFdavKFX/w/ZU1imPDpw5DAhZKx0PfTr4eeqlkTojS3u4FCzccuGkSqbpAGlr
	 38OnmFmqPyhRVLD9H9fgSAqnh5a7RWtDMOTsa1c6dfIbQDbx1az1CNVrd9qbFqvhO1
	 gYCzWUnIzMaig==
Date: Tue, 17 Jun 2025 19:41:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
In-Reply-To: <20250616163659.d372cf60ee0c476168cd448e@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 16:36:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > So the fundamental issue is that smp_text_poke_batch missed
> > handling INT3. 
> > 
> > I guess some text_poke user do not get text_mutex?
> 
> Hmm, I've checked the smp_text_poke_* users, but it seems no problem.
> Basically, those smp_text_poke* user locks text_mutex, and another
> suspicious ftrace_start_up is also set under ftrace_lock.
> ftrace_arch_code_modify_post_process() is also paired with
> ftrace_arch_code_modify_prepare() and under ftrace_lock.

Eventually, I found a bug in text_poke, and jump_label
(tracepoint) hit the bug.

The jump_label uses 2 different APIs (single and batch)
which independently takes text_mutex lock. 

smp_text_poke_single()
  __jump_label_transform()
    jump_label_transform() --> lock text_mutex

smp_text_poke_batch_add()
  arch_jump_label_transform_queue() -> lock text_mutex

smp_text_poke_batch_finish()
  arch_jump_label_transform_apply() -> lock text_mutex

This is allowed by commit 8a6a1b4e0ef1 ("x86/alternatives:
Remove the mixed-patching restriction on smp_text_poke_single()"),
but smp_text_poke_single() still expects that the batched
APIs are run in the same text_mutex lock region.
Thus if user calls those APIs in the below order;

arch_jump_label_transform_queue(addr1)
jump_label_transform(addr2)
arch_jump_label_transform_apply()

And if the addr1 > addr2, the bsearch on the array
does not work, and failed to handle int3!

This can explain the disappeared int3 case. If it happens
right before int3 is overwritten, that int3 will be 
overwritten when the int3 handler dumps the code, but
text_poke_array_refs is still 1.

It seems that commit c8976ade0c1b ("x86/alternatives: 
Simplify smp_text_poke_single() by using tp_vec and existing APIs")
introduced this problem, because it shares the global array in
the text_poke_batch and text_poke_single. Before that commit,
text_poke_single (text_poke_bp) uses its local variable.

To fix this issue, Use smp_text_poke_batch_add() in
smp_text_poke_single(), which checks whether the array
sorted and the array index does not overflow.

Please test below;


From e2a49c7cefb4148ea3142c752396d39f103c9f4d Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 17 Jun 2025 19:18:37 +0900
Subject: [PATCH] x86: alternative: Fix int3 handling failure from broken
 text_poke array

Since smp_text_poke_single() does not expect there is another
text_poke request is queued, it can make text_poke_array not
sorted or cause a buffer overflow on the text_poke_array.vec[].
This will cause an Oops in int3, or kernel page fault if it causes
a buffer overflow.

Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
so that it correctly flush the queue if needed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
Fixes: 8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..8038951650c6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	__smp_text_poke_batch_add(addr, opcode, len, emulate);
+	smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }
-- 
2.50.0.rc2.692.g299adb8693-goog




-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
