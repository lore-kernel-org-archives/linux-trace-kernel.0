Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15740DFA7;
	Sun,  3 May 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777815148; cv=none; b=PzG4cLTHeI4eIrZ/X7URRBbjYIqWnDuN4qHnR0LSfMRDnoxIzL9n80w3IcdC+YJJ5DaHgHPbqzukAW44I0YT9NS5qiIwuUNdZOKMEy+lQ3V566+YdbFoh3x/dWOmM6LsXu47q5YzkV0d651lJncyuA8Xa5bOFk8Qb1pRtfDF/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777815148; c=relaxed/simple;
	bh=8E4wEVhoxVMJzvt9Yay3GcXb/sDexIP/V9W0XqAZf1o=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VPdvl7B4lWao0x8wTYYtd+prHzAO5jbyWlubmyq6LU5IILyJTBsqnaE3N6rjXxTK6vQ4G2nnHw+h5XsMOnRVC4QKfpzihIb/LL8Hxz5UWpXJjXpO6cWf+EaeNfIsfFKS1C8RnL5+XbCusU5VYd4Xi6bniIbNYVFr8H45RMlUxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VMLUKH1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VMLUKH1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E258C2BCB4;
	Sun,  3 May 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777815148;
	bh=8E4wEVhoxVMJzvt9Yay3GcXb/sDexIP/V9W0XqAZf1o=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=VMLUKH1ycv36KQvHnq5rSyu9FU98Uiqe3ehx+970ckoAypeAM+PXvJdKFdOk518cg
	 F+rM0924/bGMboA1NclQRj7A1a6x370rN92Jr4wfl4rd2ya2blnUDGH4PdXlm8dfEE
	 EAy46h3WOH7oQmXVHZYQhk9D06XPN1NVQizvnvmI=
Date: Sun, 3 May 2026 06:32:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com,
 cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@kernel.org, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
 hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com,
 jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
 lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH 7.2 v16 00/13] khugepaged: mTHP support
Message-Id: <20260503063213.b0a84d44de341575f8854f0b@linux-foundation.org>
In-Reply-To: <20260503062109.0469201428642a4f7fcfd915@linux-foundation.org>
References: <20260419185750.260784-1-npache@redhat.com>
	<20260424065828.031775921990de37f83a2468@linux-foundation.org>
	<CAA1CXcBJFoqDrkQbRE6JnpV-gjfNXe2sUxaCyXPC82h3qk9Jig@mail.gmail.com>
	<20260503062109.0469201428642a4f7fcfd915@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 May 2026 06:21:09 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 3 May 2026 06:23:31 -0600 Nico Pache <npache@redhat.com> wrote:
> 
> >  Can you please pull the changes from the
> > staging branch so I can resend it soon (probably after LSFMM, so no
> > rush)?
> 
> np, I've removed v16 from mm.git.

And that messed up Zi Yan's "Remove CONFIG_READ_ONLY_THP_FOR_FS and
enable file THP for writable files", so I've restored v16.

Please prepare v17 against mm-unstable.
