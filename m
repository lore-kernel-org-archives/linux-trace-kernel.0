Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DB35DA7B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932793; cv=none; b=RH7b8ndtTnwYOIbnZKJyeRB4DYtY+jaQJIz3kfS9TP+ZYIpufrUsHkrtcrzq0euflJLGd0oO9u3jEYPRjhOtR2pLLErTDuVfbUCLN32SqzdXTOHaGgplA2L3f9XG8D+f/MacesWK/A8GMADnbdNCenrd9dhv5FihHKAHR6WpsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932793; c=relaxed/simple;
	bh=Dd/m4Tmo9F/AOmEAEB74kYKJgdMI/cTNQQnr+jTjFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfhDPWIqVSPmFskBoRW/Dp2h+9ObmTj6aiK6swnCoiKsvV3BCuvEZYKqJkj2ZF2NVlqjknpwexjfmYIS3TRpx7bS0oJIAK5qL2KSuxWzXhqZ7fkV4hW72gcxMa3HJR+t3JL0ebLKAMHxkHNW7x2bQoK2UX7CNSaijBen3t5bgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CWQjt1xt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CWQjt1xt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+bsC/Xim6/ItCM8thFsfmMqigqmevqKTLS+5EbwAiAM=; b=CWQjt1xtUbGLKZwCEtJCAWqN5X
	QZ+QSnrYRTa3XwpEqAkCWJIUDM3Q94JLSC+Mtm7ezyPgWxXs3lTuvVXXPV2rdoAZepBPIxgRCwA63
	FXXo39e0hQfZ8+mvmeJv/hO684N4oU804jYrZF0nUdXHsGdiiLcl+92xBoqsX2VLibtKPm6BaT5Dt
	1a2d/Y4ZqTwqTx8bpPGG0Jsr1TyeViLfOrcA8v5e7YZlK89VkTm1l5fqqRpDqOj58M9odtdMR5fp0
	yjEplQsVF1bC7XnqGnzHxNaPcNwkONAqPARybKlyK74nFbSt18GVkwgov4ZO35fmu9OoTkA2Pi71l
	hPjC9nWA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzyzY-00Gt4w-02;
	Fri, 28 Aug 2026 15:59:44 +0000
Date: Fri, 28 Aug 2026 08:59:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing instance
Message-ID: <apGwPEj65dcbZFxS@gmail.com>
References: <apGORjltZgAiAYHT@gmail.com>
 <20260828104201.21aa9d08@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828104201.21aa9d08@gandalf.local.home>
X-Debian-User: leitao

On Fri, Aug 28, 2026 at 10:42:01AM -0400, Steven Rostedt wrote:
> On Fri, 28 Aug 2026 06:38:17 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > I am seeing some UAF KASAN issue on ftrace in Meta prod, and I think
> > I got a reproducer that works ok.
> > 
> >  BUG: KASAN: slab-use-after-free in ftrace_regex_open+0x50/0x770
> >   Read of size 8 at addr ffff00097627f418 by task stress-ng-fanot/1811644
> 
> > 
> > #define TRACEFS  "/sys/kernel/tracing"
> > #define INSTANCE TRACEFS "/instances/uaf"
> > #define TARGET   INSTANCE "/set_ftrace_filter"
> 
> Ugg, this is similar to the bug I just fixed[1]. But this one will not be
> so trivial to solve. As the trace_array in question owns the ftrace_ops
> that is used to register the set_ftrace_filter file. Upping the reference
> to the trace_array will require some thought.
> 
> Let me look deeper at it.

My LLM came up with something like the following, and it doesn't
reproduce the problem anymore. Very similar to your code above:

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9d80c7bd9f16..37845399fe5cf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4788,22 +4788,37 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 static int
 ftrace_filter_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
+	int ret;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops,
-			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
-			inode, file);
+	/* Checks for tracefs lockdown, and that the instance is still alive */
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_regex_open(tr->ops,
+				FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
+				inode, file);
+	/* ftrace_regex_open() holds its own reference on success */
+	trace_array_put(tr);
+	return ret;
 }
 
 static int
 ftrace_notrace_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	/* Checks for tracefs lockdown, and that the instance is still alive */
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
-				 inode, file);
+	ret = ftrace_regex_open(tr->ops, FTRACE_ITER_NOTRACE, inode, file);
+	/* ftrace_regex_open() holds its own reference on success */
+	trace_array_put(tr);
+	return ret;
 }
 
 /* Type for quick search ftrace basic regexes (globs) from filter_parse_regex */
@@ -7496,11 +7511,15 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
 				struct dentry *parent)
 {
 
+	/*
+	 * Pass the trace array and not @ops, as @ops is freed when the
+	 * instance is removed, but the trace array can still be validated.
+	 */
 	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_filter_fops);
+			  ops->private, &ftrace_filter_fops);
 
 	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_notrace_fops);
+			  ops->private, &ftrace_notrace_fops);
 }
 
 /*

