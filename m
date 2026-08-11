Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B366353A88;
	Tue, 11 Aug 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470993; cv=none; b=b8AFyNsvPjTaLPVh/U47ORN9K1B8n9Z7+uLnHqQK4eiMlRPn+AK2PEd10dXKJJaygbf8mMtrUM0EBNnEiSVbcEXiZBKBXo9ilsy9EXjJkBSmpG8EDQNGRuEF65b7VokHZvIpLRHcy1t5wdbqI0pxpnjZFFidIU+VKKH7Kinxi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470993; c=relaxed/simple;
	bh=IkHEcNR5F7Y/t3w4/pj3o2nbN7nTokQePanahRiU+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXP6OoezaMWgZUnXdBUjpsGxjeoOnrn/7JJV+O0IZ677zNy/Cng/Gof5a0KIdb/cd9Ilh9tHiM76hJbocMAqMWKznaYenpIxxkZPIQXlOON/I0oyiCbZ+fhpJd9S3Ng4NjrT9MAlQXUCbxETWxhkjNaumdq3OlWRR6zOuhUR31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7DFFFC0196;
	Tue, 11 Aug 2026 17:56:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 6C9696000C;
	Tue, 11 Aug 2026 17:56:21 +0000 (UTC)
Date: Tue, 11 Aug 2026 13:56:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hui Su <sh_def@163.com>
Cc: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tracing: Fix NULL pointer dereference in module event
 cache removal
Message-ID: <20260811135633.0a4adc82@gandalf.local.home>
In-Reply-To: <20260811173902.1927376-2-sh_def@163.com>
References: <6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com>
	<20260811173902.1927376-2-sh_def@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wuygmbomgia34pddedf1ujihpjzn5djf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6C9696000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/DF/c7LaSkDDLxvf/3o55nlFRStd5KFl8=
X-HE-Tag: 1786470981-74592
X-HE-Meta: U2FsdGVkX19/nVVSKC/Qq77rc5rvrwfdSmqUAsJ2qgycPyXHvKBkxH9ddft9g5DBeVpgKaAPrzoqlx9T7IyaAGw3XVfI67AzPtLi2z5Va4wdCNlhpTrWbbaEfZvwYaE2+Qk/tF0xgHXzmtKLBd4pEHCFexY0b/SaIVKYyQZ12vCXCsd8EWNnPomTPhZ3F22qUNOiH9DM9AzduM61pglVx9FY5cP1CqFTt1lC30WktRcDiJmiOhwhePcmGMcV3gnxwzXCg1Guguqk99BGh8D6232mW47XyGvph5gIm4Dd3fVAhZopfW/j2bkFNPqGF62I4N74vFFl+htDyhyTCgc3fC0YmybfUZ+rHgUWqkSNfCf+xsbgT3j1fjIxDD68wviqpVagdN/pIeC3ETriTp0A69dUHmhZryQ6B0ggilFKPABsgchEbAyIGmN/2ByidO4Ww2e0BCAOMDM=

On Wed, 12 Aug 2026 01:39:03 +0800
Hui Su <sh_def@163.com> wrote:

> A module-only event filter such as ":mod:foo" is cached with a NULL
> event_mod->match when foo has not been loaded. If a later write tries to
> remove a specific match from the same module, remove_cache_mod() passes
> the NULL cached match to strcmp(), causing a NULL pointer dereference.
> 
> The issue can be reproduced from userspace by keeping one set_event file
> descriptor open across both writes:
> 
>   mount -t tracefs tracefs /sys/kernel/tracing
>   exec 3>/sys/kernel/tracing/set_event
>   printf ':mod:trace_events_kunit_missing\n' >&3
>   printf '!foo_bar:mod:trace_events_kunit_missing\n' >&3
> 
> The descriptor must remain open because reopening set_event with O_TRUNC
> calls ftrace_clear_events() and removes the cached module filter before
> the second write.
> 
> The crash was reproduced on x86_64 QEMU while KUnit workers contended on
> the event tracing path:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:strcmp+0x10/0x30
>   Call Trace:
>    __ftrace_set_clr_event_nolock+0x373/0x4a0
>    ftrace_set_clr_event+0xf0/0x180
>    ftrace_event_write+0xdf/0x110
>    vfs_write+0xf6/0x440
>    ksys_write+0x68/0xe0
>    do_syscall_64+0xf9/0x540
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Check event_mod->match before comparing it, consistent with the existing
> NULL checks for the cached system and event fields. The mismatched removal
> continues to return -EINVAL; a broad cached module filter is removed with
> "!:mod:<module>".

Thanks but it's actually easier to trigger it this way:

  echo ':mod:trace_events_kunit_missing' > /sys/kernel/tracing/set_event
  echo '!foo_bar:mod:trace_events_kunit_missing' >> /sys/kernel/tracing/set_event

as '>>' doesn't truncate.

I'll queue it up and start testing it.

-- Steve


> 
> Fixes: b355247df104 ("tracing: Cache \":mod:\" events for modules not loaded yet")
> Reported-by: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com/
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/trace/trace_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c01b10b99f67..032f741ba616 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -945,7 +945,7 @@ static int remove_cache_mod(struct trace_array *tr, const char *mod,
>  		if (strcmp(event_mod->module, mod) != 0)
>  			continue;
>  
> -		if (match && strcmp(event_mod->match, match) != 0)
> +		if (match && (!event_mod->match || strcmp(event_mod->match, match) != 0))
>  			continue;
>  
>  		if (system &&

