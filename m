Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FC34A3D5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914065; cv=none; b=JFdyFe0JhKRt93uHEL9QpVmKUMFLzvU17udI1QmRmF4HwBb/RDyFcLZeZxbaHugwT9vq9YsUdRHcPmJAiY2MuCpgqs3UDQJ8vFt/JArhiMq+78BhqB/NhEQxYwL+gScRqubzeOMnaFlwGcZsiBgqQs16VsMtR2ZHXqng6DsyeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914065; c=relaxed/simple;
	bh=lWBi6DKh6CGT2nNS2ObrEMY0Cmesqoao0it0vnaPN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7gNSBBSM30ICrV5N+La0OLvn498oXloQt+EAe3mDa4/MMDfmFX3iq1rzxI/q4EazGZGX7KkrpMqR2UZFNRMrpQdiMHVH2ZZwQ2zhHJyMHU8yP9/p6Bn3r2Y/nCk+B1jY6jT0/s3qqRbfMDHwaPGuZKgovNCW7qVKrICnvletbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C10F3B99C4;
	Fri, 31 Oct 2025 12:34:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 336496000C;
	Fri, 31 Oct 2025 12:34:21 +0000 (UTC)
Date: Fri, 31 Oct 2025 08:35:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing: Have persistent ring buffer print
 syscalls normally
Message-ID: <20251031083505.477ca703@gandalf.local.home>
In-Reply-To: <aQRLBV_KzDHaaYiG@stanley.mountain>
References: <aQRLBV_KzDHaaYiG@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: so9mbaga66zyezhfw1n6g9ywidyysm8n
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 336496000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zLtY6gr41XHO6GSvzCnrsUddNtWjDnGs=
X-HE-Tag: 1761914061-908891
X-HE-Meta: U2FsdGVkX196q4oYgUbFRwpUL6THpzSrCIHNCpTcpwVbT2uQlv6HvNrk71633lorf7DL6QNggh91NGbCy5Iamg+nM/Ept3xBCRY+Ui1ZRm2OfOJN7qzvVQkv8f7/EhYkMnqvmZcC4TgYXugukmKocz8bhOwB6wxwyFPCPG9jec9pqkMtbhaSWH2hzA+uthFA+HdGrF4ZICzktF+Bof0AHBIaexwm7pgKj+KxggXu21V9P4dygaI8GBmmqSRZshCEoyHQbbSnf6p2EvRNnNMjCp5FwH8gbKCMfYK69EEMyfumZ9TYxgUJo0AkDqRsA3wSjx/CjluemwEW6Aph4y6CMHTjG/Krrd6n5V+GMVbcGfpamSkmstOAl4xNbISNdD36

On Fri, 31 Oct 2025 08:37:09 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

>     4271                 if ((tr->text_delta)) {
>     4272                         /* ftrace and system call events are still OK */
> --> 4273                         if ((event->type > __TRACE_LAST_TYPE) &&  
>     4274                             !is_syscall_event(event))
> 
> I feel like there was a line of code here that was accidentally left out
> of the commit.

Or one was added ;-)

> 
>     4275                         return print_event_fields(iter, event);
> 
> Or we could add another tab here, but my guess is there is a missing
> statement.

The commit that caused this had:

@@ -4251,10 +4268,12 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
                 * safe to use if the array has delta offsets
                 * Force printing via the fields.
                 */
-               if ((tr->text_delta) &&
-                   event->type > __TRACE_LAST_TYPE)
+               if ((tr->text_delta)) {
+                       /* ftrace and system call events are still OK */
+                       if ((event->type > __TRACE_LAST_TYPE) &&
+                           !is_syscall_event(event))
                        return print_event_fields(iter, event);
-
+               }
                return event->funcs->trace(iter, sym_flags, event);
        }

I broke the original if statement into two if statements so that it would
look better when I added another conditional. I just forgot to increase the
indentation of the if block.

Thus, a new tab is needed.

Thanks,

-- Steve
