Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919883BB9F8;
	Fri, 22 May 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462847; cv=none; b=cuHzOAbwdXmMjjCaUkVmui/fLzZFf1Io2/Nhw09/4LXmGDDPlIiAttFL8ToM4n8jUMIaG/npttM6t4Mm27U4Ddh+hpp0cXJnC2ERU/Nzu6+YOs46JsnvbthMxzIykJV4mPCrJlPU/UKV+OtObTmoEsBG8yiMAgIAuFUhSWBJ8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462847; c=relaxed/simple;
	bh=8z/dHuRrsH69kfHsDgaXM/ZHuHT8ZYmKE+HRTueiZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVyOJkd8Fzb68LSThu63NK9LidNIBSCisl+KMjqSOdsTpCQ1wpe2Z2zlHAfwYMe68/rodhJWL8R7V1EapAY3jAjASdUxaxva/23B7v6OXYW1CkUFgVlBGsDuWMb9H28/9M1KrR9iYtQRJGQY+zFOlAq/g9DK/io50han+bNjdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmykpIUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmykpIUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F051F000E9;
	Fri, 22 May 2026 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462841;
	bh=8z/dHuRrsH69kfHsDgaXM/ZHuHT8ZYmKE+HRTueiZpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmykpIUUzqwJctPR3LtOOLGqhWqh7KcRrFtknn4Fs0FQm5So1T6OoiCg5VTwWgz9A
	 FEbM9JtFhCvlIlyj1zOUbAWvqYy4LGLYbkvmEJLlVlMIiZZpPWwHxs3VPtXNbRc68L
	 lSGh1rUkAzDG59yeupZRA7y5GRZ7DNPetY7lboa5nJIOh+L2CTb3aErKpXXPZkEHA1
	 rdxpzis1wjevMqasNM6/JUwrkNu5FvQ7QEsfSQhqB10R3eGMM/MgPfZahA1HtVM6+q
	 DpUR7LnojKa4cZ/I+DB94QJtMLAPi27zBFhA/E+w9LTkyuwI8PGa5Lqnd4TKDY+WL4
	 iLL6WRQDEegUg==
Date: Fri, 22 May 2026 16:13:45 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-ID: <ahBxxetoc4bMGmdU@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522150009.121603-1-npache@redhat.com>

NAK.

This is not a hotfixes candidate Nico. Don't send a massive series like this
with that tag please.

Thanks, Lorenzo
