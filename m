Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28B1DA313;
	Wed,  3 Jul 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048428; cv=none; b=jWVwWG/u/YLICMLRHqFmx+x4UcMDhbCSWjaf/AqwNgS4qtuDlYkeIAkLXjh9QLnIeEfgznMXU4BU5hiJzNInaEnLRdi8ch2kVw5ByT9we79hs3ZkszIuWRMNIdXHtvKUm0aX8FsQvdwEwNJAw+t+W5nBPJTJ+tH1NeBMDoS8Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048428; c=relaxed/simple;
	bh=tkAEnZTdufIPBg19mfhsTyGDEWte7diQWj8XaWSicxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EusRgFFcZsjZ20H4FG3mmQgGM2fND/OFM0lJhPbcbnot7/a7xaWNcA4upgJsw+f9wwEJa4ibeW4EqELtj0J0eonQm01HXznx/BC+VzBfhLML+msqCB5+3qfRm/6WcBzqF5SnRAba20mybI45xYSY4FMr3hmEpWXmkLHdAuXoYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kIoazDM6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kIoazDM6"
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCECB20B7001;
	Wed,  3 Jul 2024 16:13:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCECB20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720048426;
	bh=8TjyHg4R4+V1DoSvmceU1FyPFi2X1MteEWpxLXoSgCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIoazDM6qEM5gOtwqev3UjD1UibJY8Hr2zDei3VYuYcss91JR0XbKWbR6Fl4kXCnZ
	 WaWazl73kDl3vF8BZqzsFGTTV/xfw14feKzgTeAMrxNeTR7GU22xgUronbPTqGh/IP
	 I5tuoGPYcMpNojHZLqk/MfZycYKEtbZcYwwJbSNA=
Date: Wed, 3 Jul 2024 16:13:43 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Document user_events ioctl code
Message-ID: <20240703231343.GA408-beaub@linux.microsoft.com>
References: <20240703222501.1547-1-beaub@linux.microsoft.com>
 <ZoXXe8Tl9pRD6-dd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoXXe8Tl9pRD6-dd@localhost.localdomain>

On Wed, Jul 03, 2024 at 06:58:03PM -0400, Mathieu Desnoyers wrote:
> On 03-Jul-2024 10:25:01 PM, Beau Belgrave wrote:
> > The user events trace subsystem uses the 0x2A/'*' code for ioctls. These
> > are published via the uapi/linux/user_events.h header file.
> > 
> > Add a line indicating user events as the owner of the 0x2A/'*' code and the
> > current sequence numbers that are in use (00-02).
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index a141e8e65c5d..191609fe4593 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
> >  '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
> >                                                                       <mailto:alexander.shishkin@linux.intel.com>
> >  '&'   00-07  drivers/firewire/nosy-user.h
> > +'*'   00-02  uapi/linux/user_events.h                                User Events Subsystem
> 
> You may want to consider reserving a wider sequence number range to plan
> ahead for future extensions to user events. This way you won't end up
> having to jump over sequence numbers eventually reserved by others
> within the '*' code.
> 
> Thanks,
> 
> Mathieu

Yeah, I thought about that, but really didn't know how greedy we could
be. At first I had all, but then thought we would never use all of that
sequence. We'll likely want a few more for libside integration.

Maybe I'll grab the first 16, that should leave a lot for others and
give us quite bit of growing room.

How many do you think we'll need for libside? I think we'd only need 2-3
personally.

Thanks,
-Beau

> 
> 
> > +                                                                     <mailto:linux-trace-kernel@vger.kernel.org>
> >  '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
> >                                                                       <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
> >  '2'   01-04  linux/i2o.h
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
