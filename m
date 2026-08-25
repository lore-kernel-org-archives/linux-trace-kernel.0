Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D73B71A6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684161; cv=none; b=i1lOTS0rNQB0JGi+ya1f9ri9Kctgb6VWIBxTIKqIleE2P773ZCS8mxZwsFnWDuuAxQYtdT1IBM/mwNTGVOxEyXUyojL/1JuxbrJQHF+5Na42aokejKN3KMibUZrmWKzBAW0ffq22ARHPDRaoh/oDUVIi4LnzNDtbcgKFXLTvDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684161; c=relaxed/simple;
	bh=v81i0R08OhPbKwodLqy3PT8ECRERns8YsJia2mMgPmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hdn/VrHW2PZZtogat1ag0pk5IbryrMhV4PK/Sovob9GwT5+SaRf3V1Qd1NSmpETVYdydLr75JLL/U212ohP9gPsm6wGsN41QnFJSYQ8ngv8WOEwqWPSjS+e50cX2cQzrS5dYe+IfUrBWkU6MQgdQR7ugmeGC+IRbgTKOcIUY0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGgIdWUb; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGgIdWUb"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dff6253so12280145ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684155; x=1788288955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xccKXo6SW1SbkIzehhqjd8J3GgWcAs1E82/+Xs14ta0=;
        b=sGgIdWUb73c/AqT0Od7PZttUhmzl/K1z+Trk9csyZZTKUuB9AJnfgvEciFEwGi2GSz
         r40w0dHoz+sUI0NWkw1RQXLydLHvEi7GAXsiSumQgC5I0EoON9A8hxXKHMuejhs/0Abq
         RVGBMjwVtxoy+hrGodz7hw+PoWJSzgw0HTjuZfU8jz1igt09Fegq5v72EnhUTCytzoiB
         xiuwfnRG+RNbYiqfTr6temxrgoUkWNxzshhGu4S2eqU0qg7v0V6FjenYa8nlyBbdcuw3
         DDlrTqsQefJ+ZzvwXKAFV1vwcQ2NdPqnl/BXZmxYJ0sj9t8c2ygKLxORrssa4VVA8e18
         3xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684155; x=1788288955;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xccKXo6SW1SbkIzehhqjd8J3GgWcAs1E82/+Xs14ta0=;
        b=R37/lJc7W9998xZVBeT1B2ZaHQ5sG1+zyW+wbTSaFOeyP3EhlGYQqo+Jo5X/vhZ/OD
         cxczATEOfMtQhSxQsB1Zcp95UxUdR3pZbwil7FU03b4IM+Mj6J8/AHPFgW2nUqDKTAGQ
         L4VejfmgEJDOVl+Lfx+KghzINQIZ7TVa/zjYNPxO/0q1IlOBzZFz3vkNPaIF+7WUvZu4
         qzYXWnTrgKi92u9D80Gij2iOQXvtLMOlw2f708wRfedmOIWQ2XGxJz/jBMefCB2ygXR1
         HFjlXiS4Eo+gCROvfxqdqnRoqyN/6AwSoGwzVb5zs2KbJlLUA56HCKrUqejkMLT3n2KC
         V9Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqYDIIsDJh//z6wDljqCExa8+dKQoZdx2rqWrrvTiWHL4KtoseZeLqEiT82/6LfODFSanzf3Kf9d+xrSRZZN1SO1nk=@vger.kernel.org
X-Gm-Message-State: AFuF++n04fiwGv/HmuWEz2u0rg3A6za/DupdDuD+92gPX0wlpLPydfpk
	xrULA2miW7hepBlWhuj3SEzE+q57sJmckFxFmmdc2IIilktw4S0AUx+VMHwRpXPkHXsG4lvjR9z
	jE7s62w==
X-Received: from pgbdm4.prod.google.com ([2002:a05:6a02:d84:b0:c79:39f0:12f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1398:b0:3bf:8de9:c64e
 with SMTP id adf61e73a8af0-3ceed381cdcmr1617377637.2.1787684154733; Tue, 25
 Aug 2026 11:55:54 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:55:54 -0700
In-Reply-To: <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org> <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com> <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
 <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
Message-ID: <ao3lOu8-wpGTs2wd@google.com>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 25, 2026, Michael Roth wrote:
> On Wed, Aug 26, 2026 at 12:13:47AM +0800, Xiaoyao Li wrote:
> > On 8/20/2026 9:32 AM, Sean Christopherson wrote:
> > > And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
> > > using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
> > > PRIVATE mappings (of a different gmem instance).
> > 
> > I'm wondering now how this could happen.
> > 
> > the requirement for PUNCH_HOLE on gmem to trigger mapping invalidation is
> > the gmem is bound with the memslot. But how can a memslot bound with two
> > gmem instances?
> 
> I think this is for when userspace uses an mmap'able guest_memfd instance
> to handle shared memory, and a 'normal' guest_memfd instance for private
> memory. Each instance is bound to the same memslot/GPA range, and
> KVM_SET_MEMORY_ATTRIBUTES handles switching between the 2.

Yep, exactly.
