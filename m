Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390D1FC8;
	Sat, 30 May 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099354; cv=none; b=DFtDJkXoQhjCxM7+EaGgsctBNrJX4xs80syxXAN4HgZPmyIOhquTAFYT7INh/P9ZOYzOGj6JX59oowfXgd55wF9QMH2jfjI0a2jfzOwGOG26okWFGQp+5iX0DkgU91F2wDoOA74gzSNng6VG8XtDqQjPcVRJGMpab03HXmZZMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099354; c=relaxed/simple;
	bh=mc+5oOrwN+ZfkkFwpOE1UT2kmuS19vCrnLwlFEcRoK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pkh17nhIqmkhtxhi8+kVUCsSmRmOjqJi5GPxFleqdoewGhcm+yFib7Kap+0pEnPvYg7GXRaWoRVkiI/+ibnI961OCehuDx9RavLBN+zV0QzWZBw+HY/AGwKY3uQA+WMoQSQXsjASVOF4J5g7uffWnJCThnKNaRxwhNU3vZptZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0A686A02B8;
	Sat, 30 May 2026 00:02:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 2DEC420025;
	Sat, 30 May 2026 00:02:30 +0000 (UTC)
Date: Fri, 29 May 2026 20:02:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood
 <crwood@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for 7.2
Message-ID: <20260529200229.2c63539a@fedora>
In-Reply-To: <CAP4=nvSi2q=h308Osmrph4YgOkMJE_QmsfSAQcyvi8sxKY2kug@mail.gmail.com>
References: <20260529130643.3080315-1-tglozar@redhat.com>
	<20260529095646.73c95f60@fedora>
	<CAP4=nvSi2q=h308Osmrph4YgOkMJE_QmsfSAQcyvi8sxKY2kug@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b36uqmsj4i86nxc4pj8czm8k6uoej3d8
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2DEC420025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/Ur87SOy/dJeHi6/a9oPNGmvHbB9xpJg=
X-HE-Tag: 1780099350-133848
X-HE-Meta: U2FsdGVkX18dbnis6uZ3Xstd5L1XbhOEwHM5sdMMoodXK/XLwB++3EwnuZpP7hILYLWSxdUA81eirG7xCjdm9Qf7KAKp5qtCeWxerB47LruBOTdMMmp1KcAUGCudyVxzmzjsbTBudC1W+Ugy7zjlXWx28YAo7DhPbdTM4JS/mEWl16CVwF7DMkbAXe4QnZ6tOCFdP4VIlPtwsWCoqho1jhc8ud/kdBwKuSzUQfz13hPgfBIwgDX3BjXLr8H+yENEjxSRCDPXqYrQ83bpvIJER7+/k+4LvJmSsI5rDqoAkL3nrahctxBIe5bpn6X9CnUzFKGgMZt4HOLkqQukh5HjWr2Qz+J7wWzomY7LRMr6nj8Kg8ppLff/zA==

On Fri, 29 May 2026 22:50:31 +0200
Tomas Glozar <tglozar@redhat.com> wrote:
> 
> The only build where it does not work would be in the middle of the
> pull request, with the --dump-tasks fix but without the libsubcmd
> migration patchset.

Great, then we don't need to worry about it.

-- Steve
