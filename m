Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F22BCF4C;
	Mon, 27 Oct 2025 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535549; cv=none; b=sgnneWU9A3KYPEwKNw/bW+s2wNeW22kggLGm6VAlJWj1ZBHpXCxsF5m77UBIXVu79Y2BNTO7EI2htyVpxn9LuEyyFaHWytUO5gH1N9k6l3zfb18MpnRVcU+lqjax7XKfyBpgD/MUVLN3KjYorDU8ug+Jkc0qLmpgctFGPDzEyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535549; c=relaxed/simple;
	bh=AOcMq98EC8CGBYoVOSn6HcM2Q6moUQ8svsurgr3qy7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKyuxYWYwLT0ORJm3WfuElF+Br+XAZwc78bs4/H2XbLgITISsZQKADUOSIlQ9fY9cix18dt2VCbYkpwqeTqC0TGRMInnwXJG0g1qEUkZ6jQDUGTGWkVRFOAsLkLy4Xb3J4fU3afw1nkRoUVbKKH9zwO/uCgOf6kSByzi/B8eQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hkoi81s9; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hkoi81s9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761535538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/jozjS1vRHTv6C7q6QJDKxw+pz3Pe2g0a97QFylnV28=;
	b=hkoi81s9qdEt271lM2yx6wIz0Eszac/CbKqTBeqzvYpaxiAuoeXK03rJKtCEguo3QdjsV05KXxPBRmqWTzjdDbkRP1c8cM8isxrAcUfON3LkGlwd1akigWLdhLa0x8vZnB3BbZ4fwpwhu6MGpGVXqzfoZS09TR6QVqSi7cDTYGQ=
Received: from 30.74.144.189(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wr-v7UX_1761535533 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 11:25:34 +0800
Message-ID: <ad974920-658a-4909-8160-c54f7ac9403a@linux.alibaba.com>
Date: Mon, 27 Oct 2025 11:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 07/15] khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-8-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251022183717.70829-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/23 02:37, Nico Pache wrote:
> Pass an order and offset to collapse_huge_page to support collapsing anon
> memory to arbitrary orders within a PMD. order indicates what mTHP size we
> are attempting to collapse to, and offset indicates were in the PMD to
> start the collapse attempt.
> 
> For non-PMD collapse we must leave the anon VMA write locked until after
> we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> the mTHP case this is not true, and we must keep the lock to prevent
> changes to the VMA from occurring.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

LGTM. And passed my mTHP collapse testing cases. So:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
