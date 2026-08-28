Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA701940B0;
	Fri, 28 Aug 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876946; cv=none; b=qhA6MW6+HpNcwTFBzuDVdhTMsYbyEqeXkjW+NawxH5bpMwU7TcSOB9psuHWfh4Fti9Ptu/oGDACbR3JW2p3/NqHPLjl8j4YvzXkFfG9xNoyRl6puAHIwBeGEqg2BdCnSZ5WjPTR+/CowZJ4O6sYC/wwO/e3F4b42m3TMLtdhGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876946; c=relaxed/simple;
	bh=e39ENMqloKar7PQSDxfgLK6rUsQzvMvZ6oom/olCcd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU4xyxzjesQgXW+mzhUMiXclq1Rt+LJawhWpmYkIyx4b84dgzOF42DEkmXZXGHOT32/cMWRVZan9eoC9LrlxkVKllsa8mz4TFQHoDoRP+frZRJnDmIYVFqZrw1s/Jxz+f/W+iXrKRAsblUPuoPUfXlw8BGFSSdgqnHTOpLDrZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Gz8Jg1l8; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Gz8Jg1l8"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D1FE3801E1;
	Fri, 28 Aug 2026 00:29:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 1D3F32002D;
	Fri, 28 Aug 2026 00:29:01 +0000 (UTC)
Date: Thu, 27 Aug 2026 20:28:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, falemi@asu.edu,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: use-after-free in t_start() when a trace
 instance is removed
Message-ID: <20260827202859.3573c044@fedora>
In-Reply-To: <CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com>
References: <CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: egutimoahwgig1i4wo7opnofn5nd41bn
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1D3F32002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DrHT5nEZuX6hehzolIfwkLmRyc6u4smU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=r0OAEa6seKSpaiE5Us/G5uyNLgVM5O+a61Uj5cUNDL0=; b=Gz8Jg1l8QwK5oo4FiGvacJgsAP5sF5V5G/ZbNzVldKb6X1rzczcDjr0dQcwJDl/WDrdfn3LZmHhykn5TBhX7SSgsBb+f5+BSzrZKvCeebOatwGT8h6jnlcJu6Jm1iuvmGG094oOInEzzWGT0TV+RpzOcyRyS+C+a+A6A8ETOIHU=
X-HE-Tag: 1787876941-286076
X-HE-Meta: U2FsdGVkX19gTjma4HBZF7XTAwdNznWPAk8nRPh+8VY6Xygsqr/m/ok/GPwGiBKETmgXq0ZRTDg59wvgoBokGgi9I9PHfBgtfWqRJc6fEIvTBg5ebTFauLoFrSj4ik5ne02ZecIRxCAnuJBUjbN2G/tr9ao4vIKSLcK5Llou76EL4ITnwqfEQwrkxEfTkcffKgpRRzV1h40n0XBEXoV/Zh24haEbx2fUUV79XV9SZJXUoDALPP1pmti9Ga4ffikWC0TJPPXkmka4PaY1Vs1SZkb7wz6WhTBYDqfowReeL+UW4XLzQyrtw+seaXRftdEeH+aTdQAvdUz8Ny/vWmHmcDbGrkeIMADd

On Thu, 27 Aug 2026 23:05:19 +0000
Farhad Alemi <farhad.alemi@berkeley.edu> wrote:

> Hello Steven Rostedt, Masami Hiramatsu,
> 
> While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
> SEFCOM lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/116-tracing-uaf-t_start-instance-rmdir/
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in t_next
> kernel/trace/trace_events.c:1568 [inline]
>   BUG: KASAN: slab-use-after-free in t_start+0xcc/0x210
> kernel/trace/trace_events.c:1592
>   Read of size 8 at addr ffff888022f7a960 by task syz.4.116/12466
>   CPU: 0 UID: 0 PID: 12466 Comm: syz.4.116 Not tainted 7.1.0-rc5 #1
> PREEMPT(full)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x94/0xd0 lib/dump_stack.c:120
> 
> Our reproducer.c is available upon request.
> 
> Happy to test a patch if that would help.

I see what the problem is. I guess you were creating and removing trace
instances while reading available_events. All files that are part of an
instance needs to get a reference counter on the trace instance when
opened. This prevents the instance from being freed when there are
opened files in it. I see that the available_events file doesn't take
that reference which will allow its instance to be freed while another
task has its content opened. When it reads that content, it will
trigger the bug you see.

I'll work on a fix tomorrow. I'll have to audit the event files to see
if there are any other files that are not taking a reference.

Thanks,

-- Steve

