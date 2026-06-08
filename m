Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FE3630A9;
	Mon,  8 Jun 2026 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918061; cv=none; b=cdjiR8C2Ej3xmdNjmvkimzxwwwMo95D4d+YjAvI6EfOtuH0Rmd2PB9gibYnjr1pebn+rMYE5sWdfue2lXeuN61ZFqcaqHdnuePbC6ZdgTDc015ksk+LGtB+PdSkY1LsW927m7VZ6dTL2AZgCLxfTwoNzJF6Wyw9eeG006cNd9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918061; c=relaxed/simple;
	bh=IVTda/r3ipj82zRc0C9uUNP3QI7Covw/MO9ol4MtSSg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=auSKfBe+ABV99wBRvEHpVnsUAMkwBXLOb0lg5fJRk5dm1xBaXfya7KHctK29AW5MDlDU6/RVUY/6q+N3twnBEQNElq1831gSjOYQUGvu8NFR1pM1eSrR66IjIu5/Dx8gx6gOKZfxw5kIUEKszqkr1XbROFCEJjRs3qOlCKZ55M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FHucFBpw; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FHucFBpw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PzxUbcbj5dWexEFu7fMkwnP4bMPlR0eubB/DtOzn6jU=;
	b=FHucFBpw3A+rcPsVp7EgDuSypdJrvqA68Lup5Tax6kwrl7ogwm2eCX+gw/rcFd1fWVDQrzPq7
	lpu+pgXFdo+Q1+IxuOLfq0QMGcrhdJO9bA4Ec7y0M9i4RWlspibqGVQxTMg1HFg2HPqFREVGfSC
	U5hB1DuILxZCxDDrqJTvvh8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gYqM31PC6z1cyPM;
	Mon,  8 Jun 2026 19:19:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F1B740563;
	Mon,  8 Jun 2026 19:27:35 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 19:27:34 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 19:27:33 +0800
Subject: Re: [PATCH] mm/memory-failure: trace: change memory_failure_event to
 ras subsystem
To: Xie Yuanbin <xieyuanbin1@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <david@kernel.org>, <qiuxu.zhuo@intel.com>,
	<bp@alien8.de>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<nao.horiguchi@gmail.com>, <mhiramat@kernel.org>,
	<mchehab+huawei@kernel.org>, <tony.luck@intel.com>, <yi1.lai@intel.com>
References: <20260605081213.154660-1-xieyuanbin1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5d7eb2a0-e9ed-da53-fbde-548901b55141@huawei.com>
Date: Mon, 8 Jun 2026 19:27:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260605081213.154660-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/5 16:12, Xie Yuanbin wrote:
> For historical version, commit 97f0b1345219 ("tracing: add trace event
> for memory-failure") introduced memory_failure_event in ras subsystem.
> commit 31807483d395 ("mm/memory-failure: remove the selection of RAS")
> changed memory_failure_event to memory_failure subsystem. This breaks
> the backward compatibility, some user programs rely on it.
> 
> Change memory_failure_event to ras subsystem to keep backward
> compatibility.
> 
> Fixes: 31807483d395 ("mm/memory-failure: remove the selection of RAS")

With David's comment addressed:

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
