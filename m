Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839203;
	b=0UNPUie76Rmz7FHS8D02JgFsIudfUIeflUryxX+n6w3hHsWf+bB2SSRb2MjYpF/WOlmd
	 GuGvkYxu/9zSZhO/MwLkXyjnRrHTNXzz4DMr9OYjnM6uonqwsFe8Nm1X4iSWtPobsBO4L
	 pbtkwdTARn5bowvstrj2/WGcM7l66GE8Ij3h0jZAoiaiNFavxHTX6fmwaR73yR+5m5U6m
	 3LtqpaRTwRwxNhgtcNAXCR/ljayzIeIMXH2kWSzZk9yyfKWwNgunJ4yZMhdvangTmukWk
	 yFiO7NKjfRjVFztF65CwqWkCnLg07RtbT/QIQ92YalhANu83ujpPOHD2wFRGHjCjEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839203;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=j/cDML+T26sdQopeF9JOcLeFrLc7HBAnzv/NOTzn5RY=;
	b=nEN/QBAEpS+jpHoq2hkk6F6KfVEIH4p+PdpyjaTyEIIxDm9Wdu/Z9hdq47rMy8v4LkWz
	 BaJ6mJMyTekleEg8CMTkOOqD1DKNChBx0V0fWh0Baq+3yEFVZKSq+kS6bMjQdbQGdTIj/
	 4rOdX9tAgtbr3gDTK7R12u6RwDRFoy5HKso3QA+2fl1KilyvItaq8RGw6WJ6E6aCap29y
	 YEBXMqXqA14Ba8AIvbUmR3jCVU6STAvaw15GqB9HICx7+CYjNDRKe4Dpx7jEFFEr3UO+l
	 MpfUpZLt4Ndb2yXu5aK33L+tF0ecj5biiuUUvqSupQSDPSjXQ3ZfWI3f9G/7mYCYDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQPqyhx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9802606A31C;
	Mon, 16 Nov 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQPqyhx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F71F000C7;
	Mon, 16 Nov 2026 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839203;
	bh=j/cDML+T26sdQopeF9JOcLeFrLc7HBAnzv/NOTzn5RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mQPqyhx7ZPLZTQfXvRc7983IUMX1IFW5Nh8Az9s/0fDxDHzrRyTckj6/jlUz9PNSx
	 Ajg2Ajy5EAkH34N0p7lF8V3Ze6POz4mAmfRq9R4NPFSooDUyExHjKqeJEMfq3Kn2Or
	 /6IiFXfNQtVWUPxSp0MCl1REJCIBvkA7ZEEG40hwncFFnxBjttPU8JFPWflyD7UFl9
	 hqnkavPOKEg5AI4lZsQFO18q/ReLgQMHhS6XQNwIy4qGPK3rGm8m+8okUcjH+ufxxs
	 D7HrfeEhkJ0bMylk7JCWy0VE+W1VibRzG6MCMqzyKie3cFrqV3QB1TVSc+wkQT8+cN
	 /pzC4U2mRrWKw==
Message-ID: <02e6240c-78ac-48a2-8bf8-36a2327e9de8@kernel.org>
Date: Mon, 16 Nov 2026 15:26:33 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/userfaultfd: prevent poison marker loss
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>
 <avij463DZ_tSwgKy@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avij463DZ_tSwgKy@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 19:40, Lorenzo Stoakes (ARM) wrote:
> On Sat, Nov 07, 2026 at 12:51:05AM +0100, David Hildenbrand (Arm) wrote:
>> Unregistering userfaultfd leaves poison markers in the page tables.
>> However, once unregistered, hugetlb PMD tables can be shared again.
>>
>> Further, shmem page-table retraction can discard poison markers even
>> while registered in missing mode, and fork() can skip copying page
>> tables containing poison markers.
>>
>> To fix it, add VM_MAYBE_UFFD_POISON and set it before installing poison
>> markers. Preserve it across unregistration, splits, merges and fork(),
>> just like we do with guard markers.
>>
>> Use the new atomic VMA flag to disable PMD sharing and page-table
>> retraction, and to force page-table copying during fork().
>>
>> Move VM_UFFD_WP to bit 44 and make HAVE_ARCH_USERFAULTFD_WP depend on
>> 64BIT, freeing bit 12 for the new flag on both 32-bit and 64-bit systems.
>> Expose the flag as "up" in smaps.
>>
>> Losing poison markers, while unpleasant, is not really fatal, and the
>> use case is rather a niche thing. In addition, we rely on the atomic
>> VMA flags infrastructure ... so let's not CC stable.
>>
>> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
>> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> 
> Are we looking to cc: stable or this something for newer kernels only?

