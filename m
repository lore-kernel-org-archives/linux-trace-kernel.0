Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFC33BBBA;
	Thu,  9 Jul 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568059; cv=none; b=FF2UJQLH0VAZY27U+bZdcEspICNfk6TK9N0R6xtTMXj2LQD2svRaWElBKHKI7HUxytu6dE4OinwEYBcTKWa6XQx8bQQl+PvXxujHcDfNZAOBK5uTLPWxvPXDK5Ck45uNA5PgSrXN/8FZq/nc3v3AjlabEC+su2eGnN4UAznw6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568059; c=relaxed/simple;
	bh=IsaDj2ZC9GKe9GGrRztIL5f/85EmA5MA34jNsqb/ol8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tJWrluOLwNY3my4kuA50Rp2Lx2cstBv/UBlljp9qfB+6a5wSKp0lr+sxk7wj7EJf5tgpsKgy9dvh5hdbLXA/FvaZwrNrHIkGS7yvMJHhuq/CdxDDPqS4QvyLOTlnTsok9mVVNTQp+QytLFyMWSzZe/fLbKHFk3sHSzQ5v/PNrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s1YxTUUF; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s1YxTUUF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DVEML/8+IfGqKnREo8nPgV/r4XM8JifO5Ewy94XS6pg=;
	b=s1YxTUUFRO0IDT3TRih2RrpHuePCChnVY1Mkfh7aw6vzmcXWSDsaD/PefLdIgQrWYKrRr760I
	J0UTyncxTlRkDJk2ft7zpqwc1K4HGrWewU8pL/7+2gH89gAlACBs05EnHdXm983Y8+baCSGO9XB
	72nkG9EEvBIkpxxLpurm4G8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gwgLt3mgwz1cyPZ;
	Thu,  9 Jul 2026 11:24:54 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9889E4048B;
	Thu,  9 Jul 2026 11:34:07 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 11:34:07 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 11:34:06 +0800
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
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
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
Date: Thu, 9 Jul 2026 11:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/30 20:46, Breno Leitao wrote:
> Add a destructive selftest that verifies
> vm.panic_on_unrecoverable_memory_failure actually panics when a
> hwpoison error hits a kernel-owned page.
> 
> Three "kinds" of kernel-owned page can be targeted, selectable via
> the script's first positional argument (default: rodata):
> 
>   rodata  - a PG_reserved page in the kernel rodata range, sourced
>             from the "Kernel rodata" sub-resource of "System RAM" in
>             /proc/iomem.  That entry is reported on every major
>             architecture and guarantees the chosen PFN is backed by
>             struct page (an online System RAM range, not a firmware
>             hole), is PG_reserved, and is read-only -- so even if
>             the panic fails to fire for some reason, the resulting
>             PG_hwpoison marker on rodata does not corrupt writable
>             kernel state.
> 
>   slab    - a slab page found by walking /proc/kpageflags for the
>             first PFN with KPF_SLAB set (and KPF_HWPOISON / KPF_NOPAGE
>             / KPF_COMPOUND_TAIL clear).  Exercises the get_any_page()
>             path on a non PG_reserved kernel-owned page and so
>             catches regressions where get_any_page() collapses
>             kernel-owned pages into a transient -EIO instead of
>             -ENOTRECOVERABLE.
> 
>   pgtable - same as slab, but the PFN is selected via KPF_PGTABLE.
> 
> PageLargeKmalloc, the fourth page type matched by
> is_kernel_owned_page(), is intentionally not covered: it is a
> PAGE_TYPE_OPS flag with no /proc/kpageflags bit, so selecting such
> a PFN from userspace is not feasible.  The slab and pgtable
> variants already exercise the same get_any_page() positive-check
> branch.
> 
> The script enables the sysctl and writes the selected physical
> address to /sys/devices/system/memory/hard_offline_page.  A
> successful run crashes the kernel with
> 
>   Memory failure: <pfn>: unrecoverable page
> 
> A return from the inject means no panic fired.  Before reporting, the
> script restores the sysctl and best-effort unpoisons the target PFN
> through the hwpoison debugfs interface (hard_offline_page() injects
> with MF_SW_SIMULATED, so the page stays unpoisonable), then re-reads
> /proc/kpageflags: a PFN that is still the kernel-owned type it selected
> is a genuine failure, while one that raced to a different type before
> the inject is skipped as inconclusive.  Test outcome is therefore
> observed externally (serial console, kdump) rather than from the
> script's own exit code.
> 
> The script is intentionally NOT wired into run_vmtests.sh: every
> successful run panics the kernel, which is incompatible with the
> sequential "run each category in the same VM" model that
> run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
> ksft_* wrapper so a default kselftest run does not opt itself into
> a panic.  The script is meant to be executed manually inside a
> disposable VM (e.g. virtme-ng), one variant per VM boot, and
> requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

With Mike's comment addressed:

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
