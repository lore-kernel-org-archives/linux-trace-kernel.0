Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB038F654;
	Sun, 10 May 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420646; cv=none; b=WzAa1rwAeBimWeJftEizSZ7XordVrtkYZfwoQTKa9uQpXzENcwF32m7nmVvqoANnI07b7NUiM0EjmBqi7Y3+JZVT9KXZnjVKqXkyFwew/W+ZMuE1hkhov4GBKT+U3aDqlk/y/4Zur+4X3e5lvn5gxPkc39NE7sP2S51XXh2MNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420646; c=relaxed/simple;
	bh=63nl2SFh9sKVLKwnXXfbkQrugbw3c6qi+SZ9W3m1Dag=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FlFh5ph0U19knCUqRFGTkAEM44a/ypj8qsd+BewHC0o+MWU9M24UyQvFFNd0sJj3HXWU0+8WvLcV9w63jLT1w+DhA4VIm5NUT6MB/tE6mca/rG0w5V1PAu77Ys6sLnowi7Tg3RzPfBkPoOukk15/RZMvNgQNzzkl9ZI4BWGg1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DbqDM/Y2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DbqDM/Y2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Sender:Reply-To:Content-ID:Content-Description;
	bh=qOD7QxDKk3RTKnTDgKCKX5Mj4tjif9QPuV1x23Y+qME=; b=DbqDM/Y2NO6hs4kz0Y3MeDoyBa
	RSWqPDNFSCwDZPKmBnCM0Sk0LtTSOYvtX1pGE7pAqKTzP/+bhJ1ZbzOORXjS5TN1tEZQIISZ/G/uv
	VTpiTcl4OvDMUgSnKV892USVGtpTpoLUuURW82/UyphNjFe7lMvTDRDZnj7h9WgD7knqnFC+Zyz4+
	rF4k/UaGF9Uc2rQ4oYFGcBNsUpOZkl9egs5sj/UMoiy2SiMJ2afO1t2v+mc9V4mj4bO6I47trVbES
	R9hzfaaYRipyM9f09YTVGrLCMy/2oVBxbjmupoL49saso54NbueZks0urkiVkkSBw3xZAGJZcVCcH
	1uryzAGA==;
Received: from [38.23.173.23] (helo=ehlo.thunderbird.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wM4RG-0000000AryI-1hB3;
	Sun, 10 May 2026 13:43:22 +0000
Date: Sun, 10 May 2026 09:43:49 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>
CC: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com,
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org,
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_v5_10/53=5D_KVM=3A_guest=5Fmemfd=3A_Ad?=
 =?US-ASCII?Q?d_basic_support_for_KVM=5FSET=5FMEMORY=5FATTRIBUTES2?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEvNRgF9+Gr7UVEq-E2SQEb_XOQQMOXy9F_A2tA=DbNV_fJ0EQ@mail.gmail.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <20260428-gmem-inplace-conversion-v5-10-d8608ccfca22@google.com> <n5ce32wumzeiqqyqutom4apy2kqfetbvusc6j4k2xarsska5mw@klp5bmy7qhfm> <CAEvNRgF9+Gr7UVEq-E2SQEb_XOQQMOXy9F_A2tA=DbNV_fJ0EQ@mail.gmail.com>
Message-ID: <1DAB05E2-7F30-45D7-B155-B66C59D31AFF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7 May 2026 12:56:11 GMT-04:00, Ackerley Tng <ackerleytng@google=2Ecom> w=
rote:
>"Liam R=2E Howlett" <liam@infradead=2Eorg> writes:
>
>> On 26/04/28 04:25PM, Ackerley Tng via B4 Relay wrote:
>>>
>>> [=2E=2E=2Esnip=2E=2E=2E]
>>>
>>> +/*
>>> + * Preallocate memory for attributes to be stored on a maple tree, po=
inted to
>>> + * by mas=2E  Adjacent ranges with attributes identical to the new at=
tributes
>>> + * will be merged=2E  Also sets mas's bounds up for storing attribute=
s=2E
>>> + *
>>> + * This maintains the invariant that ranges with the same attributes =
will
>>> + * always be merged=2E
>>> + */
>>> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attribu=
tes,
>>> +				    pgoff_t start, size_t nr_pages)
>>> +{
>>> +	pgoff_t end =3D start + nr_pages;
>>> +	pgoff_t last =3D end - 1;
>>> +	void *entry;
>>> +
>>> +	/* Try extending range=2E entry is NULL on overflow/wrap-around=2E *=
/
>>> +	mas_set_range(mas, end, end);
>>> +	entry =3D mas_find(mas, end);
>
>Thank you for your reviews!
>
>>
>> Please read the documentation as I believe you have a bug here=2E  What
>> happens if there is another range stored higher than end + 1?
>>
>
>The invariant in this maple tree is that contiguous ranges with the same
>attribute are stored as a single range=2E
>
>The goal of this first part is to get the entry at the index just after
>the requested range, and see what the attribute there is=2E If that
>attribute is what we're about to set, extend the requested range for
>storing to the end of that range=2E
>
>If there is another range higher than end + 1, with the invariant
>maintained, that attribute has to be different than the attribute stored
>at end=2E Hence, we only want to extend this requested range up till end=
=2E
>

mas_find() will look for an entry at the given address for the first searc=
h, and if it is not found it will continue to search upwards=2E  Since you =
limit the search to end, it will work as you want and there isn't a bug as =
I was thinking in my sleep deprived state=2E

Since you are searching for exactly one address (end), it might serve you =
better to walk there=2E  Maybe walking is a better API for what you are doi=
ng here?


>> Do you have testing of these functions somewhere?
>>
>
>GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4) tests setting
>attributes in ranges=2E If test_page is 2,
>
>1=2E [0, 4) starts off shared (4 is the number of pages in the guest_memf=
d)
>2=2E [2, 3) is converted to private
>    =3D> so the ranges should now be [0, 2), [2, 3), [3, 4)
>3=2E [2, 3) is converted back to shared
>    =3D> so the ranges should now be [0, 4)
>
>I verified this by inserting some trace_printk()s and inspecting manually=
=2E
>

Thanks=2E  I find the exclusive ranges a bit odd to think about in the map=
le tree context, but this test case makes sense=2E  This is especially odd =
to look at a single index entry, at least for me=2E

I generally have a set of test cases and append any bug reproduces to that=
 list so they are unlikely to reoccur=2E  My testing is certainly different=
 from what you'll be doing, but this method has done well with the quality =
of code improving over time, and limited (if any) regressions=2E

I actually insist that any fix has a test before I accept them=2E  There a=
re two reasons for this: 1=2E Avoiding the regression=2E 2=2E People really=
 understand the bug if they can create a reproducer=2E

I hope this helps=2E


>>> +	if (entry && xa_to_value(entry) =3D=3D attributes)
>>> +		last =3D mas->last;
>>> +
>>> +	if (start > 0) {
>>> +		mas_set_range(mas, start - 1, start - 1);
>>> +		entry =3D mas_find(mas, start - 1);
>>> +		if (entry && xa_to_value(entry) =3D=3D attributes)
>>> +			start =3D mas->index;
>>> +	}
>>> +
>>> +	mas_set_range(mas, start, last);
>>> +	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>>> +}
>>> +
>>>
>>> [=2E=2E=2Esnip=2E=2E=2E]
>>>