Per above:

"Losing poison markers, while unpleasant, is not really fatal, and the
use case is rather a niche thing. In addition, we rely on the atomic
VMA flags infrastructure ... so let's not CC stable."

We cannot really backport to the pre MADV_GUARD fixes that handle the atomic flag correctly.

We could easily backport to stable kernels that have it.

Thoughts?


[...]

>>  #define VM_LOCKED	INIT_VM_FLAG(LOCKED)
>>  #define VM_IO		INIT_VM_FLAG(IO)
>>  #define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
>> @@ -502,13 +508,17 @@ enum {
>>  #endif
>>
>>  /*
>> - * vma_flags_t masks for the userfaultfd VMA flags. The two high-bit modes are
>> - * gated on the same configs as their VM_* flags above -- both of which imply
>> + * vma_flags_t masks for the userfaultfd VMA flags. The three high-bit modes are
>> + * gated on the same configs as their VM_* flags above -- all of which imply
>>   * 64BIT -- so an out-of-range bit is never fed to mk_vma_flags() on a build
>>   * whose bitmap cannot hold it.
>>   */
>>  #define VMA_UFFD_MISSING	mk_vma_flags(VMA_UFFD_MISSING_BIT)
>> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>>  #define VMA_UFFD_WP		mk_vma_flags(VMA_UFFD_WP_BIT)
>> +#else
>> +#define VMA_UFFD_WP		EMPTY_VMA_FLAGS
>> +#endif
> 
> Could you just move these up to the block above to match the convention here?
> 

Did you have the following change on top of my changes in mind?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6cd9d86f7adac..fa56d9e9f3ebd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -410,8 +410,10 @@ enum {
 #define VM_MAYBE_UFFD_POISON   INIT_VM_FLAG(MAYBE_UFFD_POISON)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 #define VM_UFFD_WP     INIT_VM_FLAG(UFFD_WP)
+#define VMA_UFFD_WP    mk_vma_flags(VMA_UFFD_WP_BIT)
 #else
 #define VM_UFFD_WP     VM_NONE
+#define VMA_UFFD_WP    EMPTY_VMA_FLAGS
 #endif
 #define VM_LOCKED      INIT_VM_FLAG(LOCKED)
 #define VM_IO          INIT_VM_FLAG(IO)
@@ -508,17 +510,12 @@ enum {
 #endif

 /*
- * vma_flags_t masks for the userfaultfd VMA flags. The three high-bit modes are
- * gated on the same configs as their VM_* flags above -- all of which imply
+ * vma_flags_t masks for the userfaultfd VMA flags. The two high-bit modes are
+ * gated on the same configs as their VM_* flags above -- both of which imply
  * 64BIT -- so an out-of-range bit is never fed to mk_vma_flags() on a build
  * whose bitmap cannot hold it.
  */
 #define VMA_UFFD_MISSING       mk_vma_flags(VMA_UFFD_MISSING_BIT)
-#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-#define VMA_UFFD_WP            mk_vma_flags(VMA_UFFD_WP_BIT)
-#else
-#define VMA_UFFD_WP            EMPTY_VMA_FLAGS
-#endif
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 #define VMA_UFFD_MINOR         mk_vma_flags(VMA_UFFD_MINOR_BIT)
 #else
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index b8b7cc2f00388..75c3e9270b62a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -201,7 +201,7 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)

 static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
-       return vma_test_any_mask(vma, VMA_UFFD_WP);
+       return vma_test_single_mask(vma, VMA_UFFD_WP);
 }

 static inline bool userfaultfd_minor(struct vm_area_struct *vma)

-- 
Cheers,

David
