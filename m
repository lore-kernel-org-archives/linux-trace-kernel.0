Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DA40D594
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828239; cv=pass; b=umbgRpdtTxd1uiKcobq2bKD2v9FUnE4llpoHLamXw4jDAWKfSU4xozE8NGwZr5sIcY41XkFyPUX77fzyDHMSkTHekV88ENs+Svgu/yygx7XC8sAxV2v1Jg+eYhbNXD3JM/UZaix7iIuOpgR6RZz8lVPJeak4o66Vf36KTHPJ0Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828239; c=relaxed/simple;
	bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVdl58N2arWn/9ze/7a/ZYQpSr5cKaO1VRpUMWFogDVLXuuNVtQRU3iypC7oyyvQ09g0jPwLbATb0KbzmxXQRKj9uob/xO+cMRUWUrfkWfGsRkdIzIKUbn4y4XUtK9wjr/NqrASWL94+Ftw0uooSoUSvK4pP8zT3UtPOUz8FigY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRE2CbgP; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRE2CbgP"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1390f75d8bbso824793c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 17:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781828237; cv=none;
        d=google.com; s=arc-20240605;
        b=VfbaxbvPl7wkRc0vGgI69JzsOK3A5QjF91q4VcjTQlBwVEiEb6RIOQ+d83sCSWe7Ry
         IkAMllcdP738EVjboU23ZsHFscxzmSb5ON3TvTY/4Gm243OcdDqUr3UAb7xLqU0y83m3
         WYsSFVEj7IVf8FVtS1wp6/2JB4ZgHuC0gkp5jNH8M5KbaKvYUZQRLMUeUR5dt2Gczyfg
         bAPA9HEU40qJbCIw/tM5OHHJxey72qodtUnWnndMMeVJuWTNl5g9jY9C8vWneB2q0NRp
         mjYVz3cRqh2wfBwFjfy+xBsAaioDzbRYN/QyB0FOk6otzW14WTb8BzOqFzV3HILOO8LV
         zO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        fh=7ViCLQ87MXulRZqmQCacni6DOCKOm7JzCv0lBeNZLJk=;
        b=dGf9vKx59iUtylliyK6cjDIDVlFpa5ieqggUHEv0LhEycWpOEnQhlhIukDjsIDSqdy
         u/CPmHSLTd2bDdvvx/i4QhxA4PKEgutlar1JffOLB0D1oXB+m6qRckBVy8aCKHz+VxcN
         Dkojbi/bOp6yX0jCA5SjzDhblqz3Zi0sLycWmZFpQWeJGMnvMc+i2tS9Ua7RiveuN7xO
         Mm2wOdlDVaUIrbN4WaOCGwiDVyOuQ4ylgoVETfk3juzML11QuGKe3Ol1aKyTAJ0o7csJ
         /MdmAfEI5nB+tDUoygBHk2PdFTJYApmvpcBhVfUqZ4pFD6WCwRr/gGsekItnA1Yzk9zD
         447w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781828237; x=1782433037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        b=MRE2CbgPTjyTtMubJMZ1FvwCNjOpFh+CFijDgzCjYWhnqv+n10UHuq/SN8uVU8fE6f
         A1nJJ4wY8gLo7HsxG5HeUNCFj7Ql9zHaRhOmdNlhdPKY8daHhyhV9oG1qr3ZzQbR4Ulu
         FRW3KvstraHmQBlKA8/928uLs1sCcFJb+u71Cn6kVOj7lhko4ek1ATloaAiKLO92c036
         5+038bm9WlB1IXmWHzezl8of4zRrdOrEfYNqBQ7gzCbT8f5YSaRfOUxFnLdaNQtCoPE1
         M4QYkaWBl4zyyx/06P2wFsd9tfX3igl8+ZPS48GSzRjd3qyxdxojXXJ1wtNAgcgu/DkL
         JhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781828237; x=1782433037;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        b=UrlcMH4eN0KYv0raHcWDfMzCbzrt8csKlpAHKZexAzE0VXWXiTWxx92bygP3xxGiDD
         T3e2WK5pLc92laxPkYZ4NpQjOHE5OMmqY9DhhXe0RVt5o/hfJWggBpHJOJHXrOV4j86W
         k/Xv/A7EEIXdrgOWyA8pfEbob3Tps5oGEmGZNf5vxTDnNF3D1n+RWX1Petkja1w2TZ8v
         XCpHdzESOLNVsvwGSEuqYiV1Inx4eiTnO5RZ03WcTxzYFL4CVmLjnejioxMXl3SsQ5Ig
         2p+7RkvcgmTqp8sK343KMn9QXVRVC/7bZYollqGtew0Ldo5ZAg2PYDmYu0LNbb+RJYXB
         E89A==
