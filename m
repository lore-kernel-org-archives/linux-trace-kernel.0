Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE82E54D0;
	Thu, 21 Aug 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795304; cv=none; b=R4Q+gsfK2vgmSqjxyvaonqvNbNvYP4zwRSniq9xJMSDTtiPPvKzbFLuSTIiG2ZLV+geGILYgWnYGXDVd4Tg6qP9onThmZkdNEr0+eDj8QUgtH9dk08F0JVw14dx2weVYqfXUEdBdhnB6VeSJCIHMat5b9m0Q/BAEHW0haPSotmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795304; c=relaxed/simple;
	bh=IZzk16PUsXdv1hJTrUS2W5MkkFnk99+e5RRwlkaxhwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAg3+064UN9taGo7YNaPrEtzsWtc69Wfl8Wgf6r5UrVWnlOUlLO3BPLtWTTBgXTSV7vyg+iHYM5Ms9h/JPS382xkUSivU208SeG3ntCAn2xOiTfliVNKBXMTcr51OeO742mfo8/yJpq77pP9wDrppGvNw/h9dRBcWfD/g3TbhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 06922C0485;
	Thu, 21 Aug 2025 16:54:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 40E0120018;
	Thu, 21 Aug 2025 16:54:41 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:54:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 07/13] khugepaged: skip collapsing mTHP to smaller
 orders
Message-ID: <20250821125445.5fb61e90@gandalf.local.home>
In-Reply-To: <b6ebe641-0a0b-40b2-a34b-07393f883985@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
	<20250819134205.622806-8-npache@redhat.com>
	<b6ebe641-0a0b-40b2-a34b-07393f883985@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qibcagcc111tgj47qy51jo96stw8z185
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 40E0120018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/b6eVfnCtrADYpbZkvhr6irAR8DA0EUBs=
X-HE-Tag: 1755795281-660595
X-HE-Meta: U2FsdGVkX19Wf7TImvNRKkdHzzdV7rkvIZhG+KmuYqaxLydUul5FOaS3X4td4dGtT9hZEXmh4L+Dk8si1hh/hVBWR74FiuUmhfbXmOOdNsDbKjyxYi57fiY6knL4h00MpaMfUIRDYdx3ziQrdIsPCvPgRRHrclGadS48nN02wTZ6PBrjY2LCI4Cx6XQvgzeBaGI9oL4ltMiwZnPR2Yi0mXZPr7egX1qPLgUYcMX9zTYFyPwQ7S8+0OCclKm2BNIeOnyiIs/374my40vMRvHjeexxt6cc3ZwRILylZC8aFqZhZnXFnIGB5uFwg43P3fQzfHePcSZ5aET9TTEaSV2JJ2QzqHIoYI0P

On Thu, 21 Aug 2025 13:05:42 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > +		/*
> > +		 * TODO: In some cases of partially-mapped folios, we'd actually
> > +		 * want to collapse.
> > +		 */  
> 
> Not a fan of adding todo's in code, they have a habit of being left forever.

It's a way to make the developer more depressed by reminding them that they
will never be able to complete their TODO list :-p

Personally, I enjoy the torture of these comments in the code ;-)

-- Steve
