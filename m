Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615732BF5C;
	Thu,  9 Jul 2026 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567119; cv=none; b=Vfx9GUUTkAL4CYZKwcehDj99YACLVtgq9DHj3jPhvKo15/fPAlDbh8bLPsTTr9Iv2L798nUCaoKJpMegAUL/JVgia7PzlPf6wvL0ZFTZc67qu8Z4pgflW17KUfkxzj1FYtC3UF1DMjUIOmYEp9zN5jZ7VzyMX6eQSE7vO2Vi9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567119; c=relaxed/simple;
	bh=hMZdu7a46AUXybubTrcKNUagaWm06hd3RYIYs8wjS0M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZieK+p4hEIGIyiX8WaB8IDqU7wc9b/s8jvu6QN4sCC0UUaIrgcsQ4H4LmE4FVospD0Rik013e+c9OxRhwSEbUVhe9agky6MlSUo4AI2D7w1Acru11I4dSxEX+hzaD9ALSS/4CRfKIpw0SGegdZS2/iGZ2SQRgsqQ3nHEv+bSTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JJOuD/rD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JJOuD/rD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hzrq08S63xNTVU7E8KWRcfGp4/hYHhmDRNHdz9i3UrU=;
	b=JJOuD/rDeHv2AAUyFTLf3x7iXUtLjFXZYvkTy6Ywb3hltv2TeHbFvQCZpFa+2vvcGpbd8WhCL
	PGTPywS8IWiUjQHUVPghi3lN4ht0fTpo9Npjihv8XxcU0cuzkzf9+OSoQSDXn4+7YZ9muDOimX+
	VrJZppqxd2vVRFG0wLRMb5M=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwg0t5twpzRhv6;
	Thu,  9 Jul 2026 11:09:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DD554057A;
	Thu,  9 Jul 2026 11:18:32 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 11:18:31 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 11:18:30 +0800
Subject: Re: [PATCH v10 5/6] Documentation: document
 panic_on_unrecoverable_memory_failure sysctl
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
	<lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-5-c6ed5b62eea2@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <30215c3f-c063-e7ca-1499-3d61e359ef80@huawei.com>
Date: Thu, 9 Jul 2026 11:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260630-ecc_panic-v10-5-c6ed5b62eea2@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/30 20:46, Breno Leitao wrote:
> Add documentation for the new vm.panic_on_unrecoverable_memory_failure
> sysctl, describing which failures trigger a panic (kernel-owned pages
> the handler cannot recover) and which are intentionally left out
> (transient allocator races and unclassified pages).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
