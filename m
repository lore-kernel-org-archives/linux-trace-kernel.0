Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626C3254BD;
	Mon, 25 May 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736245; cv=none; b=UNdsXaZfsZ63Giblc16NZ/JH0T7iunzeOatud3ItTv8VaRfS4Tbs06x+noXq/ktXPYb3S16kru5L+Y2pG+I7T/UggeSa6qOi6S5zNUBlNUGh/rUDycioUzOUQJf4PpOIAnpVk4iF6Z2hgdMsnKc8RRi+DbdITZc1XJEmq1Dvb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736245; c=relaxed/simple;
	bh=3zvRuyEGtB5onyH9z+1KBefEZNzGcmzbH91/tGZPqF8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RDpzCYWZy765JPFY8x/nRVm58fXUiyKNe3akeih1R/E4doEDVcB+wCq445tSRrb9RwPLHZi1UlsiUPhPvdSlZJ9t5LCeoEavi+pF/PHG8qP20+Qdol3Y0yQ2On/TIS+4QgSLl8O0dI1M/9+i9lP2m4+C08zvJGpP+6DkH53nc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bJyrtF7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bJyrtF7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C011F000E9;
	Mon, 25 May 2026 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779736243;
	bh=AVOvhANuc/qDLfDQ+IdQxPRPdA0dhJZiZGIRxYHlRHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bJyrtF7/OFk+pS/31wbvaD/xB7Rv/k9KDyiU6nymD22iIq9ByUeQhJMkhcoxZxBvF
	 T8XbpglCc0oyk5HIVB0rFQEQi4FYz25Tjhg9LazpnjtwnljsZVdPxfdkkBEpY4phyg
	 +1pQAolnanUVT5H5FyT1s9kkMj6evH1jJP7gJpiQ=
Date: Mon, 25 May 2026 12:10:41 -0700
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
 liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-Id: <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
In-Reply-To: <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com>
References: <20260522150009.121603-1-npache@redhat.com>
	<20260522150009.121603-12-npache@redhat.com>
	<2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 08:15:53 -0600 Nico Pache <npache@redhat.com> wrote:

> Can you please append the following fixup that reverts one of the
> changes requested in V17. The issue with the change is described
> below.

OK.  fyi, what I received was badly mangled: wordwrapping, tabs messed
up, etc.

Here's my reconstruction:


Author: Nico Pache <npache@redhat.com>
Subject: fix potential use-after-free of vma in mthp_collapse()
Date:=A0Mon May 25 07:38:59 2026 -0600

Between V17 and v18, one reviewer (Wei) brought up that we are not doing
the uffd-armed check until deep in the collapse operation.  While not
functionally incorrect, it can lead to unnecessary work.

We optimized this by passing the vma variable to mthp_collapse() and using
the collapse_max_ptes_none() function to check the state of uffd-armed
preventing the wasted work later in the collapse.

mthp_collapse() is called after mmap_read_unlock(), so the vma pointer can
become stale.  Remove the vma parameter and pass NULL to
collapse_max_ptes_none() instead.

Link: https://lore.kernel.org/2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.c=
om
Signed-off-by: Nico Pache <npache@redhat.com>
...

 mm/khugepaged.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/mm/khugepaged.c~mm-khugepaged-introduce-mthp-collapse-support-fix
+++ a/mm/khugepaged.c
@@ -1502,9 +1502,9 @@ static unsigned int collapse_mthp_count_
  * If a collapse is permitted, we attempt to collapse the PTE range into a
  * mTHP.
  */
-static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long address, int referenced, int unmapped,
-		struct collapse_control *cc, unsigned long enabled_orders)
+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
+		int referenced, int unmapped, struct collapse_control *cc,
+		unsigned long enabled_orders)
 {
 	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
 	int collapsed =3D 0, stack_size =3D 0;
@@ -1524,7 +1524,7 @@ static int mthp_collapse(struct mm_struc
 		if (!test_bit(order, &enabled_orders))
 			goto next_order;
=20
-		max_ptes_none =3D collapse_max_ptes_none(cc, vma, order);
+		max_ptes_none =3D collapse_max_ptes_none(cc, NULL, order);
=20
 		nr_occupied_ptes =3D collapse_mthp_count_present(cc, offset,
 							       nr_ptes);
@@ -1749,7 +1749,7 @@ out_unmap:
 	if (result =3D=3D SCAN_SUCCEED) {
 		/* collapse_huge_page expects the lock to be dropped before calling */
 		mmap_read_unlock(mm);
-		nr_collapsed =3D mthp_collapse(mm, vma, start_addr, referenced,
+		nr_collapsed =3D mthp_collapse(mm, start_addr, referenced,
 					     unmapped, cc, enabled_orders);
 		/* mmap_lock was released above, set lock_dropped */
 		*lock_dropped =3D true;
_

