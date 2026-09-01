Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F73859D7;
	Tue,  1 Sep 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284986; cv=none; b=cC7vwK7EWDJZFD5MMda4neNRHzXpg9THKmGDYd5AEgFuX5wp9gMzJw2BBnwjqYZ5vhOCi9QZVQfTdyJZHUqXtQfA30HUDx19MhDA9209Ca640k5rgYqpaxx4SSfJ1be9JkxoJFVPjrSucbUIZEMt1CYyQ4rRAq1dXHi8c15jeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284986; c=relaxed/simple;
	bh=cnAoMGE9nklht8651wLeA0npk+YDqzAEltkj6uh38Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ldt88h21zxMYG7FesMAFJJzt8DmZ+6FDSLBdD9revXK50w8onkrMZR0BppCZGse7Y3WD87cyu8QrVtzQIW4iL2IoCW2ILlg14xN+PSgQI5Cqku6X+5psac+qp3QJ2XBpJtJS67lhNh7UAIhnrOUdLiNV/w5Hjof3rbonABn7acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=1mgqFkkr; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="1mgqFkkr"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E5B95804FF;
	Tue,  1 Sep 2026 17:49:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 18B6320027;
	Tue,  1 Sep 2026 17:49:28 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:50:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun
 Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song
 <kasong@tencent.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dave Young <ruirui.yang@linux.dev>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Message-ID: <20260901135027.028ea9e4@gandalf.local.home>
In-Reply-To: <21998471-74B7-4799-9E8C-D75003D1A4CB@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
	<20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
	<20260901115542.35cf337f@gandalf.local.home>
	<21998471-74B7-4799-9E8C-D75003D1A4CB@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 18B6320027
X-Stat-Signature: 7ef3suggza6rwrwt98ucxd5tb1in8g7f
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gFCgDW4g7ez/BxoPyHANfn1/41/yL2k8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ygP2WicIyxvIfgiulI4Z+w98tf+NFr5YAyeGttsc9pU=; b=1mgqFkkrL4Js3FsbhN/khvoOEvnHVh/aadmAMTCUde9xGE7BUvdArUa1RFWye4SH2Ctek4vS4gXiMbJcZCGFh5DVr4gJ1YyJQrfjy3W7IYtjDzLOP7asP560ZaX5A29U3FwYxXzeZu3rRui/fC5b+U4Jy3KfK07GTDhVffGq7Bg=
X-HE-Tag: 1788284968-292977
X-HE-Meta: U2FsdGVkX19FFDvFfWjTCdlnsQZ6K9ZDH4G8yyE+mLes3dBmHWO8NPu6yEW8XXzWgHsuxMDRFSptqXWfMG/Mc+vYMqM5I7IvoIiQAb8UocwUi/mhVmxt81zskgiVGnoXtfTLsJnPK2S+57J8V1WnQFXxP6OtVQ7C3JQiqyk6GHKdnEceDMmgU8UvEa1Vj0wlxj76LZY6CogJO8meStEy2MeviQuBcRNaEP1/lsb0/kCfQ/lF+Pw1bHZfL8fAaIqQ9wHGLY9MM3CVEabUY6AJmK8sY0fn0jiO4bl6CHHeOt5dG97E3JSrappl0A9/PWW3XYCVCivoJPwoLVwpncq/jSqtrYDYGvgG

On Tue, 01 Sep 2026 12:01:24 -0400
Zi Yan <ziy@nvidia.com> wrote:

> No problem.
> 
> BTW, the plan is to add PG_folio after this series is picked up by Andrew/David.
> So the new __DEF_PAGEFLAG_NAME() will have no user then and can be deleted.
> It should be fine, right?

Yeah, then we just remove that macro and change the one user of
__DEF_PAGEFLAG_NAME() to DEF_PAGEFLAG_NAME().

It will make that patch even easier ;-)

-- Steve
