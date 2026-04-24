Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AA3D5238;
	Fri, 24 Apr 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039111; cv=none; b=XSGi5P8t7Kpf3hG4gfsn4CIRrizPcVPwEG96rp3SLRIbRSeSEhbEZlif8+irz1FBcPK8k61HBoqEX9sknaFoeYx8tTYVGCi/hDhqXNQ/UVBWy4Ebi4i9ro+oA+6GDXiOuFBG5Ly9xMSNaoXsM5Kt5IOnK/LgsFICwlFLL3ufja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039111; c=relaxed/simple;
	bh=7bYInwWM/h/4FMogzkF1bwJ652LCJHGiLjOkNtEaby0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GDrrnkxXilwQ4WJbrC/ty0GSHcnU8IKyPTtCxXlGymGsiv2Ha3ZigKqj/pI8wYbtUbStIagVAu71ItsiEfrDQivPM8Fkf5akT39u4ZGKXrcit8KAYLgzZ1nZ5SlFcNuiTApKUoz+9G5Dk5JyKv+K/YCXIuT+bdkG1RgRXtoOXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xvi5Gf8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xvi5Gf8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889FC19425;
	Fri, 24 Apr 2026 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777039110;
	bh=7bYInwWM/h/4FMogzkF1bwJ652LCJHGiLjOkNtEaby0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xvi5Gf8hVFpC//5R97FD88BNYz+MVhLRmFvxc2exXUXhHSYrE47STNlM4pTLte5C2
	 4Y2JwJd0HTqYkBYWh7rT3liPSPKqyF9JVXR1PIXqxRe65zpj4AU+LVVVYIJolPxKQY
	 HpFryOs/E9bEWySudkVDCIHCe+HL4B9dEhazWpiI=
Date: Fri, 24 Apr 2026 06:58:28 -0700
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
Message-Id: <20260424065828.031775921990de37f83a2468@linux-foundation.org>
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

Lots of stuff here:
	https://sashiko.dev/#/patchset/20260419185750.260784-1-npache@redhat.com

It's going to take some time.  Hopefully worthwhile.

As always, it's useful to hear about the usefulness of the AI review.
