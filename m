Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91F471CED
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928077; cv=none; b=KQqNEd7c1Q364Cr/jLV3mMnfZJQTA12VXCiH0d+kjzdY9dMmn0kGQ93NOApIvkcjt7vWOm/8um3oPDlcesVKYr6loi9nM3vIcUGFvo0m7QtEBHmk2gVh1o8f6l3ZZxnBdRqtTR/TiEJ26OI6hXftVATkVlay4Di727ezq6n2fQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928077; c=relaxed/simple;
	bh=CsIaoi0CGG2Q/uq/TQBZ3t8bquE3rp7aOB+eNaqsJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjCy7Cq81JMbpBqmz12citNqRBJBYLgXWTBng6i7LHTBm7pSqXA52UjOFNBOCvTyVjVHDQCBZNeRi+23j700OODL2jaOAGDk+ZRN7BkEKRPl8GLyZG4O+QhbuCMVjCbgrqgVXrdVs4ANRQgPEfvSAy+ZeJp103KJrwJKm25L/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=AbVYLWWa; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="AbVYLWWa"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 122081A03B5;
	Fri, 28 Aug 2026 14:41:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 637D132;
	Fri, 28 Aug 2026 14:41:12 +0000 (UTC)
Date: Fri, 28 Aug 2026 10:42:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing
 instance
Message-ID: <20260828104201.21aa9d08@gandalf.local.home>
In-Reply-To: <apGORjltZgAiAYHT@gmail.com>
References: <apGORjltZgAiAYHT@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ab7m7s7yfsqeju15npnb5qn3wzbkzgk1
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 637D132
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/DvSTQWRdzAkCe1AD8LbzbGiaR2oL8pI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ZO5skQkuDIAHlO0rxSAZ+pmHhdrynFYIYBlSqMeFr4A=; b=AbVYLWWacjhGDYoWyM8EcKL/yXiM+Za/RegBWJ3RibL/VpXB4BEx7l/X0/qVzPNUxKOVCPhPw+brwBjvsSoyeEgoJa8lN91TZ9SOZD0hZgRBKfNKVE4KWk8QBNrox6gyq2Cwl5yU6bvXADyNocNlUjij02gy3zs6qvIDLUcbkro=
X-HE-Tag: 1787928072-3306
X-HE-Meta: U2FsdGVkX1/ICfyGN6LKNJpWczMdvtpafmHv20DAxcyxFnPdzK+By/fvUZOIQgC2RBDEKmBesjCkRjjH5DQxEWPfcueIYGezx2G5dK5+RSwBRHf4/NuUXgbTTp3p1sB8/QKHayVLBIACzDNBXCLOhF374vQCM0+1MYw2a84xMo8drYpTwmM3yaFOMgKUsdrtjgDgrbvo4COftoc9sAaX906V2l3/vCFrXPRfWjoQd0lhq8HYdnDnZVnrr5C5rn3ei2lEv7UgNvZWeXR5mrhp3BUGP3KCTd83UIeBR8rJpRk+9XCgtDzcdvF1rinu9Ya4sVylnxHS9kJfhv0VBVbfHZTPdpsb5VMyrChTdlU1EOvjGUclqqhbsg==

On Fri, 28 Aug 2026 06:38:17 -0700
Breno Leitao <leitao@debian.org> wrote:

> I am seeing some UAF KASAN issue on ftrace in Meta prod, and I think
> I got a reproducer that works ok.
> 
>  BUG: KASAN: slab-use-after-free in ftrace_regex_open+0x50/0x770
>   Read of size 8 at addr ffff00097627f418 by task stress-ng-fanot/1811644

> 
> #define TRACEFS  "/sys/kernel/tracing"
> #define INSTANCE TRACEFS "/instances/uaf"
> #define TARGET   INSTANCE "/set_ftrace_filter"

Ugg, this is similar to the bug I just fixed[1]. But this one will not be
so trivial to solve. As the trace_array in question owns the ftrace_ops
that is used to register the set_ftrace_filter file. Upping the reference
to the trace_array will require some thought.

Let me look deeper at it.

-- Steve

[1] https://lore.kernel.org/all/20260828094153.17b95037@gandalf.local.home/
