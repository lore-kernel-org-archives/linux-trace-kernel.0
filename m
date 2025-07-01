Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807872618;
	Tue,  1 Jul 2025 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330203; cv=none; b=VDow87jSjFtXt/sLl/xtAQjCWfVJFkWPsw1uMdc3zcXM/AKDkm92kV2Q23cw06sxGJEEr5PHKVgg689hm8WiiX18b1E/m6xHlzHwbmXyUQQ4LnoSvukjxKj5PNps4+rmgWoitOawnmnaei1oh7HC5VEab+5Y9Hmo7fcyNCgljgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330203; c=relaxed/simple;
	bh=WPyoJI/uJRQN+gTOZt6D/Ivcynv4TMEJJ4cZChOY/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrGYof+YFfbF7guLEChbj7yF7U5BWsLU83KB8luEn9L6hku+oINkwrEksz7K7eCedR5dNUYkKltCBDBGw50eWB/XV5JC8s1pZ6lAMgtfyyTrKf1PGBm3nuHL4TG6gf+GjS81wP6UVw4mkLnyu9wy012PFfvbn6ld6dGF3lCPoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CD325160214;
	Tue,  1 Jul 2025 00:36:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 10C4E20026;
	Tue,  1 Jul 2025 00:36:37 +0000 (UTC)
Date: Mon, 30 Jun 2025 20:37:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 00/19] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250630203714.7af11375@gandalf.local.home>
In-Reply-To: <20250627141744.yTIdgd2m@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<20250627124248.fpuBrdWJ@linutronix.de>
	<20250627101631.59bd7ab0@gandalf.local.home>
	<20250627141744.yTIdgd2m@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: krkmfgaobojdt66b7uea7q781e75c3ob
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 10C4E20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HY7j5IkGblfjjBvmiInQmjtNFN979ntY=
X-HE-Tag: 1751330197-431042
X-HE-Meta: U2FsdGVkX183VdravY5pttDtrgeEjLKvxDwl0MiHwm8AydbLHTQt84hn+viHFUkGpYEmchpnJRaR4Va6Ai2MHVV3uiuJA5wUQoY/bZAZmwEk1b5b6obVtyo7wZrHfOC2HAzdpYu+tMZRD/RtLCBed4uMXsyc0mlGrqa8v2/DyeFpphS3IhYkFDvpNFV5PW5mkAHKp5GW2+egNYksEh4OuuQQyvzj83bGLl+TJOjQWqBvk1UklP077Q0AXAFetMaq1uA2IwmhNBoxLf5yDS37weaG5oRgKYahfHzQJbipwV+f0xbLqqMCdei7mgFKu4Md

On Fri, 27 Jun 2025 16:17:44 +0200
Nam Cao <namcao@linutronix.de> wrote:

> On Fri, Jun 27, 2025 at 10:16:31AM -0400, Steven Rostedt wrote:
> > On Fri, 27 Jun 2025 14:42:48 +0200
> > Nam Cao <namcao@linutronix.de> wrote:
> >   
> > > Is there any chance this series could be applied soon? I have some more
> > > patches which depend on this series, so it is holding up the show. I think
> > > Gabriele needs this applied for his patches as well.  
> > 
> > I'll try to take a look at these today.  
> 

OK, finished it. I didn't read the lines that were over 80 columns, as that
does give me a headache. But that means I may only have questions on the
comments and documentation.

The rest looks good besides the comments I made in the series.

Please send a v11.

Thanks,

-- Steve

