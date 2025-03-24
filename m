Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6410F1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842437; cv=none; b=uCdUNDLnv8P+11+UX3O+KWbH1YrI35hB0RffJR7dRJMBRsxjbOIfsQ6JJgc7jE6NATJ7fpeHJfKau4ZY509TmhCeMmB2Ul1uO3A2gaqWz9y+bz0EFjDkyB1PRBJblb42G/bPX0nzwq2q4O3+gEzygxlkyZAweetxuqZ6heZOUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842437; c=relaxed/simple;
	bh=N6qzzOsknKz9lP3NREPfDNoS3RR8FNBvhn97hL2o6OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDXqLvnzZ8Ix3efWwdsKmUJLFLjbLSqEDFc6CjDWAs/SMEi03yf/Zbouz7tWAjmU9ApDDecw+cmfe3RILrbkFd9DrCb2oj5R8AETv9QgpFOeSYWqo2SaJ5k11wrsKwElYAj74kzj5Gk2Qs3AMnhp+dmALu/It7kQx7HBbJc4eKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DdszAEIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdszAEIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F2CC4CEDD;
	Mon, 24 Mar 2025 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742842435;
	bh=N6qzzOsknKz9lP3NREPfDNoS3RR8FNBvhn97hL2o6OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdszAEIXreQDZzRBXy5C0b42sw1oal/dDOK6bcc7XGTn4Tz9FeVHxFt6al7ZKTZxz
	 6o1cahKAjFhBVnKqLOxNBxg0O7jwbAaMtX2e/mD/OijOINJPDCFq8rJnIpEMpe2EQB
	 Z4IVz0lgXVvgvXCNqENdC19hsRSTarjPvxg/M41U=
Date: Mon, 24 Mar 2025 11:52:33 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Kevin Mitchell <kevmitch@arista.com>,
	Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <2025032424-custard-volley-bbb6@gregkh>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home>
 <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>

On Mon, Mar 24, 2025 at 01:39:12PM -0500, Sahil Gupta wrote:
> > > Hi Steven,
> > >
> > > On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts because
> > > of the parsing of the start_mcount_loc and stop_mcount_loc values in
> > > get_mcount_loc():
> > >
> > >   *_start = strtoul(start_buff, NULL, 16);
> > >
> > > and
> > >
> > >  *_stop = strtoul(stop_buff, NULL, 16);
> > >
> > > This code makes the (often correct) assumption that the host and the target
> > > have the same architecture, however it runs into issues when compiling for
> > > a 64-bit target on a 32-bit host, as unsigned long is shorter than the
> > > pointer width. As a result, I've noticed that both start and stop max out
> > > at 2^32 - 1.
> >
> > So this has been broken for some time?
> 
> Since 2021, it seems like. However, this slipped from my radar since
> we've been using 5.10 for the longest time, which didn't have
> CONFIG_BUILDTIME_MCOUNT_SORT.
> 
> > >
> > > It seems that commit 4acda8ed fixes this issue inadvertently by directly
> > > extracting them from the ELF using the correct width. I'm wondering if it
> > > is possible to backport this as well as the other sorttable refactors to
> > > 6.12.0 since they fix this issue.
> >
> > You should ask Greg KH on this.
> 
> Sounds good, tagging Greg.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
