Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA12264D3;
	Mon,  9 Feb 2026 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680578; cv=none; b=r1toVlGUk9lm3zGywNXP9j7XNetvMzm65m7/o80YJptiT7d463ewY4/oqfzfU7MOAwkX9B1bEqODRKRjjn7JL6n/vg5XO1b3VteCiDw2YqTVzKzRys+f1pOUGzFQ1jL1VfnvqYfhttFu2OmJY9+HdcT/iCKMoIa1pdqENjJpVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680578; c=relaxed/simple;
	bh=aYdEn+DVrPJc4gnD5yFI1unhKvO4Np2pnqT4WCRT/Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYhVXr/LEH0LhkBiyxFEZMNVSWEkfVGRMowjlagegIVKb/PTL/qcwrOV1RiHkZXZkO1kqkoIELxUznM8x1UGYwz4etAKFnHn0DNsDnllbbnLWeGjIlWaNfilD1gilLm0X4fhISwJzkBpZIHX42Hjb66SgA0r5b5FDVO36QVlClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C399A5820E;
	Mon,  9 Feb 2026 23:42:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 432BC2002D;
	Mon,  9 Feb 2026 23:42:48 +0000 (UTC)
Date: Mon, 9 Feb 2026 18:42:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260209184247.4c6daccd@fedora>
In-Reply-To: <20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
	<20260204211721.74e501f0@robin>
	<20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 432BC2002D
X-Stat-Signature: y19czkhjejuu7e97o1fb1hhn5cd6tfkw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yXOHSS5B4Sot9JSEy/S7xVgifo4YO/ec=
X-HE-Tag: 1770680568-655770
X-HE-Meta: U2FsdGVkX19X4g70jRLj9WdZWmqQg7kTojVqFHh/5qkxiX2QGNXNcgGIxiAtUeOf43QFZuuDofv2Tujw2TDZ9hjXMZ9ddFjas9JT+cAl6lR/Q9OT4B8zxVHegwGyX9w1va+rUdTnnbUxF3Q6WkdYagghQmOlOf87+RB+Xn1c0Co9VT4YXtog35JFAj8bu4kKZXVlDcz4TZpsdGfYd4RMKJigjFOOQE4ryAf9SKAt26SpOoTwbinmsZJIuKSOkMk9IzxEhpMSNTXKIYsgfFJb2TN7IMoIaz/xExt3jCXFonuAmwTNR/i1Ec23P7NOKxWpjbwtKc4cTrYMC/LyQiRLjPDwAzPv4q9o

On Mon, 9 Feb 2026 18:08:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > @@ -5152,6 +5157,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
> > >  	cpumask_var_t tracing_cpumask_new;
> > >  	int err;
> > >  
> > > +	if (trace_array_is_readonly(tr))
> > > +		return -EPERM;
> > > +  
> > 
> > Shouldn't these checks be done in the open function? Doing it now is
> > too late, as -EPERM on a write is confusing when the open for write
> > succeeds.  
> 
> I've made a small program and straced. Surprisingly, for the super user,
> open(2) does not return error on opening a readonly file with O_RDWR.

*blink*

So if on open, the trace_array_is_read_only(tr) returns true and you
return -EPREM, it still succeeds? That sounds like a bug!

-- Steve
