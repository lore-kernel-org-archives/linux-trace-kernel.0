Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9647CC73;
	Thu,  4 Jun 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577651; cv=none; b=hJ6RTzngHNOqT1MR6vq3Eri7B6MQCJEdUynY1zn0nK0mIxD1mGVVuJSosWrES3JMEwZDXP2jl3HJ0ztJ+p4iJ5Iqf9nhmnIK7wW0bKgPxTv47z+COR/0RRsHl2f4+884v/8h05pIaNYNUPJe67LbHFaFztHckYCw6ydpIk76Lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577651; c=relaxed/simple;
	bh=ZEVLUn7SOlo085sZ/xPPzTu8PxQn1IRxA+cjAkAtQIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LptQGgQgx032oc+Gl+E2UfWdYcSEAeR50kyjHPLimqmMvEcHDIl1iGQ1/jzDN2H16am5f6+KoB3E+DcQdQUbdw8bh02MhAneIBefNS7GbXtjqs08rvLuPkPQqFVY0033YOAW/F+j9P7A1KBvFSe7JFuVyfrhs4QlmLc/bCVSJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4F12E1A0503;
	Thu,  4 Jun 2026 12:54:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 343C520028;
	Thu,  4 Jun 2026 12:54:07 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:54:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, unknownbbqrx <dev@unknownbbqr.xyz>, Wen
 Yang <wen.yang@linux.dev>
Subject: Re: [GIT PULL] rv fixes for v7.1
Message-ID: <20260604085405.234d22eb@fedora>
In-Reply-To: <791528a4f69460ba1e9589361860bafeb1517237.camel@redhat.com>
References: <20260603125056.75559-1-gmonaco@redhat.com>
	<20260603191627.5cb4ef6c@fedora>
	<CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
	<791528a4f69460ba1e9589361860bafeb1517237.camel@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 343C520028
X-Rspamd-Server: rspamout01
X-Stat-Signature: p8xq367qdjucj1jnuewyoc3ogucnrn85
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188BTBCx3WghgSGeG39pTIldz2lTDTP7c0=
X-HE-Tag: 1780577647-167781
X-HE-Meta: U2FsdGVkX1+LzD3TYg6p95lKJm6iJVbOEadFvIEQ66z5+JqpiQVQUE92P9EVmns5oCYHJf85I3DzTVlnlLxEACCBfAcfszWvKeiDlk2+93wJ6Ht80mXzdkGwJzqdVyK+Ai4gNcdHB11TKeWp6KRvJFmigR2QIuicEb674F0k9IT49q4eaq8h+gvaF+PGpPlo6naYAT1Em6PwTiUajFjjXe3hFaWgNM0PERPu6nfz+GeQTtKdZKBaAOFtuFybw1x7DxTlh0IN/FEVoqfnXu2Un+MoT87+s2HtNzP7bOyP38vKQa0Wf/GTL4P52le+yoE/jqyF73rYtrYnIV+0HVX/gCAI6kjKSCP+o8FP0smSj0iZ9spdH8+WKy37x/85Z0koxECOE+iIhBcuIEEOwQi6aWTNg89HEQoAPkvJLtTPbSQTqQtzW2osWw==

On Thu, 04 Jun 2026 14:42:02 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> All this to say that, in my opinion unknownbbqrx <dev@unknownbbqr.xyz>
> is NOT an anonymous contribution, just a nickname that differs from the
> legal name of this person (which we wouldn't validate anyway), so I
> would say it complies with the rules.

It's a username on github and not a nickname. I did a search for
"unknownbbqr" and it doesn't come up anywhere but Google tries to find
similar matches which brings me to an OnlyFans account :-p

It *DOES NOT* qualify because there's no accountability for this. For
people who have a nickname as their entire internet persona, sure, I'll
take patches from them as there's an entity that exists behind it. But
I'm not going to take some username on github as a persona. To me,
that's still anonymous.

-- Steve
