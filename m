Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EAA47;
	Tue,  1 Jul 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347567; cv=none; b=fVUKy3156ROCQto/vQ0v4Y3pKULJaehdcHm0R4O8lKR87IyuJR7aiulQBa2qcph7Bi+Lu4Kw7FK8WWrt+RT6g4pKyrtXXdB+OFWdRMqP9i6/HsPQytly4QLfZKIa3Bjy2caW6584MNDHJYBn5o25FH0iYMZRVWZgkJAerukA8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347567; c=relaxed/simple;
	bh=d4OhRhzXnKfFiv6vQlBt9srOwekw28c6Lb41hlTPqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCidPomCCYcfAXVn2280s9k5SdSA3Ii+ACyZihLNAER5pyRsyUHHop6SLXTQ82h2oD8du8lkSDikUyVaLa/IiqpGkPdkQYpsMPOKFJWVSziLLltn/1IcSzKL27cYFmAeMFpZaLxiMG3a+j6JO9dITXnQcXfRLdL7VSCl6VlMREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjh7aKD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0n7UELj9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjh7aKD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0n7UELj9"
Date: Tue, 1 Jul 2025 07:26:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751347563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kTb1x7UhGfb85HiulGIBcgPBzbQ24EUbidfsvuP3KU=;
	b=tjh7aKD/iHcm68cmVZZ9leqobbDJfPFOMrmrnLZUkdwnL4JyrLih7MRu5zufO4drW6yvqH
	2oSZsj++JI/LGLe4IPdRog6LsyCd1ePXoTd39YdBjLH5Hp9376R5CgXA9ieO9NAh4Yxe0x
	Z6VgbiX65UEQVzXLzQhvMXsAQ0IqcM7+PnvEKAahNHJUXg8lo0bhVuvwaSOd4DIOE2HbZx
	dRTavVqjCv5lFEL08ezbEkodYFwDQ5elNuYjW8XWXdM/IjJZR0Ho4/13qca8kE1ApbPvS8
	9k82dmmM1GlD66vJdpMyQvDtwUOjY8ALJ+DV1YS+/Cu6Jr7TdK9SF4Oaoq/9EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751347563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kTb1x7UhGfb85HiulGIBcgPBzbQ24EUbidfsvuP3KU=;
	b=0n7UELj9cOLEOgnVVF/nqCx1f4fOlvNLTphxZNdQ6aDEyROrYmBHnV6Db1QhL97tRNMnId
	nBYMa/zHD2M09DBg==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 00/19] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250701052601.L9guEoHP@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <20250627124248.fpuBrdWJ@linutronix.de>
 <20250627101631.59bd7ab0@gandalf.local.home>
 <20250627141744.yTIdgd2m@linutronix.de>
 <20250630203714.7af11375@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630203714.7af11375@gandalf.local.home>

On Mon, Jun 30, 2025 at 08:37:14PM -0400, Steven Rostedt wrote:
> On Fri, 27 Jun 2025 16:17:44 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > On Fri, Jun 27, 2025 at 10:16:31AM -0400, Steven Rostedt wrote:
> > > On Fri, 27 Jun 2025 14:42:48 +0200
> > > Nam Cao <namcao@linutronix.de> wrote:
> > >   
> > > > Is there any chance this series could be applied soon? I have some more
> > > > patches which depend on this series, so it is holding up the show. I think
> > > > Gabriele needs this applied for his patches as well.  
> > > 
> > > I'll try to take a look at these today.  
> > 
> 
> OK, finished it. I didn't read the lines that were over 80 columns, as that
> does give me a headache. But that means I may only have questions on the
> comments and documentation.

Thanks, appreciate it! I'm well aware you are probably busy with other
things already.

> The rest looks good besides the comments I made in the series.
> 
> Please send a v11.

FYI I'm on some sort of a "business trip" this week, so v11 probably can't
arrive until next week.

Best regards,
Nam
