Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59423C4FF;
	Thu,  4 Jun 2026 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537630; cv=none; b=L3eVzr4HxyW82pO2iOeGGaKLcLuAgOQNq3r45bHpA3FIQ+lYHnREmPn0tSAB3zQS0Eh2rfJKBb6/LqGj6cQ5bs3JI0yUNjqrkyWJr+Hyt+YP/7uVNqOdVANPKmHbiMybb4Ozgn6s4aua7xrePecnsIvudEKUrpHIEZ4AkAah4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537630; c=relaxed/simple;
	bh=mSi8Pus0KA7nMGO0z+b0kfqhtyYgw+rPcBtln1kvv2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFuPU8KimbrEDWjb8Ii4+9rK1/j8av1P7rRpva6RDzCv7CZ/gi83hXtqJfCauNrMf+dDW+obHN+5+8EP3NbA/9gsfVG95eeci9PMUf8VocT1Gvu7zRGvvChuaKNUWxV11e4ilgFXlTsXLWiSCWiPKbxfBrAy+1s3E5sSX/KMGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Kky2CKkp; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Kky2CKkp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nmYRbsUzzfhOIZDdazuLRX22nS9Q9OoZqwgs/MwD5ew=;
	b=Kky2CKkpIKkIiFLgQmPPwG7cQe9UxaNb9i28B0sWpbx3oZWP6hOOmLKmRDFBYu8rxmAKFPEAx
	OCX94y2KYER4lXeDL3X/ArevaOfVzOkM15HGN9zuCUvh4rHUJ7Uo8N7pc0q0AnLm46X8tMZ2zKX
	nWBkayu36w+2WkIMe+YQBLI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gW6g30YpnznTVh;
	Thu,  4 Jun 2026 09:39:11 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id C2E4840539;
	Thu,  4 Jun 2026 09:47:03 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 09:47:03 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>, <qiuxu.zhuo@intel.com>, <bp@alien8.de>,
	<akpm@linux-foundation.org>, <rostedt@goodmis.org>, <linmiaohe@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<mchehab+huawei@kernel.org>, <tony.luck@intel.com>,
	<torvalds@linux-foundation.org>, <xieyuanbin1@huawei.com>,
	<yi1.lai@intel.com>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Date: Thu, 4 Jun 2026 09:46:29 +0800
Message-ID: <20260604014629.3144-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
References: <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Wed, 3 Jun 2026 21:13:30 +0200, David Hildenbrand (Arm) wrote:
> Would the following be sufficient to avoid a full revert and the dependency on CONFIG_RAS?
>
> diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
> index aa57cc8f896b..c46b17602578 100644
> --- a/include/trace/events/memory-failure.h
> +++ b/include/trace/events/memory-failure.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #undef TRACE_SYSTEM
> -#define TRACE_SYSTEM memory_failure
> +/* Some user space relies on ras/memory_failure_event */
> +#define TRACE_SYSTEM ras
>  #define TRACE_INCLUDE_FILE memory-failure
>
>  #if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)

Yes, it should be. In fact, when I sent the V2 patch, I had already
considered this issue, and that's exactly what I did:
Link: https://lore.kernel.org/20251104072306.100738-3-xieyuanbin1@huawei.com

However, David Hildenbrand advised me at that time to completely
remove the dependence on RAS:
Link: https://lore.kernel.org/01b44e0f-ea2e-406f-9f65-b698b5504f42@kernel.org
