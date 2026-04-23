Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D015200C2;
	Thu, 23 Apr 2026 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976229; cv=none; b=TkFnP8uVhIArL2p2n2cxcl4KXXJPazrLOsXckc/sqK0+cQuNpovpWrfd6mH4laGlwyOYKVRm1zybBqsbXSpTJZZdH8+/pKFN/UgIjX2YeHMUSU22M6VqXijraxFiMaJ0H8Bhu0r7piPmYeghnmOU9SJ1ef7B9J4bPsyP2BYlZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976229; c=relaxed/simple;
	bh=oCV9JFYj7k90WIS0590/2O8/cTgDcMiI0hAXUbdj4F4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DB23ZPIv5QzWL1oIU8ilZ9XYR0GQzZvgx25f00ZC6cLm8IjWgrKVW+e7ZsZYzgyiaFKt2nXqsFbaeaa0hgyY08HwdnhR+muWTWfMNJsYXZpq3O0K7vS0JIjgpCeUGhvo4gXKcHMlBMBiyK3mwUR3mUWggvQ6UI4/HWiiCSu3aFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OGpNXtGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OGpNXtGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647A1C2BCAF;
	Thu, 23 Apr 2026 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776976229;
	bh=oCV9JFYj7k90WIS0590/2O8/cTgDcMiI0hAXUbdj4F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OGpNXtGBm0ruwTxfn2i7ZXK2qzTVTfRRlgjZtDGJ1BJ+WMeCNqr5DeRM8NaZT4mHt
	 NPaiy4BrlDOIJzcF1E3mvczFs5rzBD3ZIk8+myZi0Tsxj0D7wrlksSBTSe+PYD26Ra
	 zeAKoN7VcqwQMJTj+YJNTFXrUsiZgTlBomWxL+bU=
Date: Thu, 23 Apr 2026 13:30:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH 7.2 v16 00/13] khugepaged: mTHP support
Message-Id: <20260423133026.cbd3bc5429d4ca4eccdccda0@linux-foundation.org>
In-Reply-To: <20260419185750.260784-1-npache@redhat.com>
References: <20260419185750.260784-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 12:57:37 -0600 Nico Pache <npache@redhat.com> wrote:

> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.

Thanks, I added this to mm.git's mm-new branch for testing while review
is being completed.  I added notes regarding Usana's comments, so they
don't get lost.
