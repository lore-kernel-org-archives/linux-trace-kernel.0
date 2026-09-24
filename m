Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5A408031
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289092; cv=pass; b=nrtWcshoQ8Lt6ItcEGedfwtWwyP2QUsu98mpMUZ4bRPmknQgcxIijSxiaM2qlWB4UsuogsFZj50/cRTWsz7lUmbbcC8WTL00i3iV5t066EzFEUBkyoyOyDruVctBz+gW154YbRY4fp+vViIubKKG392Wf5mxYo6ydEfb0UYOsug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289092; c=relaxed/simple;
	bh=QyHE3recU+YgckuL/EubHuVec7rhNZz4z30xRjcK4e0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nru0Pvn2JrDORdovFwwgJbhFSHvVrP3WM2E9BXANon8YjeKucd0FdsBD7aVr9OyKW83KXVRtYaN9jSOwOcD59Sa60Zh95PVUuiZR77zbL/p6Qo73e1ql1yOEbzq7mSKOr4f9HdJu1r/EJP0T6LCzwSJ2Rue7pWnc2c60kyEgOUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDM93WMh; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDM93WMh"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067fso35871585a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790289090; cv=none;
        d=google.com; s=arc-20260327;
        b=PZYbLQB4Dy6BwxvOX6ygXgmjw2INLSZK5vf2+twkO09PwLveNeXoWm3vTm8EJyaeP4
         yJoq/Rpmb7Rwoe6Iyxiys3tLqKxcyOp2Ow89qHhped9I5ruX9P6FYjiPHzMRkQvEVjgc
         peuFimcZfSvepy2gFP+tNdkE+WEGBe4rw7PZG8cN2hvOypeNd+dEI/7k38s1FBXkqmc4
         lpV2lINVMOdHL7WxpKOchtKl6MmMhoKMBiRr+FJ2DoNlsdOTIrHMPiX2uEQArqW9Kshv
         +sIUldmvrnxBZegqBh4IfwkD+JhXSnUf8NrN1vR7HakdQxt1yDVM/R9YNossy+PZGG+E
         LCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        fh=/3ryjAaUD/7C7lRLQySvhZbajprNGUO/0F319tAg5Rs=;
        b=UXr8UCyAe6JVt9mqQA1BhapsjAF+e9anaEUv5311hywK426z9AscSFHG3e6/SWh+Y8
         oD2nFBH+x/oDnGULrpCFUmg9DhH6/gid+KJF0rZTEUnEhsa7xltDduHUV3Fhtr+9noIp
         MxHZzE3GvpJHX5f2XDOGukjm8+K8aZd68C89P8QpdlwsoqsEsaRRTiWYPxtoiixCNgI/
         lLDJms4FQplBl3QQ6qKBEReADlrkvh1RYsEoXqnbPrSg1lifmEHKbTX9dOmJrMfUectx
         3Cza+pw8ZZmuG6H1ye/F8O8KPL6hcDq6GU5k6bRa5eDI+2QhPcK5VIEY+vPuZUfg75NG
         3mlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790289090; x=1790893890; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        b=EDM93WMhJAUQLNL4eFoRDQhPSzVI9iIv9TLFUMvurLP5wlmAPQ8+lng+GCzJPPmwdJ
         s4hewAazfIHMCQN5b9wja7ZXL4mnK3b81FLtxLEPl20qDNPeQ9YvtGp7iw5gmHn81e0m
         ekrDVXV+BZ+IOxvKtFUibsRI6BhbVD0kbUJnyrYmWwTAQQVmYZiIQUhqLz90neJtvzmq
         yYbA+KyX2bqj7fq7L7PHKyfT0VaceMmnSkkvpzf7S24Hot1KUcRbRqCg+MktTdcIS/3l
         w1M/nKzuA2yEqzKfE66bnUnksOi9JdKXTz98W/OVKMEoABMVOIUaDgAfoqwOh08ZDk5f
         UYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289090; x=1790893890;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLxQ1V7eKFjM5hpU7Dk8oYI/it/LXUSsiWfbILSfCAs=;
        b=l7KwySyAjdaqfN/QlQN9tzKbX1n06f+FtoFwAhnX7GUwO5Xk5UxXzikJu5yFg0rIe2
         Rab2T9oc6Zb+/iNf7NrdamqyuKhQROfbH5NDCOWfXezI8cf5RrLeT6Esw/E2kwM5dU12
         cb2XFl1ebTmWoZoc2F8uBzSGAPr1aWX7E2OuV51DEjXXSzHucUBMjuhjSN0Io/vxQw2y
         Xr3idzlLAKCQkeLyecpp5D/nBUKzmxsY3XhSKQJ5wbZyeC3LVbqu15iaMUbkl73nV17I
         OSwIyWWiGr3nR3lYWz7doBIQzK3YUyhiiQBADvKtXugJD52aLR2Ny2SuuXisRy+tWrHQ
         CdcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0DNeEicoqSLOZOK6SWeGjZGnvOS303D1EcK9SAB6tkak2zFON3iO3Nwti2LwIX/jxXCLJFQRLcbpkVHRwq7ibjVY=@vger.kernel.org
