Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4510F1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594094; cv=none; b=UcKhqD+IcdUnnYbF2xXORMAav3r5jyJMFRgtzQGcmftKGlqnD1vcWINHyQx35Tubfpkfn9JIvTBKz77uGlaspUKDCO9p7EMxhL8GcZ8hxG4ujCgAFDzxpM8YxCJEosIMIUR/QipZrCJu9cGKX+YNeJrbGrd0mhuTvJtQVL2WzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594094; c=relaxed/simple;
	bh=xhqg1g5OBm/TnQtbW3vs2+u2oy2JMbyJhqjHe5lSmYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FdN9pvnLP1AUcCyVjPX1HADR1LA/58gYYQseN2kuEOXjmHF1llK9K2m94452B+Y9G7IQ2yWtvmqBMZz1bQkgOAptvq+dxUG1vI+zShXylctct9+1OrmST2ABfGra/0rkQUtlIpichVdbaOlVnGMGWbiNlnUYp+GIcQ2ogfNbdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asagOxcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asagOxcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C81F000E9;
	Tue, 21 Jul 2026 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594093;
	bh=pVwFeDICgQW8/HCnQHrqeF7MB10O8acebp2MSPE4hus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=asagOxcO3JvUz3Y2IQnF1Ds+taFlOTGde/5HB26EaL0mxWDGmIZ7jZcesT1IUoeAm
	 HKV1vOQ/K8GQPsf8zy5A0xFwSBRt8z9xNQGNCUgNcIJcIW0w4+BtoniR7/6YiGtPWq
	 nCH7mMRUFoy3MXk/1ljZoNngxDrgewHIR7iewho39Na+R+hLsdchBuPtpKKe0OhCHP
	 h61W5yzPnVK23i0fJELkohWeaFMVQAnidOvFW41wWDt0ugxCk+3BSmr3Y3nnrgsBNl
	 Lbw0FWhKr8mZjt6zjNFJy+1ry4M2Bc8p7kzmCpKkuUzBG45/8Ss0SMHF8j3P+Sesgz
	 zE6ynwN5TIaNQ==
Date: Tue, 21 Jul 2026 09:34:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: Linking Patchwork with Sashiko?
Message-Id: <20260721093449.968265216a1201101383b443@kernel.org>
In-Reply-To: <20260720093655.4da2224d@robin>
References: <20260715005909.GF1656185@killaraus.ideasonboard.com>
	<4928C919-7999-4E76-ADCB-F8643FED105B@linux.dev>
	<20260715162816.GF1778116@killaraus.ideasonboard.com>
	<7ia47bmw0xls.fsf@castle.c.googlers.com>
	<20260715192042.4052411a@robin>
	<7ia4wluvvlq4.fsf@castle.c.googlers.com>
	<20260720093655.4da2224d@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 09:36:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Removed all Cc's. Added Masami and linux-trace-kernel mailing list ]
> 
> On Thu, 16 Jul 2026 00:09:39 +0000
> Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > Steven Rostedt <rostedt@goodmis.org> writes:
> > 
> > > On Wed, 15 Jul 2026 21:08:47 +0000
> > > Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >  
> > >> At this moment there are 36 mailing lists who opted in for delivering email
> > >> reviews over email (without counting linux-media@). In every single case
> > >> it was based on maintainers requests in all cases of a disagreement
> > >> between maintainers I took the conservative side.  
> > >
> > > Oh, I think I missed this opt-in. Can you add replies to patches sent
> > > to linux-trace-kernel. Currently, I've been manually looking to see if
> > > a patch had a Sashiko review and sending the author a link to the
> > > review and told them to please reply to the comments.
> > >
> > > Note, I have not had anyone tell me the are against doing so.  
> > 
> > May I ask you to raise this question with other linux-trace-kernel
> > maintainers and cc me on the thread? Just to make sure everyone is
> > onboard.
> 
> Masami,
> 
> Are you OK with having Sashiko send an email on what it finds to the
> author and the mailing list?

Yeah, I hope that is good to make a discussion on ML about reviewed
result.
Mostly those are reasonable now, so maybe we need to decide a standard
format for "all-Ack".

Current problem is that the Sashiko does not look back the previous
discussion, so the commit or code comment should clearly state
"this code is intensionally do something."

A current issue is that, since Sashiko does not reflect the content
of past discussions, we must explicitly state within commits or code
comments, (where you have determined that a past review comment was
incorrect) that the code is intentionally doing this operation and why.

> > 
> > Also, please, let me know if sashiko should reply to the author and
> > also if it should send an email if there are no issues found.
> 
> I think if it finds no issues it should still send the email, as it
> adds to the confidence of the patch. It also lets us know that the
> email wasn't just dropped.
> 
> Oh, I would think that "Failed to apply" results should *not* be sent.

Yes, the fact that there is no response from Sashiko implies that
the application failed.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
