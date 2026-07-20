Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1A426EB3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554627; cv=none; b=vGfX+WFyf05JeLlWBa28sxvVNBWONPxcVkzSuaPOP6wcQIC1m1OBzfplzIZyXPhQ8th010NhxzqcLaxk6MuFGziTazsio/5HCvbiIObijY8MC6b5AhFuaTkdItoOSsAME3YV+l8pPpNbe+p2Hkxfk4tmr9ajPACSLmYxyiDLBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554627; c=relaxed/simple;
	bh=d5LA9IC8FOlvaz/ryVsIcPWf6hxrSBYkEaNdcLnam5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idzUFFD6fml4d+Cd86x7egxNJ9x+BxoKiCiwtfA0sMz1+uzARToHG7+NfquyGCJE3YhFVjRcOCTl6yR0lJeNk1XHEILN515M8YNHJ0/bvaiwwdTHclqMH00y5/OzBVO4qd8fz06gvSI6cN5VoKrel5qger+RYGjz2JAk89bYuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2FAAD160190;
	Mon, 20 Jul 2026 13:36:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 8B94F2002A;
	Mon, 20 Jul 2026 13:36:57 +0000 (UTC)
Date: Mon, 20 Jul 2026 09:36:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <20260720093655.4da2224d@robin>
In-Reply-To: <7ia4wluvvlq4.fsf@castle.c.googlers.com>
References: <20260715005909.GF1656185@killaraus.ideasonboard.com>
	<4928C919-7999-4E76-ADCB-F8643FED105B@linux.dev>
	<20260715162816.GF1778116@killaraus.ideasonboard.com>
	<7ia47bmw0xls.fsf@castle.c.googlers.com>
	<20260715192042.4052411a@robin>
	<7ia4wluvvlq4.fsf@castle.c.googlers.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8B94F2002A
X-Stat-Signature: iuwtipa73ez5jy5zhppn9ubuzyczon8n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yznEYJNgk4+SSJwhLyTIoOuy8VROnuT0=
X-HE-Tag: 1784554617-626527
X-HE-Meta: U2FsdGVkX19BS5wZmVVeuic6GNBcurrrrnN7mlvfbZDUTrfRq3OKdpH7ki1p2EKe/hfPm7dn3D+xwHoF/8PIod36WdPKXPT+7qIlHRsuFkshlpVtpLvnx/HvJLqfQsKrdbCDjm4R0hygqXI6cXLP8WTZIyfj0+aeJijnYFsc19a8MaAz54C1fMJhkQlysTL3vA9Nwc1yrbD+Gkd897nFX3JZT57X3z3Vz4aslifCamLzAugFI7AuP1O0Z4BKNj1mWQSSLb5DD0zeHxcYqdv8mPE+21UObI3OM3IpSrJWkhdgkFhl0Z7q7YVD06tBwE9MCAWKDEtYNIGUTpOQOT6YR4Hc/uOBNUog1VMyVOL31b2yhITxT9UHtUiknoIxrnYV


[ Removed all Cc's. Added Masami and linux-trace-kernel mailing list ]

On Thu, 16 Jul 2026 00:09:39 +0000
Roman Gushchin <roman.gushchin@linux.dev> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Wed, 15 Jul 2026 21:08:47 +0000
> > Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >  
> >> At this moment there are 36 mailing lists who opted in for delivering email
> >> reviews over email (without counting linux-media@). In every single case
> >> it was based on maintainers requests in all cases of a disagreement
> >> between maintainers I took the conservative side.  
> >
> > Oh, I think I missed this opt-in. Can you add replies to patches sent
> > to linux-trace-kernel. Currently, I've been manually looking to see if
> > a patch had a Sashiko review and sending the author a link to the
> > review and told them to please reply to the comments.
> >
> > Note, I have not had anyone tell me the are against doing so.  
> 
> May I ask you to raise this question with other linux-trace-kernel
> maintainers and cc me on the thread? Just to make sure everyone is
> onboard.

Masami,

Are you OK with having Sashiko send an email on what it finds to the
author and the mailing list?

> 
> Also, please, let me know if sashiko should reply to the author and
> also if it should send an email if there are no issues found.

I think if it finds no issues it should still send the email, as it
adds to the confidence of the patch. It also lets us know that the
email wasn't just dropped.

Oh, I would think that "Failed to apply" results should *not* be sent.

Thanks,

-- Steve
