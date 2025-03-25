Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764902566C5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903999; cv=none; b=Qa3UsQWcbI4mkHIOrdpRkZirPEYw8WJudZ2Q2m+8lGgbPFlc6BiBeNOiEFaCizr35/K3v2HfZoGVv7fTh635gI9bpDmmueALsOUSpPcAfUcPEYD4ltMEWyo9eMMQZJnIKFPVdYF0xn5OS2JtCbCrXrt/qnR24SmAdzgniKn1Xtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903999; c=relaxed/simple;
	bh=YQYNQeHelivcbH3OB3eWiOkvPrQkK5J31opkMh9LCJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT3lX6JjyAcw5+9rMBMcuSmF0b3p2fITZuPbtHXBrqoqK05swftiULLGV1/jGtXt+DAEbTzlLYnGGvoFMRy3ONR+cEkkcDVIeqpRpSxAgSz0B5svO2c2mnOnbe98wn5d++32EnLRjcDZ/TB3JX/Bv/EcPg+2PX0cyHISiJlimCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XukpsovO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XukpsovO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F44C4CEE4;
	Tue, 25 Mar 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742903998;
	bh=YQYNQeHelivcbH3OB3eWiOkvPrQkK5J31opkMh9LCJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XukpsovOPATwgKqMnfgCO4wa7DC4fHs9XQaBMak/I/+EBu8h1+xxvNxOv0PjGk3/I
	 oNnFYCKND38LXyDtkWacw6IsRED+F7rqA3+SOQm7RJ0pEomO3n5lh+h1FDp5YnFDuV
	 d+hmJ6uXwKEDK7aRi9cATDCNn3YmvZaXFcYx8q04=
Date: Tue, 25 Mar 2025 07:58:36 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sahil Gupta <s.gupta@arista.com>, linux-trace-kernel@vger.kernel.org,
	Kevin Mitchell <kevmitch@arista.com>,
	Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <2025032548-happily-saxophone-4079@gregkh>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home>
 <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
 <2025032424-custard-volley-bbb6@gregkh>
 <20250324150703.69665622@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324150703.69665622@gandalf.local.home>

On Mon, Mar 24, 2025 at 03:07:03PM -0400, Steven Rostedt wrote:
> On Mon, 24 Mar 2025 11:52:33 -0700
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Hi Greg,
> 
> This isn't a patch submission. It's more of a question if something should
> be backported because it happens to fix a long standing issue.

Sorry, that wasn't obvious to me.

> It appears that the ftrace mcount sorttable code was broken if you built a
> 64 bit kernel on a 32 bit machine. I'm guessing it was broken since 5.17?
> A recent update to this code coincidentally fixes that issue. That update
> landed in 6.14. The question is, is it fine to backport the changes that
> fix this? It may not be totally trivial to do so, but I could likely just
> backport the changes that address this issue.

It's up to the maintainer of the subsytem as to what they wish to see
happen.  I will always defer to them as they are the ones that have to
deal with emails from users :)

thanks,

greg k-h
