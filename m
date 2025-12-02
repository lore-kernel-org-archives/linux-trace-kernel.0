Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA34303A3D;
	Tue,  2 Dec 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662210; cv=none; b=MXkAZ6EU7SDU56M9z+qW+wIf6Tl7zJUOXZAgU8FEo1i/C9s+qWwit9/fbWrOcX5+x5a6H5/D+k6TKhCghICxhUvD9AQ/xA2iRq1EbsCPxlOsR0PSZ7rwfr/7DhIOoC1onqezKrvZCobAn9Gmkwm3LOGaBLSDd08a5TzOLT6MrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662210; c=relaxed/simple;
	bh=BCHRwvEKA/cZaZ2GzUjbZ1AAxMnsjJ4BqIxcddtp82k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHdJfStw9eQMelQ/a+gruOFvq8u7/TD7malOp+wARG9CMxgBEZ2u1EdZ409Y7SAJmp2pWQG7swAvzGbAOreDR3/A8ezSXprcsg8FJCA82c5NqVRKxCON//aQ4CmJ2v4WROmvmV2HOQH9SRydF/lWjwmnqPwjMC9LW7wNAvutPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v8eY74sK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v8eY74sK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764662203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vCswqFTvPnxysMNNAE72TpXQ4Qg0y3bXmBxEFvbbCKw=;
	b=v8eY74sKMDQ2MQYLAGoGfh5RZAY65t5cmMlrEr0835tKrYPQBpJTbKPAC43BhVV2uiTgumPt55/MtyZqzO+yxCr5BaYS/YAO61uZ65QG9he6/wK4J/TWFenyKXO8nsI7ypm0CrOvarS6V+Bra+IGKwoTqOxGl8rDB/O7x3ge85s=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WtveNUi_1764662201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 15:56:41 +0800
Message-ID: <c91f8c76-ca5a-4e8c-84a4-1b91b150e202@linux.alibaba.com>
Date: Tue, 2 Dec 2025 15:56:40 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251201185604.210634-6-shivankg@amd.com>
 <20251201185604.210634-8-shivankg@amd.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251201185604.210634-8-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/2 02:56, Shivank Garg wrote:
> When collapse_file encounters dirty or writeback pages in file-backed
> mappings, it currently returns SCAN_FAIL which maps to -EINVAL. This is
> misleading as EINVAL suggests invalid arguments, whereas dirty/writeback
> pages represent transient conditions that may resolve on retry.
> 
> Introduce SCAN_PAGE_DIRTY_OR_WRITEBACK to cover both dirty and writeback
> states, mapping it to -EAGAIN. For MADV_COLLAPSE, this provides userspace
> with a clear signal that retry may succeed after writeback completes.
> For khugepaged, this is harmless as it will naturally revisit the range
> during periodic scans after async writeback completes.
> 
> Reported-by: Branden Moore <Branden.Moore@amd.com>
> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