X-Forwarded-Encrypted: i=1; AFNElJ8OloffwMJFWvsMPl9mFZoZWY+ZrM5PeqaGcan9ypMO+g9dd+LUt9u0gDQAxPvMZKb+1b3IPNxslqA22XdyFkhzuu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQBK/pUfwQQX+F13daupdcNS2wWZPXKj65Y9U7RS/3WcQOj3E
	VnKG+Ym8bxc4EL4VWhDpgaV0OuNxuUYAtMHmQZFCxUuGuH1bqBem9kuWy/CVlhi4WEqiqqU0hgL
	03+IZlFDGJYx3alVuP6jwbKRzS1BwEmUe9p4riew4
X-Gm-Gg: AfdE7cn5JzjzZvqoK+EDyOyYfpFDZi+MVKdLrplvBkismfI4k2Ya/1MKR22Sac3l6v/
	H72uyrrEJFRBat4LcRbKgMkvFp3VmLOUftcmtwDRO69o6TeJdEK+D2ERI58U52hsztmlv5PO4Qh
	wFvmHJQVaKDXkC6rQ/Pk9/XcytB/RTDNVosDmJ0bjRb4Ee6d9NK3WKjld3d1HVwAX6MJk8ax8/S
	LijGG07OUDSigHWjBrVPvaTVdRN5fdL/a/rW5IqNamTJi9TAmz7dXkwhTHfGvfyOXpSy55qes/L
	kudpgH0yKWg0mZ19tP5otXRkm/r7TqfzfrISu06BZtMthdZuAaitFJ7fY8g=
X-Received: by 2002:a05:7023:a53:b0:137:eac4:82b3 with SMTP id
 a92af1059eb24-139a5030901mr102913c88.17.1781828235521; Thu, 18 Jun 2026
 17:17:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 17:17:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 17:17:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <509f9a66-5ae9-4c05-bef1-ced89fd29bf0@kernel.org>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-10-2f0fae496530@google.com> <509f9a66-5ae9-4c05-bef1-ced89fd29bf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 17:17:14 -0700
X-Gm-Features: AVVi8CewB9OSB5ydvz-H83kPwJbWVO-CyG6kASZWbX7de4UUA5H3gpKgSOQyYIY
Message-ID: <CAEvNRgHM4a66Jx9++6iioQLpFY-KgPvjY5+bg_X97DfSjpXzRQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Vlastimil Babka (SUSE)" <vbabka@kernel.org> writes:

> On 5/23/26 02:17, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When converting memory to private in guest_memfd, it is necessary to ensure
>> that the pages are not currently being accessed by any other part of the
>> kernel or userspace to avoid any current user writing to guest private
>> memory.
>>
>> guest_memfd checks for unexpected refcounts to determine whether a page is
>> still in use. The only expected refcounts after unmapping the range
>> requested for conversion are those that are held by guest_memfd itself.
>
> Is it sufficient to only check, and not also freeze the refcount? (i.e.
> using folio_ref_freeze()), because without freezing, anything (e.g.
> compaction's pfn-based scanner) could do a speculative folio_try_get() and
> the checked refcount becomes stale.
>

I believe there's no issue here, since the main thing here is to check
for long-term pins on the folio. Perhaps David can help me verify. :)

> Might be ok if we know that no such speculative increment can result in
> actually touching the page contents, and the extra refcount and something
> inspecting the struct folio won't interfere with anything else. Then it
> could be just a comment mentioning why it's safe.
>

In this series guest_memfd doesn't change anything in folio metadata,
guest_memfd only updates the attributes tracked in the guest_memfd
inode, and updates the RMP table for SNP.

With the upcoming huge page support, guest_memfd needs to split/merge
the folio, which means updates to folio metadata. That will need a
closer look.

I haven't added the comment, mostly because it's a long weekend here and
I'd like to get Sashiko to run on it over the weekend. We should
definitely continue this discussion on v8!

> IIRC the compaction's scanning can result in a migration here so it's
> probably ok?
>

Migration isn't supported for guest_memfd yet, so I think that's ok.

>> Update the kvm_memory_attributes2 structure to include an error_offset
>> field. This allows KVM to report the exact offset where a conversion
>> failed to userspace. If the safety check fails, return -EAGAIN and copy
>> the error_offset back to userspace so that it can potentially retry the
>> operation or handle the failure gracefully.
>>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>
>> [...snip...]
>>
