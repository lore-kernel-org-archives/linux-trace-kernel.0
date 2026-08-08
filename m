Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9A1A275;
	Sat,  8 Aug 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147239; cv=none; b=HSPlC5EsMtjrs3FGpocjFFaUB6r5krLyAH7VsTqI1ruWVLltTZGErEa9JDZTaUToBbS1x8aXJ6wOjK1csFlZ3OlnhASejX0BBNgih4eztzid6UjCv3h29wjCTCnCUXpW7ov6ECshIfj1ROPq7NvA6t47KZixOvCePSC4Cir24Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147239; c=relaxed/simple;
	bh=0tSZeBRVvKvkwivhLopdZfGQkyHCxZzT27f8mZjthhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkeFU8vXgsqQiKDehjyQdPdemrlNjufcDKu8j10145NmnypCQwQrOialcUrPhQMD98W2LFhdTZD1aqrh/4/WQPRECo1fFqULenRsblOdjRn/7MhmUCYjH6ODi6PaWgO6U0YGtynpR8UjGfWUBMzuE3l6RWJpvQs2t+gXOSwrOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=HCMaz6Lx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ymfhyta8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="HCMaz6Lx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ymfhyta8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1B13140012E;
	Fri,  7 Aug 2026 20:00:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 20:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786147235;
	 x=1786233635; bh=5fjioxdF86XfES2DbYBetaj2+5wOEm4NcVCx7s28aPc=; b=
	HCMaz6LxBSVJclILl1ZbkFOpn7quLjJFV/MG5iC+SieMcxbqlnFG+U/sEQcKobwj
	iye4OX8Nqo56UTK/q4ADouDUXQmzx/fVS4XB5swlCmeTo1l8tskl5p/9vRd0oT59
	ddfpxvXjc3BV5jL/jpwx40nRVCBGhXwsgRkebfF/UvodfOW5JBykQVXYyhebOygG
	C9eij3L5iMymxWhZGFyL7nqbd5ZGxYxxO1uZI+iGlT9gGp+NhAmQCX/xnFdpDxWn
	cyNF0ymZ1E5KzicvkUxLTfmqErnc9RfOvbWMTsWcLd/YZYXr5GeTFr8aoIBlYnan
	GaMdosWgaTyzxSITQZTafA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786147235; x=
	1786233635; bh=5fjioxdF86XfES2DbYBetaj2+5wOEm4NcVCx7s28aPc=; b=Y
	mfhyta8TIkdmlguYUXpNp8FgMGN2m299WaTlbNFywJZA4Eh41txvEh0Ez9q8vnkm
	xnSbm8Emq4EKlK9wZeLgqiS/lOTV+MkQl40L5xM4PbYNcv6dRVXrxLI1uUh+Sv4G
	Qu401nobZ+5CCbHTbQvubsWb3fx1fkI1aUPqULcpaVOrR8BIK8Uilgr7qhsWYQzI
	28ndm4wo67hZQ4XmBm1wU7LNi285VIVQxgKcqX2mSFika5+If620VBFnZRdH/dAh
	Zn1wSU0dgr0q7flXfd1CvjfuGzt3OhfS39/WXvUqiUdhLFv+LEIjVvMPG4Pt3fFF
	07KaAMkYCq1cWC8OkfzOw==
X-ME-Sender: <xms:o3F2ai_AK2df0Sbi1YeoGDmxpMJAobfdMiHwsj4jogkoby1ZuAWxRg>
    <xme:o3F2aggcvwK0eYE6RsMxTgWkryfUCRtIUwDDqmYc4gdyFLOMZ3BVKsX0wmbTRkxfM
    _XPCa1X1rAZh9Ta4VwMrFUxPPcNC0Z7IA93s32m1uDaJKf6F8QfEeY>
