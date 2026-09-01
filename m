Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8F47CC92;
	Tue,  1 Sep 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278101; cv=none; b=USgAuUO1eWAt2wG0nt/2d7LqOLyv+rDiHGdLJ47bCKnq3+HKfe1XhaXELlXJdXZ7kOKtVMwkZPv0pm8FtwLrK+4c8eUXRdUEYia3zAK2ASqomDYyjupZXMSnbV8s6o1OBKebTBCYsfp35MI2daQxu5Im2Os0pk7uLbtHsPCfqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278101; c=relaxed/simple;
	bh=a64S5AsJmm6QqlLQ5d0m9Imwh1EiEcnDjAQTmOZN2+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTurQaOtWNcluqhWx++/BfsgWjmm3nOG4/RnnMvuwJeUXyYFJ4xCFhZUfylgfma2u3p+ULfaSmU1Ar/h4d2NHlTGexqWGu7fbu6ayobbgUW/MmB4bSOezvcp28yhZdkD5XY2Afm5EYmOFJZVVDbGxL/vu0RO+etHtQqRLeLghNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=tGc4Z9sC; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="tGc4Z9sC"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C29301A0469;
	Tue,  1 Sep 2026 15:54:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8E80930;
	Tue,  1 Sep 2026 15:54:43 +0000 (UTC)
Date: Tue, 1 Sep 2026 11:55:42 -0400
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
Message-ID: <20260901115542.35cf337f@gandalf.local.home>
In-Reply-To: <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
	<20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b6ytfgjtokst1jc1aabs95dwf5ejwe1f
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8E80930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zWbvIDz+3Hi5z7GDK/fNqzAPKpw/khW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PMQPDVPJ0tCxO93gmrhVyeG5Oa0anovLBVYtrsBizkA=; b=tGc4Z9sCnIntcGcWtJ1kOvYe5256jqS1DsWodW2sqCKQLdl8Y8nHkKMI+/bZHJCQztdMhcSkJj8YVjXCQshVK+Dgc2EYzxp1kQ+nPt/MKxXAHxYAr/fN2B+/kb850ZrxY0100q3DUUBwY4s7EFwq4xvvaRIiE/XmnNIq0jxhRxw=
X-HE-Tag: 1788278083-807407
X-HE-Meta: U2FsdGVkX1+zDlnR6QN6MUglWJjwZx5iCWUM+krVLXlc2zuUtd2IG2DLx1JPwqlTPq6HywJagZIVfhFWq44D2aDRr8CqPASzgDg55B72H7mSnF5ikilDHz6BwtU39295NFtcyv6lgavetSPz7y1L0g1K1zuV3ydBJ2a0X+t/9iTl4lf+jI9pSLCyfw2TQI05jjgMqbeUDhSMlamHBWoJCJ9h/PNz2A75JPoGpqGqH4tC/s8xhJUmsTXFGe6/YTY1Ki/+liODnEmp1JpspQt4nrByo2d4u2HwgRpO1hcQFU+FSiTYj5enzhApbGNiHUuTn+pvjGsLrpU3m7+D/3dcDhPAQVDdzRzZ

On Mon, 31 Aug 2026 15:25:37 -0400
Zi Yan <ziy@nvidia.com> wrote:

> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 935893e5ea53b..caf090cd6f85e 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -144,7 +144,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>  	DEF_PAGEFLAG_NAME(owner_2),					\
>  	DEF_PAGEFLAG_NAME(arch_1),					\
>  	DEF_PAGEFLAG_NAME(reserved),					\
> -	DEF_PAGEFLAG_NAME(private),					\
> +	{ 1UL << __PG_folio, "folio" },					\
>  	DEF_PAGEFLAG_NAME(private_2),					\
>  	DEF_PAGEFLAG_NAME(writeback),					\
>  	DEF_PAGEFLAG_NAME(head),					\

Hmm, just for consistency sake, can we create a:

 #define __DEF_PAGEFLAG_NAME(_name) { 1UL <<  __PG_##_name, __stringify(_name) }

Which is similar to:

 #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }

But adds the "__" to the name. Then the above would look like:

	DEF_PAGEFLAG_NAME(reserved),					\
	__DEF_PAGEFLAG_NAME(folio),					\
	DEF_PAGEFLAG_NAME(private_2),					\
	DEF_PAGEFLAG_NAME(writeback),					\

Where the __DEF_PAGEFLAG_NAME() with the "__" still stands out, but the
code looks better than open coding it in the middle and making one wonder
why it was open coded. (It took me a bit to noticed the "__" difference.)

-- Steve