X-Gm-Message-State: AFuF++nk6LjB2bpVJOnDXOGqUT8i6oaP1clezGliun8jKk1h4yWxcWk3
	t8m2mMZkL72ypfOxtyK/49MDyO9VRdsRn+ktYd53BAkjAUeaDYtuJiITXgVyENb3Nanr9iMdPGh
	TA3nuYoNw1yPlFnhHvqfkDCBqz9VkUYVeg0543aJN
X-Gm-Gg: AYBFou3GAIjwXnAEwLogu9UsmBLtWijyi9zlt3Uh/MND1h/ovpaiBQ4sCNe5Dlyafcs
	UGcDRNMzTWZBzw4eOXREvhkDNLDHJdVklH4SLO7O5FEQwhkKJmAWnU5kA629P/T4jg8ZJQ5hEWT
	UQaHVZGR8uZ7mrgc3Hz+2rk59UePCA+dISw5Brz07f3+kfn3Ri5+M344zjMcN1rvqan4TotzAZ9
	au8ylXWyXSz+gfujtjz/JDdY4ywYbzd0nsiySWViLn0mJTQd4Kqg0hGBPwYCBeWZWaldpdHxPGt
	iYpF99hqmf+bhtFWE6OGpLMaDoKnUPIgBJB+xVjM/FzrXJZ69+nd8Eeqv6j9c/fcH776N+r+Kww
	IZoH0OvC7LrLvL2lZecL7y5cizLjHi+nb+oTrstb6eg==
X-Received: by 2002:a05:620a:2b93:b0:936:eeab:307e with SMTP id
 af79cd13be357-93c43cc5676mr141474285a.9.1790289088659; Thu, 24 Sep 2026
 15:31:28 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 15:31:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 15:31:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <179028368162.2007072.12117327378679658047.b4-ty@b4>
References: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com> <179028368162.2007072.12117327378679658047.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 15:31:27 -0700
X-Gm-Features: AclHuK8DxWsVWtzA-dbMsis8Esd8BT_dOvi97JucFF4AgqprHJknTuuePlOITb0
Message-ID: <CAEvNRgFpMwduvHPGJ5fLoVPr_iGn=ELzY4AcMGHESC6CkMyeTw@mail.gmail.com>
Subject: Re: [PATCH v13 00/44] guest_memfd: In-place conversion support
To: Sean Christopherson <seanjc@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, 10 Sep 2026 16:55:26 -0700, Ackerley Tng wrote:
>> Here's v13. Thanks everyone for the comments and fast responses!
>> We're now at ~3 weeks to soft-close at 7.3-rc5.
>>
>> v13 is based on 7.3-rc2 and:
>>
>> + Hugh's patch to export lru_cache_drain_for_folio()
>> + Another series [1], which makes kvm_gmem_get_pfn() NOT return a
>>   refcounted page to KVM.
>>
>> [...]
>
> Applied to kvm-x86 coco.  A *huge* thanks to everyone who helped with this!
>

Thank you so much everyone!

>
> [...snip...]
>