X-ME-Received: <xmr:o3F2aidVL1PT042YQundsWJcyoS5LqQ45UGUSzHEyDmOsLIwt2a2UISgO2VGVXsC-l-ewczV>
X-ME-Proxy-Cause: dmFkZTGuiWYIqMbqczaN5hN21DEhR+6Z0f7vDwxSM+m8Y4VKVFiXp+5793cnRGbAjGfvwW
    5X/TyzEtVo1pYHDPRmOCEHTFat/vgaaacqsv1WItzaFKZ+LwizPyNLgz367jaWY6HMXE1d
    CFBM6k80WXY97JW8fCmfahkE5ulQhyQbZLAPPt8YOxKhmgFBD5ADM7M8GwI6omfalwFYgI
    xGkE8WbTci2zZNhhuvO4hDP20wz5lI+L3aXee+AcE1P118cDsbpLlYnY59Ksz+231owajq
    llgHh930Zg1sxE+cYuy/8sRQJ/WlXTpoNvmD1YCtZ3qdMyVS7YpivU69odVueOgne7iGjD
    uO4eQU6IVr8ZGcht5QCfEhI5mhJxXHAT7/kiC9iZG59aRTNeAQT76THkeHqGl9bUVRMohJ
    HHVG27rk73vrtDaGdfWlZKdlbnUh9xXEQIhO1dmjQEGpZx9pnTM1JqViztNlB62iM361XT
    nULMlke7C7VCQj0P2nNrop/OJsq0nnUg78lE4QNb8PZcx24tfu1fbrVhjIjtXYSUzyRLPN
    7fD5j6psWEZ0NDdLKBdxdbmML49F/vBCvxIW6s9ZhSa6q9tRDwjIE8Y7w/87KEIZyXyEPa
    Ux7QiORgpgs382IY1NVwMRsdfQintzn4cwnV3ITQds7sBeI/NOXnOfJc/19w
X-ME-Proxy: <xmx:o3F2anqZMpKhPRVpo7UvXnwhyoZY5FJJn6mZ6Bvf7-BS3WDM28sOhg>
    <xmx:o3F2anAI0oUgTwdStn4WzjQWC4zrzczC4aMP0lfcBCxNHSYOY_bepg>
    <xmx:o3F2akYeb7AFVIU-q3Go3W7e8unwfK4XV-314UDMGBwGv-kT_cxxrw>
    <xmx:o3F2aq5aHTQsnZ1hOoj7v8cfAQEwe2ZnVL13yFVmY6bKf4z9cUdeGw>
    <xmx:o3F2aiuuhlUYMV_Y1zZOoqBoc1jvwZ2nEQBM9t4gDlqgdsGlaf0VuoQW>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 20:00:35 -0400 (EDT)
Date: Fri, 7 Aug 2026 20:00:39 -0400
From: Steven Rostedt <steven@rostedt.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Use children field for rcu head and add memory
 barriers
Message-ID: <20260807200039.1bc728f3@gandalf.local.home>
In-Reply-To: <20260808071506.cacd0c21059c942a5d2d173b@kernel.org>
References: <20260807170408.2d324df5@gandalf.local.home>
	<20260808071506.cacd0c21059c942a5d2d173b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Aug 2026 07:15:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The critical issues Sashiko mentioned will be fixed by Shuangpeng's patch[1].

No ;-) The critical issues Sashiko mentioned was from a review of that
patch which stated:

  "This isn't a bug introduced by this patch, but does this still leave
   concurrent SRCU readers vulnerable to list pointer corruption?"

Thus Shuangpeng's patch doesn't address it.

I was in the process of applying Shuangpeng's patch and I look at the
Sashiko review and wrote this patch to fix that issue too. I plan on
applying both.


> [1] https://lore.kernel.org/all/20260806022719.375354-1-shuangpeng.kernel@gmail.com/
> 
> Thank you,
> 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
> >  fs/tracefs/internal.h    |  4 ++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index 39c7a34531e8..677c39b0d62f 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> > @@ -124,6 +124,16 @@ static inline void put_ei(struct eventfs_inode *ei)
> >  static inline void free_ei(struct eventfs_inode *ei)
> >  {
> >  	if (ei) {
> > +		WARN_ON_ONCE(!list_empty(&ei->children));
> > +		/*
> > +		 * The ei should have no children if it is being freed.
> > +		 * The SRCU iteration has a smp_rmb() to make sure it
> > +		 * sees a child (that may have already been freed)
> > +		 * before it reads is_free. If is_free is set, it must
> > +		 * not use the child it acquired from ei->children, as
> > +		 * the list may be used for SRCU.
> > +		 */
> > +		smp_wmb();
> >  		ei->is_freed = 1;

And Sashiko found a bug here (from reading the comments). The smp_wmb() is
supposed to be *after* the ei->is_free = 1 !!!

I'll send a v2.

-- Steve

> >  		put_ei(ei);
> >  	}
