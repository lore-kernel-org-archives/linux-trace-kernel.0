Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F3BA46;
	Mon,  8 Jul 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478680; cv=none; b=E1KBDZIK9iT/hoj7wXbR9F6xLRoHJ/L5bZKxJRZ9hLrwEd3T08X3cAi1uwfWi9Nn2AuTtuDfDQaa4dCd7uL+t23NlqHPPjQvgrYt0INyXK34Hp1qT6Yoc7c7PHxPJb4NAkRNxEvZWtp37nHq3gTdWUQ7udGQvCVO8Z7eEAPuFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478680; c=relaxed/simple;
	bh=3T/vx7wtTuSugpPLCQmC8NiPQXjKlfD8eD6FNiQIywE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b0l3nVySdqwPRfSjsME6oSDS3ErAGJP2ASavGgXvnz1vfJG9WtpdEirNvdL7FznBmixmQLiz/ld67SSIs5rQH4jZuxNTldkkuXgLIqKLokKJcTJY4x9UShBQGOnJw9ijq4RjfGwkv9YhiJ8OPyVvztfAZ8bdLbWuSdOyi7ZGNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4/Xol0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4/Xol0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522C4C116B1;
	Mon,  8 Jul 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720478679;
	bh=3T/vx7wtTuSugpPLCQmC8NiPQXjKlfD8eD6FNiQIywE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f4/Xol0oq6iH8WxUUzqxIw0HrccGe+hEbg+a1KTMrjaSgsKKTa4ys5l+jyEYyh7X0
	 JmdAl5XcAfADZp+NftThrFFvZKp0ApH7nqMA95iOk7IUn/jYGKKawKe/Oad8clW9le
	 Wzoqr+PlHCt0E0fMpjinV9h9x8fcXS6a3AGDglyGqJ5d5YodS/krmQJsW1D1sl8Iwl
	 w80irGnckq/nWM8q/UPe44SWLyiqz36F6ZcryjP1x/+pI9F2eWlxWRr+y4CNpYSkao
	 Ii88pV28DBXApv6Lel+vxJdWMgPX39b1KM/Vc2v+cD+pHMNJOaPN7pnLXEpG7xdbS+
	 5axoyM8qVhZ0Q==
Date: Tue, 9 Jul 2024 07:44:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Document user_events ioctl code
Message-Id: <20240709074434.d3ff058a396d7020fa04f7e9@kernel.org>
In-Reply-To: <20240703231343.GA408-beaub@linux.microsoft.com>
References: <20240703222501.1547-1-beaub@linux.microsoft.com>
	<ZoXXe8Tl9pRD6-dd@localhost.localdomain>
	<20240703231343.GA408-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 16:13:43 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Wed, Jul 03, 2024 at 06:58:03PM -0400, Mathieu Desnoyers wrote:
> > On 03-Jul-2024 10:25:01 PM, Beau Belgrave wrote:
> > > The user events trace subsystem uses the 0x2A/'*' code for ioctls. These
> > > are published via the uapi/linux/user_events.h header file.
> > > 
> > > Add a line indicating user events as the owner of the 0x2A/'*' code and the
> > > current sequence numbers that are in use (00-02).
> > > 
> > > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > > ---
> > >  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > index a141e8e65c5d..191609fe4593 100644
> > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > @@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
> > >  '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
> > >                                                                       <mailto:alexander.shishkin@linux.intel.com>
> > >  '&'   00-07  drivers/firewire/nosy-user.h
> > > +'*'   00-02  uapi/linux/user_events.h                                User Events Subsystem
> > 
> > You may want to consider reserving a wider sequence number range to plan
> > ahead for future extensions to user events. This way you won't end up
> > having to jump over sequence numbers eventually reserved by others
> > within the '*' code.
> > 
> > Thanks,
> > 
> > Mathieu
> 
> Yeah, I thought about that, but really didn't know how greedy we could
> be. At first I had all, but then thought we would never use all of that
> sequence. We'll likely want a few more for libside integration.
> 
> Maybe I'll grab the first 16, that should leave a lot for others and
> give us quite bit of growing room.

I think that sounds reasonable, there is a sentence in the same file:

----
If you are writing a driver for a new device and need a letter, pick an
unused block with enough room for expansion: 32 to 256 ioctl commands.
----

Maybe you can reserve a block for 32 ioctl.

Thank you,

> 
> How many do you think we'll need for libside? I think we'd only need 2-3
> personally.
> 
> Thanks,
> -Beau
> 
> > 
> > 
> > > +                                                                     <mailto:linux-trace-kernel@vger.kernel.org>
> > >  '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
> > >                                                                       <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
> > >  '2'   01-04  linux/i2o.h
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
