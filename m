Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69931DD89;
	Tue, 19 Aug 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640533; cv=none; b=OzPh+XjNCASq6FkmfQMaow3Zi9lrndwB+9194i1RLCnTCnVw18H/sFbM3aVpfK/c5BFJtyaab/85ReEl62FtWCcS/AiSFhwDlZVZESzl5tBm2Bkg0IogZlJb4obLw7J4H4WIODphS94MVjjz3NWy6xDLZdql0rMFiuuTdER4Ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640533; c=relaxed/simple;
	bh=3vhU/lMCE6qPR2EWUaInpiU26gw7Ul+uR3Zkii7rocM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JFjx/XRP3AYdw43KVYnYoN6TAdHPDpPaApyQUpUiDRWA0itJAd1fzsWbKsVX70aADcDtm4JI3kPAyq/ZmhzdfmCfKplfwdUZCE0xbEXvE4QuNHDDg78ynSwnVS7Eibe6uUKe4d+Zvg8VMI5+q1cqln5fCRH4MTbxi1mBwqEy2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N8x+9Y/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8x+9Y/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B02C4CEF1;
	Tue, 19 Aug 2025 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755640532;
	bh=3vhU/lMCE6qPR2EWUaInpiU26gw7Ul+uR3Zkii7rocM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8x+9Y/7FBWoZhOXJBckURArIzGN8dv0F2x9lMKlxqAuLh7RQOs6+rrwT0K2w8C7F
	 1xduqjaCf/IQHqRP2YjyiSKtK7UwuskcUM6PiwEY01gMzLPRQzJKGjoX/fjFZ5Su3W
	 SQPaDFbGrpK6MNkpB9lvWgfNKdwxVlAtqAjAJOoA=
Date: Tue, 19 Aug 2025 14:55:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
Message-Id: <20250819145530.243e02184b743eb9ec506856@linux-foundation.org>
In-Reply-To: <20250819134205.622806-1-npache@redhat.com>
References: <20250819134205.622806-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 07:41:52 -0600 Nico Pache <npache@redhat.com> wrote:

> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.
> 
> ...
>
> - I created a test script that I used to push khugepaged to its limits
>    while monitoring a number of stats and tracepoints. The code is
>    available here[1] (Run in legacy mode for these changes and set mthp
>    sizes to inherit)

Could this be turned into something in tools/testing/selftests/mm/?

> V10 Changes:

I'll add this to mm-new, thanks.  I'll suppress the usual emails.
