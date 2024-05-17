Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C35A116;
	Fri, 17 May 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955344; cv=none; b=gC27/vzEHtF4MG78WU1CT35pqByfn5w/yHiURiW3y2UEoHuzryQ82g1x/po4ME/5HTv8XEar3gukUuIlWjk5bZkUo+IZCZDZ2Kc1QkIahBc+jOBDj5bByBDlhb3CzZRq6b3r5IHclErFgqNdsWR5QZmxoIbOtR0kPEHD524o8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955344; c=relaxed/simple;
	bh=d+hQgBYBD7HhNvqtRKUIitmuVSa5P1lUxQfBIglOnfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXN99fV/I3kJFKFVjzeNlnbhIGll0OlfVWKRbXjMXVcg4IuUfBuW15bH0P3nBN3A1WkY6jlB5TP38MQMtgMoqAyJsOv6lAXntYe39uBfdj6cdehKKu+S0nDCTwhxhILwuRPJrOh48/qPvIMAlSnfnTE8BtCuZk8KzeHR+1RiAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A712C2BD10;
	Fri, 17 May 2024 14:15:43 +0000 (UTC)
Date: Fri, 17 May 2024 10:16:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <20240517101613.0584c291@gandalf.local.home>
In-Reply-To: <87eda0c3uk.fsf@intel.com>
References: <20240516133454.681ba6a0@rorschach.local.home>
	<87eda0c3uk.fsf@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:08:51 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Thu, 16 May 2024, Steven Rostedt <rostedt@goodmis.org> wrote:
> > There's over 700 users of __assign_str() and because coccinelle does not
> > handle the TRACE_EVENT() macro I ended up using the following sed script:
> >
> >   git grep -l __assign_str | while read a ; do
> >       sed -e 's/\(__assign_str([^,]*[^ ,]\) *,[^;]*/\1)/' $a > /tmp/test-file;
> >       mv /tmp/test-file $a;
> >   done  
> 
> Try 'sed -i' ;)

I've always been nervous about trusting -i ;-)

> 
> >  .../drm/i915/display/intel_display_trace.h    |  56 ++++-----  
> 
> On i915,
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 

Thanks,

-- Steve

