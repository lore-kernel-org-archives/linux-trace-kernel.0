Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD21291C33;
	Thu, 23 Oct 2025 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262869; cv=none; b=UfVYLQ26yanzSkR0MyFubblqg0ovu+0SZuorCmW3QjakxTx7OPXCF4oYvojabAkotTi4zHOOk82JIZAdmuOuJq1bvWMlKzvQ24Mu4U9gpAkYe/TYyHzYc/2g9rqAUkkPdZMzhkYTwgDrbp4FPkI36XDDnV2+mLeORT7qngW4N30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262869; c=relaxed/simple;
	bh=bHtJ+x1Z8wZll9mybHd9TUEV+VSvk7XSn7Bmu6rbHyc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NQC7VyepBE1RGzd15dDV1s9qh/dNc09dD2hMKLURZRqZsfvKmjYFPUcMyGxE0izKeCyHl3tU1Wo+kbiDvokKMMeDXGNV2BBdRCukrhAyyaChDSjgBre+AAs1F2dCR/ycTLE5Pga9wYJ7pYi+5r91K9yYgqJXfALQT0JtRiRza3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=sEDgh8vq; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="sEDgh8vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761262860;
	bh=bHtJ+x1Z8wZll9mybHd9TUEV+VSvk7XSn7Bmu6rbHyc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sEDgh8vqGcl0yQfyyQSbz07amGDY2v5s/u1969YpR6kU6DoVLSDtkEc7SV7o6XTp/
	 R9ls0rYnuL8Dg2FllgRtdRk7hiwHtX63TWMRzlqyOJzA/UCsRU6/jVMjWd0OhDHlRW
	 jMwPoC0e9AbPjSqOWGutu3+6ytt2zLfMnUY7GQok=
Received: by gentwo.org (Postfix, from userid 1003)
	id BB5A1401DF; Thu, 23 Oct 2025 16:41:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B757E40190;
	Thu, 23 Oct 2025 16:41:00 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:41:00 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: David Hildenbrand <david@redhat.com>
cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
    lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
    dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
    mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
    baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
    wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
    vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
    yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
    raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
    tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
    jglisse@google.com, surenb@google.com, zokeefe@google.com, 
    hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
    rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com, 
    lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com, 
    pfalcato@suse.de, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v12 mm-new 15/15] Documentation: mm: update the admin
 guide for mTHP collapse
In-Reply-To: <ed0887eb-6124-44ab-9d1f-1e87e9640e14@redhat.com>
Message-ID: <507a683f-f121-c2d2-5dd6-7bb2db79152c@gentwo.org>
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-16-npache@redhat.com> <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org> <ed0887eb-6124-44ab-9d1f-1e87e9640e14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Oct 2025, David Hildenbrand wrote:

> The big question is still how user space can communicate the desired order,
> and how we can not break existing users.
>
> So I guess there will definitely be some support to trigger collapse to mTHP
> in the future, the big question is through which interface. So it will happen
> after this series.

Well we have a possibility of a memory policy for each VMA and we can set
memory policies for arbitrary memory ranges as well as per process through
the existing APIs from user space.

Extending the memory policies by a parameter to allow setting a preferred
order would allow us to use this mechanisms.

Memory policies can already be used to control numa balancing and
migration. The ability to specify page sizes is similar I think.

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 8fbbe613611a..429117bbd2f4 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -31,6 +31,7 @@ enum {
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
 #define MPOL_F_NUMA_BALANCING	(1 << 13) /* Optimize with NUMA balancing if possible */
+#define MPOL_F_PAGE_ORDER	(1 << 12)

 /*
  * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
@@ -56,6 +57,9 @@ enum {
 			 MPOL_MF_MOVE     | 	\
 			 MPOL_MF_MOVE_ALL)

+#define MPOL_MF_PAGE_ORDER (1<<5)	/* Set preferred page order */
+
+
 /*
  * Internal flags that share the struct mempolicy flags word with
  * "mode flags".  These flags are allocated from bit 0 up, as they
