Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD53BBA1E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541871; cv=none; b=mxScTqsuUSKoTNwehYnCDoEQwP5RXyqAejjmM2YjCaYbEUpbC9xhllFdeuGxZlVd4F8L5AiU2x6kS2b4Zx69iyq53Tz5B01SZzDiEIkfZSm7LvbGN+/GmiqonTuskoRCGcgMbUbaotuOrw/UmwFbVIbUd/5IPOcKs5W+qPMkLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541871; c=relaxed/simple;
	bh=h7KESD+MUwYdSRnvoHo8LsXENEpEGhm0QVjHFrqZ9/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8gFqDfhZ/e7x/uptuorWSTeGigyLrjAReWpc4o3nD7UpF5DaKojdRHqvJUS29NeBCXewG8x2xjyaMXRC2MUB1QV2L0+or1KIGTWVbSEg0lJNgquevuOdILDjPkwKd1w1jgB4zUKNVf5K5grJEAnJn4HKAveO4uAOiEPAF05PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=OXPcQPs8; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="OXPcQPs8"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 196A540176;
	Fri,  4 Sep 2026 17:11:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4F76920028;
	Fri,  4 Sep 2026 17:11:06 +0000 (UTC)
Date: Fri, 4 Sep 2026 13:12:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] ring-buffer: Allow splice reads on static
 buffers
Message-ID: <20260904131149.7f3bdc14@gandalf.local.home>
In-Reply-To: <20260904170107.812081F00A3D@smtp.kernel.org>
References: <20260904164450.1345852-1-vdonnefort@google.com>
	<20260904164450.1345852-2-vdonnefort@google.com>
	<20260904170107.812081F00A3D@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1kj64dtw898eun3mpnr7deh1uxbnwhci
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4F76920028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Q2PEniydE/30cTomjBJ+KkSgvc3FBMZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5oWjO0AVVicfZbofKTWU25t3/Qyq1vNz9y5syBN9cJ8=; b=OXPcQPs8ysPXC0/Pel9gW9NyWVzk8KxERMdX5XmRAhamudN+TrYod6rsWPDOyRAg69VqlnMy7mqkqoBUhbUKfEdgqio3JQnn4EqmJOPZ00yQrHgKmBM9tp1zGE4cw9ImwDyT4rK9p8j+xuTetFYTnJYhwejwrGKxCQoBe2I87FU=
X-HE-Tag: 1788541866-532009
X-HE-Meta: U2FsdGVkX19XNqIrRVZCtgdFal86QMTqHYpstR7JRISHqAoStryUXQeRPmcMON+VpR7g8DUVbeCdsJsFwj1vmfMm9/4VS4zRL4s8OePyfICvI0fXVm9Ulu+h7RA/dnfQ/gXwsela74o4aM49DirbXFWNRRkmzthBNO/OxE8KmpUr3cJn184vFdDtJA15hCvbLe17utUTwT4LragGxwNExV4UxLOpntUTUkbEsJsLXA+xKGRoEhgpcpnNSjXNikJAyJFjCAm72wVhdZsNurzoHWvKmvn4K7Y4uw+Kq/2BZZPSMSZAGCNlRZT8gdiKEyaZzYWoyCZfE6OW6AjgagAzQbppd4R6vUwX

On Fri, 04 Sep 2026 17:01:07 +0000
sashiko-bot@kernel.org wrote:

> If a malicious remote writer (such as an untrusted guest VM) modifies the
> length fields in shared memory between the initial check and the memcpy(),
> can event_size become arbitrarily large?
> 
> Could this bypass the bounds check and cause an out-of-bounds read from
> rpage->data and a massive out-of-bounds write to dpage->data?

I don't think Sashiko knows that a remote writer isn't a guest. Well that's
not the normal case. But the trusted hypervisor that we control.

-- Steve
