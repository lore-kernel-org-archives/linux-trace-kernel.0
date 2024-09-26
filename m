Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9A16DEDF;
	Thu, 26 Sep 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352409; cv=none; b=jI+nCYXsx+TrALCb6AqUGYGOwA6Ynzjv1fn5K/sNBVgrFkw5wv3DbiFkJhtHrBfaBnkqEDWMimabpEsBGsCziyj++vjvugdrF+F4cSzjOqT6O25eYucPhUsEtE4vp4acmxqdQ7zXLEpr3vUMPtUgHjvw//6EI2jsLdJdxJ0qrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352409; c=relaxed/simple;
	bh=ipbzAXPO1w8/QYpLl0+R477rPH88FMON4C9d+cpGzyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qr7Kj9fyS+YfVyrtHJT3RqeOen88yg0j6UGpGsV+m7EaYIhCuvcKm6I12IR4oPZrGo5ZgOWgGHnmBDNsxsQ/ky0lYLRITrip7lOWZuiol/sXSsF4p4ynY2V8mEQL0R6H3B8mdM3L2E5IYOx32VjmKXZUFAj5eKnXZGaFjR5DBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XDslT1BjRz1ymPr;
	Thu, 26 Sep 2024 20:06:45 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DE101402CD;
	Thu, 26 Sep 2024 20:06:43 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 26 Sep 2024 20:06:42 +0800
Message-ID: <522284d3-9655-3703-00e9-33f358dbc78d@huawei.com>
Date: Thu, 26 Sep 2024 20:06:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
To: Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, <mhiramat@kernel.org>,
	<peterz@infradead.org>, <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com> <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
 <20240923071856.GA31866@willie-the-truck> <20240923105228.GB20793@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240923105228.GB20793@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/23 18:52, Oleg Nesterov 写道:
> On 09/23, Will Deacon wrote:
>>
>> However, we should use __GFP_ZERO anyway
>> because I don't think it's a good idea to map an uninitialised page into
>> userspace.
> 
> Agreed, and imo this even needs a separate "fix info leak" patch.

Do you mean to fill the entire page with CPU specific illegal instructions
in this patch?

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang
