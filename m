Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474131AF0A7;
	Thu, 24 Oct 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757005; cv=none; b=VcwL99jyOjaO6yTnaohlyx9hFUNy6BwZd5oAXt5J9KidnpQPJD+VN81/Mlf73TBCZkqvwhpf4C4K8WukNTD4L1w9sRh3tILT7oFpTQYLLRF+NK4gJERrSvH0dOdfamx/pNXVud2IQfxTVZbvxGA4WQcwz5CY8P0RZdv7g5/dcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757005; c=relaxed/simple;
	bh=5S4sFyZ1G8GKjOpvMIMB6WQMtaGFQjjEJmd+45P3WlM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bq+ayZPqGNwKVfCdRhizyJZaUR+7BNH8vn9JxRogqoVTjNvvw6wX8rda/7BX8jdO2RbXoI59aItJY2RZUFVJD2EvB9MIdV0FjKQ0PgPdSxOkjUdixNTcbloZQudz91ba2g+VdF5sya6Oc7E305HR/3KbUpe36f49VY+4d7KruXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYyzw0313zySB0;
	Thu, 24 Oct 2024 16:01:48 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 7698D180103;
	Thu, 24 Oct 2024 16:03:20 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 16:03:19 +0800
Subject: Re: [PATCH] fgraph: Fix missing unlock in register_ftrace_graph()
To: Steven Rostedt <rostedt@goodmis.org>
CC: <dan.carpenter@linaro.org>, <mhiramat@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oe-kbuild@lists.linux.dev>, <lkp@intel.com>
References: <20241023170448.808512-1-lihuafei1@huawei.com>
 <20241023052948.0285eb2c@rorschach.local.home>
 <49d1672e-71e2-dc87-1fb3-cde430e0339f@huawei.com>
 <20241024004624.3b574af2@rorschach.local.home>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <dfa55519-fcfd-73fa-2cd5-5a408a91bd86@huawei.com>
Date: Thu, 24 Oct 2024 16:03:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241024004624.3b574af2@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/24 12:46, Steven Rostedt wrote:
> On Thu, 24 Oct 2024 10:45:46 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> Agreed, this will make the code simpler and avoid mistakes. If we need
>> to replace all mutex(&ftrace_lock), would it be better to submit another
>> cleanup patch? We can fix the issue here first.
> 
> This case is a bug fix, just add it here.
> 
> We can do a clean up separately for the other locations.
> 

Okay, I've already sent v2:

https://lore.kernel.org/lkml/20241024155917.1019580-1-lihuafei1@huawei.com/T/#u

Thanks,
Huafei

> -- Steve
> 
> .
> 
