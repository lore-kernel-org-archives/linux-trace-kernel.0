Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D247CC80;
	Thu,  4 Jun 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580589; cv=none; b=b7F/jzNP/V0lP9MVh4zO2s/L4kt4dO38r+LBFJTQeGPSst49ZCOnnxQDVID7kbETpj7pP4zjFz9yw8BOW2U8Zx/WfPVdUkg9VMmZ7/iimaUi4qONjlnAxdBQ/Gut5w0MvXR9P9wI+hNcJcKXyjmlV/1OAEVIOH+l7Fjs3bW31rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580589; c=relaxed/simple;
	bh=zqAH+jkzeCPdGtaLFK/vNcS/ptJTugJ6NWWQSyS0myc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdSzg1cxiI9o2ZlZ1ZarIH/Q95CxjNpk4KDixgmh6tkrRW2VhFTCRtZ0VcRYX/nsxbqSOpOF33i3mHsGvnzXbm2GQAlj6zgloQ9hx6bEDIHDbGLMaOE9CQgkK3BK/kYq/mTRJBYAGqDd/o4f1ft8WykSpHetTxzEpT6KzxNGU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3yh5Pqqg; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3yh5Pqqg"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zqAH+jkzeCPdGtaLFK/vNcS/ptJTugJ6NWWQSyS0myc=;
	b=3yh5PqqgSnBSISBzTBPiZwewd95hdoGK4zOI9D0d4eHRtNow6c2R3WCcx+OInBv50bJXPiRv9
	4hfxuoWEHnv7lWdmLGMhF1N52MQtX/fq8+6avM38jhqqSKdhlN+cA4K6k9ackulgXZ3ouMqQHqe
	ZNdDvCe1UL8/eke3vqzbyZg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gWQY028ygzcbRy;
	Thu,  4 Jun 2026 21:35:00 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id B624F201E9;
	Thu,  4 Jun 2026 21:43:01 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 21:43:01 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>, <qiuxu.zhuo@intel.com>, <bp@alien8.de>,
	<akpm@linux-foundation.org>, <rostedt@goodmis.org>, <linmiaohe@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<mchehab+huawei@kernel.org>, <tony.luck@intel.com>,
	<torvalds@linux-foundation.org>, <xieyuanbin1@huawei.com>,
	<yi1.lai@intel.com>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Date: Thu, 4 Jun 2026 21:42:09 +0800
Message-ID: <20260604134209.111533-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4de75e51-025c-4926-871a-4b9da479cefa@kernel.org>
References: <4de75e51-025c-4926-871a-4b9da479cefa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 4 Jun 2026 08:42:37 +0200, David Hildenbrand (Arm) wrote:
> Yeah, if only I had known that we would break user space by changing trace
> events ... now we know :)
>
> Do you have capacity to send a fix?

Sure, with pleasure.
