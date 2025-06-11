Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6A1DBB2E;
	Wed, 11 Jun 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656573; cv=none; b=R8fYorno3jLEPu6gt3e4qXnA12GfiN9O5OG/PoEO8JrsiaHDP1gtw5hCfDuCun7Ekg/LKF+buAj9AOrigyFW/ck6najPAJcmB42DHrCIgm93e3LYm0lHGyKWP3Mw55UXBkhyLetcSXfJtTAxWyZL5tBVZe7ltGcomfpsIpViyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656573; c=relaxed/simple;
	bh=oo0SuwwGExHFaOJFlP5OUqwnZC6rcdmMw2ydNsXzKVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM8iyBi8y6JSI4GLoT2S3ElO8bNGBRQMs9ZFObeMwcEDyPoyhpGgO6B3ev3ebTI2C0ECuAPyl8+4/HHIv/zDhX3/VBCKacFGd8uqc0UY1xIvqzBju32mXMEdoXqi7gVgAmAcfTTNf5cA1ykDwnahxijQABipWHulvArFGVoYMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 54A4D1D7490;
	Wed, 11 Jun 2025 15:42:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id EBAE344;
	Wed, 11 Jun 2025 15:42:44 +0000 (UTC)
Date: Wed, 11 Jun 2025 11:42:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-ID: <20250611114243.43a9e3e2@batman.local.home>
In-Reply-To: <20250611102010.1bf7c264@batman.local.home>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250610115030.0d60da65@gandalf.local.home>
	<20250611192610.6edf9713f6ee84c26f653ea5@kernel.org>
	<20250611102010.1bf7c264@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EBAE344
X-Stat-Signature: nbi5zcj69fqxhb99qxhyur8yityfrkzi
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FS9wqtWZfxAKVfAwEw2qh9QPtWdgwg40=
X-HE-Tag: 1749656564-458231
X-HE-Meta: U2FsdGVkX19LET8LxWpGGUA9FMmmpcBZD9S5sG+hwI90c36aS8MFYsmjJ4B9sh2uLCuOaYCzZGH5eiBhgxPUDsUcCVKBBeXh0rV0NixwrIoQJWbOMXYuEExaWDmcygtRoeUczYq4diKHa3r8xt6NdmQ417e4YcYs6WzGzwpYQ6GwiYEwnxcJsSAWDwWf0oLi3X9JL4tzMwLkCfZIP8NaH06bROV+gxsv9AeXpNG4ZCixzL5ucKjigeNJ+27ANeRXpTUOPDz4WKAJzDoC7rTBEe94mnv4ITYpJSt45xYF/Wdq29U0IKumVkVoA53ejduExzy76UJYbz8/1HWN4G5ew3bTuYTOEOiNvYKzzPvixVwZSgYhYDQoRqjnUKF+A+Rz

On Wed, 11 Jun 2025 10:20:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If interrupts are enabled when the break point hits and just enters the
> int3 handler, does that also mean it can schedule?

I added this:

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..0f3153322ad2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -854,6 +854,8 @@ static bool do_int3(struct pt_regs *regs)
 {
 	int res;
 
+	if (!irqs_disabled())
+		printk("IRQS NOT DISABLED\n");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
 			 SIGTRAP) == NOTIFY_STOP)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..2856805d9ed1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2728,6 +2728,12 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	int ret = 0;
 	void *ip;
 
+	if (!irqs_disabled()) {
+		instrumentation_begin();
+		printk("IRQS NOT DISABLED\n");
+		instrumentation_end();
+	}
+
 	if (user_mode(regs))
 		return 0;
 


And it didn't trigger when enabling function tracing. Are you sure
interrupts are enabled here?

-- Steve
