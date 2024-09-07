Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30C2D627;
	Sat,  7 Sep 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725695876; cv=none; b=IS3LZlTAAW1rnhaXilHEn3DVHU5eZFQEgISXuyZE/Rd/94+nJmAy8evU38oS0LgqJpd5YQPlFGogdsNo3GyihzFj8IvqdMdRZ/A+RFk8uE4KhiNaK0VVsTHd20Jj7n8LbLRa9YPtTGnbts5SsKt6m5Ul2kNImtNaTgWcSGWGALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725695876; c=relaxed/simple;
	bh=Epd2xn4E5YxQtnFSKaXQ11Wz4x6GeCI22kfda+pd6j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YnIWxdWzNngKadwmoMp2BOVfYT6cWz4au7lnJqNl3nWmCy4ENqSfUqxe42VkHpEh7tsQKS9z6FfepQMtSoxPBFmVjzcmF4j+sYUMhdJuuGfR3p+NALamB73NuCoaZ+ZcIwlVxwLr0wbHy690eeUnIwcuoIsodqcA5d6gHCfpfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X156D6N0tzyQyV;
	Sat,  7 Sep 2024 15:57:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 20138180064;
	Sat,  7 Sep 2024 15:57:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 7 Sep 2024 15:57:49 +0800
Message-ID: <6a676ec5-1ac8-4974-9cee-4525bf8c70be@huawei.com>
Date: Sat, 7 Sep 2024 15:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/2] hugetlbfs: support tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
CC: <muchun.song@linux.dev>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<david@fromorbit.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <songmuchun@bytedance.com>
References: <20240829064110.67884-1-lihongbo22@huawei.com>
 <20240829064110.67884-2-lihongbo22@huawei.com>
 <20240903155623.62615be8@gandalf.local.home>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240903155623.62615be8@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/4 3:56, Steven Rostedt wrote:
> On Thu, 29 Aug 2024 14:41:09 +0800
> Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>> Add basic tracepoints for {alloc, evict, free}_inode, setattr and
>> fallocate. These can help users to debug hugetlbfs more conveniently.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Pretty basic trace events.
yeah, very basic. Thanks for reviewing!😄

Thanks,
Hongbo
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
