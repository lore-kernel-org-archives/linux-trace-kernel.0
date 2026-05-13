Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82C4779B1;
	Wed, 13 May 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684534; cv=none; b=HAde6jd/ts8o6qXzrzIe9l4lZd/dQs0TK1CiLmTcs2jq06WycJuArT85/LeDfFCxd8IwwZ2f6Vfn2WmO9mdwiKRpL9/vKuDXxb5Pnt8Z6ispAxgpFgWOJdRIAVynkIJStK9Jsv/wAewrg0S2MJw6v5DFQcHiUC3FfaCzKZwSeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684534; c=relaxed/simple;
	bh=n/wExn3RDDu5LIIvBKIBZ0gCR53+jPQLP7RdXpSyJsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCrjAuN29O0zQuoMaec1EkdhqVDzM3TEL5QT2dDvcj0KBihMQ3TnZ17y26JUQqqeqtyDlSqJ8IphxhS6hKmN8P/U/+em8OKopRyjHQIeptOlbiTHiYEQ/bQvZZa8FFSMn3nd8/7Bxuf2Vo4x8aJUswcWXr7nhQgTPARWoefchnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3D8E5896DB;
	Wed, 13 May 2026 15:02:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id BCDC830;
	Wed, 13 May 2026 15:02:05 +0000 (UTC)
Date: Wed, 13 May 2026 11:02:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: CaoRuichuang <create0818@163.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Drop invalid top-level local in
 test_ownership
Message-ID: <20260513110208.3c14878b@gandalf.local.home>
In-Reply-To: <20260407203727.442b583c@gandalf.local.home>
References: <20260407102613.81419-1-create0818@163.com>
	<20260407203727.442b583c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: BCDC830
X-Stat-Signature: usmum9dgxojj85xgbq5mex41g7m9r9r1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ioo7M6MwS0UYAqOZUaZeGLcDoBSwWgwU=
X-HE-Tag: 1778684525-631401
X-HE-Meta: U2FsdGVkX18pZsSgACH3JEi6pmeUYLR+94PPbQXFjvFFJJjrvrDa8hbm6K267d0yb+P+eHtmD4Tgz1M2KTunFMtIjsjm4n092Jk+uTDQYKwxfjHsdtB65IlHtmltU5lkJrYp0r9tZdhEpRKXHtJHHR55Pjg4ju1StqlhbfkjgGQdzg3Lq1g/PGVfJHY6MrGmVMUk8UfMboy9KsVPzQl/cz01WvLEY7liQVZYasQeAfsEwkCgG80h6xnucMAk6yvDcXldKm66U875oNpHnnWT/y1+a3X0gyDfUppbE7G/cYmMWr4Wp+cMLcBvQJ8eNXzZVWJGv9SalMR7XjkUEEXsZPnarBzXVsqkqrlU0aNSNBFE1Mjc3F6LFlPX10NLQwX/RpCI1qoF44yDyQeVAoHopysRdpRe4jril1/XcK6cUYU=


Shuah,

Can you pull this into your urgent branch?

Thanks,

-- Steve


On Tue, 7 Apr 2026 20:37:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> Care to take this through your tree. Probably could even add:
> 
> Cc: stable@vger.kernel.org
> Fixes: 8b55572e51805 ("tracing/selftests: Add tracefs mount options test")
> 
> As well as:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> On Tue,  7 Apr 2026 18:26:13 +0800
> CaoRuichuang <create0818@163.com> wrote:
> 
> > From: Cao Ruichuang <create0818@163.com>
> > 
> > test_ownership.tc is sourced by ftracetest under /bin/sh.
> > 
> > The script currently declares mount_point with local at file scope,
> > which makes /bin/sh abort with "local: not in a function" before the
> > test can reach the eventfs ownership checks.
> > 
> > Replace the top-level local declaration with a normal shell variable so
> > kernels that support the gid= tracefs mount option can run the test at
> > all.
> > 
> > Signed-off-by: Cao Ruichuang <create0818@163.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > index e71cc3ad0..6d00d3c0f 100644
> > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > @@ -6,7 +6,7 @@
> >  original_group=`stat -c "%g" .`
> >  original_owner=`stat -c "%u" .`
> >  
> > -local mount_point=$(get_mount_point)
> > +mount_point=$(get_mount_point)
> >  
> >  mount_options=$(get_mnt_options "$mount_point")
> >    
> 

